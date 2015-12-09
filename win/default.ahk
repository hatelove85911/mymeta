;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <redwolf85911@gmail.com>
;
; Script Function:
;   Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



#InstallKeybdHook
#InstallMouseHook

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;Esc to Capslock;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;Caps lock to Esc and control;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;$Escape::CapsLock


;SetCapsLockState, AlwaysOff
Capslock::
Send {LControl Down}
KeyWait, CapsLock
Send {LControl Up}
if ( A_PriorKey = "CapsLock" )
{
    Send {Esc}
}
return



Shift::
Send {Shift Down}
KeyWait, Shift
Send {Shift Up}
if ( A_PriorKey = "RShift" )
{
    ToggleCapsLock()
}
return

ToggleCapsLock(){
    capsLockOn := GetKeyState("Capslock" , "T")
    if(capsLockOn = 1){
        SetCapsLockState, Off
    } else if (capsLockOn = 0) {
        SetCapsLockState, On
    }
    Return
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;toggle proxy;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



!p::
    ToggleProxy("http://proxy.pal.sap.corp:8080")
return

ToggleProxy(ProxyAddress){
    RegRead, ProxyStatus,HKEY_CURRENT_USER,Software\Microsoft\Windows\CurrentVersion\Internet Settings,ProxyEnable
    ProxyOn := ProxyStatus = 1 ? 0 : 1

    RegWrite,REG_DWORD,HKEY_CURRENT_USER,Software\Microsoft\Windows\CurrentVersion\Internet Settings,ProxyEnable, %ProxyOn%
    RegWrite,REG_SZ,HKEY_CURRENT_USER,Software\Microsoft\Windows\CurrentVersion\Internet Settings,ProxyServer,%ProxyAddress%

    if(ProxyOn = 1){
        TrayTip Connection Status, Proxy Enabled - %ProxyAddress%, 3
    } else if (ProxyOn = 0) {
        TrayTip Connection Status, Proxy Disabled, 3
    }

    Return
}
