//
//  MatchState.swift
//  ScoringEngine
//
//  Created by BURAKHAN OZAY on 5.10.2026.
//

public struct MatchState: Sendable {
    public let format: MatchFormat
    public private(set) var games = Score()
    public private(set) var points = Score()

    public init(format: MatchFormat) {
        self.format = format
    }

    public mutating func pointWon(by side: Side) {
        points[side] += 1
        guard points[side] >= 4, points[side] - points[side.opponent] >= 2 else { return }
        games[side] += 1
        points = Score()
    }

    public static func replay(format: MatchFormat, points: [Side]) -> MatchState {
        var state = MatchState(format: format)
        for side in points {
            state.pointWon(by: side)
        }
        return state
    }
}
