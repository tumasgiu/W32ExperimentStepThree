Tested on Cygwin 2.5.2 with
[swift-cygwin-20160815](https://github.com/tinysun212/swift-windows/releases/tag/swift-cygwin-20160815)

Compile the Win32 Swift library :  

`swiftc -force-single-frontend-invocation -parse-as-library -emit-library -I /usr/include/ -I /usr/include/w32api/ -I CWin32/ -module-name "Win32" Win32/Sources/*`

Now we should have a `libWin32.dll` in working directory  

Compile the Swift App :  

`swiftc -I /usr/include/ -I /usr/include/w32api/ -I CWin32/ -L. SwiftW32App.swift`
