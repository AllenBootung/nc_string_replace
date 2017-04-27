
DIM fso, d, f, s, i, FileNum
dim Selector
i=0
dim targetNc
Set ws = CreateObject("WScript.Shell")
WS.RUN "cmd /K C:\WINDOWS\SYSTEM32\taskkill.EXE /F /im CMD.EXE & EXIT" , 2, true
If wscript.arguments.count<1 then
Rem ws.run """C:\Program Files\Windows Media Player\wmplayer.exe"""
wscript.quit
end if

DIM Nc

set Nc= NEW NcReplace

Selector= inputbox ("17.常準風M17 18.Hass風M83 19.M57 20.M7" & chr(10) & chr(10) &_
"21.關水 22.關水G55 23.隆峰換刀" & chr(10) &_
chr(10) & "31.關M09不防呆 32.+10 33.+10M99" & VBCRLF &vbcrlf &  "111命名 112異刀 113換刀 114減刀 115.G55 116換刀G55 119.M57" & VBCRLF &vbcrlf & "121命名 300刪防呆" & VBCRLF & VBCRLF & "61.THD同 62.TH 63.THF" & VBCRLF & "64.不關水 65.TH 66.THD" & VBCRLF & VBCRLF & "68. G68旋轉 90.四軸  1010.分離 1011.合併" & " 1014.THD" & VBCRLF & "1030.Cancel Tnext"  , "NcStringReplacer v3.4.1.0916b by Tung")

sFolder=FolderRoute()
Rem Nc.secom
DIM Tminus

if Selector = 0 then
wscript.quit
end if

Rem ************************************10
DO
Set fso = CreateObject("Scripting.FileSystemObject")
set Pnum = fso.GetFile(Wscript.Arguments(i))

IF not Isnumeric( right(Pnum,1) ) then
Pnum = right(Pnum,5)

else if Isnumeric( right(Pnum,1) ) then
Pnum = right(Pnum,2)
end if
end if

Pnum = left(Pnum,2)
Tnum = right(Pnum,1)
Pnum = left(Pnum,1)
IF not IsNumeric(Pnum) then
Pnum = 0
end if
IF not IsNumeric(Tnum) then
Tnum = 1
end if
Rem ************************************24

dim regex
set regex= New RegExp
DIM Pend
Pend = "M"

regex.Pattern = "O(\d+.+)"
regex.IgnoreCase = True
regex.Global = True
Set ts = fso.OpenTextFile(Wscript.Arguments(i),1)
str = ts.ReadAll
ts.close

Rem **************Nc title Oxxxx and M09**********
str = regex.Replace(str, "O00" & Pnum & Tnum & "(E)" & vbcrlf )
str = Replace(str,".M09",".")

Rem *************
Rem SELECTOR AREA
Rem *************

Select Case Selector

Case 1 
	if Tassign=0 then
		Tassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Tnum")
		Hassign= Tassign
		Dassign= Hassign
	end if
	NC.changeT("AssignWater")
	Nc.Ncend("M01")


Case 2 
	if Tassign=0 then
		Tassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Tnum")
		Hassign= Tassign
		Dassign= Hassign
	end if
	NC.changeT("AssignWater")



Case 3
	if Tassign=0 then
		Tassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Tnum")
		Hassign= Tassign
		Dassign= Hassign
	end if
	NC.changeT("AssignWater")
	Nc.Ncend("M99")


Case 4
	Nc.aicc(0)
	Nc.changeT("Tminus")


Case 6
	Nc.aicc(0)
	Nc.changeT("sync")
	Nc.cord("G55")
	Nc.NcEnd("M99")


case 10
	str = Replace(str,".html", ".php" )


case 11
	rem (post liwe)

	Nc.aicc(11)	
	str = Replace(str,"M09", "M08")
	str = Replace(str,"M6", "M6" & Vbcrlf & "T#510" )
	str = Replace(str,"M05", "M09" & vbcrlf & "M05")
	str = Replace(str,"G98 G84", "M29" & vbcrlf & "G98 G84")



