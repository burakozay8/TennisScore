import Foundation
import Testing
import ScoringEngine
@testable import TennisScore

@MainActor
@Suite("ScoringSession")
struct ScoringSessionTests {
    static func session(_ format: MatchFormat = .bestOf3, winners: [Side] = []) -> ScoringSession {
        var snapshot = MatchSnapshot(format: format, firstServer: .a, playerA: "Burak", playerB: "Kaan")
        snapshot.pointLog = winners.map { Point(winner: $0, at: .now) }
        return ScoringSession(snapshot: snapshot)
    }

    static let oneSet = MatchFormat(setsToWin: 1)

    @Test func scoreRecordsPointAndAdvancesState() {
        let session = Self.session()
        let before = Date.now
        session.score(.a)
        #expect(session.snapshot.pointLog.map(\.winner) == [.a])
        #expect(session.snapshot.pointLog[0].at >= before)
        #expect(session.state.points[.a] == 1)
    }

    @Test func everyChangeBumpsRevisionAndNotifies() {
        let session = Self.session()
        var notified: [Int] = []
        session.onChange = { notified.append($0.revision) }
        session.score(.a)
        session.score(.b)
        session.undo()
        #expect(session.snapshot.revision == 3)
        #expect(notified == [1, 2, 3])
    }

    @Test func matchWinningPointRecordsEndTime() {
        let session = Self.session(Self.oneSet)
        for _ in 0..<24 { session.score(.a) }
        #expect(session.state.winner == .a)
        #expect(session.snapshot.endedAt != nil)
    }

    @Test func pointsAfterMatchAreIgnored() {
        let session = Self.session(Self.oneSet)
        for _ in 0..<24 { session.score(.a) }
        session.score(.b)
        #expect(session.snapshot.pointLog.count == 24)
        #expect(session.snapshot.revision == 24)
    }

    @Test func undoReopensFinishedMatch() {
        let session = Self.session(Self.oneSet)
        for _ in 0..<24 { session.score(.a) }
        session.undo()
        #expect(session.state.winner == nil)
        #expect(session.snapshot.endedAt == nil)
        #expect(session.state.games[.a] == 5)
    }

    @Test func undoWithNoPointsDoesNothing() {
        let session = Self.session()
        var notified = false
        session.onChange = { _ in notified = true }
        session.undo()
        #expect(session.snapshot.revision == 0)
        #expect(!notified)
    }

    @Test func restoresMatchInProgress() {
        let session = Self.session(winners: [.a, .a, .a, .a, .b])
        #expect(session.state.games[.a] == 1)
        #expect(session.state.points[.b] == 1)
    }

    @Test func stateAlwaysMatchesSnapshot() {
        let session = Self.session()
        let taps: [Side?] = [.a, .a, .b, nil, .a, .a, .a, nil, nil, .b, .b, .b, .b, nil, .a]
        for tap in taps {
            if let side = tap { session.score(side) } else { session.undo() }
            #expect(session.state == session.snapshot.state)
        }
    }
}
