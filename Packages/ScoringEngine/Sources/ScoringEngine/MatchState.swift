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
    public private(set) var sets: [SetScore] = []

    public init(format: MatchFormat) {
        self.format = format
    }

    public mutating func pointWon(by side: Side) {
        points[side] += 1
        guard points.isWon(by: side, target: 4) else { return }
        games[side] += 1
        points = Score()
        guard games.isWon(by: side, target: format.gamesPerSet) else { return }
        sets.append(SetScore(games: games))
        games = Score()
    }

    public static func replay(format: MatchFormat, pointWinners: [Side]) -> MatchState {
        var state = MatchState(format: format)
        for side in pointWinners {
            state.pointWon(by: side)
        }
        return state
    }
}
