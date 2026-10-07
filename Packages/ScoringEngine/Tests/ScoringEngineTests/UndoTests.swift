import Testing
import ScoringEngine

@Suite("Undo")
struct UndoTests {
    @Test func undoGameWinningPoint() {
        let state = MatchState.undoingLast("aaab" + "a")
        #expect(state.games[.a] == 0)
        #expect(state.points[.a] == 3)
        #expect(state.points[.b] == 1)
    }

    @Test func undoSetWinningPoint() {
        let state = MatchState.undoingLast(games(.a, 5) + games(.b, 4) + games(.a, 1))
        #expect(state.sets.isEmpty)
        #expect(state.games[.a] == 5)
        #expect(state.games[.b] == 4)
        #expect(state.points[.a] == 3)
    }

    @Test func undoGameThatStartsTiebreak() {
        let state = MatchState.undoingLast(sixAll)
        #expect(state.kind == .regular)
        #expect(state.games[.a] == 6)
        #expect(state.games[.b] == 5)
    }

    @Test func undoTiebreakWinningPoint() {
        let state = MatchState.undoingLast(sixAll + tiebreak(7, 5))
        #expect(state.sets.isEmpty)
        #expect(state.kind == .tiebreak(target: 7))
        #expect(state.points[.a] == 6)
        #expect(state.points[.b] == 5)
    }

    @Test func undoMatchWinningPoint() {
        let state = MatchState.undoingLast(sets(.a, 2))
        #expect(state.winner == nil)
        #expect(state.sets.count == 1)
        #expect(state.games[.a] == 5)
    }

    @Test func undoRestoresServer() {
        #expect(MatchState.played(games(.a, 1)).server == .b)
        #expect(MatchState.undoingLast(games(.a, 1)).server == .a)
    }

    @Test func undoLandsOnTheSameStateAsNeverPlaying() {
        #expect(MatchState.undoingLast("aaab") == MatchState.played("aaa"))
    }
}
