import Foundation
import AppKit
import CryptoKit

/// Arşiv içerisindeki bir dosyanın geçici sandbox dizininde açılmasını ve
/// harici uygulamalardaki düzenleme/kayıt işlemlerinin anlık izlenmesini yöneten oturum
public struct InPlaceEditSession: Identifiable, Sendable {
    public let id: UUID
    public let archiveURL: URL
    public let item: ArchiveItem
    public let localFileURL: URL
    public let rootTempDir: URL
    public var lastKnownModificationDate: Date
    public var lastKnownFileSize: Int64
    public var lastKnownHash: String

    public init(
        id: UUID = UUID(),
        archiveURL: URL,
        item: ArchiveItem,
        localFileURL: URL,
        rootTempDir: URL,
        lastKnownModificationDate: Date,
        lastKnownFileSize: Int64,
        lastKnownHash: String
    ) {
        self.id = id
        self.archiveURL = archiveURL
        self.item = item
        self.localFileURL = localFileURL
        self.rootTempDir = rootTempDir
        self.lastKnownModificationDate = lastKnownModificationDate
        self.lastKnownFileSize = lastKnownFileSize
        self.lastKnownHash = lastKnownHash
    }
}

/// Algılanan dosya değişikliği kaydı
public struct InPlaceEditChange: Identifiable, Equatable {
    public var id: UUID { session.id }
    public var session: InPlaceEditSession
    public let detectedAt: Date

    public var fileName: String { session.item.name }
    public var relativePath: String { session.item.path }
    public var archiveURL: URL { session.archiveURL }

    public static func == (lhs: InPlaceEditChange, rhs: InPlaceEditChange) -> Bool {
        lhs.session.id == rhs.session.id
    }
}

/// Arşiv İçi Dosya Düzenleme & Canlı Güncelleme Yöneticisi (In-Place File Editor & Watcher)
@MainActor
public final class InPlaceEditManager: ObservableObject {
    public static let shared = InPlaceEditManager()

    /// Aktif izlenen düzenleme oturumları
    @Published public private(set) var activeSessions: [InPlaceEditSession] = []

    /// Değişiklik algılanmış ve onay bekleyen dosyalar
    @Published public private(set) var pendingChanges: [InPlaceEditChange] = []

    /// Güncelleme devam ediyor mu?
    @Published public var isUpdating: Bool = false

    /// Son durum / geri bildirim mesajı
    @Published public var statusMessage: String? = nil

    private var pollTimer: Timer?
    private var hasSetupObserver: Bool = false

    private init() {
        setupLifecycleObservers()
    }

    private func setupLifecycleObservers() {
        guard !hasSetupObserver else { return }
        hasSetupObserver = true

        // Kullanıcı başka uygulamadan UnPack'e geri döndüğünde değişiklikleri hemen denetle
        NotificationCenter.default.addObserver(
            forName: NSApplication.didBecomeActiveNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor in
                self?.checkForModifications()
            }
        }

