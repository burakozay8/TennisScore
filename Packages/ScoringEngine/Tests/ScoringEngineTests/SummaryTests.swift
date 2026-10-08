import Testing
import ScoringEngine

@Suite("Summary")
struct SummaryTests {
    static let oneSetAll = sets(.a, 1) + sets(.b, 1)

    @Test func noFinishedSetsIsEmpty() {
        #expect(MatchState.played("").summary(from: .a) == "")
    }

    @Test func regularSetsFromBothSides() {
        let fourSix = games(.b, 5) + games(.a, 4) + games(.b, 1)
        let state = MatchState.played(sets(.a, 1) + fourSix)
        #expect(state.summary(from: .a) == "6-0 4-6")
        #expect(state.summary(from: .b) == "0-6 6-4")
    }

    @Test func setTiebreakShowsLoserPoints() {
        let state = MatchState.played(sixAll + tiebreak(7, 5))
        #expect(state.summary(from: .a) == "7-6(5)")
        #expect(state.summary(from: .b) == "6-7(5)")
    }

    @Test func matchTiebreakInBrackets() {
        let format = MatchFormat(finalSet: .matchTiebreak)
        let state = MatchState.played(Self.oneSetAll + tiebreak(10, 8), format)
        #expect(state.summary(from: .a) == "6-0 0-6 [10-8]")
        #expect(state.summary(from: .b) == "0-6 6-0 [8-10]")
    }

    @Test func finalSetTiebreakLooksLikeASetTiebreak() {
        let format = MatchFormat(finalSet: .finalSetTiebreak)
        let state = MatchState.played(Self.oneSetAll + sixAll + tiebreak(10, 8), format)
        #expect(state.summary(from: .a) == "6-0 0-6 7-6(8)")
    }
}
