import SwiftUI
import SwiftData

@main
struct TennisScoreApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: Match.self)
    }
}
