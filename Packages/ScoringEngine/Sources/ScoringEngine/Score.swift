//
//  Score.swift
//  ScoringEngine
//
//  Created by BURAKHAN OZAY on 5.10.2026.
//

public struct Score: Sendable, Hashable {
    public var a: Int
    public var b: Int

    public init(a: Int = 0, b: Int = 0) {
        self.a = a
        self.b = b
    }

    public subscript(side: Side) -> Int {
        get {
            switch side {
            case .a: return a
            case .b: return b
            }
        }
        set {
            switch side {
            case .a: a = newValue
            case .b: b = newValue
            }
        }
    }
}

extension Score {
    func isWon(by side: Side, target: Int) -> Bool {
        self[side] >= target && self[side] - self[side.opponent] >= 2
    }
}
