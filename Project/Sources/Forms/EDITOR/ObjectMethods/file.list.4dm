// ----------------------------------------------------
// Object method : EDITOR.file.list - (4DPop XLIFF)
// ID[CAB3C37DF997445BB6676A8AF2885774]
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
	: ($Lon_formEvent=On Selection Change:K2:29)
		
		form_timerEvent(1; 10)
		
		//______________________________________________________
	: ($Lon_formEvent=On Delete Action:K2:56)
		
		EDITOR_DELETE("delete_file")
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 