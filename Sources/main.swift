import CWin32
import Win32

class AppDelegate: ApplicationDelegate {

    enum AppError: Error {
        case couldNotCreateMenu
    }

    func createMenu() throws -> HMENU {
        guard let menu = CreateMenu() else { throw AppError.couldNotCreateMenu }
        guard let fileSubMenu = CreatePopupMenu() else { throw AppError.couldNotCreateMenu }

        "&Exit".withUTF16CString {
            AppendMenuW(fileSubMenu, 0, 1001, $0)
        }

        let flags: Menu.CFlag = [Menu.CFlag.string, Menu.CFlag.popup]

        "&File".withUTF16CString {
            AppendMenuW(menu, flags.rawValue, unsafeBitCast(fileSubMenu, to: UInt64.self), $0)
        }

        guard let helpSubMenu = CreatePopupMenu() else { throw AppError.couldNotCreateMenu }

        "&About".withUTF16CString {
            AppendMenuW(helpSubMenu, 0, 1002, $0)
        }

        "&Help".withUTF16CString {
            AppendMenuW(menu, flags.rawValue, unsafeBitCast(helpSubMenu, to: UInt64.self), $0)
        }

        return menu
    }

    func main() {

        print("instance : \(Application.shared.hInstance.pointee)")

        do {
            let wc = try WindowClass(identifier: "MainWindow") { hwnd, messageCode, wParam, lParam in
                //print("code : \(String(messageCode, radix: 16)) , message: \(SystemMessage.WindowManager(rawValue: messageCode))")

                guard let message = SystemMessage.WindowManager(rawValue: messageCode)
                else {
                    return DefWindowProcW(hwnd, messageCode, wParam, lParam)
                }

                switch message {
                    case .paint:
                        var ps = PAINTSTRUCT()
                        let hdc = BeginPaint(hwnd, &ps)
                        EndPaint(hwnd, &ps)
                    case .command:
                        switch wParam {
                            case 1001:
                                DestroyWindow(hwnd)
                            case 1002:
                                MessageBox(message: "W32Experiment\nWritten in Swift", title: "About").display()
                            default:
                                return DefWindowProcW(hwnd, messageCode, wParam, lParam)
                        }
                    case .destroy:
                        PostQuitMessage(0)
                    default:
                        return DefWindowProcW(hwnd, messageCode, wParam, lParam)
                }

                return DefWindowProcW(hwnd, messageCode, wParam, lParam)
            }

            let window = try Window(class: wc)

            let menu = try createMenu()

            SetMenu(window.handle, menu)

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
