//
//  Point.swift
//  ScoringEngine
//
//  Created by BURAKHAN OZAY on 12.10.2026.
//

import Foundation

public struct Point: Codable, Sendable, Hashable {
    public let winner: Side
    public let at: Date

    public init(winner: Side, at: Date) {
        self.winner = winner
        self.at = at
    }
}
