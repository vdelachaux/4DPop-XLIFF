// ----------------------------------------------------
// Object method : EDITOR.details.subform - (4DPop XLIFF)
// ID[3AAFE48A0C55457DBFF073ED7062C9AD]
// Created #5-6-2013 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_formEvent)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=-1)
		
		//automatic scroll
		OBJECT SET SCROLL POSITION:C906(<>Lst_strings; Selected list items:C379(<>Lst_strings))
		
		//______________________________________________________
	: ($Lon_formEvent=-2)  //new unit
		
		EDITOR_NEW("unit")
		
		//______________________________________________________
	: ($Lon_formEvent=On Losing Focus:K2:8)
		
		SET LIST ITEM PARAMETER:C986(<>Lst_strings; *; "_new"; False:C215)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 