import CWin32
import Win32

class AppDelegate: ApplicationDelegate {
    func main() {

        print("instance : \(Application.shared.hInstance.pointee)")

        do {
            let wc = try WindowClass(identifier: "MainWindow") { hwnd, messageCode, wParam, lParam in
                print("code : \(String(messageCode, radix: 16)) , message: \(SystemMessage.WindowManager(rawValue: messageCode))")

                guard let message = SystemMessage.WindowManager(rawValue: messageCode)
                else {
                    return DefWindowProcW(hwnd, messageCode, wParam, lParam)
                }

                switch message {
                    case .paint:
                        var ps = PAINTSTRUCT()
                        let hdc = BeginPaint(hwnd, &ps)
                        EndPaint(hwnd, &ps)
                    case .destroy:
                        PostQuitMessage(0)
                    default:
                        return DefWindowProcW(hwnd, messageCode, wParam, lParam)
                }

                return DefWindowProcW(hwnd, messageCode, wParam, lParam)
            }

            let window = try Window(class: wc)
            window.display()

            window.title = "Hëllœ"
        } catch {
            let mBox = MessageBox(message: "\(error)")
            mBox.display()
            PostQuitMessage(1)
        }
    }
}

let delegate = AppDelegate()
Application.delegate = delegate
Application.run()
