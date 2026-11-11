import SwiftUI
import AppKit

// MARK: - Sürüm Notları Kaynağı (Tek Merkez)

public enum UnPackReleaseNotes {
    public static var latestFallbackMarkdown: String {
        """
        ## UnPack v1.9.1

        macOS Human Interface Guidelines (HIG) standartlarıyla baştan tasarlanan Hakkında ekranı, bağımsız Uygulama Hakkında penceresi ve canlı arşiv motoru tanılama görünümü.

        ### Yenilenen Hakkında Deneyimi & Özellikler
        - **Modern Apple Kimlik & Durum Kartı:** Uygulama sürümü, etkin işlemci mimarisi, son güncelleme denetim zamanı ve tek tıkla kopyalanabilen sistem özet bilgisi tek düzenli başlıkta birleştirildi.
        - **Bağımsız UnPack Hakkında Penceresi:** Üst menü çubuğundaki `UnPack > UnPack Hakkında` komutu artık sistem varsayılan penceresi yerine özel tasarlanmış yerel pencereyi açar.
        - **Canlı Arşiv Motoru Tanılama:** `7zz`, `unrar`, `rar`, `libarchive` ve `APFS F_PUNCHHOLE` bileşenlerinin çalışma durumu gerçek zamanlı olarak denetlenir ve gösterilir.
        - **Açık Kaynak Lisansları & Sürüm Notları:** MIT lisansı ve üçüncü taraf motor bildirimleri için yerel lisans penceresi ile doğrudan web sitesi/GitHub bağlantıları eklendi.

        ## UnPack v1.9.0

        macOS Human Interface Guidelines standartlarına uygun yerel arayüz yenilemesi, Canlı Arşiv İçi Dosya Düzenleme ve güncellenmiş dokümantasyonla sunulan kararlı sürüm.

        ### Özgün macOS Arayüzü & Sürüm Yenilikleri
        - **Saf Apple Tasarım Dili:** Gezgin, Tercihler, Onboarding, Sıkıştırma, Çıkarma ve İlerleme pencerelerinden gereksiz süslemeler kaldırıldı; standart macOS tipografisi ve yerel kontroller uygulandı.
        - **Canlı Arşiv İçi Düzenleme (In-Place Edit):** Arşivdeki dosyaları harici uygulamalarda düzenleyip anlık SHA-256 ve değişiklik takibiyle tek tıkla arşive geri işleyin.
        - **Yerel Güncelleme & Sürüm Notları Görünümü:** Markdown sürüm notları, indirme ilerleme penceresi ve otomatik DMG kurulumu sistem standartlarıyla hizalandı.
        - **Retina Ekran Görüntüleri & Dokümantasyon:** Uygulama ekran görüntüleri ve web tanıtım sayfası `v1.9.0` sürümüyle birebir güncellendi.

        ## UnPack v1.8.6

        Arşiv içerisindeki dosyaları harici uygulamalarda doğrudan düzenleme, canlı dosya izleme ve arşivi anında güncelleme özellikleri eklendi.

        ### Canlı Arşiv İçi Dosya Düzenleme (In-Place Edit)
        - **Varsayılan Uygulamayla Aç & Düzenle:** Arşivdeki herhangi bir dosyayı TextEdit, VS Code, Xcode veya sistem varsayılan uygulamanızla doğrudan açıp düzenleyebilirsiniz.
        - **Anlık Değişiklik Algılama:** Düzenlenen dosyanın kaydedilmesi durumunda dosya boyutu, değişiklik tarihi ve SHA-256 hash kontrolleriyle anında tespit edilir.
        - **Akıllı Güncelleme Onay Bandı:** Düzenleme yapıldığında arşiv gezgininde yerel bir onay bandı belirir; tek tıkla arşivi güncelleyebilir veya değişikliği yoksayabilirsiniz.
        - **Otomatik Güncelleme Tercihi:** Tercihler > Genel sekmesinden düzenlenen dosyaların onay sorulmadan doğrudan arşive işlenmesi seçilebilir.

        ## UnPack v1.8.5

        Yapay zeka arayüz klişelerinden tamamen arındırılmış, macOS Human Interface Guidelines (HIG) standartlarında zarif ve yerel Apple tasarım dili.

        ### Özgün macOS Arayüz Tasarımı
        - **Sade ve Doğal Apple Standartları:** Sahne arkası kromatik ışık parıltıları ve aşırı renkli dekoratif efektler kaldırıldı; Apple'ın özgün macOS tasarım felsefesi uygulandı.
        - **macOS Resmi 8 Vurgu Rengi:** Sistem Ayarları ile uyumlu resmi Apple renk paleti (Mavi, Mor, Pembe, Kırmızı, Turuncu, Sarı, Yeşil, Grafit) entegre edildi.
        - **Finder Tarzı Yol Çubuğu & Arama:** Dosya hiyerarşisinde gezinmeyi kolaylaştıran kompakt yol çubuğu ve standart arama alanı oluşturuldu.
        - **Yerel Segmented Kontroller:** Araç çubuğu ve pencere kontrollerinde yerel macOS `.bordered` ve `.segmented` buton stillerine geçildi.
        - **Yalın İlerleme Paneli:** Dönen yörüngeler yerine sistemle uyumlu `ProgressView` ve metrik kartları getirildi.

        ## UnPack v1.8.0

        Yetersiz disk alanına sahip Mac'lerde büyük arşivlerin açılabilmesini sağlayan "Alan Açarak Çıkarma (Space-Saving In-Place Extraction)" modu eklendi. Çıkarılan dosyaların arşivdeki blokları adım adım serbest bırakılarak minimum boş alanda ayıklama yapılır.

        ### Alan Açarak Çıkarma (Düşük Disk Alanı Modu)
        - **Minimum Tepe Disk Kullanımı:** Normalde `Arşiv Boyutu + Çıkarılan Dosyalar` kadar boş alan gerekirken; Alan Açma Modu ile yalnızca en büyük tek dosya boyutu kadar alanla 50-100 GB devasa arşivleri bile açabilirsiniz.
        - **macOS APFS Blok Delme (Sparse Hole Punching):** macOS APFS dosya sistemi üzerinde `F_PUNCHHOLE` çağrısı kullanılarak çıkarılan her dosyanın disk blokları anında deallocate edilir ve işletim sistemine geri kazandırılır.
        - **Ters Kısaltma (Reverse Truncation) & Kuyruk Koruma:** APFS harici disklerde ve ZIP/TAR arşivlerinde dosyalar sondan başa doğru ayıklanır; her adımda `ftruncate` ile arşiv küçültülür.
        - **Çökme ve Kesinti Korumalı Günlükleme (Journaling):** `.unpack-journal.json` sayesinde işlem elektrik kesintisi veya iptal ile yarıda kalsa bile arşiv bozulmaz; UnPack açıldığında tek tıkla kaldığı yerden devam eder.
        - **Akıllı Ön Kontrol (Pre-flight Space Check):** Hedef diskte yeterli alan olup olmadığı çıkarma öncesinde simüle edilir; alan kritikse kullanıcıya otomatik Alan Açma Modu önerilir.
        - **Çok Parçalı Arşiv (Multi-part) Otomatik Tasarrufu:** `.part1.rar` veya `.7z.001` gibi çok ciltli arşivlerde tamamlanan ciltler anında temizlenerek disk alanı serbest bırakılır.

        ## UnPack v1.7.2

        RAM ve CPU tüketimini en aza indirgeyen, arka plan işlemlerini ve dosya önbelleğini optimize eden yüksek verimlilik güncellemesi.

        ### Düşük RAM ve CPU Tüketimi Optimizasyonları
        - **Otomatik Temizlenen Simge Önbelleği:** Dosya simgeleri artık `NSCache` altyapısıyla yönetilmekte; sistem bellek baskısı hissettiğinde otomatik tahliye edilerek RAM şişmesi engellenmektedir.
        - **Düşük CPU ve Güç Tüketimi:** Arşivleme ve çıkarma sırasındaki boru hattı okuma döngüleri optimize edildi. Gereksiz uyandırmalar azaltılarak CPU çekirdeklerinin düşük güç durumunda kalması sağlandı.
        - **Sıfır Gecikmeli Liste Filtreleme:** Arama ve klasör içi dosya listelemeleri önbelleğe alınarak her kullanıcı etkileşiminde tekrarlanan CPU filtreleme yükü ortadan kaldırıldı.
        - **Otomatik Geçici Alan Temizliği:** Hızlı bakış ve sürükle-bırak için açılan geçici dosyalar periyodik olarak temizlenerek disk ve bellek sağlığı güvenceye alındı.
        - **Zamanlayıcı Birleştirme (Timer Coalescing):** Arka plan güncelleme denetimleri macOS enerji tasarrufu standartlarına uygun şekilde optimize edildi.

        ## UnPack v1.7.1

        Performans, verimlilik ve dosya ilişkilendirme süreçlerini optimize eden bu güncelleme; macOS sistem uyumluluğunu en üst düzeye taşır.

        ### Performans ve Verimlilik İyileştirmeleri
        - **Toplu Dosya Eşitleme:** İlk kurulumda ve açılışta arşiv formatları artık tek tek sormak yerine tek bir onayla arka planda topluca UnPack ile eşleştirilir.
        - **Motor Önbellekleme:** Arşiv motoru ikili yol aramaları ve dosya kontrol çağrıları optimize edilerek her işlemdeki disk I/O yükü azaltıldı.
        - **Akıcı İlerleme Eğrisi:** Sıkıştırma ve arşivleme ekranındaki yüzde hesaplamaları yumuşatılarak %95 seviyesinde yaşanan yapay duraklamalar giderildi.
        - **Arka Plan Önbellek Tazeleme:** Finder simge önbelleği ve QuickLook yenileme işlemleri ana iş parçacığını bloke etmeden asenkron çalışacak şekilde uyarlandı.

        ## UnPack v1.7.0

        UnPack; sadeleştirilmiş yeni kimliği, modern Apple standartlarında arşiv oluşturma arayüzü, sessiz arka plan güncelleme sistemi ve doğrudan Finder sağ tık entegrasyonuyla güncellendi.

        ### Tasarım ve Kullanıcı Deneyimi Yenilikleri
        - **Sadeleştirilmiş Araç Çubuğu:** Klasik buton kalabalığı kaldırıldı; birincil çıkarma ve ekleme eylemleri, hızlı önizleme araçları ve gelişmiş özellikler düzenli bir araç çubuğunda toplandı.
        - **Finder Tarzı Izgara (Grid) Görünümü:** Arşiv içeriğini ayrıntılı tablonun yanı sıra büyük önizleme kartları halinde görüntüleme seçeneği eklendi. Araç çubuğundan tek tıkla Liste ve Izgara arasında geçiş yapabilirsiniz.
        - **Apple Yol ve Spotlight Arama Çubuğu:** Klasör hiyerarşisinde rahatça gezinmeyi sağlayan tıklanabilir yol çubuğu ve Spotlight arama kutusu baştan tasarlandı.
        - **Zarif Boş Durumlar:** Henüz arşiv açılmadığında veya boş klasörlere girildiğinde kullanıcıyı karşılayan net Apple simge ve yönlendirmeleri eklendi.
        - **Klavye Kısayol Rozetleri:** Alt çubuğa Space ile hızlı bakış ve ⌘E ile çıkarma kısayollarını hatırlatan tuş rozetleri yerleştirildi.

        ### Sistem Uyumluluğu
        - **Evrensel Destek:** Apple Silicon (M1, M2, M3, M4) ve Intel (x86_64) işlemcili Mac bilgisayarlarla tam uyumludur.
        - **İşletim Sistemi:** macOS Sonoma (14.0) ve macOS Sequoia (15.0) sürümlerini destekler.
        """
    }
}

