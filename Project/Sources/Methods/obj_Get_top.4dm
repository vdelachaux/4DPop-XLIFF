//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : obj_top
// Created 26/08/10 by Vincent de Lachaux
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_bottom; $Lon_left; $Lon_parameters; $Lon_right; $Lon_top)
C_TEXT:C284($Txt_object)

If (False:C215)
	C_LONGINT:C283(obj_Get_top; $0)
	C_TEXT:C284(obj_Get_top; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1))
	
	$Txt_object:=$1
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

OBJECT GET COORDINATES:C663(*; $Txt_object; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)

$0:=$Lon_top
