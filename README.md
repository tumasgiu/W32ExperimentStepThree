
### Step 1

Compile the Win32 Swift library :  

```
swiftc -emit-library -I /usr/include/ -I /usr/include/w32api/ -I CWin32/ -module-name "Win32" Win32/MessageBox.swift Win32/Application.swift
```

Now we should have a `libWin32.dll` in working directory

### Step 2

Compile the Swift App Library :  

`swiftc -I /usr/include/ -I /usr/include/w32api/ -I CWin32/ -L. -lWin32 SwiftW32App.swift`

### Step 3

`cc -L. -lSwiftW32App -o app.exe main.c`