// MARK: - Çalışma Ortamı & Motor Tanılama Yardımcısı

private struct AboutDiagnostics {
    let runtimeArchitecture: String
    let runtimeArchTag: String
    let processorSummary: String
    let osVersionString: String
    let memoryGB: Int
    let optimalThreadDescription: String
    let sevenZipAvailable: Bool
    let unrarAvailable: Bool
    let rarAvailable: Bool
    let systemArchiveToolsAvailable: Bool

    static func current() -> AboutDiagnostics {
        let detector = AppleSiliconDetector.shared
        let osVer = ProcessInfo.processInfo.operatingSystemVersion
        let osString = "macOS \(osVer.majorVersion).\(osVer.minorVersion).\(osVer.patchVersion)"

        #if arch(arm64)
        let archName = "Apple Silicon (arm64)"
        let archTag = "arm64"
        let coreText = "\(detector.chipName) • \(detector.totalCores) Çekirdek (\(detector.performanceCores)P + \(detector.efficiencyCores)E)"
        let threadText = "\(detector.optimalThreadCount) eşzamanlı görev (P/E dengeli)"
        #else
        let archName = "Intel (x86_64)"
        let archTag = "x86_64"
        let coreCount = ProcessInfo.processInfo.processorCount
        let coreText = "\(detector.chipName) • \(coreCount) Çekirdek"
        let optimalIntelThreads = max(2, coreCount > 4 ? coreCount - 1 : coreCount)
        let threadText = "\(optimalIntelThreads) eşzamanlı görev (çoklu çekirdek)"
        #endif

        let hasBsdtar = FileManager.default.isExecutableFile(atPath: "/usr/bin/bsdtar")
        let hasZip = FileManager.default.isExecutableFile(atPath: "/usr/bin/zip")

        return AboutDiagnostics(
            runtimeArchitecture: archName,
            runtimeArchTag: archTag,
            processorSummary: coreText,
            osVersionString: osString,
            memoryGB: detector.unifiedMemoryGB,
            optimalThreadDescription: threadText,
            sevenZipAvailable: SevenZipEngine.available7zPath != nil,
            unrarAvailable: UnrarEngine.availableUnrarPath != nil,
            rarAvailable: UnrarEngine.availableRarPath != nil,
            systemArchiveToolsAvailable: hasBsdtar || hasZip
        )
    }

