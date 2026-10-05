//
//  ScoreTests.swift
//  ScoringEngine
//
//  Created by BURAKHAN OZAY on 5.10.2026.
//

import Testing
import ScoringEngine

@Suite("Score")
struct ScoreTests {
    @Test func subscriptReadsAndWritesEachSide() {
        var score = Score(a: 2, b: 5)
        #expect(score[.a] == 2)
        #expect(score[.b] == 5)

        score[.a] += 1

        #expect(score[.a] == 3)
        #expect(score[.b] == 5)
    }
}
