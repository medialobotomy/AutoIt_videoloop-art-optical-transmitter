;
; AutoIt Version: 3.3
; Language:       English
; Platform:       Win10
; Author:         media lobotomy
;
; Script Function:
;   Records video in a loop.
;

AutoItSetOption("SendKeyDelay", 400)

Opt("WinTitleMatchMode", 3)
;WinActivate("[CLASS:VLC video output 0D8F3938]", "VLC media player") ;Switch to vlc
;WinActivate("Camera", "")
;WinActivate("VLC media player", "") ;Switch to vlc
;Opt("WinTitleMatchMode", 1)
;Sleep(2000000)

Sleep(2000)

$LoopMe = 0
$Stage = 1

While ($LoopMe < 100)
	$LoopMe = $LoopMe + 1
;	Run("\\vserver02\5348\mywork\My Pictures\Camera Roll")

	;Activate camera roll folder (needs to be open), and open the last video (the most recent if sorted by date) in vlc
	;Then pause video in vlc, and move to start of video, and continue to stage 2...
    If $Stage = 1 And WinActivate("Camera Roll", "") <> 0 Then
        Send("{PGDN}")
        Send("{END}")
        Send("+{F10}")
        Send("hv")
		Sleep(1000)
		Opt("WinTitleMatchMode", 2)
		WinActivate("VLC media player", "") ;Switch to vlc
		Opt("WinTitleMatchMode", 3)
		Sleep(1000)
        Send(" {LEFT 3}f") ;Pause, return to beginning, and switch to fullscreen.
		$Stage = 2
    EndIf

	;Activate camera app, press record, switch to vlc, start playing, wait 30 seconds, then switch
	;back to camera, stop record, and continue to stage 3...
    If $Stage = 2 And WinActivate("Camera", "") <> 0 Then
        Send(" ") ;Start record in camera app
;		WinActivate("[CLASS:VLC video output 0D8F3938]", "VLC media player") ;Switch to vlc
		Opt("WinTitleMatchMode", 2)
		WinActivate("VLC media player", "") ;Switch to vlc
		Opt("WinTitleMatchMode", 3)
        Send(" ") ;Unpause vlc
		Sleep(30000) ;Pause script for 30 seconds
        WinActivate("Camera", "") ;Switch to camera app
        Send(" ") ;Stop record
		Opt("WinTitleMatchMode", 2)
		WinActivate("VLC media player", "") ;Switch to vlc
		Opt("WinTitleMatchMode", 3)
;        Send("^q") ;Exit vlc
		$Stage = 1
    EndIf

    Sleep(5000)
WEnd

; Finished!
