//
//  TiebreakTests.swift
//  ScoringEngine
//
//  Created by BURAKHAN OZAY on 6.10.2026.
//

import Testing
import ScoringEngine

@Suite("Tiebreak")
struct TiebreakTests {
    static let sixAll = games(.a, 5) + games(.b, 5) + games(.a, 1) + games(.b, 1)

    @Test func sixAllStartsTiebreak() {
        let state = MatchState.played(Self.sixAll)
        #expect(state.kind == .tiebreak(target: 7))
        #expect(state.sets.isEmpty)
    }

    @Test(arguments: [(7, 0), (7, 5), (8, 6), (12, 10)])
    func tiebreakEnds(a: Int, b: Int) {
        let state = MatchState.played(Self.sixAll + tiebreak(a, b))
        #expect(state.sets.count == 1)
        #expect(state.sets[0].games[.a] == 7)
        #expect(state.sets[0].games[.b] == 6)
        #expect(state.sets[0].tiebreak?[.a] == a)
        #expect(state.sets[0].tiebreak?[.b] == b)
        #expect(state.kind == .regular)
        #expect(state.games[.a] == 0)
        #expect(state.games[.b] == 0)
    }

    @Test(arguments: [(6, 6), (7, 6)])
    func tiebreakContinues(a: Int, b: Int) {
        let state = MatchState.played(Self.sixAll + tiebreak(a, b))
        #expect(state.sets.isEmpty)
        #expect(state.kind == .tiebreak(target: 7))
    }

    @Test func tiebreakPointText() {
        let state = MatchState.played(Self.sixAll + tiebreak(3, 2))
        #expect(state.pointText(for: .a) == "3")
        #expect(state.pointText(for: .b) == "2")
    }
}
