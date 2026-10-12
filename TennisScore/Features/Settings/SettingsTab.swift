import SwiftUI

struct SettingsTab: View {
    @AppStorage("courtTheme") private var theme: CourtTheme = .night
    @Environment(\.palette) private var palette

    var body: some View {
        NavigationStack {
            Form {
                Picker("Court theme", selection: $theme) {
                    ForEach(CourtTheme.allCases) { option in
                        Text(option.name).tag(option)
                    }
                }
                .listRowBackground(palette.surface)
            }
            .tint(palette.accent)
            .scrollContentBackground(.hidden)
            .background(palette.background)
            .navigationTitle("Settings")
        }
    }
}
