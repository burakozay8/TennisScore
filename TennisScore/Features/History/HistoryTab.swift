import SwiftUI

struct HistoryTab: View {
    @Environment(\.palette) private var palette

    var body: some View {
        ContentUnavailableView("No matches yet", systemImage: "clock.arrow.circlepath",
                               description: Text("Finished matches will appear here."))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(palette.background)
    }
}
