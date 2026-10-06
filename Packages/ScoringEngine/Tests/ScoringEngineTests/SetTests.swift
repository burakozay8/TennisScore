import Testing
import ScoringEngine

@Suite("Set")
struct SetTests {
    @Test(arguments: [
        (games(.a, 6), 6, 0),
        (games(.a, 5) + games(.b, 4) + games(.a, 1), 6, 4),
        (games(.a, 5) + games(.b, 5) + games(.a, 2), 7, 5),
    ])
    func setEnds(sequence: String, a: Int, b: Int) {
        let state = MatchState.played(sequence)
        #expect(state.sets.count == 1)
        #expect(state.sets[0].games[.a] == a)
        #expect(state.sets[0].games[.b] == b)
        #expect(state.games[.a] == 0)
        #expect(state.games[.b] == 0)
    }

    @Test(arguments: [
        games(.a, 5) + games(.b, 5) + games(.a, 1),
        games(.a, 5) + games(.b, 5),
    ])
    func setContinues(sequence: String) {
        let state = MatchState.played(sequence)
        #expect(state.sets.isEmpty)
    }

    @Test func advantageSetNeedsTwoGameLead() {
        let format = MatchFormat(tiebreakInSets: false)
        let sevenSix = games(.a, 5) + games(.b, 5) + games(.a, 1) + games(.b, 1) + games(.a, 1)

        let stillPlaying = MatchState.played(sevenSix, format)
        #expect(stillPlaying.sets.isEmpty)

        let finished = MatchState.played(sevenSix + games(.a, 1), format)
        #expect(finished.sets.count == 1)
        #expect(finished.sets[0].games[.a] == 8)
        #expect(finished.sets[0].games[.b] == 6)
    }
}