    var rarStatusText: String {
        if unrarAvailable && rarAvailable {
            return "Okuma & Oluşturma Hazır"
        } else if unrarAvailable {
            return "Yalnızca Okuma (unrar)"
        } else if rarAvailable {
            return "Yalnızca Oluşturma (rar)"
        }
        return "Sistemde Bulunamadı"
    }
}

// MARK: - Ana Hakkında İçeriği (Ayarlar Sekmesi & Bağımsız Pencere Ortak)

@MainActor
public struct AboutContentView: View {
    @ObservedObject private var settings = AppSettings.shared
    @ObservedObject private var updateChecker = UpdateChecker.shared

    @State private var showReleaseNotesSheet: Bool = false
    @State private var showLicensesSheet: Bool = false
    @State private var copiedVersionInfo: Bool = false

    public let onShowFeedback: ((String) -> Void)?

    private let diagnostics = AboutDiagnostics.current()
    private let websiteURLString = "https://blackowltr.github.io/UnPack/"

    public init(onShowFeedback: ((String) -> Void)? = nil) {
        self.onShowFeedback = onShowFeedback
    }

    private var accentColor: Color {
        settings.accentColorChoice.color
    }

    private var activeReleaseNotes: String {
        if let body = UpdateDownloadManager.shared.releaseInfo?.body, !body.isEmpty {
            return body
        }
        return UnPackReleaseNotes.latestFallbackMarkdown
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            // 1. Kimlik Başlığı & Birincil Aksiyon Kartı
            identityHeroCard

            // 2. Arşiv Motorları & Canlı Durum Tanılaması
            enginesSectionCard

            // 3. Sistem, Donanım ve Gizlilik Mimarisi
            systemSpecsSectionCard

            // 4. Topluluk, Kaynak Kod ve Açık Kaynak Bileşenleri
            linksSectionCard

            // 5. Yalın Telif Hakkı Alt Bilgisi
            footerNote
        }
        .sheet(isPresented: $showReleaseNotesSheet) {
            AboutReleaseNotesSheet(
                version: updateChecker.currentVersion,
                markdown: activeReleaseNotes,
                accentColor: accentColor,
                onDismiss: { showReleaseNotesSheet = false }
            )
        }
        .sheet(isPresented: $showLicensesSheet) {
            AboutLicensesSheet(
                version: updateChecker.currentVersion,
                accentColor: accentColor,
                onDismiss: { showLicensesSheet = false }
            )
        }
    }

    // MARK: - 1. Kimlik Kartı
    private var identityHeroCard: some View {
        VStack(spacing: 0) {
            // Üst Kimlik Bölümü
            HStack(alignment: .center, spacing: 16) {
                appIconBadge

                VStack(alignment: .leading, spacing: 5) {
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text("UnPack")
                            .font(.system(size: 21, weight: .bold))
                            .foregroundColor(.primary)

                        Text("v\(updateChecker.currentVersion)")
                            .font(.system(size: 11, weight: .semibold, design: .monospaced))
                            .foregroundColor(.primary)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 2)
                            .background(Color.primary.opacity(0.06))
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .strokeBorder(Color(NSColor.separatorColor).opacity(0.55), lineWidth: 0.5)
                            )

                        Text("Universal")
                            .font(.system(size: 10.5, weight: .medium))
                            .foregroundColor(.secondary)
                    }

                    Text("macOS için hızlı, sade ve çevrimdışı arşiv yöneticisi.")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)

                    HStack(spacing: 8) {
                        Text("\(diagnostics.runtimeArchTag) • \(diagnostics.osVersionString)")
                            .font(.system(size: 11, design: .monospaced))
                            .foregroundColor(.secondary)
                            .lineLimit(1)

                        Spacer(minLength: 4)

                        Button {
                            copyDiagnosticsSummary()
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: copiedVersionInfo ? "checkmark.circle.fill" : "doc.on.doc")
                                    .font(.system(size: 10.5, weight: .medium))
                                    .foregroundColor(copiedVersionInfo ? .green : accentColor)
                                Text(copiedVersionInfo ? "Kopyalandı" : "Bilgiyi Kopyala")
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundColor(copiedVersionInfo ? .green : .primary)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3.5)
                            .background(Color.primary.opacity(0.045))
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .strokeBorder(Color(NSColor.separatorColor).opacity(0.45), lineWidth: 0.5)
                            )
                        }
                        .buttonStyle(.plain)
                        .help("Sürüm, macOS ve donanım özetini panoya kopyalar")
                    }
                    .padding(.top, 2)
                }
            }
            .padding(16)

            Divider()
                .opacity(0.35)

            // Orta Güncelleme Durum Satırı
            HStack(alignment: .center, spacing: 12) {
                Circle()
                    .fill(updateChecker.updateAvailable ? accentColor : Color.green)
                    .frame(width: 8, height: 8)

                VStack(alignment: .leading, spacing: 2) {
                    Text(updateStatusHeadline)
                        .font(.system(size: 12.5, weight: .semibold))
                        .foregroundColor(.primary)

                    Text(updateStatusSubline)
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer(minLength: 10)

                Button {
                    Task {
                        await updateChecker.checkForUpdates(manual: true)
                    }
                } label: {
                    if updateChecker.isChecking {
                        HStack(spacing: 6) {
                            ProgressView()
                                .controlSize(.small)
                            Text("Denetleniyor...")
                        }
                    } else if updateChecker.updateAvailable {
                        Label("v\(updateChecker.latestVersion) Kur", systemImage: "arrow.down.circle")
                    } else {
                        Label("Güncellemeleri Denetle", systemImage: "arrow.clockwise")
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(accentColor)
                .controlSize(.regular)
                .disabled(updateChecker.isChecking)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 11)

            Divider()
                .opacity(0.35)

            // Alt Hızlı Eylem Çubuğu
            HStack(spacing: 8) {
                Button {
                    showReleaseNotesSheet = true
                } label: {
                    Label("Sürüm Notları", systemImage: "doc.text.magnifyingglass")
                        .font(.system(size: 11.5, weight: .medium))
                }
                .buttonStyle(.bordered)
                .controlSize(.small)

                Button {
                    openExternalURL(websiteURLString)
                } label: {
                    Label("Web Sitesi", systemImage: "safari")
                        .font(.system(size: 11.5, weight: .medium))
                }
                .buttonStyle(.bordered)
                .controlSize(.small)

                Button {
                    openExternalURL("https://github.com/\(updateChecker.repoSlug)")
                } label: {
                    Label("GitHub", systemImage: "chevron.left.forwardslash.chevron.right")
                        .font(.system(size: 11.5, weight: .medium))
                }
                .buttonStyle(.bordered)
                .controlSize(.small)

                Spacer()

                Button {
                    showLicensesSheet = true
                } label: {
                    Label("Lisanslar", systemImage: "text.book.closed")
                        .font(.system(size: 11.5, weight: .medium))
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color(NSColor.windowBackgroundColor).opacity(0.35))
        }
        .background(Color(NSColor.controlBackgroundColor))
        .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 11, style: .continuous)
                .strokeBorder(Color(NSColor.separatorColor).opacity(0.45), lineWidth: 0.5)
        )
        .shadow(color: Color.black.opacity(0.025), radius: 2, y: 1)
    }

    @ViewBuilder
    private var appIconBadge: some View {
        if let appIcon = NSApplication.shared.applicationIconImage {
            Image(nsImage: appIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 68, height: 68)
                .shadow(color: Color.black.opacity(0.14), radius: 5, y: 2)
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(accentColor)
                    .frame(width: 68, height: 68)

                Image(systemName: "archivebox.fill")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(.white)
            }
        }
    }

    private var updateStatusHeadline: String {
        if updateChecker.updateAvailable {
            return "Yeni Sürüm Mevcut: v\(updateChecker.latestVersion)"
        }
        return updateChecker.lastCheckStatus ?? "Güncelleme Denetimi Hazır"
    }

    private var updateStatusSubline: String {
        if let checkDate = updateChecker.lastCheckDate {
            return "Son denetim: \(Self.relativeDateFormatter.string(from: checkDate)) • GitHub Releases"
        }
        return "GitHub Releases üzerinden yeni sürümleri otomatik denetler."
    }

    private static let relativeDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "tr_TR")
        df.dateStyle = .medium
        df.timeStyle = .short
        return df
    }()

    // MARK: - 2. Arşiv Motorları (2x2 Canlı Durum Kartları)
    private var enginesSectionCard: some View {
        AboutGroupSection(title: "Arşiv Motorları ve Yetenekler") {
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 10),
                    GridItem(.flexible(), spacing: 10)
                ],
                spacing: 10
            ) {
                EngineCapabilityTile(
                    icon: "doc.zipper",
                    title: "7-Zip Core (7zz)",
                    formats: ".7z, .iso, .cab, .wim",
                    status: diagnostics.sevenZipAvailable ? "Hazır (Yerleşik)" : "Bulunamadı",
                    isReady: diagnostics.sevenZipAvailable
                )

                EngineCapabilityTile(
                    icon: "archivebox",
                    title: "RAR / UnRAR",
                    formats: ".rar, .rev, .r00, .cbr",
                    status: diagnostics.rarStatusText,
                    isReady: diagnostics.unrarAvailable
                )

                EngineCapabilityTile(
                    icon: "shippingbox",
                    title: "libarchive & ZIP",
                    formats: ".zip, .tar, .tgz, .txz, .zst",
                    status: diagnostics.systemArchiveToolsAvailable ? "Hazır (macOS Yerleşik)" : "Kısıtlı",
                    isReady: diagnostics.systemArchiveToolsAvailable
                )

                EngineCapabilityTile(
                    icon: "externaldrive.badge.checkmark",
                    title: "APFS Space-Saver",
                    formats: "F_PUNCHHOLE + Günlükleme",
                    status: "Etkin (Düşük Disk Modu)",
                    isReady: true
                )
            }
            .padding(12)
        }
    }

    // MARK: - 3. Sistem ve Mimari Kartı
    private var systemSpecsSectionCard: some View {
        AboutGroupSection(title: "Sistem, Donanım ve Güvenlik") {
            VStack(spacing: 0) {
                AboutKeyValueRow(title: "İşlemci & Çekirdek", value: diagnostics.processorSummary)
                AboutRowDivider()
                AboutKeyValueRow(title: "Etkin Mimari & Bellek", value: "\(diagnostics.runtimeArchitecture) • \(diagnostics.memoryGB) GB RAM")
                AboutRowDivider()
                AboutKeyValueRow(title: "Önerilen İş Parçacığı", value: diagnostics.optimalThreadDescription)
                AboutRowDivider()
                AboutKeyValueRow(title: "Şifreleme & Bütünlük", value: "AES-256 Bit • SHA-256 & Zip Slip Koruması")
                AboutRowDivider()
                AboutKeyValueRow(title: "Gizlilik Modeli", value: "%100 Çevrimdışı • Sıfır Telemetri")
            }
        }
    }

    // MARK: - 4. Bağlantılar & Destek Kartı
    private var linksSectionCard: some View {
        AboutGroupSection(title: "Dokümantasyon ve Destek") {
            VStack(spacing: 0) {
                AboutLinkRow(
                    icon: "safari.fill",
                    iconColor: accentColor,
                    title: "Resmi Web Sitesi & Kurulum Rehberi",
                    subtitle: "blackowltr.github.io/UnPack",
                    buttonTitle: "Aç"
                ) {
                    openExternalURL(websiteURLString)
                }

                AboutIconRowDivider()

                AboutLinkRow(
                    icon: "ladybug.fill",
                    iconColor: .orange,
                    title: "Hata Bildir veya Öneri Paylaş",
                    subtitle: "github.com/\(updateChecker.repoSlug)/issues",
                    buttonTitle: "Sorun Bildir"
                ) {
                    openExternalURL("https://github.com/\(updateChecker.repoSlug)/issues")
                }

                AboutIconRowDivider()

                AboutLinkRow(
                    icon: "shippingbox.and.arrow.backward.fill",
                    iconColor: .gray,
                    title: "Tüm Sürümler & SHA-256 Özetleri",
                    subtitle: "Geçmiş DMG ve ZIP kurulum paketleri",
                    buttonTitle: "Sürümler"
                ) {
                    openExternalURL("https://github.com/\(updateChecker.repoSlug)/releases")
                }
            }
        }
    }

    // MARK: - 5. Alt Bilgi
    private var footerNote: some View {
        VStack(spacing: 3) {
            Text("Telif Hakkı © 2026 blackowltr • MIT Lisansı altında açık kaynak.")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.secondary)

            Text("macOS 14 Sonoma, 15 Sequoia ve üzeri için yerel Swift & SwiftUI.")
                .font(.system(size: 10.5))
                .foregroundColor(.secondary.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 2)
    }

    // MARK: - Eylemler
    private func openExternalURL(_ raw: String) {
        if let url = URL(string: raw) {
            NSWorkspace.shared.open(url)
        }
    }

    private func copyDiagnosticsSummary() {
        let summary = """
        UnPack v\(updateChecker.currentVersion) (Universal Binary)
        Sistem: \(diagnostics.osVersionString)
        Donanım: \(diagnostics.processorSummary) • \(diagnostics.memoryGB) GB RAM
        Mimari: \(diagnostics.runtimeArchitecture)
        Motorlar: 7zz=\(diagnostics.sevenZipAvailable ? "hazir" : "yok"), unrar=\(diagnostics.unrarAvailable ? "hazir" : "yok"), rar=\(diagnostics.rarAvailable ? "hazir" : "yok"), libarchive=\(diagnostics.systemArchiveToolsAvailable ? "hazir" : "yok")
        """

        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(summary, forType: .string)

        copiedVersionInfo = true
        onShowFeedback?("Sürüm ve sistem bilgisi panoya kopyalandı.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            copiedVersionInfo = false
        }
    }
}

