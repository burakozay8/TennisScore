import SwiftUI

enum CourtTheme: String, CaseIterable, Identifiable {
    case night, grass, clay

    var id: Self { self }

    var name: String { rawValue.capitalized }

    var palette: Palette {
        switch self {
        case .night:
            Palette.night
        case .grass:
            Palette.grass
        case .clay:
            Palette.clay
        }
    }
}
