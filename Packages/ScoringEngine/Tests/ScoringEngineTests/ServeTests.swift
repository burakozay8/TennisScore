import Testing
import ScoringEngine

@Suite("Serve")
struct ServeTests {
    @Test(arguments: [Side.a, .b])
    func firstServerServesFirstPoint(first: Side) {
        let state = MatchState.played("", firstServer: first)
        #expect(state.server == first)
    }

    @Test(arguments: [Side.a, .b])
    func serveAlternatesEveryGame(first: Side) {
        #expect(MatchState.played("aa", firstServer: first).server == first)
        #expect(MatchState.played(games(.a, 1), firstServer: first).server == first.opponent)
        #expect(MatchState.played(games(.a, 2), firstServer: first).server == first)
    }

    @Test func serveOrderContinuesIntoNextSet() {
        let sixFour = MatchState.played(games(.a, 5) + games(.b, 4) + games(.a, 1))
        #expect(sixFour.sets.count == 1)
        #expect(sixFour.server == .a)

        let sixThree = MatchState.played(games(.a, 5) + games(.b, 3) + games(.a, 1))
        #expect(sixThree.sets.count == 1)
        #expect(sixThree.server == .b)
    }

    @Test(arguments: [(0, Side.a), (1, .b), (2, .b), (3, .a), (4, .a), (5, .b)])
    func tiebreakServeRotation(pointsPlayed: Int, expected: Side) {
        let tiebreakPoints = String("ababab".prefix(pointsPlayed))
        let state = MatchState.played(sixAll + tiebreakPoints)
        #expect(state.kind == .tiebreak(target: 7))
        #expect(state.server == expected)
    }

    @Test(arguments: [Side.a, .b])
    func setAfterTiebreakIsOpenedByTheReceiver(first: Side) {
        let state = MatchState.played(sixAll + tiebreak(7, 5), firstServer: first)
        #expect(state.sets.count == 1)
        #expect(state.server == first.opponent)
    }

    @Test func matchTiebreakContinuesServeOrder() {
        let format = MatchFormat(finalSet: .matchTiebreak)
        let sixLove = sets(.a, 1)
        let oneSix = games(.b, 5) + games(.a, 1) + games(.b, 1)

        let start = MatchState.played(sixLove + oneSix, format)
        #expect(start.kind == .tiebreak(target: 10))
        #expect(start.server == .b)

        let afterOnePoint = MatchState.played(sixLove + oneSix + "a", format)
        #expect(afterOnePoint.server == .a)
    }
}