// MARK: - Menü Bar "UnPack Hakkında" Bağımsız Pencere Denetleyicisi

@MainActor
public final class AboutWindowController {
    public static let shared = AboutWindowController()

    private var aboutWindow: NSWindow?

    private init() {}

    public func show() {
        if let win = aboutWindow {
            win.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            return
        }

        let rootView = StandaloneAboutWindowView(
            onClose: { [weak self] in
                self?.close()
            }
        )

        let hosting = NSHostingController(rootView: rootView)
        let win = NSWindow(contentViewController: hosting)
        win.styleMask = [.titled, .closable, .miniaturizable]
        win.title = "UnPack Hakkında"
        win.titlebarAppearsTransparent = true
        win.titleVisibility = .hidden
        win.isMovableByWindowBackground = true
        win.isReleasedWhenClosed = false
        win.setContentSize(NSSize(width: 540, height: 640))
        win.center()

        self.aboutWindow = win
        win.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    public func close() {
        aboutWindow?.close()
        aboutWindow = nil
    }
}

@MainActor
private struct StandaloneAboutWindowView: View {
    @ObservedObject private var settings = AppSettings.shared
    @State private var feedbackMessage: String? = nil
    let onClose: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                AboutContentView(onShowFeedback: { msg in
                    withAnimation {
                        feedbackMessage = msg
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation {
                            feedbackMessage = nil
                        }
                    }
                })
                .padding(.horizontal, 22)
                .padding(.top, 28)
                .padding(.bottom, 20)
            }

