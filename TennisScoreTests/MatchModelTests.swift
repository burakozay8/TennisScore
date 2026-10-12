import Foundation
import SwiftData
import Testing
import ScoringEngine
@testable import TennisScore

@MainActor
@Suite("Match model")
struct MatchModelTests {
    static let start = Date(timeIntervalSince1970: 1_791_000_000)

    static func games(_ side: Side, _ count: Int) -> String {
        String(repeating: side.rawValue, count: 4 * count)
    }

    static func snapshot(_ sequence: String, format: MatchFormat = .bestOf3) -> MatchSnapshot {
        var snapshot = MatchSnapshot(format: format, firstServer: .b,
                                     playerA: "Burak", playerB: "Kaan", startedAt: start)
        let winners = sequence.compactMap { Side(rawValue: String($0)) }
        snapshot.pointLog = winners.enumerated().map { index, winner in
            Point(winner: winner, at: start.addingTimeInterval(Double(index) * 30))
        }
        snapshot.revision = snapshot.pointLog.count
        return snapshot
    }

    @Test func snapshotRoundTripThroughDatabase() throws {
        let container = try ModelContainer(for: Match.self,
                                           configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        var original = Self.snapshot("aaaabbbba", format: MatchFormat(finalSet: .matchTiebreak))
        original.endedAt = Self.start.addingTimeInterval(3_600)

        container.mainContext.insert(Match(snapshot: original))
        try container.mainContext.save()

        let freshContext = ModelContext(container)
        let stored = try #require(try freshContext.fetch(FetchDescriptor<Match>()).first)
        #expect(stored.snapshot == original)
    }

    @Test func applyUpdatesChangingFields() {
        var snapshot = Self.snapshot("")
        let match = Match(snapshot: snapshot)

        snapshot.pointLog = Self.snapshot("aaaa").pointLog
        snapshot.endedAt = Self.start.addingTimeInterval(600)
        snapshot.revision = 4
        match.apply(snapshot)

        #expect(match.pointLog.count == 4)
        #expect(match.endedAt == snapshot.endedAt)
        #expect(match.revision == 4)
        #expect(match.playerA == "Burak")
    }

    @Test func summaryUsesWinnersPointOfView() {
        let firstSet = Self.games(.b, 5) + Self.games(.a, 3) + Self.games(.b, 1)
        let secondSet = Self.games(.b, 5) + Self.games(.a, 4) + Self.games(.b, 1)
        let match = Match(snapshot: Self.snapshot(firstSet + secondSet))
        #expect(match.snapshot.state.winner == .b)
        #expect(match.summary == "6-3 6-4")
    }

    @Test func summaryOfMatchInProgressUsesSideA() {
        let firstSet = Self.games(.a, 5) + Self.games(.b, 4) + Self.games(.a, 1)
        let secondSetSoFar = Self.games(.a, 2) + Self.games(.b, 1)
        let match = Match(snapshot: Self.snapshot(firstSet + secondSetSoFar))
        #expect(match.summary == "6-4")
    }
}
