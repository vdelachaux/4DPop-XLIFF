//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : obj_SET_RIGHT
// Created 26/08/10 by Vincent de Lachaux
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($3)

C_BOOLEAN:C305($Boo_align)
C_LONGINT:C283($Lon_; $Lon_bottom; $Lon_left; $Lon_parameters; $Lon_right)
C_LONGINT:C283($Lon_top)
C_TEXT:C284($Txt_object)

If (False:C215)
	C_TEXT:C284(obj_SET_RIGHT; $1)
	C_LONGINT:C283(obj_SET_RIGHT; $2)
	C_BOOLEAN:C305(obj_SET_RIGHT; $3)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2))
	
	$Txt_object:=$1
	$Lon_right:=$2
	
	If ($Lon_parameters>=3)
		
		$Boo_align:=$3
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

OBJECT GET COORDINATES:C663(*; $Txt_object; $Lon_left; $Lon_top; $Lon_; $Lon_bottom)

If ($Boo_align)
	
	OBJECT MOVE:C664(*; $Txt_object; $Lon_right-$Lon_; 0)
	
Else 
	
	OBJECT MOVE:C664(*; $Txt_object; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom; *)
	
End if 
