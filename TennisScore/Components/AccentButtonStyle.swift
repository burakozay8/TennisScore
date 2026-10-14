import SwiftUI

struct AccentButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        AccentButton(configuration: configuration)
    }

    private struct AccentButton: View {
        let configuration: ButtonStyleConfiguration
        @Environment(\.palette) private var palette
        @Environment(\.isEnabled) private var isEnabled

        var body: some View {
            configuration.label
                .font(.actionLabel)
                .textCase(.uppercase)
                .tracking(3)
                .foregroundStyle(palette.onAccent)
                .frame(maxWidth: .infinity, minHeight: Size.control)
                .background(palette.accent, in: .capsule)
                .opacity(!isEnabled ? 0.4 : (configuration.isPressed ? 0.8 : 1))
                .scaleEffect(configuration.isPressed ? 0.98 : 1)
                .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
        }
    }
}

#Preview {
    VStack(spacing: Spacing.l) {
        Button("Start match") {}
            .buttonStyle(AccentButtonStyle())
        Button("Start match") {}
            .buttonStyle(AccentButtonStyle())
            .disabled(true)
    }
    .padding(Spacing.l)
    .background(Palette.night.background)
}