        // Periyodik kontrol zamanlayıcısı (her 2 saniyede bir)
        pollTimer?.invalidate()
        pollTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.checkForModifications()
            }
        }
    }

    /// Bir dosyanın SHA-256 özetini hesaplar (küçük/orta dosyalar için)
    private func computeHash(for fileURL: URL) -> String? {
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        let digest = SHA256.hash(data: data)
        return digest.map { String(format: "%02x", $0) }.joined()
    }

    /// Arşiv içindeki bir dosyayı geçici bir çalışma dizinine çıkartıp düzenlemek üzere açar
    @discardableResult
    public func startEditing(archiveURL: URL, item: ArchiveItem, customAppURL: URL? = nil) async throws -> URL {
        // Eğer bu dosya için halihazırda açık bir oturum varsa ve dosya hala mevcutsa onu aç
        if let existing = activeSessions.first(where: { $0.archiveURL == archiveURL && $0.item.path == item.path }) {
            if FileManager.default.fileExists(atPath: existing.localFileURL.path) {
                openFile(url: existing.localFileURL, withApp: customAppURL)
                return existing.localFileURL
            } else {
                activeSessions.removeAll(where: { $0.id == existing.id })
            }
        }

        let sessionID = UUID()
        let rootTempDir = FileManager.default.temporaryDirectory
            .appendingPathComponent("UnPack_InPlaceEdits")
            .appendingPathComponent(sessionID.uuidString)
        try FileManager.default.createDirectory(at: rootTempDir, withIntermediateDirectories: true)

        // Dosyayı arşivden tekil olarak çıkart
        let extractedURL = try await ArchiveManager.shared.extractItemForPreview(archiveURL: archiveURL, item: item)

        // Hedef hiyerarşik konumu sağla: rootTempDir/<item.path>
        let canonicalTargetURL = rootTempDir.appendingPathComponent(item.path)
        try FileManager.default.createDirectory(at: canonicalTargetURL.deletingLastPathComponent(), withIntermediateDirectories: true)

        if extractedURL.path != canonicalTargetURL.path {
            if FileManager.default.fileExists(atPath: canonicalTargetURL.path) {
                try? FileManager.default.removeItem(at: canonicalTargetURL)
            }
            try FileManager.default.copyItem(at: extractedURL, to: canonicalTargetURL)
        }

        // Başlangıç meta verilerini oku
        let attrs = try FileManager.default.attributesOfItem(atPath: canonicalTargetURL.path)
        let modDate = attrs[.modificationDate] as? Date ?? Date()
        let fileSize = attrs[.size] as? Int64 ?? item.uncompressedSize
        let hash = computeHash(for: canonicalTargetURL) ?? "\(modDate.timeIntervalSince1970)_\(fileSize)"

        let session = InPlaceEditSession(
            id: sessionID,
            archiveURL: archiveURL,
            item: item,
            localFileURL: canonicalTargetURL,
            rootTempDir: rootTempDir,
            lastKnownModificationDate: modDate,
            lastKnownFileSize: fileSize,
            lastKnownHash: hash
        )

        activeSessions.append(session)

        // Harici uygulamada aç
        openFile(url: canonicalTargetURL, withApp: customAppURL)

        return canonicalTargetURL
    }

    private func openFile(url: URL, withApp appURL: URL?) {
        if let app = appURL {
            NSWorkspace.shared.open(
                [url],
                withApplicationAt: app,
                configuration: NSWorkspace.OpenConfiguration()
            )
        } else {
            NSWorkspace.shared.open(url)
        }
    }

    /// Aktif oturumlardaki dosyaları değişiklik açısından tarar
    public func checkForModifications() {
        guard !isUpdating else { return }

        for index in activeSessions.indices {
            let session = activeSessions[index]

            guard FileManager.default.fileExists(atPath: session.localFileURL.path) else {
                continue
            }

            guard let attrs = try? FileManager.default.attributesOfItem(atPath: session.localFileURL.path) else {
                continue
            }

            let currentModDate = attrs[.modificationDate] as? Date ?? Date()
            let currentSize = attrs[.size] as? Int64 ?? 0

            // Değişiklik tarihi en az 0.5 saniye yeniyse veya boyut farklıysa hash kontrolü yap
            let timeDiff = currentModDate.timeIntervalSince(session.lastKnownModificationDate)
            if timeDiff > 0.5 || currentSize != session.lastKnownFileSize {
                if let currentHash = computeHash(for: session.localFileURL), currentHash != session.lastKnownHash {
                    // Değişiklik doğrulandı!
                    handleFileModified(session: session)
                }
            }
        }
    }

    private func handleFileModified(session: InPlaceEditSession) {
        // Eğer kullanıcı otomatik güncelleme seçeneğini açtıysa doğrudan arşivi güncelle
        if AppSettings.shared.autoUpdateEditedFilesInArchive {
            Task {
                await self.applyUpdateDirectly(for: session)
            }
            return
        }

        // Değilse onay için bekleyen değişikliklere ekle
        if !pendingChanges.contains(where: { $0.session.id == session.id }) {
            let change = InPlaceEditChange(session: session, detectedAt: Date())
            pendingChanges.append(change)
        }
    }

    /// Kullanıcı onayıyla değişikliği arşive uygular
    public func applyUpdate(for change: InPlaceEditChange) async {
        await applyUpdateDirectly(for: change.session)
    }

    private func applyUpdateDirectly(for session: InPlaceEditSession) async {
        isUpdating = true
        statusMessage = "‘\(session.item.name)’ arşive kaydediliyor..."

        do {
            try await ArchiveManager.shared.updateItemInArchive(
                archiveURL: session.archiveURL,
                item: session.item,
                localFileURL: session.localFileURL,
                rootTempDir: session.rootTempDir
            )

            // Başlangıç referanslarını güncelle (böylece tekrar tetiklenmez)
            if let idx = activeSessions.firstIndex(where: { $0.id == session.id }) {
                let attrs = try? FileManager.default.attributesOfItem(atPath: session.localFileURL.path)
                let modDate = attrs?[.modificationDate] as? Date ?? Date()
                let size = attrs?[.size] as? Int64 ?? session.lastKnownFileSize
                let hash = computeHash(for: session.localFileURL) ?? session.lastKnownHash

                activeSessions[idx].lastKnownModificationDate = modDate
                activeSessions[idx].lastKnownFileSize = size
                activeSessions[idx].lastKnownHash = hash
            }

            pendingChanges.removeAll(where: { $0.session.id == session.id })
            isUpdating = false
            statusMessage = "‘\(session.item.name)’ arşive başarıyla güncellendi."

            // Görünümün güncellenmesi için merkezi bildirim gönder
            NotificationCenter.default.post(name: .unpackArchiveModifiedInPlace, object: session.archiveURL)

            if AppSettings.shared.playSoundOnCompletion {
                NSSound(named: "Glass")?.play()
            }
        } catch {
            isUpdating = false
            statusMessage = "Güncelleme başarısız: \(error.localizedDescription)"
        }
    }

    /// Kullanıcı değişikliği yoksaymak isterse
    public func discardChange(_ change: InPlaceEditChange) {
        if let idx = activeSessions.firstIndex(where: { $0.id == change.session.id }) {
            let attrs = try? FileManager.default.attributesOfItem(atPath: change.session.localFileURL.path)
            let modDate = attrs?[.modificationDate] as? Date ?? Date()
            let size = attrs?[.size] as? Int64 ?? change.session.lastKnownFileSize
            let hash = computeHash(for: change.session.localFileURL) ?? change.session.lastKnownHash

            activeSessions[idx].lastKnownModificationDate = modDate
            activeSessions[idx].lastKnownFileSize = size
            activeSessions[idx].lastKnownHash = hash
        }
        pendingChanges.removeAll(where: { $0.session.id == change.session.id })
    }

    /// Belirtilen arşiv kapatıldığında ilgili oturumları temizler
    public func cleanup(for archiveURL: URL) {
        let matching = activeSessions.filter { $0.archiveURL == archiveURL }
        for session in matching {
            try? FileManager.default.removeItem(at: session.rootTempDir)
        }
        activeSessions.removeAll(where: { $0.archiveURL == archiveURL })
        pendingChanges.removeAll(where: { $0.archiveURL == archiveURL })
    }
}
