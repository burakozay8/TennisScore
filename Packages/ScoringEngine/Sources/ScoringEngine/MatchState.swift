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
    public private(set) var kind: GameKind = .regular
    public private(set) var winner: Side?   // nil while the match is in progress

    public init(format: MatchFormat) {
        self.format = format
    }

    private var pointsToWinGame: Int {
        switch kind {
        case .regular:
            return 4
        case .tiebreak(let target):
            return target
        }
    }

    private var isDecidingSet: Bool {
        setsWon(by: .a) == format.setsToWin - 1 && setsWon(by: .b) == format.setsToWin - 1
    }

    private func setsWon(by side: Side) -> Int {
        sets.count(where: { $0.winner == side })
    }

    public mutating func pointWon(by side: Side) {
        guard winner == nil else { return }
        points[side] += 1
        guard points.isWon(by: side, target: pointsToWinGame) else { return }
        let tiebreakScore: Score? = if case .tiebreak = kind { points } else { nil }
        games[side] += 1
        points = Score()
        kind = .regular
        if tiebreakScore != nil || games.isWon(by: side, target: format.gamesPerSet) {
            sets.append(SetScore(games: games, tiebreak: tiebreakScore))
            games = Score()
            let setsWonBySide = setsWon(by: side)
            if setsWonBySide == format.setsToWin {
                winner = side
                return
            }
            if isDecidingSet && format.finalSet == .matchTiebreak {
                kind = .tiebreak(target: 10)
            }
            return
        }
        if games[side] == format.gamesPerSet && games[side.opponent] == format.gamesPerSet {
            if isDecidingSet && format.finalSet == .finalSetTiebreak {
                kind = .tiebreak(target: 10)
            } else if format.tiebreakInSets {
                kind = .tiebreak(target: 7)
            }
        }
    }

    public static func replay(format: MatchFormat, pointWinners: [Side]) -> MatchState {
        var state = MatchState(format: format)
        for side in pointWinners {
            state.pointWon(by: side)
        }
        return state
    }
}
