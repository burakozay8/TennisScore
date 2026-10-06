extension MatchState {
    private static let callouts = ["0", "15", "30", "40"]

    public func pointText(for side: Side) -> String {
        let own = points[side]
        let other = points[side.opponent]
        if own >= 3 && other >= 3 {
            return own > other ? "AD" : "40"
        }
        return Self.callouts[own]
    }
}