            Divider()
                .opacity(0.45)

            HStack {
                if let msg = feedbackMessage {
                    HStack(spacing: 6) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text(msg)
                            .font(.system(size: 11, weight: .medium))
                    }
                } else {
                    Text("UnPack • macOS Yerli Arşiv Yöneticisi")
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                }

                Spacer()

                Button("Tamam") {
                    onClose()
                }
                .keyboardShortcut(.defaultAction)
                .buttonStyle(.borderedProminent)
                .tint(settings.accentColorChoice.color)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color(NSColor.controlBackgroundColor).opacity(0.6))
        }
        .frame(width: 540, height: 640)
        .background(Color(NSColor.windowBackgroundColor))
        .tint(settings.accentColorChoice.color)
    }
}

// MARK: - Sürüm Notları & Açık Kaynak Lisans Panelleri

@MainActor
private struct AboutReleaseNotesSheet: View {
    let version: String
    let markdown: String
    let accentColor: Color
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 14) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(accentColor)
                        .frame(width: 36, height: 36)

                    Image(systemName: "doc.text.magnifyingglass")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text("UnPack Yenilikler & Sürüm Notları")
                        .font(.system(size: 15, weight: .bold))
                    Text("UnPack v\(version) Sürüm Geçmişi")
                        .font(.system(size: 11.5))
                        .foregroundColor(.secondary)
                }

                Spacer()

                Button("Tamam") {
                    onDismiss()
                }
                .keyboardShortcut(.defaultAction)
                .buttonStyle(.borderedProminent)
                .tint(accentColor)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)

            Divider()

            ReleaseNotesMarkdownView(markdown: markdown)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
        }
        .frame(width: 560, height: 500)
        .background(Color(NSColor.windowBackgroundColor))
    }
}

