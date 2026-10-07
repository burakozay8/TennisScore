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
        let pointWinners = sequence.compactMap { Side(rawValue: String($0)) }
        return replay(format: format, pointWinners: pointWinners)
    }
}

let sixAll = games(.a, 5) + games(.b, 5) + games(.a, 1) + games(.b, 1)

func games(_ side: Side, _ count: Int) -> String {
    String(repeating: side.rawValue, count: 4 * count)
}

func tiebreak(_ a: Int, _ b: Int) -> String {
    let level = String(repeating: "ab", count: min(a, b))
    let leader = a > b ? "a" : "b"
    return level + String(repeating: leader, count: abs(a - b))
}

func sets(_ side: Side, _ count: Int) -> String {
    String(repeating: games(side, 6), count: count)
}
