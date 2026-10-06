//
//  GameTests.swift
//  ScoringEngine
//
//  Created by BURAKHAN OZAY on 5.10.2026.
//

import Testing
import ScoringEngine

@Suite("Game")
struct GameTests {
    @Test func loveGameWinsAGame() {
        let state = MatchState.played("aaaa")
        #expect(state.games[.a] == 1)
        #expect(state.points[.a] == 0)
        #expect(state.points[.b] == 0)
    }

    @Test func threePointsDoNotWinAGame() {
        let state = MatchState.played("aaa")
        #expect(state.points[.a] == 3)
        #expect(state.games[.a] == 0)
    }

    @Test func deuceNeedsTwoPointLead() {
        var state = MatchState.played("aaabbba")
        #expect(state.points[.a] == 4)
        #expect(state.points[.b] == 3)
        #expect(state.games[.a] == 0)
        state.pointWon(by: .b)
        #expect(state.games[.a] == 0)
        state.pointWon(by: .a)
        state.pointWon(by: .a)
        #expect(state.games[.a] == 1)
    }

    @Test(arguments: [1, 5, 20])
    func longDeuceStillNeedsTwoPointLead(deuces: Int) {
        let deuce = "aaabbb" + String(repeating: "ab", count: deuces)
        let stillDeuce = MatchState.played(deuce)
        #expect(stillDeuce.games[.a] == 0)
        #expect(stillDeuce.games[.b] == 0)
        #expect(stillDeuce.points[.a] == stillDeuce.points[.b])

        let won = MatchState.played(deuce + "aa")
        #expect(won.games[.a] == 1)
        #expect(won.points[.a] == 0)
    }

    @Test(arguments: [
        ("", "0", "0"), ("a", "15", "0"), ("aa", "30", "0"), ("aaa", "40", "0"),
        ("aaabbb", "40", "40"), ("aaabbba", "AD", "40"), ("aaabbbab", "40", "40"),
        ("aaabbbb", "40", "AD"),
    ])
    func pointText(sequence: String, a: String, b: String) {
        let state = MatchState.played(sequence)
        #expect(state.pointText(for: .a) == a)
        #expect(state.pointText(for: .b) == b)
    }
}
