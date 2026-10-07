//
//  FinalSetTests.swift
//  ScoringEngine
//
//  Created by BURAKHAN OZAY on 7.10.2026.
//

import Testing
import ScoringEngine

@Suite("Final set")
struct FinalSetTests {
    // --- match tiebreak: replaces the deciding set ---

    static let matchTiebreak = MatchFormat(finalSet: .matchTiebreak)
    static let oneSetAll = sets(.a, 1) + sets(.b, 1)

    @Test(arguments: [2, 3])   // best of 3 → 1-1, best of 5 → 2-2
    func matchTiebreakReplacesDecidingSet(setsToWin: Int) {
        let format = MatchFormat(setsToWin: setsToWin, finalSet: .matchTiebreak)
        let state = MatchState.played(sets(.a, setsToWin - 1) + sets(.b, setsToWin - 1), format)
        #expect(state.kind == .tiebreak(target: 10))
        #expect(state.winner == nil)
        #expect(state.games[.a] == 0)
        #expect(state.games[.b] == 0)
    }

    @Test(arguments: [(10, 0), (10, 8), (12, 10)])
    func matchTiebreakDecidesMatch(a: Int, b: Int) {
        let state = MatchState.played(Self.oneSetAll + tiebreak(a, b), Self.matchTiebreak)
        #expect(state.winner == .a)
        #expect(state.sets.count == 3)
        #expect(state.sets[2].games[.a] == 1)
        #expect(state.sets[2].games[.b] == 0)
        #expect(state.sets[2].tiebreak?[.a] == a)
        #expect(state.sets[2].tiebreak?[.b] == b)
        #expect(state.sets[2].isMatchTiebreak)
    }

    @Test(arguments: [(9, 9), (10, 9)])
    func matchTiebreakNeedsTwoPointLead(a: Int, b: Int) {
        let state = MatchState.played(Self.oneSetAll + tiebreak(a, b), Self.matchTiebreak)
        #expect(state.winner == nil)
        #expect(state.kind == .tiebreak(target: 10))
    }

    // --- final set tiebreak: deciding set at 6-6 → tiebreak to 10 ---

    @Test(arguments: [2, 3])
    func finalSetTiebreakStartsAtSixAll(setsToWin: Int) {
        let format = MatchFormat(setsToWin: setsToWin, finalSet: .finalSetTiebreak)
        let state = MatchState.played(sets(.a, setsToWin - 1) + sets(.b, setsToWin - 1) + sixAll, format)
        #expect(state.kind == .tiebreak(target: 10))
    }

    @Test func finalSetTiebreakDecidesMatch() {
        let format = MatchFormat(finalSet: .finalSetTiebreak)
        let state = MatchState.played(Self.oneSetAll + sixAll + tiebreak(10, 8), format)
        #expect(state.winner == .a)
        #expect(state.sets[2].games[.a] == 7)
        #expect(state.sets[2].games[.b] == 6)
        #expect(state.sets[2].tiebreak?[.a] == 10)
        #expect(state.sets[2].tiebreak?[.b] == 8)
        #expect(!state.sets[2].isMatchTiebreak)
    }

    @Test func earlierSetsKeepSevenPointTiebreak() {
        let format = MatchFormat(finalSet: .finalSetTiebreak)
        let state = MatchState.played(sixAll, format)
        #expect(state.kind == .tiebreak(target: 7))
    }

    // --- regular: nothing changes ---

    @Test func regularDecidingSetIsPlayedNormally() {
        let decidingSetStarts = MatchState.played(Self.oneSetAll)
        #expect(decidingSetStarts.kind == .regular)

        let decidingSetAtSixAll = MatchState.played(Self.oneSetAll + sixAll)
        #expect(decidingSetAtSixAll.kind == .tiebreak(target: 7))
    }
}
