import CWin32
import Win32

class AppDelegate: ApplicationDelegate {
    func main() -> Int {
        let mBox = MessageBox(message: "Hello Windows !")
        mBox.display()
        return 0
    }
}

let delegate = AppDelegate()

let hinst = GetModuleHandleA(nil)
// TODO: replace this dummy with CommandLine
let dummy: UnsafeMutablePointer<CHAR>? = UnsafeMutablePointer.allocate(capacity: 1)

Application.delegate = delegate
Application.run(hInstance: hinst!, lpCmdLine: dummy!, nCmdShow: 0)
