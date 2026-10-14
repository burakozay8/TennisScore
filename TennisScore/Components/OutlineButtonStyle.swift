import SwiftUI

struct OutlineButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        OutlineButton(configuration: configuration)
    }

    private struct OutlineButton: View {
        let configuration: ButtonStyleConfiguration
        @Environment(\.palette) private var palette
        @Environment(\.isEnabled) private var isEnabled

        var body: some View {
            configuration.label
                .font(.headline)
                .foregroundStyle(palette.primary)
                .padding(.horizontal, Spacing.l)
                .frame(minHeight: Size.control)
                .overlay(RoundedRectangle(cornerRadius: Radius.large)
                    .strokeBorder(palette.line, lineWidth: 1)
                )
                .contentShape(.rect)
                .opacity(!isEnabled ? 0.4 : (configuration.isPressed ? 0.8 : 1))
                .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
        }
    }
}

#Preview {
    Button("Toss", systemImage: "shuffle") {}
        .buttonStyle(OutlineButtonStyle())
        .padding(Spacing.l)
        .background(Palette.night.background)
}
