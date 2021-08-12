// ----------------------------------------------------
// Object method : EDITOR.unit_source_box.resize - (4DPop XLIFF.4DB)
// Created 23/03/12 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_formEvent)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Getting Focus:K2:7)\
		 | ($Lon_formEvent=On Losing Focus:K2:8)
		
		DETAILS_UPDATE
		
		//______________________________________________________
	: ($Lon_formEvent=On After Edit:K2:43)
		
		DETAILS_AFTER_MODIFICATION
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unnecessarily activated form event")
		
		//______________________________________________________
End case 