//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : win_RESIZE_FROM_PAGE
// Created 05/02/07 by vdl
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_; $Lon_Bottom; $Lon_Height; $Lon_Increment; $Lon_Left; $Lon_Offset; $Lon_Page; $Lon_Right)
C_LONGINT:C283($Lon_Top; $Lon_x; $Win_hdl)

If (False:C215)
	C_LONGINT:C283(win_RESIZE_FROM_PAGE; $1)
End if 

ARRAY TEXT:C222($tTxt_objects; 0x0000)
ARRAY POINTER:C280($tPtr_variables; 0x0000)
ARRAY LONGINT:C221($tLon_pages; 0x0000)

$Lon_Page:=$1

$Win_hdl:=Current form window:C827

//Compute the offset
OBJECT GET COORDINATES:C663(*; String:C10($Lon_Page; "00")+".Window.Max"; $Lon_; $Lon_; $Lon_; $Lon_Height)
GET WINDOW RECT:C443($Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom; $Win_hdl)
$Lon_Offset:=($Lon_Top+$Lon_Height)-$Lon_Bottom

If ($Lon_Offset#0)
	
	//Resize Window
	$Lon_Increment:=Abs:C99($Lon_Offset)\10
	
	If ($Lon_Increment#0)
		
		While ($Lon_x<Abs:C99($Lon_Offset))
			
			$Lon_x:=$Lon_x+$Lon_Increment
			
			If ($Lon_x>Abs:C99($Lon_Offset))
				
				$Lon_x:=Abs:C99($Lon_Offset)
				
			End if 
			
			If ($Lon_Offset>0)
				
				SET WINDOW RECT:C444($Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom+$Lon_x; $Win_hdl)
				
			Else 
				
				SET WINDOW RECT:C444($Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom-$Lon_x; $Win_hdl)
				
			End if 
		End while 
		
	Else 
		
		If ($Lon_Offset>0)
			
			SET WINDOW RECT:C444($Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom+$Lon_Offset; $Win_hdl)
			
		Else 
			
			SET WINDOW RECT:C444($Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom-$Lon_Offset; $Win_hdl)
			
		End if 
	End if 
	
	OBJECT GET COORDINATES:C663(*; String:C10($Lon_Page; "00")+".Window.Mini"; $Lon_; $Lon_; $Lon_; $Lon_Height)
	FORM SET VERTICAL RESIZING:C893(True:C214; $Lon_Height)
	
	//Move Objects
	OBJECT MOVE:C664(*; "@.Move@"; 0; $Lon_Offset)
	
	//Resize Objects
	OBJECT MOVE:C664(*; "@.Resize@"; 0; 0; 0; $Lon_Offset)
	
End if 

FORM GET OBJECTS:C898($tTxt_objects; $tPtr_variables; $tLon_pages; *)

$Lon_x:=0

Repeat 
	
	$Lon_x:=Find in array:C230($tLon_pages; $Lon_Page; $Lon_x+1)
	
	If ($Lon_x>0)
		
		OBJECT SET VISIBLE:C603(*; $tTxt_objects{$Lon_x}; True:C214)
		
	End if 
Until ($Lon_x=-1)

OBJECT SET VISIBLE:C603(*; "00.@.Move"; True:C214)