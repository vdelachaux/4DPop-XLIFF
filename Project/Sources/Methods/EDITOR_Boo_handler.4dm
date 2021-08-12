//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : XLIFF_EDITOR_Boo_handler
// ID[A7956FC4E6184BE7938085056A765EA4]
// Created 31/10/06 by vdl
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_POINTER:C301(${2})

C_BOOLEAN:C305($Boo_Capitalize; $Boo_enterable; $Boo_OK)
C_LONGINT:C283($Lon_buffer; $Lon_colonne; $Lon_color; $Lon_End_j; $Lon_error; $Lon_Height)
C_LONGINT:C283($Lon_i; $Lon_icon; $Lon_ID; $Lon_j; $Lon_Left; $Lon_ligne)
C_LONGINT:C283($Lon_parameters; $Lon_ref; $Lon_Size; $Lon_styles; $Lon_Sublist; $Lon_Unused)
C_LONGINT:C283($Lon_Width; $Lon_wLeft; $Lon_wTop; $Lon_x; $Lon_y; $Lon_Top)
C_TIME:C306($Gmt_ResSourceFile; $Gmt_ResTargetFile; $Gmt_Start)
C_PICTURE:C286($Pic_buffer)
C_TEXT:C284($kTxt_Separator; $Txt_buffer; $Txt_CharacterEscaped; $Txt_dtdFilePath; $Txt_entryPoint)
C_TEXT:C284($Txt_error; $Txt_Group; $Txt_HTML_Path; $Txt_Localized_Folder_Path; $Txt_Path; $Txt_Resname)
C_TEXT:C284($Txt_Source; $Txt_Source_Path; $Txt_StopCaracters; $Txt_targetFolderPath; $Txt_targetPath; $Txt_version)
C_TEXT:C284($Txt_XSL_Path)

ARRAY LONGINT:C221($tLon_ResIDs; 0)
ARRAY TEXT:C222($tTxt_attributNames; 0)
ARRAY TEXT:C222($tTxt_attributValues; 0)
ARRAY TEXT:C222($tTxt_files; 0)
ARRAY TEXT:C222($tTxt_ResNames; 0)
ARRAY TEXT:C222($tTxt_Source_Strings; 0)
ARRAY TEXT:C222($tTxt_Target_Strings; 0)

