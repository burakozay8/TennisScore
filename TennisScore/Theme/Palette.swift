import SwiftUI

struct Palette {
    let background: Color
    let surface: Color
    let line: Color
    let primary: Color
    let secondary: Color
    let accent: Color
    let onAccent: Color
}

extension Palette {
    static let night = Palette(
        background: Color(hex: 0x0A1222),
        surface: Color(hex: 0x121E37),
        line: Color(hex: 0x22325A),
        primary: Color(hex: 0xF2F5FA),
        secondary: Color(hex: 0x95A2BC),
        accent: Color(hex: 0xD4F04C),
        onAccent: Color(hex: 0x0A1222)
    )

    static let grass = Palette(
        background: Color(hex: 0x0D2619),
        surface: Color(hex: 0x153524),
        line: Color(hex: 0x24503A),
        primary: Color(hex: 0xF3EEDF),
        secondary: Color(hex: 0xA9BBA8),
        accent: Color(hex: 0xBBA2F2),
        onAccent: Color(hex: 0x0D2619)
    )

    static let clay = Palette(
        background: Color(hex: 0x1C120E),
        surface: Color(hex: 0x2B1B14),
        line: Color(hex: 0x4A2E22),
        primary: Color(hex: 0xF7EDE4),
        secondary: Color(hex: 0xC2A595),
        accent: Color(hex: 0xE8784A),
        onAccent: Color(hex: 0x1C120E)
    )
}

extension Color {
    init(hex: UInt32) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

extension EnvironmentValues {
    @Entry var palette: Palette = .night
}
