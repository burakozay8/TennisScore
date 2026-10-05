//
//  Side.swift
//  ScoringEngine
//
//  Created by BURAKHAN OZAY on 5.10.2026.
//

public enum Side: Sendable {
    case a, b
    public var opponent: Side {
        self == .a ? .b : .a
    }
}