@MainActor
private struct AboutLicensesSheet: View {
    let version: String
    let accentColor: Color
    let onDismiss: () -> Void

    private let mitLicenseText = """
    MIT License

    Copyright (c) 2026 blackowltr (UnPack)

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
    """

    var body: some View {
        VStack(spacing: 14) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.secondary.opacity(0.16))
                        .frame(width: 36, height: 36)

                    Image(systemName: "text.book.closed.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(accentColor)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text("Açık Kaynak Lisansları ve Bileşenler")
                        .font(.system(size: 15, weight: .bold))
                    Text("UnPack v\(version) • Üçüncü Taraf Arşiv Motorları")
                        .font(.system(size: 11.5))
                        .foregroundColor(.secondary)
                }

                Spacer()

                Button("Tamam") {
                    onDismiss()
                }
                .keyboardShortcut(.defaultAction)
                .buttonStyle(.borderedProminent)
                .tint(accentColor)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)

            Divider()

            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    AboutGroupSection(title: "Kullanılan Arşiv ve Sistem Bileşenleri") {
                        VStack(spacing: 0) {
                            AboutKeyValueRow(title: "7-Zip Console (7zz)", value: "GNU LGPL / 7-Zip License (Igor Pavlov)")
                            AboutRowDivider()
                            AboutKeyValueRow(title: "libarchive (macOS bsdtar)", value: "New BSD License")
                            AboutRowDivider()
                            AboutKeyValueRow(title: "UnRAR / RAR for macOS", value: "WinRAR / rarlab Freeware UnRAR License")
                            AboutRowDivider()
                            AboutKeyValueRow(title: "UnPack Uygulama Kodu", value: "MIT License • Saf Swift & SwiftUI")
                        }
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("MIT Lisans Metni")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(.secondary)
                            .padding(.leading, 4)

                        Text(mitLicenseText)
                            .font(.system(size: 10.5, design: .monospaced))
                            .foregroundColor(.secondary)
                            .textSelection(.enabled)
                            .padding(14)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(NSColor.controlBackgroundColor))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .strokeBorder(Color(NSColor.separatorColor).opacity(0.4), lineWidth: 0.5)
                            )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .frame(width: 560, height: 500)
        .background(Color(NSColor.windowBackgroundColor))
    }
}

