//
//  MatchFormat.swift
//  ScoringEngine
//
//  Created by BURAKHAN OZAY on 5.10.2026.
//

public struct MatchFormat: Sendable, Hashable {
    public enum FinalSet: Sendable, Hashable {
        case regular
        case finalSetTiebreak
        case matchTiebreak
    }

    public var setsToWin: Int
    public var gamesPerSet: Int
    public var tiebreakInSets: Bool
    public var finalSet: FinalSet

    public init(setsToWin: Int = 2,
                gamesPerSet: Int = 6,
                tiebreakInSets: Bool = true,
                finalSet: FinalSet = .regular)
    {
        self.setsToWin = setsToWin
        self.gamesPerSet = gamesPerSet
        self.tiebreakInSets = tiebreakInSets
        self.finalSet = finalSet
    }

    public static let bestOf3 = MatchFormat()
}
