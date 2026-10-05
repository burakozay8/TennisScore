// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "ScoringEngine",
    platforms: [
        .iOS(.v26),
        .watchOS(.v26),
        .macOS(.v26),
    ],
    products: [
        .library(name: "ScoringEngine", targets: ["ScoringEngine"]),
    ],
    targets: [
        .target(name: "ScoringEngine"),
        .testTarget(name: "ScoringEngineTests", dependencies: ["ScoringEngine"]),
    ]
)
