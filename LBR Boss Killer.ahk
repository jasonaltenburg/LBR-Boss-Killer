#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Event  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Coordmode, Client

; ---- Declare Arrays ----

Global LBArea := {FirstFavorite: "1296,282"
, CursedKoko: "1296,382"
, Bridge: "1296,492"
, Vilewood: "1296,592"
, LoneTree: "1296,708"
, SparkBubble: "1296,810"
, BlueTerror: "1296,270"
, GreenTerror: "1296,382"
, RedTerror: "1296,483"
, PurpleTerror: "1296,588"
, CheesePub: "1296, 690"}


Global LBCoords := {PetMenu:"400, 90"
, PTeam1:"360,450"
, PTeam2: "360,515"
, LeafCounter: "1120, 420"
, LeafBet: "710, 360"
, LeafCount: "375, 360"
, CardC: "700, 905"
, CardU: "850, 905"
, CardR: "1040, 905"
, CardE: "1210, 905"
, CardM: "1390, 905"
, CardL: "1560, 905"
, CardTr: "1260, 730"
, CardSa: "1460, 640"}

Global ChestType := {Epic: "1296, 530", Legendary: "1296, 630"}

; ---- Begin Tutorial Section --- 
/*
Global Typeofchestused

Inputbox Typeofchestused

msgbox % Typeofchestused . " is the chest type"

UseChest(Typeofchestused)
*/
; ---- Begin Hotkey Section --- 


;Transcend and Salvage
!q::
mousegetpos, mx, my
LBClick("CardTr")
LBClick("CardTr")
send {alt down}
LBClick("CardSa")
LBClick("CardSa")
send {alt up}
mx := mx+60
sleep 50
mousemove %mx%, %my%
sleep 50
click
sleep 50
click
Sleep 50
return

;Transcend only
!e::
mousegetpos, mx, my
LBClick("CardTr")
LBClick("CardTr")
mousemove %mx%, %my%
sleep 50
return

;SalvageOnly
!r::
mousegetpos, mx, my
sleep 50
send {alt down}
LBClick("CardSa")
LBClick("CardSa")
send {alt up}
sleep 50
mousemove %mx%, %my%
sleep 50
return

; Single Boss Kill Loop no terrors
+z::
LeafSet("p")
Tele("Bridge")
Tele("Vilewood")
Tele("LoneTree")
LeafSet("o")
Tele("CursedKoko")
Tele("FirstFavorite")
return

; Boss Killing Loop + Terrors
!z::
Loop
{
LeafSet("p")
Tele("Bridge")
Tele("Vilewood")
Tele("LoneTree")
Tele("SparkBubble")
Tele("CursedKoko")
Scroll("Down")
Tele("BlueTerror")
Tele("GreenTerror")
Tele("RedTerror")
Tele("PurpleTerror")
Tele("CheesePub")
Scroll("Up")
Tele("FirstFavorite")
LeafSet("o")
UseChest("Legendary")
ArtifactSpam()
UseChest("Epic")
ArtifactSpam()
}
return

!Escape::
Pause,Toggle
Return

+Escape::
Reload

; ------- Function Junction -------

UseChest(type){
Tooltip % "Using " . type . " Chest"
sleep 1000
sendinput 0
sleep 100
click % ChestType[type]
sleep 1000
}

ArtifactSpam(){
Sleep 250
Sendinput b
sleep 250
Loop 400
{
Tooltip % "Artifact Spamming " . A_Index . " / 400"
click 1296,593
Sleep 125
}
Sendinput {escape}
Sleep 125
}


LeafSet(type) {
sleep 200
sendinput % type
sleep 200
sendinput % type
Sleep 100
}

LBClick(here) {
sleep 50
click % LBCoords[here]
Sleep 50
}


Tele(Location) {
Tooltip % "Heading to " . Location
if(Location="CursedKoko") 
	Leafset("o")
if(Location="CursedKoko") 
	Leafset("g")
if(Location="RedTerror") 
	Leafset("k")
if(Location="CheesePub") 
	Leafset("j")
Sleep 250
sendinput v
sleep 250
; Msgbox % LBArea[Location]
click % LBArea[Location]
Sleep 150
click % LBArea[Location]
Sleep 250
Sendinput {escape}
Tooltip % "Hanging out in " . Location
if(Location="CheesePub") 
	LeafBet("Bet")
Sleep 2550
if(Location="CursedKoko" or Location="CheesePub") 
	Leafset("h")
if(Location="CursedKoko") 
	Leafset("p")
Sleep 100
Return
}


LeafBet(action) {
Sleep 100
LBClick("LeafCounter")
Sleep 100
if(action="Bet") 
	LBClick("LeafBet")
if(action="Count") 
	LBClick("LeafCount")
Sleep 100
Return
}


Scroll(dir) {
x := "{Wheel" . dir . " 200}"
Tooltip % "Scrolling " . dir
Sleep 250
sendinput v
sleep 250
Loop 3
{
Tooltip % "Scrolling " . dir . " " . A_Index . " / 3"
Sendinput % x
Sleep 150
}
Sendinput {escape}
Sleep 250
}