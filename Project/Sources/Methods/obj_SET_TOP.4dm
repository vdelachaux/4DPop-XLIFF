//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : obj_SET_TOP
// Created 26/08/10 by Vincent de Lachaux
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($Lon_; $Lon_bottom; $Lon_left; $Lon_parameters; $Lon_right)
C_LONGINT:C283($Lon_top)
C_TEXT:C284($Txt_object)

If (False:C215)
	C_TEXT:C284(obj_SET_TOP; $1)
	C_LONGINT:C283(obj_SET_TOP; $2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2))
	
	$Txt_object:=$1
	$Lon_top:=$2
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

OBJECT GET COORDINATES:C663(*; $Txt_object; $Lon_left; $Lon_; $Lon_right; $Lon_bottom)
OBJECT MOVE:C664(*; $Txt_object; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom; *)
