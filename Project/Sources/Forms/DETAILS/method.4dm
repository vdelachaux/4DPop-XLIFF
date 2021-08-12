// ----------------------------------------------------
// Form method : DETAILS - (4DPop XLIFF)
// ID[51315CDBE4F44949977B4BAA78E9F7A9]
// Created #4-6-2013 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_formEvent)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388

// ----------------------------------------------------

Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		SET TIMER:C645(10)
		
		//______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		//______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		DETAILS_SET_LANGUAGES
		DETAILS_ON_RESIZE(On Load:K2:1)
		
		//______________________________________________________
	: ($Lon_formEvent=On Bound Variable Change:K2:52)
		
		DETAILS_LOAD
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 