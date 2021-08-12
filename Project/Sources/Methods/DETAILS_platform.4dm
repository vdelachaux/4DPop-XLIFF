//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : DETAILS_platform
// Database: 4DPop XLIFF
// ID[94847FB750EC4936AEF5A91DEC00924E]
// Created #27-8-2013 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_choice; $Lon_parameters)
C_TEXT:C284($kTxt_template; $Mnu_pop; $Txt_icon)

If (False:C215)
	C_TEXT:C284(DETAILS_platform; $0)
	C_TEXT:C284(DETAILS_platform; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	$kTxt_template:=";#images/{file}.png"
	
	If ($Lon_parameters>=1)
		
		$Txt_icon:=Choose:C955(Length:C16($1)=0; "mac_win"; $1)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Length:C16($Txt_icon)=0)
	
	$Mnu_pop:=Create menu:C408
	APPEND MENU ITEM:C411($Mnu_pop; "Macintosh + Windows")
	SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "mac_win")
	APPEND MENU ITEM:C411($Mnu_pop; "Macintosh")
	SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "mac")
	APPEND MENU ITEM:C411($Mnu_pop; "Windows")
	SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "win")
	
	$Txt_icon:=Dynamic pop up menu:C1006($Mnu_pop)
	RELEASE MENU:C978($Mnu_pop)
	
End if 

If (Length:C16($Txt_icon)#0)
	
	OBJECT SET FORMAT:C236(*; "unit_platform.button"; Replace string:C233($kTxt_template; "{file}"; $Txt_icon))
	
End if 

$0:=$Txt_icon

// ----------------------------------------------------
// End