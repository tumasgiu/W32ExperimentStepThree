import PackageDescription

let package = Package(
    name: "W32App",
    dependencies: [
        .Package(url: "https://github.com/tumasgiu/GDI.git", majorVersion: 0, minor: 1)
    ]
)
