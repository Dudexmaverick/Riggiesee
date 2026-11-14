
// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "RiggieSee",
    dependencies: [
        .package(
            url: "https://github.com/rhx/SwiftGtk.git",
            branch: "gtk4"
        )
    ],
    targets: [
        .executableTarget(
            name: "RiggieSee",
            dependencies: [
                .product(
                    name: "Gtk",
                    package: "SwiftGtk"
                )
            ]
        )
    ]
)
