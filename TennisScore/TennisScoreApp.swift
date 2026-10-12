//
//  TennisScoreApp.swift
//  TennisScore
//
//  Created by BURAKHAN OZAY on 12.10.2026.
//

import SwiftUI
import SwiftData

@main
struct TennisScoreApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        } .modelContainer(for: Match.self)
    }
}
