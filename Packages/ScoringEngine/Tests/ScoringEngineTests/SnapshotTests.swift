import Foundation
import Testing
import ScoringEngine

@Suite("Snapshot")
struct SnapshotTests {
    static let start = Date(timeIntervalSince1970: 1_791_000_000)

    static func snapshot(_ sequence: String = "",
                         format: MatchFormat = .bestOf3,
                         firstServer: Side = .a) -> MatchSnapshot
    {
        var snapshot = MatchSnapshot(format: format, firstServer: firstServer,
                                     playerA: "Burak", playerB: "Kaan", startedAt: start)
        let winners = sequence.compactMap { Side(rawValue: String($0)) }
        snapshot.pointLog = winners.enumerated().map { index, winner in
            Point(winner: winner, at: start.addingTimeInterval(Double(index) * 30))
        }
        return snapshot
    }

    @Test func newMatchStartsEmpty() {
        let snapshot = Self.snapshot()
        #expect(snapshot.pointLog.isEmpty)
        #expect(snapshot.endedAt == nil)
        #expect(snapshot.revision == 0)
        #expect(snapshot.state == MatchState(format: .bestOf3, firstServer: .a))
    }

    @Test func stateReplaysPointLog() {
        let snapshot = Self.snapshot("aaaa")
        #expect(snapshot.state.games[.a] == 1)
        #expect(snapshot.state == MatchState.played("aaaa"))
    }

    @Test func stateUsesFirstServer() {
        let snapshot = Self.snapshot(firstServer: .b)
        #expect(snapshot.state.server == .b)
    }

    @Test func jsonRoundTrip() throws {
        var original = Self.snapshot("aaabbba", format: MatchFormat(finalSet: .matchTiebreak))
        original.endedAt = Self.start.addingTimeInterval(3_600)
        original.revision = 7

        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(MatchSnapshot.self, from: data)
        #expect(decoded == original)
    }

    @Test func finalSetEncodesAsPlainString() throws {
        let data = try JSONEncoder().encode(MatchFormat(finalSet: .matchTiebreak))
        let json = try #require(String(data: data, encoding: .utf8))
        #expect(json.contains(#""finalSet":"matchTiebreak""#))
    }
}
