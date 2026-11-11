import Foundation
import SwiftUI

/// Desteklenen arşiv formatları ve yetenekleri
public enum ArchiveFormat: String, CaseIterable, Identifiable, Sendable {
    case rar = "RAR"
    case zip = "ZIP"
    case sevenZip = "7Z"
    case tar = "TAR"
    case tarGz = "TAR.GZ"
    case tarBz2 = "TAR.BZ2"
    case tarXz = "TAR.XZ"
    case zstd = "Zstandard"
    case iso = "ISO"
    case dmg = "DMG"
    case cab = "CAB"

    public var id: String { rawValue }

    /// Formatın tipik dosya uzantıları
    public var extensions: [String] {
        switch self {
        case .rar: return ["rar", "rev", "r00", "r01", "cbr"]
        case .zip: return ["zip", "zipx", "cbz", "jar", "war"]
        case .sevenZip: return ["7z", "cb7"]
        case .tar: return ["tar"]
        case .tarGz: return ["tar.gz", "tgz"]
        case .tarBz2: return ["tar.bz2", "tbz2", "tbz"]
        case .tarXz: return ["tar.xz", "txz"]
        case .zstd: return ["zst", "tar.zst"]
        case .iso: return ["iso"]
        case .dmg: return ["dmg"]
        case .cab: return ["cab"]
        }
    }

    /// Birincil dosya uzantısı
    public var primaryExtension: String {
        switch self {
        case .rar: return "rar"
        case .zip: return "zip"
        case .sevenZip: return "7z"
        case .tar: return "tar"
        case .tarGz: return "tar.gz"
        case .tarBz2: return "tar.bz2"
        case .tarXz: return "tar.xz"
        case .zstd: return "tar.zst"
        case .iso: return "iso"
        case .dmg: return "dmg"
        case .cab: return "cab"
        }
    }

    /// UnPack tarafından yeni arşiv olarak oluşturulabilir mi?
    public var canCompress: Bool {
        switch self {
        case .rar, .zip, .tar, .tarGz, .tarBz2, .tarXz, .sevenZip:
            return true
        case .zstd, .iso, .dmg, .cab:
            return false
        }
    }

    /// Ayıklanabilir mi?
    public var canExtract: Bool {
        return true
    }

    /// Parola ile şifreleme destekliyor mu?
    public var supportsEncryption: Bool {
        switch self {
        case .zip, .sevenZip, .rar:
            return true
        default:
            return false
        }
    }

    /// SF Symbol simgesi
    public var systemIcon: String {
        switch self {
        case .rar: return "doc.zipper"
        case .zip: return "doc.badge.gearshape"
        case .sevenZip: return "archivebox.fill"
        case .tar, .tarGz, .tarBz2, .tarXz: return "shippingbox.fill"
        case .iso: return "opticaldisc.fill"
        case .dmg: return "externaldrive.fill"
        default: return "doc.zipper"
        }
    }

    /// Format birincil sistem rengi
    public var liquidPrimaryColor: Color {
        switch self {
        case .rar:
            return Color(red: 0.24, green: 0.38, blue: 0.68) // Cobalt Slate
        case .zip:
            return Color(red: 0.04, green: 0.46, blue: 0.90) // System Blue
        case .sevenZip:
            return Color(red: 0.04, green: 0.62, blue: 0.42) // Forest Emerald
        case .tar, .tarGz:
            return Color(red: 0.35, green: 0.42, blue: 0.56) // Steel Slate
        case .tarBz2:
            return Color(red: 0.42, green: 0.44, blue: 0.54) // Iron Slate
        case .tarXz:
            return Color(red: 0.18, green: 0.36, blue: 0.72) // Deep Cobalt
        case .zstd:
            return Color(red: 0.08, green: 0.56, blue: 0.72) // Ocean Teal
        case .iso, .dmg:
            return Color(red: 0.28, green: 0.48, blue: 0.80) // Mac Disk Blue
        case .cab:
            return Color(red: 0.46, green: 0.49, blue: 0.56) // Graphite
        }
    }

    /// Format ikincil ton rengi
    public var liquidSecondaryColor: Color {
        switch self {
        case .rar:
            return Color(red: 0.42, green: 0.56, blue: 0.82)
        case .zip:
            return Color(red: 0.25, green: 0.68, blue: 0.95)
        case .sevenZip:
            return Color(red: 0.25, green: 0.80, blue: 0.58)
        case .tar, .tarGz:
            return Color(red: 0.54, green: 0.62, blue: 0.78)
        case .tarBz2:
            return Color(red: 0.60, green: 0.62, blue: 0.72)
        case .tarXz:
            return Color(red: 0.40, green: 0.56, blue: 0.86)
        case .zstd:
            return Color(red: 0.32, green: 0.74, blue: 0.86)
        case .iso, .dmg:
            return Color(red: 0.50, green: 0.68, blue: 0.92)
        case .cab:
            return Color(red: 0.66, green: 0.69, blue: 0.76)
        }
    }

