//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : XLIFF_EDITOR_LOAD_FILE
// ID[DC28759989BF46DD9EB2F70D2EB1A0BF]
// Created 22/03/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_currentFile; $Lon_parameters; $Lon_ref; $Lon_x)
C_POINTER:C301($Ptr_currentFile; $Ptr_source; $Ptr_target)
C_TEXT:C284($kTxt_source; $kTxt_target; $Txt_buffer; $Txt_filePath)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	$kTxt_source:="unit_source_box.resize"
	$kTxt_target:="unit_target_box.move.resize"
	
	$Ptr_source:=OBJECT Get pointer:C1124(Object named:K67:5; $kTxt_source)
	$Ptr_target:=OBJECT Get pointer:C1124(Object named:K67:5; $kTxt_target)
	
	$Ptr_currentFile:=OBJECT Get pointer:C1124(Object named:K67:5; "current-file")
	
	//http://forums.4d.fr/Post/FR/16454692/1/16455688#16455688
	//$Lon_currentFile:=$Ptr_currentFile->
	If (Not:C34(Is nil pointer:C315($Ptr_currentFile)))
		
		$Lon_currentFile:=$Ptr_currentFile->
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
OBJECT SET VISIBLE:C603(*; "unit@"; False:C215)

GET LIST ITEM:C378(<>Lst_files; *; $Lon_ref; $Txt_buffer)

If ($Lon_ref#0) & ($Lon_ref#$Lon_currentFile)
	
	If (EDITOR_save("save"; $Lon_currentFile))
		
		$Ptr_currentFile->:=$Lon_ref
		//CLEAR VARIABLE(<>tTxt_dumpLines)
		
	Else 
		
		$Lon_ref:=0
		
	End if 
End if 

$Lon_currentFile:=$Ptr_currentFile->

If ($Lon_ref#0)
	
	//CLEAR VARIABLE(<>Txt_Search)
	CLEAR VARIABLE:C89(<>Txt_ID)
	CLEAR VARIABLE:C89(<>Txt_Resname)
	CLEAR VARIABLE:C89(<>Txt_fileDump)
	CLEAR VARIABLE:C89(<>bNoTranslate)
	
	CLEAR VARIABLE:C89(<>tTxt_attributeNames)
	CLEAR VARIABLE:C89(<>tTxt_attributeValues)
	
	If (Is a list:C621(<>Lst_strings))
		
		CLEAR LIST:C377(<>Lst_strings; *)
		
	End if 
	
	<>Txt_CurrentFileName:=$Txt_buffer
	OBJECT SET TITLE:C194(<>bFiles; $Txt_buffer)  //pallet
	
	If ($Lon_currentFile#0)
		
		//ARRAY TEXT($tTxt_languageCodes;0x0000)
		//LIST TO ARRAY("managed_language_codes";$tTxt_languageCodes)
		
		GET LIST ITEM PARAMETER:C985(<>Lst_files; $Lon_currentFile; "fullpath"; $Txt_filePath)
		<>Lst_strings:=XLIFF_parseFile($Txt_filePath)
		
		//Default values for xliff
		EDITOR_Boo_handler("default_xliff_attributes"; -><>tTxt_xliff_attributeNames; -><>tTxt_xliff_attributeValues)
		
		//Default values for file
		EDITOR_Boo_handler("default_file_attributes"; -><>tTxt_file_attributeNames; -><>tTxt_file_attributeValues)
		
		$Lon_x:=Find in array:C230(<>tTxt_prop_groupNames; "resname-prefix")
		If ($Lon_x>0)
			
			<>Txt_prefix:=<>tTxt_prop_groupValues{$Lon_x}
			
		Else 
			
			<>Txt_prefix:=""
			
		End if 
		
		$Lon_x:=Find in array:C230(<>tTxt_prop_groupNames; "resname-separator")
		If ($Lon_x>0)
			
			<>Txt_prefixSeparator:=<>tTxt_prop_groupValues{$Lon_x}
			
		Else 
			
			<>Txt_prefixSeparator:=""
			
		End if 
		
		$Lon_x:=Find in array:C230(<>tTxt_file_attributeNames; "source-language")
		If ($Lon_x>0)
			
			<>Txt_sourceLanguage:=Substring:C12(<>tTxt_file_attributeValues{$Lon_x}; 1; 2)
			
		Else 
			
			<>Txt_sourceLanguage:=<>Txt_sourceLang
			
		End if 
		
		$Lon_x:=Find in array:C230(<>tTxt_file_attributeNames; "target-language")
		If ($Lon_x>0)
			
			<>Txt_targetLanguage:=Substring:C12(<>tTxt_file_attributeValues{$Lon_x}; 1; 2)
			
		Else 
			
			<>Txt_targetLanguage:=<>Txt_targetLang
			
		End if 
		
		REDRAW WINDOW:C456
		
	Else 
		
		<>Lst_strings:=New list:C375
		
	End if 
	
	DISABLE MENU ITEM:C150(1; 3)
	DISABLE MENU ITEM:C150(1; 4)
	
Else 
	
	SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_files; $Lon_currentFile)
	
End if 

EDITOR_SCREEN_UPDATE
//Lsth_DISPLAY_SCROLLBAR (-><>Lst_strings)

OBJECT SET VISIBLE:C603(*; "_Spinner"; False:C215)

// ----------------------------------------------------
// End