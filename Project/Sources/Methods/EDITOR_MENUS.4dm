//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : EDITOR_MENUS
// Created 26/10/06 by vdl
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_modified; $Boo_userSet)
C_TEXT:C284($Mnu_choice; $Mnu_main; $Txt_entryPoint)

If (False:C215)
	C_TEXT:C284(EDITOR_MENUS; $1)
End if 

$Txt_entryPoint:=$1

Case of 
		
		//_____________________________________________________
	: ($Txt_entryPoint="stringList")
		
		$Mnu_main:=mnu_Load_menu_from_file("stringList"; Get 4D folder:C485(Current resources folder:K5:16)+"menus.xml")
		
		$Mnu_choice:=Dynamic pop up menu:C1006($Mnu_main)
		RELEASE MENU:C978($Mnu_main)
		
		//_____________________________________________________
	: ($Txt_entryPoint="New")
		
		$Mnu_main:=mnu_Load_menu_from_file("buttonNew"; Get 4D folder:C485(Current resources folder:K5:16)+"menus.xml")
		
		$Mnu_choice:=Dynamic pop up menu:C1006($Mnu_main)
		RELEASE MENU:C978($Mnu_main)
		
		//_____________________________________________________
	: ($Txt_entryPoint="actions")
		
		$Boo_userSet:=(Selected list items:C379(<>Lst_files)>0)
		
		If ($Boo_userSet)
			
			GET LIST ITEM PARAMETER:C985(<>Lst_files; *; "modified"; $Boo_modified)
			
		End if 
		
		$Mnu_main:=Create menu:C408
		
		APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("MenuNew")+" "+Get localized string:C991("Menuxliff"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "new_file")
		
		APPEND MENU ITEM:C411($Mnu_main; "(-")
		
		APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("Menus_ValidateUsingDTD"))
		//SET MENU ITEM PARAMETER($Mnu_main;-1;"save_validate")
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "validate")
		
		If (Not:C34($Boo_userSet))
			
			DISABLE MENU ITEM:C150($Mnu_main; -1)
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("Menus_ShowTheFile"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "main_revele_file")
		
		If (Not:C34($Boo_userSet))
			
			DISABLE MENU ITEM:C150($Mnu_main; -1)
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("Menus_Delete"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "delete_file")
		
		If (Not:C34($Boo_userSet))
			
			DISABLE MENU ITEM:C150($Mnu_main; -1)
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_main; "(-")
		
		APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("MenuSave"))  //Save
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "save_menu_validate")
		
		If (Not:C34($Boo_modified))
			
			DISABLE MENU ITEM:C150($Mnu_main; -1)
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("MenuRevert"))  //Revert to Saved
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "revert")
		
		If (Not:C34($Boo_modified))
			
			DISABLE MENU ITEM:C150($Mnu_main; -1)
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_main; "(-")
		APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("Menus_Informations"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "file_infos")
		
		If (Not:C34($Boo_userSet))
			
			DISABLE MENU ITEM:C150($Mnu_main; -1)
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_main; "(-")
		
		APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("Menus_ImportSTR#Resource…"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "main_from_str")
		
		If (Not:C34($Boo_userSet))
			
			DISABLE MENU ITEM:C150($Mnu_main; -1)
			
		End if 
		
		$Mnu_choice:=Dynamic pop up menu:C1006($Mnu_main)
		RELEASE MENU:C978($Mnu_main)
		
		//_____________________________________________________
	: ($Txt_entryPoint="execute")
		
		$Mnu_choice:=Get selected menu item parameter:C1005
		
		//_____________________________________________________
	: ($Txt_entryPoint="install")
		
		SET MENU BAR:C67(mnu_Load_menu_from_file("editor"; Get 4D folder:C485(Current resources folder:K5:16)+"menus.xml"))
		
		//_____________________________________________________
	: ($Txt_entryPoint="uninstall")
		
		mnu_RELEASE_MENU(Get menu bar reference:C979(Current process:C322))
		
		//_____________________________________________________
	Else 
		
		$Mnu_choice:=$Txt_entryPoint
		
		//_____________________________________________________________________
End case 

Case of 
		
		//.....................................................
	: (Length:C16($Mnu_choice)=0)
		
		//.....................................................
	: ($Mnu_choice="file_infos")
		
		XLIFF_EDITOR_INFORMATIONS("dialog")
		
		//.....................................................
	: ($Mnu_choice="new_@")
		
		EDITOR_NEW($Mnu_choice)
		
		//.....................................................
	: ($Mnu_choice="save_@")
		
		EDITOR_save($Mnu_choice)
		
		//.....................................................
	: ($Mnu_choice="main_@")
		
		EDITOR_Boo_handler(Replace string:C233($Mnu_choice; "main_"; ""))
		
		//.....................................................
	: ($Mnu_choice="copy")
		
		MENU_COPY
		
		//.....................................................
	: ($Mnu_choice="duplicate")
		
		MENU_COPY
		MENU_PASTE
		
		//.....................................................
	: ($Mnu_choice="validate")
		
		EDITOR_Boo_handler("validate_file")
		
		//.....................................................
	Else 
		
		TRACE:C157
		
		//.....................................................
End case 