#include <windows.h>

// Win32 App entry point
int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
{
    /// We don't pass hPrevInstance as it is always nil for Win32 programs.
    return swiftW32App(hInstance, lpCmdLine, nCmdShow);
}