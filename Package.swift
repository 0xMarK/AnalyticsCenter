// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AnalyticsCenter",
    products: [
        .library(
            name: "AnalyticsCenter",
            targets: ["AnalyticsCenter"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AnalyticsCenter",
            dependencies: []),
        .testTarget(
            name: "AnalyticsCenterTests",
            dependencies: ["AnalyticsCenter"]),
    ]
)
