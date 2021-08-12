//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : FILE_VALIDATION
// Database: 4DPop XLIFF
// ID[C15A667AF9854AB58E648EA71C8281BE]
// Created #26-9-2013 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($Boo_externalDTD; $Boo_givenDTD; $Boo_noDTD; $Boo_OK)
C_LONGINT:C283($Lon_error; $Lon_parameters)
C_TEXT:C284($Dom_root; $File_toValidate; $Txt_DTD; $Txt_errorMethod)

If (False:C215)
	C_LONGINT:C283(xml_Validation; $0)
	C_TEXT:C284(xml_Validation; $1)
	C_TEXT:C284(xml_Validation; $2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$File_toValidate:=$1
	
	If ($Lon_parameters>=2)
		
		$Txt_DTD:=$2
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: (Test path name:C476($File_toValidate)#Is a document:K24:1)
		
		$Lon_error:=-43
		
		//______________________________________________________
	: (Length:C16($Txt_DTD)=0)
		
		$Boo_noDTD:=True:C214
		
		//______________________________________________________
	: (Position:C15("<?xml"; $Txt_DTD)=1)
		
		$Boo_givenDTD:=True:C214
		
		//______________________________________________________
	: (Test path name:C476($Txt_DTD)#Is a document:K24:1)
		
		$Lon_error:=-43
		
		//______________________________________________________
	Else 
		
		$Boo_externalDTD:=True:C214
		
		//______________________________________________________
End case 

$Txt_errorMethod:=Method called on error:C704

ON ERR CALL:C155("xml_NO_ERROR")

Case of 
		
		//______________________________________________________
	: ($Boo_noDTD)
		
		$Dom_root:=DOM Parse XML source:C719($File_toValidate; True:C214)
		
		//______________________________________________________
	: ($Boo_givenDTD)
		
		$Dom_root:=DOM Parse XML source:C719($File_toValidate; True:C214; $Txt_DTD)
		
		//______________________________________________________
	: ($Boo_externalDTD)
		
		$Dom_root:=DOM Parse XML source:C719($File_toValidate; True:C214; $Txt_DTD)
		
		//______________________________________________________
End case 

$Boo_OK:=(OK=1)

ON ERR CALL:C155($Txt_errorMethod)

If ($Boo_OK)
	
	DOM CLOSE XML:C722($Dom_root)
	
Else 
	
	$Lon_error:=xml_last_error
	
End if 

$0:=$Lon_error

// ----------------------------------------------------
// End