// MARK: - Yardımcı Bileşenler

private struct AboutGroupSection<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(.secondary)
                .padding(.leading, 4)

            VStack(spacing: 0) {
                content
            }
            .background(Color(NSColor.controlBackgroundColor))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .strokeBorder(Color(NSColor.separatorColor).opacity(0.4), lineWidth: 0.5)
            )
            .shadow(color: Color.black.opacity(0.02), radius: 2, y: 1)
        }
    }
}

private struct EngineCapabilityTile: View {
    let icon: String
    let title: String
    let formats: String
    let status: String
    let isReady: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 7) {
                Image(systemName: icon)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.secondary)
                    .frame(width: 16)

                Text(title)
                    .font(.system(size: 12.5, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Spacer(minLength: 4)

                Circle()
                    .fill(isReady ? Color.green : Color.orange)
                    .frame(width: 7, height: 7)
            }

            Text(formats)
                .font(.system(size: 10.5, design: .monospaced))
                .foregroundColor(.secondary)
                .lineLimit(1)

            Text(status)
                .font(.system(size: 10.5, weight: .medium))
                .foregroundColor(isReady ? .primary.opacity(0.8) : .orange)
                .lineLimit(1)
        }
        .padding(.horizontal, 11)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(NSColor.windowBackgroundColor).opacity(0.55))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .strokeBorder(Color(NSColor.separatorColor).opacity(0.35), lineWidth: 0.5)
        )
    }
}

private struct AboutKeyValueRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack(spacing: 12) {
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.secondary)
            Spacer(minLength: 10)
            Text(value)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.primary)
                .multilineTextAlignment(.trailing)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 9.5)
    }
}

private struct AboutLinkRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let buttonTitle: String
    let action: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(iconColor)
                    .frame(width: 26, height: 26)

                Image(systemName: icon)
                    .font(.system(size: 12.5, weight: .semibold))
                    .foregroundColor(.white)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.primary)

                Text(subtitle)
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }

            Spacer(minLength: 10)

            Button(buttonTitle, action: action)
                .buttonStyle(.bordered)
                .controlSize(.regular)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
    }
}

private struct AboutRowDivider: View {
    var body: some View {
        Divider()
            .opacity(0.35)
            .padding(.leading, 14)
    }
}

private struct AboutIconRowDivider: View {
    var body: some View {
        Divider()
            .opacity(0.35)
            .padding(.leading, 52)
    }
}
