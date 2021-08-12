//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : EDITOR_NEW
// ID[928A3463F22045428D64278CBB57F899]
// Created 27/03/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_expanded; $Boo_OK)
C_LONGINT:C283($Lon_group; $Lon_groupCount; $Lon_parameters; $Lon_ref; $Lon_unitCount; $Lst_item)
C_TIME:C306($Gmt_Target)
C_PICTURE:C286($Pic_buffer)
C_TEXT:C284($Txt_buffer; $Txt_file; $Txt_localisedFolderPath; $Txt_path; $Txt_resname; $Txt_type)

If (False:C215)
	C_TEXT:C284(EDITOR_NEW; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	If ($Lon_parameters>=1)
		
		$Txt_type:=Replace string:C233($1; "new_"; "")
		
	End if 
	
	$Txt_type:=Choose:C955(Length:C16($Txt_type)=0; "unit"; $Txt_type)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Txt_type="unit")
		
		GET LIST ITEM:C378(<>Lst_strings; *; $Lon_ref; $Txt_resname; $Lst_item; $Boo_expanded)
		
		If ($Lon_ref<0)  //Group
			
			If (Not:C34(Is a list:C621($Lst_item)))
				
				$Lst_item:=New list:C375
				
				SET LIST ITEM:C385(<>Lst_strings; $Lon_ref; $Txt_resname; $Lon_ref; $Lst_item; $Boo_expanded)
				
			End if 
			
		Else 
			
			$Lon_group:=List item parent:C633(<>Lst_strings; $Lon_ref)
			
			GET LIST ITEM:C378(<>Lst_strings; List item position:C629(<>Lst_strings; $Lon_group); $Lon_ref; $Txt_resname; $Lst_item; $Boo_expanded)
			
		End if 
		
		$Lon_unitCount:=(OBJECT Get pointer:C1124(Object named:K67:5; "count.unit"))->
		(OBJECT Get pointer:C1124(Object named:K67:5; "count.unit"))->:=$Lon_unitCount+1
		
		<>vLast_unit_ID:=<>vLast_unit_ID+1
		
		$Txt_resname:=Replace string:C233(Get localized string:C991("NewItem"); "{id}"; String:C10(lsth_Lon_CountFirstLevelItems(->$Lst_item)+1))
		
		APPEND TO LIST:C376($Lst_item; $Txt_resname; <>vLast_unit_ID)
		SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_unit_ID; "_type"; "unit")
		SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_unit_ID; "_new"; True:C214)
		SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_unit_ID; "id"; <>vLast_unit_ID)
		SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_unit_ID; "resname"; $Txt_resname)
		
		SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_unit_ID; Additional text:K28:7; <>vLast_unit_ID)
		
		APPEND TO ARRAY:C911(<>tTxt_attributeNames; "id")
		APPEND TO ARRAY:C911(<>tTxt_attributeValues; String:C10(<>vLast_unit_ID))
		APPEND TO ARRAY:C911(<>tTxt_attributeNames; "resname")
		APPEND TO ARRAY:C911(<>tTxt_attributeValues; $Txt_resname)
		
		SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_strings; <>vLast_unit_ID)
		OBJECT SET SCROLL POSITION:C906(<>Lst_strings; List item position:C629(<>Lst_strings; <>vLast_unit_ID))
		
		EDITOR_MODIFIED
		
		form_timerEvent(2; -1)
		
		//______________________________________________________
	: ($Txt_type="group")
		
		$Lon_groupCount:=(OBJECT Get pointer:C1124(Object named:K67:5; "count.group"))->
		$Lon_groupCount:=$Lon_groupCount+1
		(OBJECT Get pointer:C1124(Object named:K67:5; "count.group"))->:=$Lon_groupCount
		
		<>vLast_Group_UID:=<>vLast_Group_UID-1
		
		$Txt_resname:=Replace string:C233(Get localized string:C991("NewGroup"); "{id}"; String:C10(lsth_Lon_CountFirstLevelItems(-><>Lst_strings)+1))
		
		APPEND TO LIST:C376(<>Lst_strings; $Txt_resname; <>vLast_Group_UID)
		SET LIST ITEM PARAMETER:C986(<>Lst_strings; 0; "_type"; "group")
		SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_Group_UID; "_new"; True:C214)
		SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_Group_UID; "resname"; $Txt_resname)
		
		SET LIST ITEM PROPERTIES:C386(<>Lst_strings; 0; False:C215; Bold:K14:2; 0)
		
		APPEND TO ARRAY:C911(<>tTxt_attributeNames; "resname")
		APPEND TO ARRAY:C911(<>tTxt_attributeValues; $Txt_resname)
		
		SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_strings; <>vLast_Group_UID)
		OBJECT SET SCROLL POSITION:C906(<>Lst_strings; List item position:C629(<>Lst_strings; <>vLast_Group_UID))
		
		EDITOR_MODIFIED
		
		form_timerEvent(2; -1)
		
		//______________________________________________________
	: ($Txt_type="file")
		
		If (EDITOR_save)
			
			$Txt_file:=Request:C163(Get localized string:C991("FileName"); Get localized string:C991("NewFile"))
			$Boo_OK:=((OK=1) & (Length:C16($Txt_file)>0))
			
			If ($Boo_OK)
				
				If ($Txt_file#"@.xlf")
					
					$Txt_file:=$Txt_file+".xlf"
					
				End if 
				
				//Get the database .lproj folder path
				DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "target_folder"; $Txt_buffer)
				$Txt_localisedFolderPath:=xliff_Txt_Language("Folder.Path.Validated"; $Txt_buffer; <>Txt_targetLang)
				CREATE FOLDER:C475($Txt_localisedFolderPath; *)
				
				$Boo_OK:=(Test path name:C476($Txt_localisedFolderPath)=Is a folder:K24:2)
				
				//Test if file already exist
				If ($Boo_OK)
					
					ARRAY TEXT:C222($tTxt_files; 0x0000)
					DOCUMENT LIST:C474($Txt_localisedFolderPath; $tTxt_files)
					
					$Boo_OK:=(Find in array:C230($tTxt_files; $Txt_file)=-1)
					
					If (Not:C34($Boo_OK))
						
						BEEP:C151
						
					End if 
				End if 
				
				//Create the file
				If ($Boo_OK)
					
					$Txt_path:=$Txt_localisedFolderPath+$Txt_file
					$Gmt_Target:=Create document:C266($Txt_path)
					
					If (OK=1)
						
						DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "default.encoding"; $Txt_buffer)
						SAX SET XML DECLARATION:C858($Gmt_Target; $Txt_buffer)
						SEND PACKET:C103($Gmt_Target; "\r")
						
						DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "default_comment"; $Txt_buffer)
						SAX ADD XML COMMENT:C852($Gmt_Target; $Txt_buffer)
						SEND PACKET:C103($Gmt_Target; "\r")
						
						//DOCTYPE is no more recommended
						//SAX ADD XML DOCTYPE($Gmt_Target;Get localized string("DOCTYPE"))
						//SEND PACKET($Gmt_Target;"\r")
						
						//_____________________________________________________________ <xliff>
						EDITOR_Boo_handler("default_xliff_attributes"; -><>tTxt_xliff_attributeNames; -><>tTxt_xliff_attributeValues)
						SAX OPEN XML ELEMENT ARRAYS:C921($Gmt_Target; "xliff"; <>tTxt_xliff_attributeNames; <>tTxt_xliff_attributeValues)
						
						//_____________________________________________________________ <file>
						EDITOR_Boo_handler("default_file_attributes"; -><>tTxt_file_attributeNames; -><>tTxt_file_attributeValues)
						SAX OPEN XML ELEMENT ARRAYS:C921($Gmt_Target; "file"; <>tTxt_file_attributeNames; <>tTxt_file_attributeValues)
						
						//_____________________________________________________________ <header>
						SAX OPEN XML ELEMENT:C853($Gmt_Target; "header")
						SAX CLOSE XML ELEMENT:C854($Gmt_Target)
						
						//_____________________________________________________________ <body>
						SAX OPEN XML ELEMENT:C853($Gmt_Target; "body")
						SAX CLOSE XML ELEMENT:C854($Gmt_Target)
						
						//_____________________________________________________________ </body>
						SAX CLOSE XML ELEMENT:C854($Gmt_Target)
						
						//_____________________________________________________________ </file>
						SAX CLOSE XML ELEMENT:C854($Gmt_Target)
						
						//_____________________________________________________________ </xliff>
						CLOSE DOCUMENT:C267($Gmt_Target)
						
						Repeat 
							
							$Lon_ref:=$Lon_ref+1
							
						Until (List item position:C629(<>Lst_files; $Lon_ref)=0)
						
						APPEND TO LIST:C376(<>Lst_files; Replace string:C233($Txt_file; ".xlf"; ""); $Lon_ref)
						SET LIST ITEM PARAMETER:C986(<>Lst_files; $Lon_ref; "fullpath"; $Txt_path)
						
						DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "default.encoding"; $Txt_buffer)
						SET LIST ITEM PARAMETER:C986(<>Lst_files; $Lon_ref; "file.encoding"; $Txt_buffer)
						
						SET LIST ITEM PARAMETER:C986(<>Lst_files; $Lon_ref; "xml.standalone"; False:C215)
						SET LIST ITEM PROPERTIES:C386(<>Lst_files; $Lon_ref; False:C215; Plain:K14:1; 0; Foreground color:K23:1)
						
						$Pic_buffer:=util_getResourceImage("Images/ListValid.tiff")
						SET LIST ITEM ICON:C950(<>Lst_files; $Lon_ref; $Pic_buffer)
						
						SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_files; $Lon_ref)
						
						If (Is a list:C621(<>Lst_strings))
							
							CLEAR LIST:C377(<>Lst_strings; *)
							
						End if 
						
					Else 
						
						BEEP:C151
						
					End if 
				End if 
				
				form_timerEvent(1; -1)
				
			End if 
		End if 
		
		//______________________________________________________
	Else 
		
		TRACE:C157
		
		//______________________________________________________
End case 

// ----------------------------------------------------
// End