//
//  MatchSnapshot.swift
//  ScoringEngine
//
//  Created by BURAKHAN OZAY on 12.10.2026.
//

import Foundation

public struct MatchSnapshot: Codable, Sendable, Hashable, Identifiable {
    public let id: UUID
    public let format: MatchFormat
    public let firstServer: Side
    public let playerA: String
    public let playerB: String
    public let startedAt: Date
    public var pointLog: [Point]
    public var endedAt: Date?      // nil while the match is in progress
    public var revision: Int

    public init(
        id: UUID = UUID(),
        format: MatchFormat,
        firstServer: Side,
        playerA: String,
        playerB: String,
        startedAt: Date = .now
    )
    {
        self.id = id
        self.format = format
        self.firstServer = firstServer
        self.playerA = playerA
        self.playerB = playerB
        self.startedAt = startedAt
        self.pointLog = []
        self.revision = 0
    }

    public var state: MatchState {
        .replay(format: format, firstServer: firstServer, pointWinners: pointLog.map(\.winner))
    }
}
