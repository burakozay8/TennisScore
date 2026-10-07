//
//  SetScore.swift
//  ScoringEngine
//
//  Created by BURAKHAN OZAY on 6.10.2026.
//

public struct SetScore: Sendable {
    public let games: Score
    public let tiebreak: Score?   // the tiebreak points if the set ended 7-6, otherwise nil

    public var winner: Side {
        games[.a] > games[.b] ? .a : .b
    }
}