    /// Format renk geçişi
    public var liquidGradient: LinearGradient {
        LinearGradient(
            colors: [liquidPrimaryColor, liquidPrimaryColor.opacity(0.88)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    /// Format SF Sembolü
    public var liquidSymbol: String {
        switch self {
        case .rar: return "books.vertical.fill"
        case .zip: return "doc.zipper"
        case .sevenZip: return "archivebox.fill"
        case .tar, .tarGz, .tarBz2, .tarXz: return "shippingbox.fill"
        case .iso: return "opticaldisc.fill"
        case .dmg: return "externaldrive.fill"
        case .zstd: return "bolt.fill"
        case .cab: return "cabinet.fill"
        }
    }

    /// Türkçe açıklama
    public var localizedDescription: String {
        switch self {
        case .rar: return "WinRAR Arşivi (RAR4 / RAR5)"
        case .zip: return "Standart ZIP Arşivi"
        case .sevenZip: return "7-Zip Yüksek Sıkıştırmalı Arşiv"
        case .tar: return "Unix Tape Arşivi"
        case .tarGz: return "Gzip Sıkıştırmalı Tar Arşivi"
        case .tarBz2: return "Bzip2 Sıkıştırmalı Tar Arşivi"
        case .tarXz: return "XZ / LZMA Sıkıştırmalı Tar Arşivi"
        case .zstd: return "Zstandard Yüksek Hızlı Arşiv"
        case .iso: return "Optik Disk Görüntüsü (ISO 9660)"
        case .dmg: return "Apple Disk Görüntüsü"
        case .cab: return "Microsoft Dolap Arşivi"
        }
    }

    /// Dosya başlığındaki sihirli byte'lardan (Magic Bytes) formatı tespit eder
    public static func detect(from url: URL) -> ArchiveFormat? {
        // Önce dosya uzantısını kontrol et
        let ext = url.pathExtension.lowercased()
        let filename = url.lastPathComponent.lowercased()

        if filename.hasSuffix(".tar.gz") || filename.hasSuffix(".tgz") { return .tarGz }
        if filename.hasSuffix(".tar.bz2") || filename.hasSuffix(".tbz2") { return .tarBz2 }
        if filename.hasSuffix(".tar.xz") || filename.hasSuffix(".txz") { return .tarXz }
        if filename.hasSuffix(".tar.zst") { return .zstd }

        for format in ArchiveFormat.allCases {
            if format.extensions.contains(ext) {
                return format
            }
        }

        // Uzantı tutmazsa sihirli byte'ları oku
        guard let handle = try? FileHandle(forReadingFrom: url) else { return nil }
        defer { try? handle.close() }

        guard let headerData = try? handle.read(upToCount: 32), headerData.count >= 4 else { return nil }
        let bytes = [UInt8](headerData)

        // RAR4: 52 61 72 21 1A 07 00
        // RAR5: 52 61 72 21 1A 07 01 00
        if bytes.count >= 7,
           bytes[0] == 0x52, bytes[1] == 0x61, bytes[2] == 0x72, bytes[3] == 0x21,
           bytes[4] == 0x1A, bytes[5] == 0x07 {
            return .rar
        }

        // ZIP: 50 4B 03 04 veya 50 4B 05 06 (boş)
        if bytes[0] == 0x50, bytes[1] == 0x4B {
            return .zip
        }

        // 7Z: 37 7A BC AF 27 1C
        if bytes.count >= 6,
           bytes[0] == 0x37, bytes[1] == 0x7A, bytes[2] == 0xBC, bytes[3] == 0xAF,
           bytes[4] == 0x27, bytes[5] == 0x1C {
            return .sevenZip
        }

        // GZ: 1F 8B
        if bytes[0] == 0x1F, bytes[1] == 0x8B {
            return .tarGz
        }

        // BZ2: 42 5A (BZ)
        if bytes[0] == 0x42, bytes[1] == 0x5A {
            return .tarBz2
        }

        // XZ: FD 37 7A 58 5A 00
        if bytes.count >= 6,
           bytes[0] == 0xFD, bytes[1] == 0x37, bytes[2] == 0x7A,
           bytes[3] == 0x58, bytes[4] == 0x5A, bytes[5] == 0x00 {
            return .tarXz
        }

        return nil
    }
}
