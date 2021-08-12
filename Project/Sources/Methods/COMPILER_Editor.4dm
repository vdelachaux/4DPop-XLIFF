//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : Compiler_XLIFF
// Created 21/03/07 by vdl
// ----------------------------------------------------
// Description
// Compiler Directives & Module Initialisations
// ----------------------------------------------------
C_BOOLEAN:C305($1)

C_BOOLEAN:C305(<>Boo_initialized)

C_LONGINT:C283($Lon_version)
C_BOOLEAN:C305($Boo_onOpen; $Boo_quitOnError)

//Version Number
$Lon_version:=130  //xxx pour x.x.x

If (Count parameters:C259>=1)
	
	$Boo_onOpen:=$1
	
End if 

//Process variables  {
C_LONGINT:C283(Lon_typeEditorWindow)
//}

If ($Boo_onOpen)\
 | (Not:C34(<>Boo_initialized))
	
	//Interprocess arrays  {
	ARRAY BOOLEAN:C223(<>tBoo_attributes; 0)
	ARRAY TEXT:C222(<>tTxt_attributeNames; 0)
	ARRAY TEXT:C222(<>tTxt_attributeValues; 0)
	
	ARRAY TEXT:C222(<>tTxt_Sources; 0)
	ARRAY TEXT:C222(<>tTxt_Targets; 0)
	
	ARRAY BOOLEAN:C223(<>tBoo_xliff_Attributes_ListBox; 0)
	ARRAY TEXT:C222(<>tTxt_xliff_attributeNames; 0)
	ARRAY TEXT:C222(<>tTxt_xliff_attributeValues; 0)
	
	ARRAY BOOLEAN:C223(<>tBoo_file_Attributes_ListBox; 0)
	ARRAY TEXT:C222(<>tTxt_file_attributeNames; 0)
	ARRAY TEXT:C222(<>tTxt_file_attributeValues; 0)
	
	ARRAY BOOLEAN:C223(<>tBoo_file_Notes_ListBox; 0)
	ARRAY TEXT:C222(<>tTxt_file_Notes; 0)
	ARRAY TEXT:C222(<>tTxt_filePrivateHeaderElements; 0)
	
	ARRAY TEXT:C222(<>tTxt_prop_groupNames; 0)
	ARRAY TEXT:C222(<>tTxt_prop_groupValues; 0)
	
	ARRAY TEXT:C222(<>tTxt_unit_Attribute_Names; 0)
	ARRAY TEXT:C222(<>tTxt_group_Attribute_Names; 0)
	
	ARRAY TEXT:C222(<>tTxt_Search; 0)
	//}
	
	//Interprocess variables {
	C_LONGINT:C283(<>Lst_strings; <>Lst_files)
	C_LONGINT:C283(<>Lon_Onglet)
	
	C_TEXT:C284(<>Dom_object)
	C_TEXT:C284(<>Txt_sourceLang; <>Txt_targetLang)
	C_TEXT:C284(<>Focus)
	C_TEXT:C284(<>Txt_Resname; <>Txt_Target; <>Txt_Note)
	C_TEXT:C284(<>Txt_fileDump)
	C_TEXT:C284(<>Txt_CurrentFileName)
	C_TEXT:C284(<>Txt_ID)
	C_TEXT:C284(<>Txt_Buffer)
	C_TEXT:C284(<>Txt_CurrentFile_Path)
	C_TEXT:C284(<>Txt_Creation)
	C_TEXT:C284(<>Txt_Modification)
	C_TEXT:C284(<>Txt_Size)
	C_TEXT:C284(<>Txt_sourceLanguage)
	C_TEXT:C284(<>Txt_targetLanguage)
	C_TEXT:C284(<>Txt_prefix)
	C_TEXT:C284(<>Txt_prefixSeparator)
	
	C_LONGINT:C283(<>Xliff_vLon_Current)
	C_LONGINT:C283(<>vLast_Group_UID; <>vLast_unit_ID)
	C_LONGINT:C283(<>bPath; <>bEscape; <>bUtil; <>bPreferences; <>bInfos; <>bAction; <>bNewFile; <>bNewGroup)
	C_LONGINT:C283(<>bNewUnit; <>bLang; <>bAutoCompletion; <>bFiles; <>bOpen; <>bFile)
	C_LONGINT:C283(<>cb_1)
	C_LONGINT:C283(<>file_Attribute_Header)
	C_LONGINT:C283(<>file_Value_Header)
	C_LONGINT:C283(<>bR_3; <>bR_4)
	C_LONGINT:C283(<>dev_Lon_Error)
	C_LONGINT:C283(<>bNoTranslate)
	C_LONGINT:C283(<>xliff_Attribute_Header)
	C_LONGINT:C283(<>xliff_Lon_LastError)
	C_LONGINT:C283(<>xliff_Lon_Preference_Page)
	C_LONGINT:C283(<>xliff_Value_Header)
	
	C_BOOLEAN:C305(<>Boo_quit)
	C_BOOLEAN:C305(<>Boo_displayAttributs)
	//}
	
	//Initialisation {
	<>Boo_initialized:=Editor_init($Lon_version)
	
	If (<>Boo_initialized)
		
		$Boo_onOpen:=False:C215
		
		If (Not:C34(env_Boo_Is_a_Component) & Is compiled mode:C492)
			
			EXECUTE METHOD:C1007("Demo_Open"; $Boo_onOpen)
			
		End if 
		
		If ($Boo_onOpen)
			
			EDITOR_MAIN
			
		End if 
		
	Else 
		
		//Error during initialisation
		ALERT:C41("An error occurred during \""+Replace string:C233(Current method name:C684; "COMPILER_"; "")+"\" module loading")
		
		If ($Boo_quitOnError)
			
			QUIT 4D:C291
			
		End if 
	End if 
	//}
	
