import SwiftUI
import Testing
@testable import TennisScore

@MainActor
@Suite("Theme")
struct ThemeTests {
    @Test func storedThemeNamesNeverChange() {
        #expect(CourtTheme.allCases.map(\.rawValue) == ["night", "grass", "clay"])
    }

    @Test func hexSplitsIntoChannels() {
        let resolved = Color(hex: 0xD4F04C).resolve(in: EnvironmentValues())
        #expect(abs(Double(resolved.red) - 212.0 / 255) < 0.001)
        #expect(abs(Double(resolved.green) - 240.0 / 255) < 0.001)
        #expect(abs(Double(resolved.blue) - 76.0 / 255) < 0.001)
    }

    @Test func eachThemeHasItsOwnAccent() {
        let accents = CourtTheme.allCases.map { $0.palette.accent.resolve(in: EnvironmentValues()) }
        #expect(Set(accents.map { "\($0.red)-\($0.green)-\($0.blue)" }).count == 3)
    }
}
