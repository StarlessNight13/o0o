#Requires AutoHotkey v2.0
#SingleInstance Force

exnglish := "0x409"

^!PgDn:: Suspend  ; Suspend script with Ctrl+Alt+S
^!PgUp:: Reload   ; Reload script with Ctrl+Alt+R

#HotIf GetInputLangID() == exnglish
Home & a:: {
    Send(GetKeyState("Shift") ? "Ä" : "ä")
}

Home & o:: {
    Send(GetKeyState("Shift") ? "Ö" : "ö")
}
Home & u:: {
    Send(GetKeyState("Shift") ? "Ü" : "ü")
}
Home & s:: {
    Send("ß")  ; Note: ß typically doesn't have a capital form in common usage
}
#HotIf

~Home:: Send("{Home}")

GetInputLangID(hWnd := '') {
    (!hWnd) && hWnd := WinActive('A'), childPID := ''
    if WinGetProcessName(hWnd) = 'ApplicationFrameHost.exe' {
        pid := WinGetPID(hWnd)
        for ctl in WinGetControls(hWnd)
            DllCall('GetWindowThreadProcessId', 'Ptr', ctl, 'UIntP', childPID)
        until childPID != pid
        DetectHiddenWindows True
        hWnd := WinExist('ahk_pid' childPID)
    }
    threadId := DllCall('GetWindowThreadProcessId', 'Ptr', hWnd, 'UInt', 0)
    lyt := DllCall('GetKeyboardLayout', 'Ptr', threadId, 'UInt')
    return langID := Format('{:#x}', lyt & 0x3FFF)
}
