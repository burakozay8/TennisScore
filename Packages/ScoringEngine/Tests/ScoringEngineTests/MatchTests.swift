import Testing
import ScoringEngine

@Suite("Match")
struct MatchTests {
    @Test(arguments: [1, 2, 3])
    func winningEnoughSetsEndsMatch(setsToWin: Int) {
        let format = MatchFormat(setsToWin: setsToWin)

        let oneSetShort = MatchState.played(sets(.a, setsToWin - 1), format)
        #expect(oneSetShort.winner == nil)

        let finished = MatchState.played(sets(.a, setsToWin), format)
        #expect(finished.winner == .a)
    }

    @Test func bestOfThreeTwoSetsToOne() {
        let state = MatchState.played(sets(.a, 1) + sets(.b, 1) + sets(.a, 1))
        #expect(state.winner == .a)
        #expect(state.sets.count == 3)
    }

    @Test func pointsAfterMatchAreIgnored() {
        let state = MatchState.played(sets(.a, 2) + "bbbbb")
        #expect(state.winner == .a)
        #expect(state.sets.count == 2)
        #expect(state.games[.b] == 0)
        #expect(state.points[.b] == 0)
    }
}
