// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "AugmentedButton",
    platforms: [
        .iOS(.v9),
	],
	products: [
		.library(name: "AugmentedButton", targets: ["AugmentedButton"]),
	],
	targets: [
		.target(name: "AugmentedButton", path: "Sources"),
		
		.testTarget(name: "AugmentedButtonTests", dependencies: ["AugmentedButton"])
	]
)
