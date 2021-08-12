//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : Méthode : OBJECT_ENABLE
// Created 02/04/09 by Vincent de Lachaux
// ----------------------------------------------------
// Modified by Vincent de Lachaux (23/10/09)
// Update (and simplify) code with new commands (v12)
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($1)
C_TEXT:C284(${2})

C_BOOLEAN:C305($Boo_activated)
C_LONGINT:C283($Lon_frontColor; $Lon_i; $Lon_parameters)

If (False:C215)
	C_BOOLEAN:C305(object_ENABLE; $1)
	C_TEXT:C284(object_ENABLE; ${2})
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

$Boo_activated:=$1
$Lon_frontColor:=Choose:C955($Boo_activated; -1; -3)

// ----------------------------------------------------

For ($Lon_i; 2; $Lon_parameters)
	
	OBJECT SET RGB COLORS:C628(*; ${$Lon_i}; $Lon_frontColor; -2)
	OBJECT SET ENTERABLE:C238(*; ${$Lon_i}; $Boo_activated)
	OBJECT SET ENABLED:C1123(*; ${$Lon_i}; $Boo_activated)
	
End for 
