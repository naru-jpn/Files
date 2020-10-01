// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Files",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "Files",
            targets: ["Files"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Files",
            dependencies: [],
            path: "Sources/Files"
        ),
        .testTarget(
            name: "FilesTests",
            dependencies: ["Files"],
            path: "Tests/FilesTests"
        ),
    ]
)
