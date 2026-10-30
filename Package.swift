// swift-tools-version: 5.10
import PackageDescription

var mxGraphEditorExclude: [String] = []
#if !os(macOS) && !os(visionOS) && !os(iOS) && !os(tvOS) && !os(watchOS)
  mxGraphEditorExclude = [
    "FileDialog.mm",
  ]
#endif

let package = Package(
  name: "MetaApps",
  platforms: [
    .macOS(.v14),
    .visionOS(.v1),
    .iOS(.v17),
    .tvOS(.v17),
    .watchOS(.v10),
  ],
  products: [
    .executable(
      name: "MXGraphEditor",
      targets: ["MXGraphEditor"]
    ),
    .executable(
      name: "MetaversalDemo",
      targets: ["MetaversalDemo"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/the-swift-collective/imgui", from: "1.92.0"),
    .package(url: "https://github.com/wabiverse/MetaOneTBB.git", from: "1.0.0"),
    .package(url: "https://github.com/wabiverse/MetaImath.git", from: "1.0.0"),
    .package(url: "https://github.com/wabiverse/MetaOpenEXR.git", from: "1.0.0"),
    .package(url: "https://github.com/wabiverse/MetaOpenColorIO.git", from: "1.0.0"),
    .package(url: "https://github.com/wabiverse/MetaOpenImageIO.git", from: "1.0.0"),
    .package(url: "https://github.com/wabiverse/MetaOpenTimelineIO.git", from: "1.0.0"),
    .package(url: "https://github.com/wabiverse/MetaMaterialX.git", from: "1.0.0"),
    .package(url: "https://github.com/wabiverse/MetaOpenVDB.git", from: "1.0.0"),
    .package(url: "https://github.com/wabiverse/MetaOpenSubdiv.git", from: "1.0.0"),
    .package(url: "https://github.com/wabiverse/MetaPtex.git", from: "1.0.0"),
    .package(url: "https://github.com/wabiverse/MetaDraco.git", from: "1.0.0"),
    .package(url: "https://github.com/wabiverse/MetaMicrosoftSTL.git", from: "1.0.0"),
  ],
  targets: [
    .executableTarget(
      name: "MXGraphEditor",
      dependencies: [
        .product(name: "MaterialX", package: "MetaMaterialX"),
        .product(name: "backend_glfw", package: "imgui"),
        .product(name: "backend_opengl3", package: "imgui"),
      ],
      exclude: mxGraphEditorExclude,
      cxxSettings: [
        .define("_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH", .when(platforms: [.windows])),
        .define("_ALLOW_KEYWORD_MACROS", to: "1", .when(platforms: [.windows])),
        .define("static_assert(_conditional, ...)", to: "", .when(platforms: [.windows])),
      ]
    ),
    .executableTarget(
      name: "MetaversalDemo",
      dependencies: [
        .product(name: "OneTBB", package: "MetaOneTBB"),
        .product(name: "ImGui", package: "imgui"),
        .product(name: "Imath", package: "MetaImath"),
        .product(name: "OpenEXR", package: "MetaOpenEXR"),
        .product(name: "OpenColorIO", package: "MetaOpenColorIO"),
        .product(name: "OpenImageIO", package: "MetaOpenImageIO"),
        .product(name: "OpenTimelineIO", package: "MetaOpenTimelineIO"),
        .product(name: "MaterialX", package: "MetaMaterialX"),
        .product(name: "OpenVDB", package: "MetaOpenVDB"),
        .product(name: "OpenSubdiv", package: "MetaOpenSubdiv"),
        .product(name: "Ptex", package: "MetaPtex"),
        .product(name: "Draco", package: "MetaDraco"),
        .product(name: "MicrosoftSTL", package: "MetaMicrosoftSTL", condition: .when(platforms: [.windows])),
      ],
      cxxSettings: [
        .define("_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH", .when(platforms: [.windows])),
        .define("_ALLOW_KEYWORD_MACROS", to: "1", .when(platforms: [.windows])),
        .define("static_assert(_conditional, ...)", to: "", .when(platforms: [.windows])),
      ],
      swiftSettings: [
        .interoperabilityMode(.Cxx),
      ]
    ),
  ],
  cLanguageStandard: .gnu17,
  cxxLanguageStandard: .cxx17
)
