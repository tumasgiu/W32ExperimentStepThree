import PackageDescription

let package = Package(
        name: "W32App",
        dependencies: [
            .Package(url: "https://github.com/tinysun212/Win32.git", majorVersion: 1, minor: 0)
        ]
)
