//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : Obj_CENTER
// Created 13/10/06 by vdl
// ----------------------------------------------------
// Description
// Center position of an object relative to another
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_LONGINT:C283($Lon_Bottom; $Lon_Left; $Lon_Middle; $Lon_Mode; $Lon_parameters)
C_LONGINT:C283($Lon_refBottom; $Lon_refLeft; $Lon_refRight; $Lon_refTop; $Lon_Right)
C_LONGINT:C283($Lon_Top)

If (False:C215)
	C_TEXT:C284(Obj_CENTER; $1)
	C_TEXT:C284(Obj_CENTER; $2)
	C_LONGINT:C283(Obj_CENTER; $3)
End if 

// ----------------------------------------------------
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2))
	
	OBJECT GET COORDINATES:C663(*; $2; $Lon_refLeft; $Lon_refTop; $Lon_refRight; $Lon_refBottom)
	
	If ($Lon_parameters>=3)
		
		$Lon_Mode:=$3
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If ($Lon_Mode=0) | ($Lon_Mode>=Vertically centered:K39:4)
	
	$Lon_Middle:=$Lon_refTop+(($Lon_refBottom-$Lon_refTop)/2)
	
	OBJECT GET COORDINATES:C663(*; $1; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
	OBJECT MOVE:C664(*; $1; 0; ($Lon_Middle-(($Lon_Bottom-$Lon_Top)/2))-$Lon_Top)
	
	If ($Lon_Mode#0)
		
		If ($Lon_Mode>Vertically centered:K39:4)
			
			$Lon_Mode:=$Lon_Mode-Vertically centered:K39:4
			
		End if 
		
	End if 
	
End if 

If ($Lon_Mode=0) | ($Lon_Mode=Horizontally centered:K39:1)
	
	$Lon_Middle:=$Lon_refLeft+(($Lon_refRight-$Lon_refLeft)/2)
	
	OBJECT GET COORDINATES:C663(*; $1; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
	OBJECT MOVE:C664(*; $1; ($Lon_Middle-(($Lon_Right-$Lon_Left)/2))-$Lon_Left; 0)
	
End if 

// ----------------------------------------------------
