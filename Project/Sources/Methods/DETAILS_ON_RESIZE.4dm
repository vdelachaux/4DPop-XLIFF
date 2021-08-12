//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : DETAILS_ON_RESIZE
// Database: 4DPop XLIFF
// ID[6972B46373A34E92B61042685A9B8AB9]
// Created #5-6-2013 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Management of the dynamyc resizing of object
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_event; $Lon_height; $Lon_offset; $Lon_parameters; $Lon_saved; $Lon_width)
C_POINTER:C301($Ptr_container)

If (False:C215)
	C_LONGINT:C283(DETAILS_ON_RESIZE; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$Lon_event:=$1
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Ptr_container:=OBJECT Get pointer:C1124(Object named:K67:5; "form-height")
OBJECT GET SUBFORM CONTAINER SIZE:C1148($Lon_width; $Lon_height)

$Lon_saved:=$Ptr_container->

If ($Lon_saved=0)
	
	FORM GET PROPERTIES:C674("DETAILS"; $Lon_width; $Lon_saved)
	
End if 

If ($Lon_event#On Load:K2:1)
	
	$Lon_offset:=(($Lon_height)-$Lon_saved)/2
	
	If ($Lon_offset#0)
		
		OBJECT MOVE:C664(*; "@.move@"; 0; $Lon_offset)
		OBJECT MOVE:C664(*; "@.resize@"; 0; 0; 0; $Lon_offset)
		
		OBJECT GET COORDINATES:C663(*; "unit_source_box.resize"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
		OBJECT MOVE:C664(*; "unit_source_M_box"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom; *)
		
		OBJECT GET COORDINATES:C663(*; "unit_target_box.move.resize"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
		OBJECT MOVE:C664(*; "unit_target_M_box"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom; *)
		
	End if 
End if 

$Ptr_container->:=$Lon_height

// ----------------------------------------------------
// End