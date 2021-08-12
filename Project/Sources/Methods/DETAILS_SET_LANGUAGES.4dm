//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : DETAILS_SET_LANGUAGES
// Database: 4DPop XLIFF
// ID[DFFF6D668ED9463EBE4C4F7D17FF3984]
// Created #11-7-2013 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_parameters; $Lon_x)
C_TEXT:C284($kTxt_template)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	ARRAY TEXT:C222($tTxt_languageCodes; 0x0000)
	LIST TO ARRAY:C288("managed_language_codes"; $tTxt_languageCodes)
	
	$kTxt_template:=";#images/langs/lang_%.png"
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Lon_x:=Find in array:C230($tTxt_languageCodes; <>Txt_sourceLanguage)

If ($Lon_x>0)
	
	OBJECT SET FORMAT:C236(*; "unit_source_icon"; \
		Replace string:C233($kTxt_template; "%"; String:C10($Lon_x; "00")))
	
End if 

$Lon_x:=Find in array:C230($tTxt_languageCodes; <>Txt_targetLanguage)

If ($Lon_x>0)
	
	OBJECT SET FORMAT:C236(*; "unit_target_icon.move"; \
		Replace string:C233($kTxt_template; "%"; String:C10($Lon_x; "00")))
	
End if 

// ----------------------------------------------------
// End