regex.Pattern = "G90 G00 G5(.+)" & vbcrlf & "G00 "
set matches = regex.execute(str)

for each match in matches
FirstG0 = match.value
next

FirstG1 = Replace( FirstG0, "X0. Y0." & vbcrlf & "G00 ", "")

	str = Replace(str, FirstG0, FirstG1)




	Nc.NcEnd("M01")


case 13



	rem (post liwe)
	Nc.aicc(11)	
	str = Replace(str,"M09", "M08")
	str = Replace(str,"M6", "M6" & Vbcrlf & "T#510" )
	str = Replace(str,"M05", "M09" & vbcrlf & "M05")
	str = Replace(str,"G98 G84", "M29" & vbcrlf & "G98 G84")



regex.Pattern = "G90 G00 G5(.+)" & vbcrlf & "G00 "
set matches = regex.execute(str)

for each match in matches
FirstG0 = match.value
next

FirstG1 = Replace( FirstG0, "X0. Y0." & vbcrlf & "G00 ", "")

	str = Replace(str, FirstG0, FirstG1)




	Nc.NcEnd("M99")




case 111
	Lget=111

case 211
	Lget=111
	Nc.clean(1)
case 112
	Lget=111
	Nc.changeT("sync")


case 113
	Lget=111
	Nc.changeT("sync")
	Nc.NcEnd("M99")

	

case 114
	Lget=111
	Nc.changeT("Tminus")
	Rem Nc.NcEnd("M99")

CASE 115
	Lget=111
	Nc.cord("G55")

case 116
	Lget=111
	Nc.changeT("sync")
	Nc.cord("G55")
	Nc.NcEnd("M99")

case 119
	Lget=111
	Nc.wind("M57")

case 121
	Lget=121
	Rem Nc.clean(1)
case 122
	Lget=121
	Nc.changeT("sync")


CASE 123
	Lget=121
	Nc.changeT("sync")
	Nc.NcEnd("M99")	

case 124
	Lget=121
	Nc.changeT("Tminus")
	Rem Nc.NcEnd("M99")

CASE 125
	Lget=121
	Nc.cord("G55")
	Nc.changeT("sync")

case 126
	Lget=121
	Nc.changeT("sync")
	Nc.cord("G55")
	Nc.NcEnd("M99")

case 129
	Lget=121
	Nc.wind("M57")


Case 11
	Nc.clean(1)
Case 12
	Nc.changeT("sync")

Case 13
	Nc.changeT("sync")
	Nc.NcEnd("M99")

Case 14
	Nc.changeT("Tminus")
	Nc.NcEnd("M99")


Case 16
	Nc.changeT("sync")
	Nc.cord("G55")
	Nc.NcEnd("M99")

Case 17
	Nc.wind("M17")
Case 18
	Nc.aicc(0)
	Nc.wind("M83")
Case 19
	Nc.wind("M57")

Case 20
	Nc.wind("M7")

CASE 411
	str = Replace(str,"M09"," ")

CASE 413
	str = Replace(str,"M09"," ")
	Nc.changeT("F3")
	Nc.NcEnd("M99")

CASE 511
	str = Replace(str,"M09"," ")
	Nc.clean(1)
Case 21
str = Replace(str,"M8","(M8)")
Case 22
str = Replace(str,"M8","(M8)")
	Nc.cord("G55")
Case 23
	Nc.changeT("Tcrlf")
	str = Replace(str,"(M8)","M8")
	Nc.NcEnd("M99")
CASE 31 
	

Case 32
	Nc.changeT("Tten")
	Nc.NcEnd("M30")

Case 33
	Nc.changeT("Tten")
	Nc.NcEnd("M99")

case 61
	if Tassign=0 then
		Tassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Tnum")
		Hassign= Tassign
		Dassign= Hassign
	end if
	NC.changeT("Assign")



CASE 62
	if Tassign=0 then
		Tassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Tnum")
		Hassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Hnum")
		Dassign= Hassign
	end if
	NC.changeT("Assign")