End if 

//Methods declarations {
If (False:C215)  // 4DPop interface
	
	//******************************************************************
	C_POINTER:C301(xliff_EDITOR; $1)
End if 

If (False:C215)  // private
	
	//******************************************************************
	C_BOOLEAN:C305(COMPILER_Editor; $1)
	
	//******************************************************************
	C_TEXT:C284(DETAILS_AFTER_MODIFICATION; $1)
	C_TEXT:C284(DETAILS_AFTER_MODIFICATION; $2)
	
	//******************************************************************
	C_LONGINT:C283(DETAILS_ON_RESIZE; $1)
	
	//******************************************************************
	C_TEXT:C284(DETAILS_platform; $0)
	C_TEXT:C284(DETAILS_platform; $1)
	
	//******************************************************************
	C_TEXT:C284(EDITOR_Autofill; $0)
	C_TEXT:C284(EDITOR_Autofill; $1)
	C_TEXT:C284(EDITOR_Autofill; $2)
	
	//******************************************************************
	C_BOOLEAN:C305(EDITOR_Boo_handler; $0)
	C_TEXT:C284(EDITOR_Boo_handler; $1)
	C_POINTER:C301(EDITOR_Boo_handler; ${2})
	
	//******************************************************************
	C_TEXT:C284(EDITOR_DELETE; $1)
	
	//******************************************************************
	C_BOOLEAN:C305(Editor_init; $0)
	C_LONGINT:C283(Editor_init; $1)
	
	//******************************************************************
	C_TEXT:C284(EDITOR_MAIN; $1)
	C_LONGINT:C283(EDITOR_MAIN; $2)
	
	//******************************************************************
	C_TEXT:C284(EDITOR_MENUS; $1)
	
	//******************************************************************
	C_TEXT:C284(EDITOR_NEW; $1)
	
	//******************************************************************
	C_BOOLEAN:C305(EDITOR_save; $0)
	C_TEXT:C284(EDITOR_save; $1)
	C_LONGINT:C283(EDITOR_save; $2)
	
	//******************************************************************
	C_LONGINT:C283(EDITOR_SEARCH; $1)
	
	//******************************************************************
	C_POINTER:C301(DETAILS_UPDATE; $1)
	
	//******************************************************************
	C_POINTER:C301(PREFERENCES; ${2})
	C_TEXT:C284(PREFERENCES; $1)
	C_POINTER:C301(PREFERENCES; $2)
	C_POINTER:C301(PREFERENCES; $3)
	C_POINTER:C301(PREFERENCES; $4)
	C_POINTER:C301(PREFERENCES; $5)
	
	//******************************************************************
	C_POINTER:C301(XLIFF_DEFAULT_LANGUAGES; $1)
	C_POINTER:C301(XLIFF_DEFAULT_LANGUAGES; $2)
	C_TEXT:C284(XLIFF_DEFAULT_LANGUAGES; $3)
	
	//******************************************************************
	C_TEXT:C284(XLIFF_EDITOR_INFORMATIONS; $1)
	
	//******************************************************************
	C_LONGINT:C283(XLIFF_EDITOR_SAVE_FILE; $1)
	C_TEXT:C284(XLIFF_EDITOR_SAVE_FILE; $2)
	C_TEXT:C284(XLIFF_EDITOR_SAVE_FILE; $3)
	C_TEXT:C284(XLIFF_EDITOR_SAVE_FILE; $4)
	
	//******************************************************************
	C_TEXT:C284(XLIFF_EDITOR_PROPERTIES; $1)
	
	//******************************************************************
	C_TEXT:C284(xliff_Txt_Localized_Path; $0)
	C_TEXT:C284(xliff_Txt_Localized_Path; $1)
	
	//******************************************************************
	C_TEXT:C284(xliff_Property_Group; $0)
	C_TEXT:C284(xliff_Property_Group; $1)
	C_TEXT:C284(xliff_Property_Group; $2)
	C_BOOLEAN:C305(xliff_Property_Group; $3)
	C_TEXT:C284(xliff_Property_Group; $4)
	
	//******************************************************************
	C_LONGINT:C283(XLIFF_parseFile; $0)
	C_TEXT:C284(XLIFF_parseFile; $1)
	
	//******************************************************************
	C_TEXT:C284(xliff_Txt_Language; $0)
	C_TEXT:C284(xliff_Txt_Language; $1)
	C_TEXT:C284(xliff_Txt_Language; $2)
	C_TEXT:C284(xliff_Txt_Language; $3)
	
	//******************************************************************
End if 

//}