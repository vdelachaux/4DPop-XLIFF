//XLIFF_EDITOR_Lon_Objects_Method
C_BOOLEAN:C305($Boo_expanded)
C_LONGINT:C283($Lon_; $Lon_formEvent; $Lon_reference; $Lon_sublist)
C_TEXT:C284($kTxt_source; $kTxt_target; $Mnu_popup; $Txt_action; $Txt_group; $Txt_resname)

ARRAY LONGINT:C221($tLon_find; 0)

$Lon_formEvent:=Form event code:C388
$kTxt_source:="unit_source_box.resize"
$kTxt_target:="unit_target_box.move.resize"

Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Alternative Click:K2:36)\
		 | ($Lon_formEvent=On Long Click:K2:37)
		
		$Mnu_popup:=Create menu:C408
		APPEND MENU ITEM:C411($Mnu_popup; Get localized string:C991("Menus_FillIn"))
		SET MENU ITEM PARAMETER:C1004($Mnu_popup; -1; "AutoFill")
		
		APPEND MENU ITEM:C411($Mnu_popup; "(-")
		
		APPEND MENU ITEM:C411($Mnu_popup; Get localized string:C991("Menus_Preferences…"))
		SET MENU ITEM PARAMETER:C1004($Mnu_popup; -1; "Preferences")
		
		$Txt_action:=Dynamic pop up menu:C1006($Mnu_popup)
		RELEASE MENU:C978($Mnu_popup)
		
		//______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		$Txt_action:="AutoFill"
		
		//______________________________________________________
End case 

Case of 
		
		//______________________________________________________
	: ($Txt_action="Preferences")
		
		XLIFF_EDITOR_PROPERTIES("dialog_5")
		
		//______________________________________________________
	: ($Txt_action="AutoFill")
		
		GET LIST ITEM:C378(<>Lst_strings; \
			List item position:C629(<>Lst_strings; List item parent:C633(<>Lst_strings; *)); $Lon_; $Txt_group)
		
		$Txt_resname:=EDITOR_Autofill(<>Txt_Resname; $Txt_group)
		
		<>Txt_Resname:=$Txt_resname
		
		DETAILS_AFTER_MODIFICATION($Txt_resname; "resname_box")
		
		EDITOR_MODIFIED
		
		form_timerEvent(2; -1)
		
		//______________________________________________________
		//: ($Txt_action="AutoFillGroup")
		
		//  //current
		//GET LIST ITEM(<>Lst_strings;*;$Lon_reference;$Txt_group;$Lon_sublist;$Boo_expanded)
		
		//If ($Lon_sublist=0)
		//  //parent
		//GET LIST ITEM(<>Lst_strings;List item position(<>Lst_strings;List item parent(<>Lst_strings;*));$Lon_reference;$Txt_group;$Lon_sublist;$Boo_expanded)\
			
		//End if
		
		//For ($Lon_i;1;Count list items($Lon_sublist);1)
		//GET LIST ITEM($Lon_sublist;$Lon_i;$Lon_reference;$Txt_element)
		
		//  //GET LIST ITEM PARAMETER(<>Lst_strings;$Lon_reference;"resname";$Txt_resname)
		//  //EDITOR_Boo_handler ("resname_autofill";->$Txt_resname;->$Txt_group)
		//  //SET LIST ITEM(<>Lst_strings;$Lon_reference;$Txt_resname;$Lon_reference)
		
		//$Txt_resname:=EDITOR_Autofill ($Txt_element;$Txt_group)
		//SET LIST ITEM(<>Lst_strings;$Lon_reference;EDITOR_Autofill ($Txt_resname;$Txt_group);$Lon_reference)
		//SET LIST ITEM PARAMETER(<>Lst_strings;$Lon_reference;"resname";$Txt_resname)
		
		//  //find duplicates
		//DELETE FROM ARRAY($tLon_find;1;Size of array($tLon_find))
		
		//$tLon_find{0}:=Find in list(<>Lst_strings;$Txt_resname;1;$tLon_find;*)
		
		//If (Size of array($tLon_find)>1)  // | ($tLon_find{0}#$Lon_reference)
		//$Lon_icon:=Use PicRef+15050
		//$Lon_style:=Italic
		//$Lon_color:=0x00FF0000
		
		//Else
		
		//$Lon_icon:=0
		//$Lon_style:=Plain
		//$Lon_color:=Foreground color
		
		//End if
		
		//SET LIST ITEM PROPERTIES(<>Lst_strings;$Lon_reference;False;$Lon_style;$Lon_icon;$Lon_color)
		
		//End for
		
		//EDITOR_MODIFIED
		
		//form_timerEvent (2;-1)
		
		//______________________________________________________
End case 