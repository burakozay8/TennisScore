//
//  Helpers.swift
//  ScoringEngine
//
//  Created by BURAKHAN OZAY on 5.10.2026.
//

import ScoringEngine

extension MatchState {
    static func played(_ sequence: String,
                       _ format: MatchFormat = .bestOf3) -> MatchState
    {
        let points = sequence.compactMap { Side(rawValue: String($0)) }
        return replay(format: format, points: points)
    }
}
