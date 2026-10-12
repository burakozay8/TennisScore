import Foundation
import SwiftData
import ScoringEngine

@Model
final class Match {
    @Attribute(.unique) var id: UUID
    var playerA: String
    var playerB: String
    var startedAt: Date
    var endedAt: Date?
    var format: MatchFormat
    var firstServer: Side
    var pointLog: [Point]
    var revision: Int
    var summary: String          // cached score line for the history list

    init(snapshot: MatchSnapshot) {
        id = snapshot.id
        playerA = snapshot.playerA
        playerB = snapshot.playerB
        startedAt = snapshot.startedAt
        endedAt = snapshot.endedAt
        format = snapshot.format
        firstServer = snapshot.firstServer
        pointLog = snapshot.pointLog
        revision = snapshot.revision
        summary = ""
        apply(snapshot)
    }

    func apply(_ snapshot: MatchSnapshot) {
        pointLog = snapshot.pointLog
        endedAt = snapshot.endedAt
        revision = snapshot.revision
        let state = snapshot.state
        summary = state.summary(from: state.winner ?? .a)
    }

    var snapshot: MatchSnapshot {
        var snapshot = MatchSnapshot(id: id, format: format, firstServer: firstServer,
                                     playerA: playerA, playerB: playerB, startedAt: startedAt)
        snapshot.pointLog = pointLog
        snapshot.endedAt = endedAt
        snapshot.revision = revision
        return snapshot
    }
}
