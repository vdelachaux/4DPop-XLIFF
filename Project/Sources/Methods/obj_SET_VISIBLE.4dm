//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : obj_SET_VISIBLE
// ID[3F8E820CB8B54235993125319F3D1587]
// Created 30/11/10 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($1)
C_TEXT:C284(${2})

C_BOOLEAN:C305($Boo_visible)
C_LONGINT:C283($Lon_i; $Lon_parameters)

If (False:C215)
	C_BOOLEAN:C305(obj_SET_VISIBLE; $1)
	C_TEXT:C284(obj_SET_VISIBLE; ${2})
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	$Boo_visible:=$1
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

For ($Lon_i; 2; $Lon_parameters; 1)
	
	If (OBJECT Get visible:C1075(*; ${$Lon_i})#$Boo_visible)
		
		OBJECT SET VISIBLE:C603(*; ${$Lon_i}; $Boo_visible)
		
	End if 
	
End for 

// ----------------------------------------------------
// End