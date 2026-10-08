//
//  MatchState+Text.swift
//  ScoringEngine
//
//  Created by BURAKHAN OZAY on 6.10.2026.
//

extension MatchState {
    private static let callouts = ["0", "15", "30", "40"]

    public func pointText(for side: Side) -> String {
        let own = points[side]
        if case .tiebreak = kind {
            return String(own)
        }
        let other = points[side.opponent]
        if own >= 3 && other >= 3 {
            return own > other ? "AD" : "40"
        }
        return Self.callouts[own]
    }

    public func summary(from side: Side) -> String {
        sets.map { $0.text(from: side) }.joined(separator: " ")
    }
}

extension SetScore {
    func text(from side: Side) -> String {
        let setScore = "\(games[side])-\(games[side.opponent])"
        if let tiebreak {
            if isMatchTiebreak {
                return "[\(tiebreak[side])-\(tiebreak[side.opponent])]"
            }
            return "\(setScore)(\(min(tiebreak[.a], tiebreak[.b])))"
        }
        return setScore
    }
}
