//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : xml_Error_text
// Database: 4DPop XLIFF
// ID[D4D51497664446FB9EEB0EF4E173742F]
// Created #26-9-2013 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($0)
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_error; $Lon_parameters)
C_TEXT:C284($Txt_error)

If (False:C215)
	C_TEXT:C284(xml_Error_text; $0)
	C_LONGINT:C283(xml_Error_text; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$Lon_error:=$1
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Txt_error:=Get localized string:C991("Error"+String:C10($Lon_error))

If (Length:C16($Txt_error)=0)
	
	$Txt_error:=Replace string:C233(Get localized string:C991("error"); "{error}"; String:C10($Lon_error))
	
End if 

$0:=$Txt_error

// ----------------------------------------------------
// End