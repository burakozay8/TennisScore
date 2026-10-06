//
//  GameKind.swift
//  ScoringEngine
//
//  Created by BURAKHAN OZAY on 6.10.2026.
//

public enum GameKind: Sendable, Equatable {
    case regular                 // a normal game: 0, 15, 30, 40
    case tiebreak(target: Int)   // a tiebreak: first to `target` points, win by 2
}
