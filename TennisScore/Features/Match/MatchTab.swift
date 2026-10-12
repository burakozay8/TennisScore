import SwiftUI

struct MatchTab: View {
    @Environment(\.palette) private var palette

    var body: some View {
        ContentUnavailableView("No match in progress", systemImage: "tennisball",
                               description: Text("Set up a match to start scoring."))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(palette.background)
    }
}