case 63
	if Tassign=0 then
		Tassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Tnum")
		Hassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Hnum")
		Dassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Dnum")

	end if
	NC.changeT("Assign")
	



case 64
	if Tassign=0 then
		Tassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Tnum")
		Hassign= Tassign
		Dassign= Hassign
	end if
	NC.changeT("AssignWater")
	Nc.Ncend("M01")


CASE 65
	if Tassign=0 then
		Tassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Tnum")
		Hassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Hnum")
		Dassign= Hassign
	end if
	NC.changeT("AssignWater")

case 66
	if Tassign=0 then
		Tassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Tnum")
		Hassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Hnum")
		Dassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Dnum")

	end if
	NC.changeT("AssignWater")

case 1014
	if Tassign=0 then
		Tassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Tnum")
		Tnext = inputbox(Wscript.Arguments(i) & vbcrlf & "Tnext") 
		Hassign= Tassign
		Dassign= Hassign
	end if
	NC.changeT("MCXWater")



CASE 1012
	if Tassign=0 then
		Tassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Tnum")
		Hassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Hnum")
		Dassign= Hassign
	end if
	NC.changeT("MCXWater")

case 1013
	if Tassign=0 then
		Tassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Tnum")
		Hassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Hnum")
		Dassign=inputbox( Wscript.Arguments(i) & vbcrlf & "Dnum")

	end if
	NC.changeT("MCXWater")
	




CASE 1030
regex.Pattern = "T(\d+)" & VBCRLF
str = regex.Replace(str, VBCRLF    )

str = Replace(str,"A0." ," ") 



case 10000

IF SearchFlag = 0 then
SearchText = InputBox("Searching for")
ReplaceText = Inputbox("Replace with")
SearchFlag = 1
end if
 
str = Replace(str, SearchText , ReplaceText )


Rem ****************
Rem G55 G56 G57
Rem ****************

Case 54
	IF CordPnum = 0 then
		CordPnum= inputbox("G54.1 P")
	end IF
	Nc.cord("G54.1P" & CordPnum)

Case 55
	Nc.cord("G55")
Case 56
	Nc.cord("G56")
Case 57
	Nc.cord("G57")

CASE 68 
	IF ( Degree = 0) then
		Degree = Inputbox ("Rotate degree." & vbcrlf & "90." & vbcrlf &"-90.")
	End IF
	NC.rotate( Degree)

case 90

	IF ( Degree = 0) then
		Degree = Inputbox ("Rotate degree." & vbcrlf & "90." & vbcrlf &"-90.")
	End IF
	NC.rotate4( Degree)


Case 30
	Nc.NcEnd("M30")
Case 99
	Nc.NcEnd("M99")

case 101
	Nc.NcEnd("M01")

CASE 555
str = Replace(str,"G54","G55")
str = regex.Replace(str, "O05" & Pnum & Tnum & "(E)" )
Rem ******************
Rem Drill
Rem ******************

Case 83c
	Nc.aicc(0)
str = Replace(str, "G81" , "G83")
regex.Pattern = "M03S(\d+)"
str = regex.Replace(str, "M03S3000")
	Nc.drill

Case 73
	Nc.aicc(0)
str = Replace(str, "G81" , "G73")
regex.Pattern = "M03S(\d+)"
str = regex.Replace(str, "M03S600")
	Nc.drill


case 350
str = Replace(str,"G00Z5."," ")

CASE 705
	Nc.aicc(1)


case 509
str = Replace(str,"M09"," ")
str = Replace(str,"M05"," ")

Rem ---------------------LOCK BOARD--------

CASE 600
regex.Pattern = "F500"
str = regex.Replace(str, "F600" )

case 1010
	Nc.separate


case 1000
	Nc.list(1000)

CASE 2000
	Nc.list(2000)

CASE 2121
CreateAutoSkip

CASE 1982000
	Nc.list(1982000)

case 3000
	Nc.listConti(3000)

case 3500
	Nc.list(3500)



case 300
	Nc.clean(0)
Case 411
	Nc.view

