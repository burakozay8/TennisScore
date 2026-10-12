import SwiftUI

struct RootView: View {
    @AppStorage("courtTheme") private var theme: CourtTheme = .night

    var body: some View {
        TabView {
            Tab("Match", systemImage: "tennisball") {
                MatchTab()
            }
            Tab("History", systemImage: "clock.arrow.circlepath") {
                HistoryTab()
            }
            Tab("Settings", systemImage: "slider.horizontal.3") {
                SettingsTab()
            }
        }
        .environment(\.palette, theme.palette)
        .tint(theme.palette.accent)
        .preferredColorScheme(.dark)
    }
}
