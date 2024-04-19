// swift-tools-version:5.10
import PackageDescription


let swiftSettings: [SwiftSetting] = [
	.enableExperimentalFeature("StrictConcurrency")
]

let package = Package(
	name: "HTTPCoders",
	products: {
		var ret = [Product]()
		ret.append(.library(name: "FormDataCoder",       targets: ["FormDataCoder"]))
		ret.append(.library(name: "FormURLEncodedCoder", targets: ["FormURLEncodedCoder"]))
		return ret
	}(),
	dependencies: {
		var ret = [Package.Dependency]()
		ret.append(.package(url: "https://github.com/apple/swift-collections.git", from: "1.0.1"))
		ret.append(.package(url: "https://github.com/Frizlab/stream-reader.git",   from: "3.5.0"))
		return ret
	}(),
	targets: {
		var ret = [Target]()
		ret.append(.target(name: "FormDataCoder", dependencies: {
			var ret = [Target.Dependency]()
			ret.append(.product(name: "OrderedCollections", package: "swift-collections"))
			ret.append(.product(name: "StreamReader",       package: "stream-reader"))
			return ret
		}(), swiftSettings: swiftSettings))
		ret.append(.testTarget(name: "FormDataCoderTests", dependencies: ["FormDataCoder"], swiftSettings: swiftSettings))
		
		ret.append(.target(name: "FormURLEncodedCoder", swiftSettings: swiftSettings))
		ret.append(.testTarget(name: "FormURLEncodedCoderTests", dependencies: ["FormURLEncodedCoder"], swiftSettings: swiftSettings))
		return ret
	}()
)
