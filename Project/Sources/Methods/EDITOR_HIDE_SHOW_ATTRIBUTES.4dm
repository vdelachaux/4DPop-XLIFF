//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : EDITOR_HIDE_SHOW_ATTRIBUTES
// Database: 4DPop XLIFF
// ID[588466B83A3A4139803739B2D410D395]
// Created #4-6-2013 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($Boo_visible)
C_LONGINT:C283($Lon_; $Lon_bottom; $Lon_left; $Lon_parameters; $Lon_right; $Lon_top)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	$Boo_visible:=Not:C34(OBJECT Get visible:C1075(*; "attributes.form"))
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
OBJECT SET VISIBLE:C603(*; "attributes.@"; $Boo_visible)

If ($Boo_visible)
	
	OBJECT GET COORDINATES:C663(*; "attributes.line"; $Lon_; $Lon_; $Lon_; $Lon_bottom)
	
Else 
	
	OBJECT GET COORDINATES:C663(*; "attributes.form"; $Lon_; $Lon_; $Lon_; $Lon_bottom)
	
End if 

OBJECT GET COORDINATES:C663(*; "file.list"; $Lon_left; $Lon_top; $Lon_right; $Lon_)
OBJECT MOVE:C664(*; "file.list"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom; *)

// ----------------------------------------------------
// End