case else
MSGBOX "CASE ELSE " & Selector
WSCRIPT.QUIT
End select
Rem ***************************************==============================
Rem end select
Rem ***************************************==============================

regex.Pattern = "M30"
set matches = regex.execute(str)
for each match in matches
Pend30 = match.value
next
Rem msgbox( pend30)
regex.Pattern = "M99"
set matches = regex.execute(str)
for each match in matches
Pend99 = match.value
next

regex.Pattern = "M01"
set matches = regex.execute(str)
for each match in matches
Pend01 = match.value
next


regex.Pattern = "\(E"
str = regex.Replace(str, "(" & Pend30 & Pend99 & Pend01  )

Rem PEndR2 = right( Pend30 & Pend99 , 2)
Rem regex.Pattern = "G90G80"
Rem str = Replace(str,"G90G80","G90G80N" & Pnum & Tnum & PEndR2  )
Rem *****************************210


if Lget=111 then
	Nc.rename("Last2")
else if Lget=121 then
	if InputLast2 = 0 then
		InputLast2= inputbox("Tens digit = ")
	end if
	Nc.rename("Input")
else
	Nc.rename("NoChange")
end if
END IF

Rem ws.RUN C:\Windows\notepad.exe  & """" &  targetNc & """"
Rem wscript.sleep 500
i=i+1
LOOP while i< Wscript.Arguments.Count

Rem WS.RUN "cmd /MIN /K PAUSE & C:\WINDOWS\SYSTEM32\taskkill.EXE /F /im notepad.EXE & EXIT" , 2, true

Rem @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2@@@@@@@@@@@@@@@
Rem Sub Program
Rem @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@





SUB CreateAutoSkip

dim Skip, Padd

sFolder= FolderRoute()

set ts= fso.CreateTextFile( sFolder & "\O2000.nc" ,True)

StartP = inputbox("First Start")
EndP  = inputbox("First End")
Padd  = inputbox("P add")

StartTen = left( StartP, 1)
StartOne = right( StartP, 1)
EndTen = left( EndP, 1)
EndOne = right( EndP, 1)
EndOne = EndOne -1 +1
i=StartOne
ts.Write "%" & vbcrlf & "O2000" & vbcrlf

do 
Skip= padd -1 +1 +i 
ts.Write "M98P" & StartTen & i & vbcrlf
ts.Write "M98P" & StartTen & Skip & vbcrlf
i=i+1


if i > 10 then
msgbox("Out of range")
wscript.quit
end if

LOOP while ( i<= EndOne)

ts.Write "M30" & vbcrlf & "%"
ts.close
Rem ws.RUN C:\Windows\notepad.exe & """" & sFolder & "\O2000.nc" &""""
wscript.quit
END SUB



Rem *****************
Rem **FOLDER NAME****
Rem *****************

Function FolderRoute

WordLength = Len(Wscript.Arguments(0))
j=0
Fold= WordLength-j

do
    charWord = Mid(Wscript.Arguments(0), Fold, 1)
    Fold= WordLength-j
    j=j+1
