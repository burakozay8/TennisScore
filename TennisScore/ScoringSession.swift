import Foundation
import Observation
import ScoringEngine

@Observable
final class ScoringSession {
    private(set) var snapshot: MatchSnapshot
    private(set) var state: MatchState
    @ObservationIgnored var onChange: ((MatchSnapshot) -> Void)?

    init(snapshot: MatchSnapshot) {
        self.snapshot = snapshot
        self.state = snapshot.state
    }

    func score(_ side: Side) {
        if state.winner != nil { return }
        snapshot.pointLog.append(Point(winner: side, at: .now))
        state.pointWon(by: side)
        if state.winner != nil { snapshot.endedAt = .now }
        commit()
    }

    func undo() {
        if snapshot.pointLog.isEmpty { return }
        snapshot.pointLog.removeLast()
        snapshot.endedAt = nil
        state = snapshot.state
        commit()
    }

    private func commit() {
        snapshot.revision += 1
        onChange?(snapshot)
    }
}
