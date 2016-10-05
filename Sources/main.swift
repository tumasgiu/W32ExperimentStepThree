import CWin32
import Win32
import GDI

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

    class MainWindowDelegate: WindowClassDelegate {

        var draw = false
        var previousPoint: Point = Point.zero

        func onPaint(window: Window) {
            var rect = window.clientRect
            window.paint { context in
                context.drawText("Hello Swifty Window !", inRect: &rect, options: [.singleLine, .center, .centerVertically])
            }
        }
        func onDestroy(window: Window) -> Bool {
            exit(0)
            return true
        }
        func onCommand(param: UInt64) {
            switch param {
                case 1001:
                    exit(0)
                case 1002:
                    MessageBox(message: "W32Experiment\nWritten in Swift", title: "About").display()
                default:
                    break
            }
        }
        func onMouseEvent(_ event: MouseEvent, at point: Point, in window: Window) {
            switch event {
            case .buttonDown:
                draw = true
                previousPoint = point
            case .buttonUp:
                if draw {
                    window.draw { deviceContext in
                        deviceContext.moveTo(previousPoint)
                        deviceContext.lineTo(point)
                    }
                    draw = false
                }
            case .move:
                if draw {
                    window.draw { deviceContext in
                        deviceContext.moveTo(previousPoint)
                        deviceContext.lineTo(point)
                    }
                    previousPoint = point
                }
            default:
                break
            }
        }
    }

    let mainWindowDelegate = MainWindowDelegate()

    var mainWindow: Window!

    func main() {
        do {
            let wc = WindowClass(identifier: "MainWindow")
            wc.delegate = mainWindowDelegate

            try wc.register()

            mainWindow = try Window(class: wc)

            let menu = try createMenu()

            SetMenu(mainWindow.handle, menu)

        } catch {
            let mBox = MessageBox(message: "\(error)")
            mBox.display()
            exit(1)
        }

        mainWindow.display()
        mainWindow.title = "Hëllœ"
    }
}

let delegate = AppDelegate()
Application.delegate = delegate

Application.run()
