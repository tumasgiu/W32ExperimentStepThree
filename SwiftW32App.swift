import CWin32
import Win32

let delegate = AppDelegate()

@_silgen_name("swiftW32App")
public func winMain(hInstance: HINSTANCE, lpCmdLine: LPSTR, nCmdShow: Int) -> Int {
    Application.delegate = delegate
    return Application.run(hInstance: hInstance, lpCmdLine: lpCmdLine, nCmdShow: nCmdShow)
}

class AppDelegate: ApplicationDelegate {

    func main() -> Int {
        let mBox = MessageBox(message: "Hello Windows !")
        mBox.display()
        return 0
    }

}
