//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : xml_NO_ERROR
// Database: 4DPop XLIFF
// ID[5C5D00ED45BA4D9EB8C81BA157D0C9FD]
// Created #30-9-2013 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_parameters)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
xml_last_error:=ERROR

// ----------------------------------------------------
// End