If (False:C215)
	C_BOOLEAN:C305(EDITOR_Boo_handler; $0)
	C_TEXT:C284(EDITOR_Boo_handler; $1)
	C_POINTER:C301(EDITOR_Boo_handler; ${2})
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$Txt_entryPoint:=$1
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Txt_entryPoint="update")
		
		TRACE:C157
		
		//______________________________________________________
	: ($Txt_entryPoint="validate_file@")
		
		$Txt_entryPoint:=Replace string:C233($Txt_entryPoint; "validate_file"; "")
		GET LIST ITEM PARAMETER:C985(<>Lst_files; *; "fullpath"; $Txt_Source_Path)
		
		// Modified by vdl (28/05/08)
		// In C/S mode wait for local update  {
		If (Application type:C494=4D Remote mode:K5:5)
			
			$Gmt_Start:=Current time:C178
			
			Repeat 
				
				DELAY PROCESS:C323(Current process:C322; 10)
				
			Until (Test path name:C476($Txt_Source_Path)=Is a document:K24:1) | ((Current time:C178-$Gmt_Start)>30)
			
		End if   // }
		
		If (Test path name:C476($Txt_Source_Path)=Is a document:K24:1)
			
			//Get DTD file name {
			$Lon_x:=Find in array:C230(<>tTxt_xliff_attributeNames; "version")
			
			If ($Lon_x>0)
				
				$Txt_version:=<>tTxt_xliff_attributeValues{$Lon_x}
				
			Else 
				
				DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "default.version"; $Txt_version)
				
			End if 
			
			DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "dtd_folder"; $Txt_buffer)
			$Txt_dtdFilePath:=$Txt_buffer+"xliff_"+$Txt_version+".dtd"
			//}
			
			If (Test path name:C476($Txt_dtdFilePath)=Is a document:K24:1)
				
				GET LIST ITEM PROPERTIES:C631(<>Lst_files; *; $Boo_enterable; $Lon_styles; $Lon_icon; $Lon_color)
				
				$Lon_error:=xml_Validation($Txt_Source_Path)  //;$Txt_dtdFilePath)
				
				If ($Lon_error=0)
					
					$Lon_styles:=Plain:K14:1
					$Pic_buffer:=util_getResourceImage("Images/ListValid.tiff")
					$Lon_color:=Foreground color:K23:1
					
				Else 
					
					$Lon_styles:=Italic:K14:3
					$Pic_buffer:=util_getResourceImage("Images/ListAlert.tiff")
					
					$Txt_error:=xml_Error_text($Lon_error)
					
					If (Length:C16($Txt_error)=0)
						
						$Txt_error:="Error: "+String:C10($Lon_error)
						
					End if 
				End if 
				
				SET LIST ITEM PROPERTIES:C386(<>Lst_files; *; $Boo_enterable; $Lon_styles; 0; $Lon_color)
				SET LIST ITEM ICON:C950(<>Lst_files; *; $Pic_buffer)
				
			Else 
				
				$Txt_error:=Get localized string:C991("Error-43")+"\r\r\""+$Txt_dtdFilePath+"\""
				
			End if 
			
			If (Length:C16($Txt_error)>0) & (Length:C16($Txt_entryPoint)=0)
				
				ALERT:C41($Txt_error)
				
			End if 
		End if 
		
		//______________________________________________________
	: ($Txt_entryPoint="modified")  //Mark current file as modified
		
		TRACE:C157
		
		//SET LIST ITEM PARAMETER(<>Lst_files;*;"modified";True)
		//
		//GET LIST ITEM ICON(<>Lst_strings;*;$Pic_buffer)
		//GET LIST ITEM PROPERTIES(<>Lst_strings;*;$Boo_enterable;$Lon_styles;$Lon_icon)
		//
		//SET LIST ITEM PROPERTIES(<>Lst_strings;*;False;$Lon_styles;0;Foreground color)
		//SET LIST ITEM ICON(<>Lst_strings;*;$Pic_buffer)
		//
		//$Lon_parentRef:=List item parent(<>Lst_strings;*)
		//
		//If ($Lon_parentRef#0)
		//
		//GET LIST ITEM ICON(<>Lst_strings;$Lon_parentRef;$Pic_buffer)
		//SET LIST ITEM PROPERTIES(<>Lst_strings;$Lon_parentRef;False;Bold;0;Foreground color)
		//SET LIST ITEM ICON(<>Lst_strings;$Lon_parentRef;$Pic_buffer)
		//
		//End if
		//
		//ENABLE MENU ITEM(1;3)
		//ENABLE MENU ITEM(1;4)
		
		//______________________________________________________
	: ($Txt_entryPoint="resname_autofill")
		
		DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "ignored_characters"; $Txt_CharacterEscaped)
		$Txt_CharacterEscaped:=Replace string:C233($Txt_CharacterEscaped; "\\r"; "\r")
		$Txt_CharacterEscaped:=Replace string:C233($Txt_CharacterEscaped; "\\n"; "\n")
		$Txt_CharacterEscaped:=Replace string:C233($Txt_CharacterEscaped; "\\t"; "\t")
		$Txt_CharacterEscaped:=Replace string:C233($Txt_CharacterEscaped; "\\\""; Char:C90(Double quote:K15:41))
		
		$Txt_Source:=$2->
		$Txt_Group:=$3->
		
		If (Length:C16(<>Txt_prefix)=0)
			
			If (Position:C15($Txt_Group; $Txt_Source)#1)
				
				$Txt_Resname:=$Txt_Group+<>Txt_prefixSeparator+$Txt_Source
				
			End if 
			
		Else 
			
			If (Position:C15(<>Txt_prefix; $Txt_Source)#1)
				
				$Txt_Resname:=<>Txt_prefix+$Txt_Source
				
			End if 
		End if 
		
		$Txt_Resname:=Lowercase:C14($Txt_Resname)
		
		$Lon_End_j:=Length:C16($Txt_Resname)
		
		$Boo_Capitalize:=True:C214  //The first is capitalized
		
		For ($Lon_j; 1; $Lon_End_j; 1)
			
			Case of 
					
					//______________________________________________________
				: ($Lon_j>Length:C16($Txt_Resname))
					
					//______________________________________________________
				: (Position:C15($Txt_Resname[[$Lon_j]]; $Txt_StopCaracters)>0)
					
					$Txt_Resname:=Substring:C12($Txt_Resname; 1; $Lon_j-1)
					$Lon_j:=$Lon_End_j+1
					
					//______________________________________________________
				: (Position:C15($Txt_Resname[[$Lon_j]]; $Txt_CharacterEscaped)>0)
					
					$Boo_Capitalize:=($Boo_Capitalize | (($Txt_Resname[[$Lon_j]]=" ")))
					$Txt_Resname:=Replace string:C233($Txt_Resname; $Txt_Resname[[$Lon_j]]; ""; 1)
					$Lon_j:=$Lon_j-1
					
					//______________________________________________________
				: ($Boo_Capitalize)
					
					$Txt_Resname[[$Lon_j]]:=Uppercase:C13($Txt_Resname[[$Lon_j]])
					$Boo_Capitalize:=False:C215
					
					//______________________________________________________
			End case 
		End for 
		
		DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "max_resname_size"; $Lon_buffer)
		
		If ($Lon_buffer>0)
			
			$Txt_Resname:=Substring:C12($Txt_Resname; 1; $Lon_buffer)
			
		End if 
		
		$2->:=$Txt_Resname
		
		//______________________________________________________
	: ($Txt_entryPoint="view_in_browser")
		
		GET LIST ITEM PARAMETER:C985(<>Lst_files; *; "fullpath"; $Txt_Path)
		$Txt_Localized_Folder_Path:=doc_gTxt_Path("parent.path"; $Txt_Path)
		$Txt_XSL_Path:=$Txt_Localized_Folder_Path+"xliff.xsl"
		$Txt_HTML_Path:=$Txt_Localized_Folder_Path+"monfichier.html"
		_O_XSLT APPLY TRANSFORMATION:C882($Txt_Path; $Txt_XSL_Path; $Txt_HTML_Path)
		
		If (OK=0)
			
			_O_XSLT GET ERROR:C884($Txt_error; $Lon_ligne; $Lon_colonne)
			ALERT:C41($Txt_error+" [L:"+String:C10($Lon_ligne)+" - C:"+String:C10($Lon_colonne)+"]")
			
		Else 
			
			OPEN URL:C673($Txt_HTML_Path)
			
		End if 
		
		//______________________________________________________
	: ($Txt_entryPoint="revele_file")
		
		GET LIST ITEM PARAMETER:C985(<>Lst_files; *; "fullpath"; $Txt_Path)
		
		If (Test path name:C476($Txt_Path)=Is a document:K24:1)
			
			SHOW ON DISK:C922($Txt_Path)
			
		End if 
		
		//______________________________________________________
	: ($Txt_entryPoint="from_str")  //Import STR# in a group
		
		DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "target_folder"; $Txt_targetFolderPath)
		
		$Txt_Source_Path:=xliff_Txt_Language("Folder.Path.Validated"; $Txt_targetFolderPath; <>Txt_sourceLang)
		$Boo_OK:=(Test path name:C476($Txt_Source_Path)=Is a folder:K24:2)
		
		If ($Boo_OK)
			
			$kTxt_Separator:=$Txt_Source_Path[[Length:C16($Txt_Source_Path)]]
			
			//Append Localized file
			$Txt_Source_Path:=$Txt_Source_Path+"Localized.rsrc"
			$Boo_OK:=(Test path name:C476($Txt_Source_Path)=Is a document:K24:1)
			
		End if 
		
		If ($Boo_OK)
			
			$Txt_buffer:=Request:C163("STR# ID :\\ex. 1500 | 15001,15002,...,15xxx | 15000-1510")
			$Boo_OK:=((OK=1) & (Length:C16($Txt_buffer)>0))
			
			If ($Boo_OK)
				
				// Added by Vincent de Lachaux (11/07/08)
				// list and range of IDs
				//{
				ARRAY LONGINT:C221($tLon_IDs; 0x0000)
				$Lon_x:=Position:C15(","; $Txt_buffer)
				
				If ($Lon_x>0)
					
					Repeat 
						
						$Lon_x:=Position:C15(","; $Txt_buffer)
						
						If ($Lon_x>0)
							
							$Lon_ID:=Num:C11(Substring:C12($Txt_buffer; 1; $Lon_x-1))
							$Txt_buffer:=Substring:C12($Txt_buffer; $Lon_x+1)
							
						Else 
							
							$Lon_ID:=Num:C11($Txt_buffer)
							
						End if 
						
						APPEND TO ARRAY:C911($tLon_IDs; $Lon_ID)
						
					Until ($Lon_x=0)
					
				Else 
					
					$Lon_x:=Position:C15("-"; $Txt_buffer)
					
					If ($Lon_x>0)
						
						$Lon_y:=Num:C11(Substring:C12($Txt_buffer; $Lon_x+1))
						$Lon_x:=Num:C11(Substring:C12($Txt_buffer; 1; $Lon_x-1))
						
						If ($Lon_y>$Lon_x)
							
							For ($Lon_i; $Lon_x; $Lon_y; 1)
								
								APPEND TO ARRAY:C911($tLon_IDs; $Lon_i)
								
							End for 
							
						Else 
							
							BEEP:C151
							
						End if 
						
					Else 
						
						APPEND TO ARRAY:C911($tLon_IDs; Num:C11($Txt_buffer))
						
					End if 
				End if 
				//}
				
				//Open the resource file
				$Gmt_ResSourceFile:=Open resource file:C497($Txt_Source_Path)
				$Boo_OK:=(OK=1)
				
				If ($Boo_OK)
					
					RESOURCE LIST:C500("STR#"; $tLon_ResIDs; $tTxt_ResNames; $Gmt_ResSourceFile)
					
					For ($Lon_j; 1; Size of array:C274($tLon_IDs); 1)
						
						$Lon_ID:=$tLon_IDs{$Lon_j}
						$Lon_x:=Find in array:C230($tLon_ResIDs; $Lon_ID)
						$Boo_OK:=((OK=1) & ($Lon_x>0))
						
						If ($Boo_OK)
							
							$Txt_ResName:=$tTxt_ResNames{$Lon_x}
							
							If (Length:C16($Txt_ResName)=0)
								
								$Txt_ResName:="STR# "+String:C10($Lon_ID)
								
							End if 
							
							STRING LIST TO ARRAY:C511($Lon_ID; $tTxt_Source_Strings; $Gmt_ResSourceFile)
							$Boo_OK:=(OK=1)
							
							If ($Boo_OK)
								
								If (<>Txt_targetLang#<>Txt_sourceLang)
									
									//Get target localized path
									$Txt_targetPath:=xliff_Txt_Language("Folder.Path.Validated"; $Txt_targetFolderPath; <>Txt_targetLang)+"Localized.rsrc"
									
									If (Test path name:C476($Txt_targetPath)=Is a document:K24:1)
										
										$Gmt_ResTargetFile:=Open resource file:C497($Txt_targetPath)
										
										If (OK=1)
											
											STRING LIST TO ARRAY:C511($Lon_ID; $tTxt_Target_Strings; $Gmt_ResTargetFile)
											
										Else 
											
											ALERT:C41(Get localized string:C991("xliff_AnErrorOccurredTheResourcesFileCannotBeOpened."))
											$Gmt_ResTargetFile:=?00:00:00?
											
										End if 
									End if 
									
								Else 
									
									//The sources strings will be copied in the targets
									COPY ARRAY:C226($tTxt_Source_Strings; $tTxt_Target_Strings)
									
								End if 
							End if 
							
							If ($Boo_OK)
								
								$Lon_Sublist:=New list:C375
								
								For ($Lon_i; 1; Size of array:C274($tTxt_Source_Strings); 1)
									
									// Added by Vincent de Lachaux (16/07/08)
									// Filtrer les caractères 0
									//{
									
									Repeat 
										
										$Lon_x:=Position:C15(Char:C90(0); $tTxt_Source_Strings{$Lon_i}; *)
										
										If ($Lon_x>0)
											
											$tTxt_Source_Strings{$Lon_i}:=Delete string:C232($tTxt_Source_Strings{$Lon_i}; $Lon_x; 1)
											
										End if 
									Until ($Lon_x=0)
									//}
									
									DELETE FROM ARRAY:C228(<>tTxt_attributeNames; 1; Size of array:C274(<>tTxt_attributeNames))
									DELETE FROM ARRAY:C228(<>tTxt_attributeValues; 1; Size of array:C274(<>tTxt_attributeValues))
									<>vLast_unit_ID:=<>vLast_unit_ID+1
									APPEND TO LIST:C376($Lon_Sublist; $tTxt_Source_Strings{$Lon_i}; <>vLast_unit_ID)
									SET LIST ITEM PROPERTIES:C386($Lon_Sublist; 0; False:C215; Plain:K14:1; 0; Foreground color:K23:1)
									SET LIST ITEM PARAMETER:C986($Lon_Sublist; <>vLast_unit_ID; "4D_additional_text"; $Lon_i)
									SET LIST ITEM PARAMETER:C986($Lon_Sublist; <>vLast_unit_ID; "_type"; "unit")
									APPEND TO ARRAY:C911(<>tTxt_attributeNames; "id")
									APPEND TO ARRAY:C911(<>tTxt_attributeValues; String:C10($Lon_i))
									APPEND TO ARRAY:C911(<>tTxt_attributeNames; "resname")
									
									If (Length:C16($tTxt_Source_Strings{$Lon_i})>0)
										
										APPEND TO ARRAY:C911(<>tTxt_attributeValues; $tTxt_Source_Strings{$Lon_i})
										
									Else 
										
										APPEND TO ARRAY:C911(<>tTxt_attributeValues; "#"+String:C10($Lon_i))
										
									End if 
									
									SET LIST ITEM PARAMETER:C986($Lon_Sublist; <>vLast_unit_ID; "_source"; $tTxt_Source_Strings{$Lon_i})
									
									If (Size of array:C274($tTxt_Target_Strings)>=$Lon_i)
										
										// Added by Vincent de Lachaux (16/07/08)
										// Filtrer les caractères 0
										//{
										
										Repeat 
											
											$Lon_x:=Position:C15(Char:C90(0); $tTxt_Target_Strings{$Lon_i}; *)
											
											If ($Lon_x>0)
												
												$tTxt_Target_Strings{$Lon_i}:=Delete string:C232($tTxt_Target_Strings{$Lon_i}; $Lon_x; 1)
												
											End if 
										Until ($Lon_x=0)
										//}
										
										// Comparaison diacritique (11/07/08)
										//{
										//Si ($tTxt_Target_Strings{$Lon_i}=$tTxt_Source_Strings{$Lon_i})
										If (Position:C15($tTxt_Target_Strings{$Lon_i}; $tTxt_Source_Strings{$Lon_i}; *)=1)
											
											//}
											APPEND TO ARRAY:C911(<>tTxt_attributeNames; "translate")
											APPEND TO ARRAY:C911(<>tTxt_attributeValues; "no")
											
										Else 
											
											SET LIST ITEM PARAMETER:C986($Lon_Sublist; <>vLast_unit_ID; "_target"; $tTxt_Target_Strings{$Lon_i})
											
										End if 
									End if 
									
									//EDITOR_Boo_handler ("keep_attributes";->$Lon_Sublist;-><>vLast_Unit_UID)
									
								End for 
								
								<>vLast_Group_UID:=<>vLast_Group_UID-1
								APPEND TO LIST:C376(<>Lst_strings; $Txt_ResName; <>vLast_Group_UID; $Lon_Sublist; True:C214)
								SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_Group_UID; "4D_additional_text"; $Lon_ID)
								SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_Group_UID; "_type"; "group")
								SET LIST ITEM PROPERTIES:C386(<>Lst_strings; 0; False:C215; Bold:K14:2; 0; Foreground color:K23:1)
								DELETE FROM ARRAY:C228(<>tTxt_attributeNames; 1; Size of array:C274(<>tTxt_attributeNames))
								DELETE FROM ARRAY:C228(<>tTxt_attributeValues; 1; Size of array:C274(<>tTxt_attributeValues))
								APPEND TO ARRAY:C911(<>tTxt_attributeNames; "resname")
								APPEND TO ARRAY:C911(<>tTxt_attributeValues; $Txt_ResName)
								APPEND TO ARRAY:C911(<>tTxt_attributeNames; "id")
								APPEND TO ARRAY:C911(<>tTxt_attributeValues; String:C10($Lon_ID))
								
								//EDITOR_Boo_handler ("keep_attributes";-><>Lst_strings;-><>vLast_Group_UID)
								
								SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_strings; 0)
								EDITOR_MODIFIED
								GOTO OBJECT:C206(<>Txt_Resname)
								
								//<>Lon_timerEvent:=2
								form_timerEvent(2)
								
							End if 
							
						Else 
							
							If (Size of array:C274($tLon_IDs)=1)
								
								ALERT:C41(Replace string:C233(Get localized string:C991("xliff_STR#ID{id}ResourceNotFound."); "{id}"; String:C10($Lon_ID)))
								
							End if 
						End if 
					End for 
					
				Else 
					
					ALERT:C41(Get localized string:C991("xliff_AnErrorOccurredTheResourcesFileCannotBeOpened."))
					$Gmt_ResSourceFile:=?00:00:00?
					
				End if 
				
				If ($Gmt_ResTargetFile#?00:00:00?)
					
					CLOSE RESOURCE FILE:C498($Gmt_ResTargetFile)
					
				End if 
				
				If ($Gmt_ResSourceFile#?00:00:00?)
					
					CLOSE RESOURCE FILE:C498($Gmt_ResSourceFile)
					
				End if 
			End if 
			
		Else 
			
			ALERT:C41(Replace string:C233(Get localized string:C991("xliff_TheLocalized.rsrcFileShouldBeInThe{Folder}.lproj folder."); "{folder}"; xliff_Txt_Language("FolderFromCode.Folder.Name"; ""; <>Txt_sourceLang)))
			
		End if 
		
		//______________________________________________________
	: ($Txt_entryPoint="note@")
		
		FORM GET PROPERTIES:C674("XLIFF_Note"; $Lon_Width; $Lon_Height)
		
		GET LIST PROPERTIES:C632(<>Lst_strings; $Lon_Unused; $Lon_Unused; $Lon_Size)
		OBJECT GET COORDINATES:C663(<>Lst_strings; $Lon_Left; $Lon_Top; $Lon_Unused; $Lon_Unused)
		
		GET WINDOW RECT:C443($Lon_wLeft; $Lon_wTop; $Lon_Unused; $Lon_Unused)
		GET MOUSE:C468($Lon_Unused; $Lon_Y; $Lon_Unused)
		$Lon_Left:=$Lon_wLeft+$Lon_Left+30
		$Lon_Top:=$Lon_wTop+$Lon_Top+(((($Lon_Y-$Lon_Top)\$Lon_Size)+1)*$Lon_Size)
		Open window:C153($Lon_Left; $Lon_Top; $Lon_Left+$Lon_Width; $Lon_Top+$Lon_Height; Pop up window:K34:14)
		
		GET LIST ITEM:C378(<>Lst_strings; *; $Lon_ref; $Txt_buffer)
		GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_ref; "_note"; <>Txt_Note)
		$Txt_buffer:=<>Txt_Note
		DIALOG:C40("XLIFF_Note")
		
		If (<>Txt_Note#$Txt_buffer)
			
			SET LIST ITEM PARAMETER:C986(<>Lst_strings; $Lon_ref; "_note"; <>Txt_Note)
			EDITOR_MODIFIED
			
			If (Length:C16(<>Txt_Note)>0)
				
				$Pic_buffer:=util_getResourceImage("Images/note.png")
				
			End if 
			
			SET LIST ITEM ICON:C950(<>Lst_strings; $Lon_ref; $Pic_buffer)
			
		End if 
		
		CLOSE WINDOW:C154
		
		//______________________________________________________
	: ($Txt_entryPoint="search")
		
		//<>Boo_Search:=Non(<>Boo_Search)
		//Si (<>Boo_Search)
		//OBJET FIXER VISIBLE(<>Lon_Onglet;Faux)
		//OBJET FIXER VISIBLE(*;"SearchBar.@";Vrai)
		//ALLER A OBJET(<>tTxt_Search)
		//Sinon
		//OBJET FIXER VISIBLE(<>Lon_Onglet;Vrai)
		//OBJET FIXER VISIBLE(*;"SearchBar.@";Faux)
		//Fin de si
		
		//______________________________________________________
	: ($Txt_entryPoint="default_xliff_attributes")
		
		If (Find in array:C230($2->; "version")<0)
			
			DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "default.version"; $Txt_buffer)
			APPEND TO ARRAY:C911($2->; "version")
			APPEND TO ARRAY:C911($3->; $Txt_buffer)
			
		End if 
		
		//______________________________________________________
	: ($Txt_entryPoint="default_file_attributes")
		
		If (Find in array:C230($2->; "source-language")<0)
			
			APPEND TO ARRAY:C911($2->; "source-language")
			APPEND TO ARRAY:C911($3->; <>Txt_sourceLang)
			
		End if 
		
		If (Find in array:C230($2->; "target-language")<0)
			
			APPEND TO ARRAY:C911($2->; "target-language")
			APPEND TO ARRAY:C911($3->; <>Txt_targetLang)
			
		End if 
		
		If (Find in array:C230($2->; "datatype")<0)
			
			APPEND TO ARRAY:C911($2->; "datatype")
			APPEND TO ARRAY:C911($3->; "x-STR#")
			
		End if 
		
		If (Find in array:C230($2->; "original")<0)
			
			APPEND TO ARRAY:C911($2->; "original")
			APPEND TO ARRAY:C911($3->; "undefined")
			
		End if 
		
		//______________________________________________________
	: ($Txt_entryPoint="doc_url")
		
		OPEN URL:C673("http://www.oasis-open.org/committees/xliff/documents/xliff-20020415.htm")
		
		//______________________________________________________
	: (Length:C16($Txt_entryPoint)=0)
		
		//Appel sur erreur
		
		//-----------------------------------------------------
	Else 
		
		TRACE:C157
		
		//-----------------------------------------------------
End case 

$0:=$Boo_OK

// ----------------------------------------------------
// End