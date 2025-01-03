; Need this for tap esc, hold control to work
#InstallKeybdHook
#UseHook
#MenuMaskKey vkFF

;; Variables probably need to be declared at top

;; Setup applications to ignore programmer dvorak layout
nodvp_list := ["RainbowSix_Vulkan.exe"
	, "RainbowSix.exe"
	, "Warframe.x64.exe"
	, "anki.exe"
	, "factorio.exe"
	, "Legion TD 2.exe"
	, "Goose Goose Duck.exe"
	, "Risk of Rain 2.exe"
	, "helldivers2.exe"
	, "crs-handler.exe"
	, "valheim.exe"]


For index, exe_name in nodvp_list
	GroupAdd, NoDVP, ahk_exe %exe_name%

;; I hate capslock
SetCapsLockState AlwaysOff
DetectHiddenWindows On

;; Use Icon
I_Icon = F:\Archive\dvp-icon.png
IfExist, %I_Icon%
    Menu, Tray, Icon, %I_Icon%

;; state vars
toogle_esc_tap := true
esc_tap_control_start_time := 0

;; All initialization should be done before defining any variable.
;; Keep all initialization before this line
;; ===

;; Example grading shortcut
;; #q::
;;  Send 13{Enter 2}
;;  return

;; Script meta configurations

#F1:: ; Add windows below mouse cursor to not use DVP layout
	MouseGetPos, , , id, control
	WinGet, exename, ProcessName, ahk_id %id%
	GroupAdd, NoDVP, ahk_exe %exename%
	Tooltip % "NoDVP activated for " exename
	SetTimer, TooltipOff, -1500
	return

#\:: ; turn off monitor
    SendMessage 0x112, 0xF170, 2, , Program Manager  ; Monitor off
	Return

#+\:: ; lock and trun off monitor
	Run rundll32.exe user32.dll`,LockWorkStation
	Sleep 1000
	SendMessage 0x112, 0xF170, 2, 2 Program Manager ; Monitor off
	Sleep 1000
	Return

; Fast forwarding in potplayer
#IfWinActive ahk_class PotPlayer64 ahk_exe PotPlayerMini64.exe
Right::
    KeyWait, Right, T0.3
    if ErrorLevel {
        Send, cccccccccccccccccc
        ToolTip, >>>
        KeyWait, Right
        Send, z
        ToolTip
    } else Send {Right}
    return
#IfWinActive



#z:: ; Reload Script
    Reload
    Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
    MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
    IfMsgBox, Yes, Edit
    return

;; Suspend
#Escape:: Suspend

#m:: ; Play video in mpv
#IfWinActive ahk_exe brave.exe
Send ^l ; select url
send ^c ; copy url
if (InStr(clipboard, "youtube.com")) {
	Tooltip % "Trying to play: " clipboard
	SetTimer, TooltipOff, -500
	run "mpv" %clipboard%
}
return
#If

#a:: ; interact with Anki
ControlFocus,, User 1 - Anki
ControlSend,,{Enter}, User 1 - Anki
Sleep 250
ControlSend,,{Enter}, User 1 - Anki
return


#IfWinNotActive ahk_group NoDVP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Shift
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+`::Send, {~} ;; +Zenkaku

+1::Send, +5
+2::Send, 7
+3::Send, 5
+4::Send, 3
+5::Send, 1
+6::Send, 9
+7::Send, 0
+8::Send, 2
+9::Send, 4
+0::Send, 6
+-::Send, 8
+=::Send, ``

+q::Send, :
+[::Send, ?
+]::Send, +6

+'::Send, _ ;; +Colon

+z::Send, "

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Plane
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

`::$

1::&
2::[
3::{
4::}
5::(
6::=
7::*
8::)
9::+
0::]
-::+1
=::#


q::`;
w::,
e::.
r::p
t::y
y::f
u::g
i::c
o::r
p::l
[::/
]::@

; a::a
s::o
d::e
f::u
g::i
h::d
;;  ^j::Send, ^h
j::h
k::t
l::n
`;::s ;; Semicolon
'::- ;; Colon

z::'
x::q
c::j
v::k
b::x
n::b
; m::m
,::w
.::v
/::z


#k::
    toogle_esc_tap := !toogle_esc_tap
    Tooltip % "Esc tap " (toogle_esc_tap ? "is on" : "is off")
	SetTimer, TooltipOff, -1500
    return

#c::GDLookup()

;; any #If related clears all previous things, so need to double define here
#If toogle_esc_tap and Not WinActive("ahk_group NoDVP")

;; Heavily inspired by: https://github.com/kshenoy/CapsUnlocked/blob/master/CapsUnlocked.ahk
*LControl::
	Send {LControl Down}
	State := (GetKeyState("Alt", "P") || GetKeyState("Shift", "P") || GetKeyState("LWin", "P") || GetKeyState("RWin", "P"))
	if ( !State && (esc_tap_control_start_time = 0)) {
		esc_tap_control_start_time = A_TickCount
	}

	KeyWait, LControl
	Send {LControl Up}
	if (State) {
		return
	}

	elapsed_time := A_TickCount - esc_tap_control_start_time
	if ((A_PriorKey = "LControl") && (elapsed_time < 125)) {
		Send {Esc}
	}
	esc_tap_control_start_time := 0
	return

;; Old implementation, for saving purposes
/* *LCtrl::
 * 	Send {Ctrl Down}
 * 	cDown := A_TickCount
 * 	Return
 *
 * *LCtrl up::
 * 	If (((A_TickCount - cDown) < 125) && (A_PriorKey = "LControl"))
 * 		Send {Blind}{Ctrl Up}{Esc}
 * 	Else
 * 		Send {Blind}{Ctrl Up}
 * 	Return
 */

;; This techincally clears both, since last #If already overwrites first #IfWin
#If

;; Setup input method switching

SetDefaultKeyboard(LocaleID) {
	Lan := DllCall("LoadKeyboardLayout", "Str", Format("{:08x}", LocaleID), "Int", 0)
	WinExist("A")
	ControlGetFocus, CtrlFocus
	PostMessage 0x50, 0, % Lan, %CtrlFocus%
}

;; Mapping here relates to the physical keyboard. So the previous dvp mapping aren't active.
#+k::SetDefaultKeyboard(0x0409) ; English (USA)
#+j::SetDefaultKeyboard(0x0411) ; Japanese
#+i::SetDefaultKeyboard(0x0804) ; Chinese (PRC)


;; GoldenDict quick lookup setup
GDLookup() {
	curClip := Clipboard
	Clipboard := ""
	Sleep 100
	SendInput {Ctrl Down}{c Down}
	Sleep 50
	SendInput {c Up}{Ctrl Up}
	ClipWait, 1
	selected := Clipboard
	if StrLen(selected) > 0 and StrLen(selected) < 20 {
		WinGetActiveTitle, Title
		run "C:\Program Files (x86)\GoldenDict\GoldenDict.exe" %selected%
		Sleep, 800
		IfWinExist, %Title%
			WinActivate
	}
	Clipboard =
	if StrLen(curClip) > 0 {
		Clipboard = %curClip%
	}
	VarSetCapacity(curClip, 0)
	VarSetCapacity(selected, 0)
}





;; A goto statement destination to deactivate a tooltip through a timer
tooltipOff:
ToolTip
return
