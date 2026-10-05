//
//  MatchFormatTests.swift
//  ScoringEngine
//
//  Created by BURAKHAN OZAY on 5.10.2026.
//

import Testing
import ScoringEngine

@Suite("MatchFormat")
struct MatchFormatTests {
    @Test func bestOf3UsesStandardRules() {
        let bestOf3 = MatchFormat.bestOf3
        #expect(bestOf3.setsToWin == 2)
        #expect(bestOf3.gamesPerSet == 6)
        #expect(bestOf3.tiebreakInSets)
        #expect(bestOf3.finalSet == .regular)
    }
}
