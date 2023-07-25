; Need this for tap esc, hold control to work
#InstallKeybdHook
#UseHook

;; Setup applications to ignore programmer dvorak layout
nodvp_list := ["RainbowSix_Vulkan.exe"
	, "RainbowSix.exe"
	, "Warframe.x64.exe"
	, "anki.exe"
	, "factorio.exe"
	, "Legion TD 2.exe"
	, "Goose Goose Duck.exe"
	, "Risk of Rain 2.exe"
	, "valheim.exe"]

For index, exe_name in nodvp_list
	GroupAdd, NoDVP, ahk_exe %exe_name%

;; I hate capslock
SetCapsLockState AlwaysOff

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
        Send, cccccccccccccccccccccccccccccccccccccccc
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
	Static SPI_SETDEFAULTINPUTLANG := 0x005A, SPIF_SENDWININICHANGE := 2

	Lan := DllCall("LoadKeyboardLayout", "Str", Format("{:08x}", LocaleID), "Int", 0)
	VarSetCapacity(binaryLocaleID, 4, 0)
	NumPut(LocaleID, binaryLocaleID)
	DllCall("SystemParametersInfo", "UInt", SPI_SETDEFAULTINPUTLANG, "UInt", 0, "UPtr", &binaryLocaleID, "UInt", SPIF_SENDWININICHANGE)

	WinGet, windows, List
	Loop % windows {
		PostMessage 0x50, 0, % Lan, , % "ahk_id " windows%A_Index%
	}
}

;; Mapping here relates to the physical keyboard. So the previous dvp mapping aren't active.
#+k::SetDefaultKeyboard(0x0409) ; English (USA)
#+j::SetDefaultKeyboard(0x0411) ; Japanese
#+i::SetDefaultKeyboard(0x0804) ; Chinese (PRC)


;; A goto statement destination to deactivate a tooltip through a timer
tooltipOff:
ToolTip
return
