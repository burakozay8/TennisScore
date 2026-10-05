//
//  Test.swift
//  ScoringEngine
//
//  Created by BURAKHAN OZAY on 5.10.2026.
//

import Testing
import ScoringEngine

@Suite("Side")
struct SideTests {
    @Test func opponentSwapsSides() {
        #expect(Side.a.opponent == .b)
        #expect(Side.b.opponent == .a)
    }
}