loop while ( charWord <> "\" )


FolderRoute= Mid(Wscript.Arguments(0), 1, Fold)

END Function

Rem ############################################################
Rem Class
Rem ############################################################
Class NcReplace




sub separate
Dim TxtCount


TxtCount = 1


Rem Set ts = fso.OpenTextFile(Wscript.Arguments(i),1)
Rem str = ts.ReadAll
Rem ts.close
Rem -------------

Rem Set fso = CreateObject("Scripting.FileSystemObject")
Rem Set MyFile= fso.OpenTextFile("D:\source.txt", 1 , TRUE)
 
Rem Do While MyFile.AtEndOfLine <> True 
Rem    username=MyFile.ReadLine
Rem    msgbox username
Rem    MyFile.NextLine
Rem loop
Rem MyFile.Close

Set tsa = fso.OpenTextFile(Wscript.Arguments(i),1)

Do While tsa.Readline <> "M30"
    Set txta = fso.CreateTextFile(Wscript.Arguments(i) & "_N" & TxtCount & ".nc", True)

    
    
    Do
	str = tsa.Readline
        txta.write str
        txta.write vbCrLf
        
        Rem tsa.nextline

    Loop While str <> "M01"
    
    TxtCount = TxtCount + 1


Loop 
    txta.Close
    
end sub







Rem ******
Rem AiccOn=0 is no aicc
Rem ****** 
sub aicc(AiccOn)

Select Case AiccON

Case 0 
str = Replace(str,"/G05.1 Q0",  " ")
str = Replace(str,"/G05.1Q0",  " ")
str = Replace(str,"/G05.1 Q1",  " ")	
str = Replace(str,"/G05.1Q1",  " ")


Case 1
str = Replace (str,"G17G00G54X0.Y0.","G17G00G54X0.Y0." &VBCRLF &"/G05.1 Q1" )
str = Replace(str,"G17G00G55X0.Y0.","G17G00G55X0.Y0." &VBCRLF &"/G05.1 Q1" )
str = Replace(str,"M09","/G05.1 Q0" &VBCRLF & "M09")

Case 11
str = Replace (str,"G90 G80 G17 G40 G49" & vbcrlf  & "G91 G28 Z0."  , "G90 G80 G17 G40 G49" & VBCRLF & "G05.1 Q1" )

str = Replace(str,"G91 G28 Y0.", "G05.1 Q0" )

End Select

end sub

Rem ******
Rem replace G54 to G55 G56
Rem ******
sub cord(Cordinate)
str = Replace(str, "G54",  Cordinate )
end sub

Rem ********
Rem change T and H
Rem ********

Sub changeT( TandH)
Select Case TandH

Case "sync"
Tnext= Tnum +0 +1
if Tnum=0 then 
Tnum = Tnum +10
end if
str = Replace(str,"(SONCHU POSTPROCESSOR A.I.C TAICHUNG)", VBCRLF & "T" & Tnum & "M6")
str = Replace(str,"H1" ,"H" & Tnum)

Case "syncPre"
Tnext= Tnum +0 +1
str = Replace(str,"(SONCHU POSTPROCESSOR A.I.C TAICHUNG)", VBCRLF & "T" & Tnum & "M6" & VBCRLF & "T" & Tnext)
str = Replace(str,"H1" ,"H" & Tnum)


Case "Tminus"
if Tminus=0 then
Tminus= inputbox("Tminus")
end if 
Tnum=0+Tnum-Tminus
IF Tnum<=0 then
Tnum= Tnum +10
END IF
str = Replace(str,"(SONCHU POSTPROCESSOR A.I.C TAICHUNG)",  VBCRLF & "T" & Tnum & "M6")
str = Replace(str,"H1" ,"H" & Tnum)

Case "Tcrlf"
str = Replace(str,"H1","H" & Tnum)
str = Replace(str,"(SONCHU POSTPROCESSOR A.I.C TAICHUNG)",  VBCRLF & "T" & Tnum & vbcrlf  & "M6" )

Case "Tten"
str = Replace(str,"H1","H1" & Tnum)
str = Replace(str,"(SONCHU POSTPROCESSOR A.I.C TAICHUNG)",    VBCRLF & "T1" & Tnum & "M6")


case "Assign"

str = Replace(str,"H1" ,"H" & Hassign)
str = Replace(str,"(SONCHU POSTPROCESSOR A.I.C TAICHUNG)", VBCRLF & "N" & pnum & tnum & vbcrf & "T" & Tassign & "M6")


regex.Pattern = "G90G10P(.+)"
str = regex.Replace(str, " " & vbcrlf    )


str = Replace(str,"M8" ," " )
str = Replace(str,"D17" , "D" & Dassign )
str = Replace(str,"M08" ," " )
Tassign=0

case "AssignWater"

str = Replace(str,"H1" ,"H" & Hassign)
str = Replace(str,"(SONCHU POSTPROCESSOR A.I.C TAICHUNG)",   VBCRLF & "N" & pnum & tnum & VBCRLF & "T" & Tassign & "M6")


regex.Pattern = "G90G10P(.+)"
str = regex.Replace(str, " " & vbcrlf    )



str = Replace(str,"D17" , "D" & Dassign )
Tassign=0


case "MCXWater"

regex.Pattern = "H(\d+)"
str = regex.Replace(str, "H" & Hassign   )

regex.Pattern = "T(\d+) "
str = regex.Replace(str, "T" & Tassign & " " & "M6"    )


regex.Pattern = "G90G10P(.+)"
str = regex.Replace(str, " " & vbcrlf    )

regex.Pattern = "T(\d+)" & vbcrlf
str = regex.Replace(str, "T" & Tnext & VBCRLF    )

regex.Pattern = "D(\d+) "
str = regex.Replace(str, "D" & Dassign    )

Tassign=0




Case else

End Select
End sub

Rem ******
Rem Rotate
Rem ******

sub rotate( Degree)


str = Replace(str, "G40G49G90G80", "G40G49G90G80G69")
str = Replace(str, "/G05.1 Q1", "/G05.1 Q1" & vbcrlf & "G68R" & Degree )
str = Replace(str, "/G05.1Q1", "/G05.1 Q1" & vbcrlf & "G68R" & Degree )





regex.Pattern = "G90 G00 G5(.+)" 
set matches = regex.execute(str)

for each match in matches
FirstG0 = match.value
next


regex.Pattern = "X(.+)" 
FirstG1 = regex.Replace( FirstG0, " ")

str = Replace(str, FirstG0 , "G69" & vbcrlf & FirstG1 & vbcrlf & "G68 "& "R" & Degree & vbcrlf & FirstG0 )









str = Replace(str, "M09", "G69" & vbcrlf & "M09" )

END SUB

rem ************************************
sub rotate4( Degree)
rem ************************************



regex.Pattern = "S(\d+) M03" 
set matches = regex.execute(str)

for each match in matches
SpindleSpeed = match.value
next


str = Replace(str, SpindleSpeed , "M11" & vbcrlf & vbclf & "A" & Degree & vbcrlf & "M10" & vbcrlf & SpindleSpeed  )


str = Replace(str, "M09", "M11" & vbcrlf & "M09")

END SUB

Rem **********
Rem M30 or M99
Rem **********

SUB NcEnd(M30orM99)
select case M30orM99

case "M99"
str = Replace(str, "M30","M99")

case "M30"
str = Replace(str, "M99","M30")

case "M01"
str = Replace(str, "M30","M01")

case else

end select
end sub

Rem ***************
Rem Drill
Rem ***************
sub drill

regex.Pattern = "S(\d+)M03"
str = regex.Replace(str, " ")

regex.Pattern = "G43Z(.+)"
set matches = regex.execute(str)

for each match in matches
Zh = match.value
Zhlen = Len(Zh)-7
Zh = mid(Zh,5,Zhlen)
next

regex.Pattern = "G80Z(.+)"
str = regex.Replace(str, "G80Z" & Zh)

regex.Pattern = "F(.+)"
str = regex.Replace(str, "F50.Q2.")
end sub


Rem ****************
Rem O2000 list
Rem ****************


sub listConti(ListType)

dim StartP, EndP, StartTen, StartOne, EndTen, EndOne
dim Ofile, Onum, connect

select case ListType


case 3000
Ofile="O3000"
Onum="O3000"
connect= "#510= 1" & vbcrlf & "M198P"

case 3500
Ofile="O3500"
Onum="O3500"
connect="M198P"

end select

sFolder= FolderRoute()
set ts= fso.CreateTextFile( sFolder & "\" & Ofile ,True)

StartP = inputbox("Start")
StartP = StartP -1 +1
EndP  = inputbox("End")
EndP = EndP -1 +1



ts.Write "%" & vbcrlf & Ofile & vbcrlf
ts.Write "(#510=NEXT TOOL)" & vbcrlf 
ts.Write "(#3012=SYSTEM NOW TIME)" & vbcrlf & vbcrlf

ts.Write "#711=#701" & vbcrlf 
ts.Write "#701=#3012" & vbcrlf 

do 
	ts.Write connect & StartP & vbcrlf & "M01" & vbcrlf & vbcrlf


	StartP = StartP + 1

	if StartP > 10000 then
	msgbox("Out of range")
	wscript.quit
	end if

LOOP while ( StartP <= EndP)

if Ofile = "O1000" then
ts.write "%"
else
ts.Write "T#510 M6" & vbcrlf
ts.Write "G91G28Z0" & vbcrlf & "G90G0G53X#541Y#542" & vbcrlf


ts.Write "#712=#702" & vbcrlf 
ts.Write "#702=#3012" & vbcrlf 

ts.Write "M30" & vbcrlf & "%"
end if

ts.close

Rem ws.RUN C:\Windows\notepad.exe  & """" & sFolder & "\" & Ofile & """"

Rem C:\Windows\notepad.exe
wscript.quit
END SUB

rem ***************************
rem
rem *****************************

sub list(ListType)

dim StartP, EndP, StartTen, StartOne, EndTen, EndOne
dim Ofile, Onum, connect

select case ListType

case 1000
Ofile="O1000"
Onum="O1000"
connect="N"

case 2000
Ofile="O2000"
Onum="O2000"
connect="M98P"

case 1982000
Ofile="O2000"
Onum="O2000"
connect="M198P"

case 3000
Ofile="O3000"
Onum="O3000"
connect="M198P"

case 3500
Ofile="O3500"
Onum="O3500"
connect="M198P"

end select

sFolder= FolderRoute()
set ts= fso.CreateTextFile( sFolder & "\" & Ofile ,True)

StartP = inputbox("Start")
EndP  = inputbox("End")

StartTen = left( StartP, 1)
StartOne = right( StartP, 1)
EndTen = left( EndP, 1)
EndOne = right( EndP, 1)
EndOne = EndOne -1 +1
i=StartOne

ts.Write "%" & vbcrlf & Ofile & vbcrlf
do 
	ts.Write connect & StartTen & i & vbcrlf & "M01" & vbcrlf

	if( StartTen<>EndTen) then 
	ts.Write connect & EndTen & i & vbcrlf
	end if

	i=i+1

	if i > 10 then
	msgbox("Out of range")
	wscript.quit
	end if

LOOP while ( i<= EndOne)

if Ofile = "O1000" then
ts.write "%"
else
ts.Write "G91G28Z0" & vbcrlf & "G90G0G53X#501Y#502" & vbcrlf
ts.Write "M30" & vbcrlf & "%"
end if

ts.close

Rem ws.RUN C:\Windows\notepad.exe  & """" & sFolder & "\" & Ofile & """"

Rem C:\Windows\notepad.exe
wscript.quit
END SUB

Rem *********
Rem Decide wind 
Rem *********

sub wind(WindType)

select case WindType

case "M57"
str = Replace(str,"M8","M57")
str = Replace(str,"M09","M59")

case "M83"
str = Replace(str,"M8","M83")
str = Replace(str,"M09","M84")

case else
str = Replace(str,"M8", WindType)

end select
end sub

Rem ***********
Rem change file name
Rem ***********
sub rename(FileStyle)

sFolder=FolderRoute()


select case FileStyle


case "Last2"

set ts= fso.CreateTextFile( sFolder &"\O00" &  Pnum & Tnum  ,True)
targetNc= sFolder &"\O00" &  Pnum & Tnum
ts.Write str
ts.close
fso.DeleteFile Wscript.Arguments(i)

case "Input"




set ts= fso.CreateTextFile( sFolder & "\O00" & InputLast2  & Tnum  ,True)
targetNc= sFolder & "\O00" & InputLast2 & Tnum
ts.Write str
ts.close
fso.DeleteFile Wscript.Arguments(i)



case "NoChange"
Rem IF not fso.ExistFolder("D:\NewHassVm2") then
Rem fso.CreateFolder("D:\NewHassVm2")
Rem end if
set ts= fso.CreateTextFile("c:\nc\NewHassVm2\bk" & i & ".txt"   ,True)
targetNc= Wscript.Arguments(i) 
ts.Write str
ts.close

OverwriteExisting = True
Rem IF not fso.FolderExist("D:\NewHassVm2") then
Rem fso.CreateFolder("D:\NewHassVm2")
Rem end if
fso.CopyFile "c:\nc\NewHassVm2\bk" & i & ".txt" , Wscript.Arguments(i) , OverwriteExisting


case else

end select
end sub

Rem *****************************
Rem Ncviewer List
Rem *****************************
SUB view
dim ViewList
ViewList=" "
dim CountArgu
CountArgu=0
do
ViewList=ViewList  & Wscript.Arguments(CountArgu) & " "
CountArgu=CountArgu+1

if CountArgu>20 then
msgbox("CountArgu>20")
wscript.quit
end if

loop while CountArgu < Wscript.Arguments.Count

Rem msgbox("#" & ViewList)
ws.run "D:\NCVIEWER\NcViewer.exe /append" & ViewList
wscript.quit
end sub

Rem ***************
Rem clean Tool Offset
Rem ***************
SUB clean(CleanOn)

select case CleanOn
case 1
str = Replace(str,"M30", "#2022=#2021" & vbcrlf &"#2021=#2001" & vbcrlf & "#2001=-200." &vbcrlf & "M30")

case else
str = Replace(str,"#2022=#2021" & vbcrlf &"#2021=#2001" & vbcrlf & "#2001=-200.", " ")

end select
end sub



End Class
Rem #############################################################
Rem END CLASS


Rem =======diary==================
rem 1001---replace " X0.Y0. vbcrlf G00"
rem 	   at begin.
rem	   G68 G90 rotare	   
rem
rem
rem
rem 0925---o3000 record working time
rem 0916---509 = kill m05 m09
REM 0829---O3000 add T#510 M6 at the end
rem 0813---G98 G84 plus M29
rem 0725---O3000  conti m198 and TNEXT.
rem        O3500 no Tnext
rem 	   10 tnext
rem        replace variable


rem 0724---post liwe 3.4.2.0724


rem ******************
rem 0706---m198 add G53
rem 0705---m198 add m01
rem 0701---90. 4th
REM 0528---64 ADD NC.END M01, G68 REPLACE M30->M05
rem 0521---G54.1 P
rem 0517---?????
REM 0429---MAIN SCREEN
Rem 0414---1010 separate nc, delete ex-co, fix G90G10P17R(.+) to G90G10P(.+)
Rem 0410---add 61 T=H=D 64~66 remain water
Rem 0402---edit O
Rem 0330---62 63 assign T H
Rem 0329---design for win7. 62 assign T H
Rem 0218---G68. remove aic2 from menu
Rem 0213---ADD 111 121 SERIES TO MAIN MENU
Rem 0104---123 125
Rem 1127---sub aicc g05.1q1
Rem 1126---aicc2 511
Rem 1122---MAIN SCREEN
Rem 1120---aicc2 NO M09, found bug in 113 T=10 --> H00
Rem 0710---no clean
Rem 0709---ADD N
Rem 0624---#2021=#2001 WHEN NC DONE
Rem 0601---fix word open space path
Rem FIX O0011->O0000
Rem 0530---VIEWNC 411=see
Rem 0528---ADD SYNC WITH NO PRETOOL
Rem 0518---HASS NO PRETOOL
Rem 0516---CLASS V3.4
Rem 0510---change wend to do loop
Rem add 121, change O0001 to O0021
Rem 0426---del Lget original file
Rem 0425---Add Lget series for or105
Rem 112,113,114,116,119
Rem need to edit Lget seires files 
Rem while end prog
Rem fix 32 33 bug
Rem v3.3.0425b
Rem --------------------
Rem 0423---Add Lget to rename file name
Rem 1000 111
Rem v3.3.0423a
Rem ==============================
Rem FINDSTR /N .* %1 > F:\WINNT\Debug\RESULT.TXT