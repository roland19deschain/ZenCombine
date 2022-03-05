// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "ZenCombine",
	platforms: [
		.iOS(.v13),
		.tvOS(.v13),
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
