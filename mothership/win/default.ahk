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
$Escape::CapsLock


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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;toggle proxy for critical applications;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
!p::
    ToggleProxy("http://proxy.sin.sap.corp:8080")
return

ToggleProxy(ProxyAddress){
    static AutoConfigURL = "NOTSETYET"

    ; first if autoconfigurl hasn't been save, read and store in the static variable
    if(AutoConfigURL = "NOTSETYET"){
      RegRead, AutoConfigURL, HKEY_CURRENT_USER,Software\Microsoft\Windows\CurrentVersion\Internet Settings, AutoConfigURL
    }

    ; read the default connection setting value, and judge if proxy should be toggled on or off
    RegRead, DefaultConSet, HKEY_CURRENT_USER,Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connections,DefaultConnectionSettings
    ProxyOn := SubStr(DefaultConSet, 17, 2) =  "03" ? 0 : 1

    if(ProxyOn = 1){
       ;if proxy should be on set the corresponding value
        NewConSet := mid$(DefaultConSet, 17, "03")
    } else if (ProxyOn = 0) {
       ;if proxy should off set the corresponding value
        NewConSet := mid$(DefaultConSet, 17, "05")
    }

    RegWrite,REG_BINARY,HKEY_CURRENT_USER,Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connections,DefaultConnectionSettings,%NewConSet%
    RegWrite,REG_SZ,HKEY_CURRENT_USER,Software\Microsoft\Windows\CurrentVersion\Internet Settings,ProxyServer,%ProxyAddress%
    RegWrite,REG_SZ,HKEY_CURRENT_USER,Software\Microsoft\Windows\CurrentVersion\Internet Settings,AutoConfigURL,%AutoConfigURL%

    EnvGet, HomeDir, USERPROFILE
    proxyOnScriptPath = "\Dropbox\mymeta\mothership\win\onProxy.ps1"
    proxyOffScriptPath = "\Dropbox\mymeta\mothership\win\offProxy.ps1"


    if(ProxyOn = 1){
        Run, powershell.exe -windowstyle hidden %HomeDir%%proxyOnScriptPath% -proxyaddr %ProxyAddress%
        TrayTip Connection Status, Proxy Enabled - %ProxyAddress%, 3
    } else if (ProxyOn = 0) {
        Run, powershell.exe -windowstyle hidden %HomeDir%%proxyOffScriptPath%
        TrayTip Connection Status, Proxy Disabled, 3
    }
    Return
}


mid$(input, startPos, replacement) {
   Return, SubStr(input,1,startPos-1) . replacement . SubStr(input,startPos+StrLen(replacement))
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;right alt to ctrl;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RAlt::Control 
