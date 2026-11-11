import SwiftUI

/// WinRAR'ın klasik araç çubuğu ikonlarını modern Apple macOS estetiğiyle birleştiren yüksek kaliteli buton bileşeni
public struct WinRARToolbarButton: View {
    public let title: String
    public let icon: String
    public let color: Color
    public let shortcut: KeyEquivalent?
    public let action: () -> Void

    @State private var isHovered: Bool = false

    public init(
        title: String,
        icon: String,
        color: Color = AppSettings.shared.accentColorChoice.color,
        shortcut: KeyEquivalent? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.color = color
        self.shortcut = shortcut
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(spacing: 3) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(isHovered ? Color.primary.opacity(0.08) : Color(NSColor.controlBackgroundColor).opacity(0.7))
                        .frame(width: 36, height: 32)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .strokeBorder(
                                    Color(NSColor.separatorColor).opacity(isHovered ? 0.55 : 0.30),
                                    lineWidth: 0.6
                                )
                        )

                    Image(systemName: icon)
                        .font(.system(size: 15, weight: .semibold))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(color)
                }

                Text(title)
                    .font(.system(size: 11, weight: isHovered ? .semibold : .medium))
                    .foregroundStyle(Color.primary)
                    .lineLimit(1)
            }
            .frame(width: 62, height: 52)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            withAnimation(.spring(response: 0.25, dampingFraction: 0.75)) {
                isHovered = hovering
            }
        }
        .help(title)
    }
}
