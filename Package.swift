// swift-tools-version:5.9

import PackageDescription

let package = Package(
	name: "ZenCombine",
	platforms: [
		.iOS(.v14),
		.tvOS(.v14),
		.macOS(.v10_15),
		.watchOS(.v6)
	],
	products: [
		.library(
			name: "ZenCombine",
			type: .static,
			targets: ["ZenCombine"]
		)
	],
	dependencies: [],
	targets: [
		.target(
			name: "ZenCombine",
			dependencies: [],
			path: "Sources/"
		),
		.testTarget(
			name: "ZenCombineTests",
			dependencies: ["ZenCombine"],
			path: "Tests/"
		)
	],
	swiftLanguageVersions: [.v5]
)
