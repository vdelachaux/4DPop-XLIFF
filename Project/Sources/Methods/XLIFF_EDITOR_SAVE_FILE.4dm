//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : XLIFF_EDITOR_SAVE_FILE
// Created 16/10/06 by vdl
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_BLOB:C604($Blb_1; $Blb_2; $Blb_buffer)
C_BOOLEAN:C305($Boo_CDATA; $Boo_expanded; $Boo_groupOpened; $Boo_standalone; $Boo_translate)
C_LONGINT:C283($Lon_count; $Lon_currentFile; $Lon_i; $Lon_index; $Lon_j; $Lon_list; $Lon_offset; $Lon_parameters)
C_LONGINT:C283($Lon_privateElementNumber; $Lon_reference; $Lon_state; $Lon_Sublist; $Lon_x)
C_TIME:C306($Gmt_target)
C_TEXT:C284($Txt_buffer; $Txt_errorHandlerMethod; $Txt_fileName; $Txt_note; $Txt_path; $Txt_path_1; $Txt_path_2; $Txt_separator)
C_TEXT:C284($Txt_source; $Txt_sourceLanguage; $Txt_structureFolderPath; $Txt_target; $Txt_targetLanguage; $Txt_Type; $Txt_value; $Txt_version)
C_TEXT:C284($Txt_xmlTest)

ARRAY TEXT:C222($tTxt_fileAttributeValues; 0)

If (False:C215)
	C_LONGINT:C283(XLIFF_EDITOR_SAVE_FILE; $1)
	C_TEXT:C284(XLIFF_EDITOR_SAVE_FILE; $2)
	C_TEXT:C284(XLIFF_EDITOR_SAVE_FILE; $3)
	C_TEXT:C284(XLIFF_EDITOR_SAVE_FILE; $4)
End if 

$Lon_parameters:=Count parameters:C259

If ($Lon_parameters>=1)
	
	$Lon_currentFile:=$1
	
Else 
	
	$Lon_currentFile:=Selected list items:C379(<>Lst_files; *)
	
End if 

If ($Lon_parameters>=4)
	
	$Txt_sourceLanguage:=$2
	$Txt_targetLanguage:=$3
	$Txt_fileName:=$4
	
	DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "target_folder"; $Txt_buffer)
	$Txt_path:=xliff_Txt_Language("Folder.Path.Validated"; $Txt_buffer; Substring:C12($Txt_targetLanguage; 1; 2))
	$Txt_path:=doc_gTxt_Path("create.hierarchy"; $Txt_path)
	$Txt_path:=$Txt_path+$Txt_fileName
	
	If (Test path name:C476($Txt_path)=Is a document:K24:1)
		
		MOVE DOCUMENT:C540($Txt_path; Temporary folder:C486+String:C10(Random:C100*Milliseconds:C459))
		
	End if 
	
	$Gmt_target:=Create document:C266($Txt_path)
	
	If (OK=1)
		
		XML SET OPTIONS:C1090($Gmt_target; XML String encoding:K45:21; XML raw data:K45:23)
		
		If (True:C214)  //XML
			
			GET LIST ITEM PARAMETER:C985(<>Lst_files; $Lon_currentFile; "file.encoding"; $Txt_buffer)
			
			If (Length:C16($Txt_buffer)=0)
				
				DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "default.encoding"; $Txt_buffer)
				
			End if 
			
			GET LIST ITEM PARAMETER:C985(<>Lst_files; $Lon_currentFile; "xml.standalone"; $Boo_standalone)
			SAX SET XML DECLARATION:C858($Gmt_target; $Txt_buffer; $Boo_standalone; True:C214)
			SEND PACKET:C103($Gmt_target; "\r")
			
			GET LIST ITEM PARAMETER:C985(<>Lst_files; $Lon_currentFile; "file.comment"; $Txt_buffer)
			
			If (Length:C16($Txt_buffer)=0)
				
				DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "default_comment"; $Txt_buffer)
				
			End if 
			
			//………………………………………………………………………………………………………………………
			$Txt_buffer:=Replace string:C233($Txt_buffer; "{year}"; String:C10(Year of:C25(Current date:C33)))
			$Txt_buffer:=Replace string:C233($Txt_buffer; "{month}"; String:C10(Month of:C24(Current date:C33); "00"))
			$Txt_buffer:=Replace string:C233($Txt_buffer; "{date}"; String:C10(Current date:C33; ISO date:K1:8))
			$Txt_buffer:=Replace string:C233($Txt_buffer; "{database}"; doc_gTxt_Path("structure.file"))
			
			//………………………………………………………………………………………………………………………
			SAX ADD XML COMMENT:C852($Gmt_target; $Txt_buffer)
			SEND PACKET:C103($Gmt_target; "\r")
			
			//DOCTYPE is no more recommended
			//GET LIST ITEM PARAMETER(<>Lst_files;$Lon_currentFile;"Nom DOCTYPE";$Txt_buffer)
			
			//If (Length($Txt_buffer)>0)
			
			//$Txt_buffer:=$Txt_buffer+" PUBLIC \""
			//GET LIST ITEM PARAMETER(<>Lst_files;$Lon_currentFile;"ID PUBLIC";$Txt_source)
			//$Txt_buffer:=$Txt_buffer+$Txt_source+"\" \""
			//GET LIST ITEM PARAMETER(<>Lst_files;$Lon_currentFile;"ID SYSTEM";$Txt_source)
			//$Txt_buffer:=$Txt_buffer+$Txt_source+"\""
			
			//Else 
			// 
			//  $Txt_buffer:=Get localized string("DOCTYPE")
			
			//End if 
			
			//SAX ADD XML DOCTYPE($Gmt_target;$Txt_buffer)
			//SEND PACKET($Gmt_target;"\r")
			
		End if 
		
		If (True:C214)  //<xliff>
			
			SAX OPEN XML ELEMENT ARRAYS:C921($Gmt_target; "xliff"; \
				<>tTxt_xliff_attributeNames; <>tTxt_xliff_attributeValues)
			
			COPY ARRAY:C226(<>tTxt_file_attributeValues; $tTxt_fileAttributeValues)
			$Lon_x:=Find in array:C230(<>tTxt_file_attributeNames; "target-language")
			
			If ($Lon_x>0)
				
				$tTxt_fileAttributeValues{$Lon_x}:=$Txt_targetLanguage
				
			End if 
			
			If (True:C214)  //<file>
				
				SAX OPEN XML ELEMENT ARRAYS:C921($Gmt_target; "file"; \
					<>tTxt_file_attributeNames; $tTxt_fileAttributeValues)
				
				If (True:C214)  //HEADER
					
					SAX OPEN XML ELEMENT:C853($Gmt_target; "header")  //<header>
					
					GET LIST ITEM PARAMETER:C985(<>Lst_files; $Lon_currentFile; "file.version"; $Txt_version)
					
					If (Length:C16($Txt_version)=0)
						
						DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "default.version"; $Txt_version)
						
					End if 
					
					If ($Txt_version="1.0")  //header required
						
						$Lon_x:=Find in array:C230(<>tTxt_prop_groupNames; "version")
						
						If ($Lon_x<0)
							
							APPEND TO ARRAY:C911(<>tTxt_prop_groupNames; "version")
							APPEND TO ARRAY:C911(<>tTxt_prop_groupValues; $Txt_version)
							
						Else 
							
							<>tTxt_prop_groupValues{$Lon_x}:=$Txt_version
							
						End if 
						
						If (Size of array:C274(<>tTxt_prop_groupNames)>0)
							
							SAX OPEN XML ELEMENT:C853($Gmt_target; "prop-group"; "name"; "Xliff-Editor.4dbase")  //<prop-group>
							
							For ($Lon_i; 1; Size of array:C274(<>tTxt_prop_groupNames); 1)
								
								SAX OPEN XML ELEMENT:C853($Gmt_target; "prop"; "prop-type"; <>tTxt_prop_groupNames{$Lon_i})  //<prop>
								SAX ADD XML ELEMENT VALUE:C855($Gmt_target; <>tTxt_prop_groupValues{$Lon_i})
								SAX CLOSE XML ELEMENT:C854($Gmt_target)  //</prop>
								
							End for 
							
							SAX CLOSE XML ELEMENT:C854($Gmt_target)  //</prop-group>
							
						End if 
					End if 
					
					For ($Lon_i; 1; Size of array:C274(<>tTxt_file_Notes); 1)
						
						SAX OPEN XML ELEMENT:C853($Gmt_target; "note")  //<note>
						SAX ADD XML ELEMENT VALUE:C855($Gmt_target; xliff_Txt_Format(<>tTxt_file_Notes{$Lon_i}; ""; True:C214))
						SAX CLOSE XML ELEMENT:C854($Gmt_target)  //</note>
						
					End for 
					
					// Added by Vincent de Lachaux (31/10/08)
					// Restore the others items for <header> {
					For ($Lon_j; 1; Size of array:C274(<>tTxt_filePrivateHeaderElements); 1)
						
						$Txt_value:=<>tTxt_filePrivateHeaderElements{$Lon_j}
						$Txt_xmlTest:=DOM Parse XML variable:C720($Txt_value)
						
						If (OK=1)
							
							DOM CLOSE XML:C722($Txt_xmlTest)
							$Txt_value:=Replace string:C233($Txt_value; "\r\n"; "\r")
							$Txt_value:=Replace string:C233($Txt_value; "\n"; "\r")
							$Txt_value:=Replace string:C233($Txt_value; "\t"; "    ")
							SEND PACKET:C103($Gmt_target; ("    "*2)+$Txt_value+"\r")
							
						End if 
					End for 
					//}
					
					SAX CLOSE XML ELEMENT:C854($Gmt_target)  //</header>
					
				End if 
				
				If (True:C214)  //BODY
					
					SAX OPEN XML ELEMENT:C853($Gmt_target; "body")  //<body>
					
					$Lon_list:=Copy list:C626(<>Lst_strings)
					
					For ($Lon_i; 1; Count list items:C380($Lon_list; *); 1)
						
						ARRAY TEXT:C222($tTxt_attributeNames; 0x0000)
						ARRAY TEXT:C222($tTxt_attributeValues; 0x0000)
						
						GET LIST ITEM:C378($Lon_list; $Lon_i; $Lon_reference; $Txt_buffer; $Lon_Sublist; $Boo_expanded)  //Group
						
						If ($Lon_Sublist#0)\
							 & (Not:C34($Boo_expanded))
							
							SET LIST ITEM:C385($Lon_list; $Lon_reference; $Txt_buffer; $Lon_reference; $Lon_Sublist; True:C214)
							
						End if 
						
						$Boo_translate:=True:C214
						$Lon_index:=0
						
						GET LIST ITEM PARAMETER:C985($Lon_list; $Lon_reference; "_type"; $Txt_Type)
						
						//keep only master tags {
						GET LIST ITEM PARAMETER ARRAYS:C1195($Lon_list; $Lon_reference; $tTxt_attributeNames; $tTxt_attributeValues)
						$Lon_count:=Size of array:C274($tTxt_attributeNames)
						
						For ($Lon_j; 1; $Lon_count; 1)
							
							Case of 
									
									//______________________________________________________
									//Turn Around ACI0076093
									//________________________________________
								: ($tTxt_attributeNames{$Lon_j}="DistantChildrenID")
									
									//________________________________________
								: ($tTxt_attributeNames{$Lon_j}=Additional text:K28:7)
									
									//______________________________________________________
								: ($tTxt_attributeNames{$Lon_j}="private.@")  //private tags
									
									//______________________________________________________
								: ($tTxt_attributeNames{$Lon_j}="_@")  //private tags
									
									//________________________________________
								: (Position:C15("_"; $tTxt_attributeNames{$Lon_j})=1)  //internal tags
									
									//________________________________________
								: ($tTxt_attributeNames{$Lon_j}="d4:includeIf")\
									 & (Length:C16($tTxt_attributeValues{$Lon_j})=0)
									
									//______________________________________________________
								Else 
									
									$Lon_index:=$Lon_index+1
									$tTxt_attributeNames{$Lon_index}:=$tTxt_attributeNames{$Lon_j}
									$tTxt_attributeValues{$Lon_index}:=$tTxt_attributeValues{$Lon_j}
									
									Case of 
											
											//___________________
										: ($tTxt_attributeNames{$Lon_j}="translate")
											
											$Boo_translate:=($tTxt_attributeValues{$Lon_j}="yes")
											
											//___________________
										: ($tTxt_attributeNames{$Lon_j}="d4:includeIf")
											
											
											
											
											//___________________
									End case 
									
									//______________________________________________________
							End case 
						End for 
						
						$Lon_offset:=$Lon_count-$tTxt_attributeNames
						DELETE FROM ARRAY:C228($tTxt_attributeNames; $Lon_index+1; $Lon_offset)
						DELETE FROM ARRAY:C228($tTxt_attributeValues; $Lon_index+1; $Lon_offset)
						//}
						
						If (List item parent:C633($Lon_list; $Lon_reference)=0)  //It's a group
							
							If ($Boo_groupOpened)  //last opened group
								
								SAX CLOSE XML ELEMENT:C854($Gmt_target)  //</group>
								
							End if 
							
							SAX OPEN XML ELEMENT ARRAYS:C921($Gmt_target; "group"; $tTxt_attributeNames; $tTxt_attributeValues)  //<group>
							$Boo_groupOpened:=True:C214
							
						Else 
							
							If (True:C214)  //<trans-unit>
								
								SAX OPEN XML ELEMENT ARRAYS:C921($Gmt_target; "trans-unit"; \
									$tTxt_attributeNames; $tTxt_attributeValues)
								
								SAX OPEN XML ELEMENT:C853($Gmt_target; "source")  //<source>
								GET LIST ITEM PARAMETER:C985($Lon_list; $Lon_reference; "_source"; $Txt_source)
								
								//auto detect a content XML (like styled text)
								$Boo_CDATA:=Match regex:C1019("(?imsx)[^<]*<([^\\s]*)[^>]*>.*</\\1>.*"; $Txt_source)
								
								If ($Boo_CDATA)
									
									$Txt_source:=Replace string:C233($Txt_source; Char:C90(Carriage return:K15:38); "<br/>")
									SAX ADD XML CDATA:C856($Gmt_target; $Txt_source)
									
								Else 
									
									$Txt_source:=xliff_Txt_Format($Txt_source; ""; True:C214)
									SAX ADD XML ELEMENT VALUE:C855($Gmt_target; $Txt_source)
									
								End if 
								
								SAX CLOSE XML ELEMENT:C854($Gmt_target)  //</source>
								
								If ($Boo_translate)
									
									SAX OPEN XML ELEMENT:C853($Gmt_target; "target")  //<target>
									
									If ($Txt_sourceLanguage=$Txt_targetLanguage)
										
										If ($Boo_CDATA)  // #30-5-2013
											
											SAX ADD XML CDATA:C856($Gmt_target; $Txt_source)
											
										Else 
											
											SAX ADD XML ELEMENT VALUE:C855($Gmt_target; $Txt_source)
											
										End if 
										
									Else 
										
										GET LIST ITEM PARAMETER:C985($Lon_list; $Lon_reference; "_target"; $Txt_target)
										
										If ($Boo_CDATA)  // #30-5-2013
											
											$Txt_target:=Replace string:C233($Txt_target; Char:C90(Carriage return:K15:38); "<br/>")
											SAX ADD XML CDATA:C856($Gmt_target; $Txt_target)
											
										Else 
											
											$Txt_target:=xliff_Txt_Format($Txt_target; ""; True:C214)
											SAX ADD XML ELEMENT VALUE:C855($Gmt_target; $Txt_target)
											
										End if 
									End if 
									
									SAX CLOSE XML ELEMENT:C854($Gmt_target)  //</target>
									
								End if 
								
								// Added by Vincent de Lachaux (31/10/08)
								// Restoration of non-standard informations  arbitrarily at the end of the <trans-unit> {
								$Lon_privateElementNumber:=0
								GET LIST ITEM PARAMETER:C985($Lon_list; $Lon_reference; "private.number"; $Lon_privateElementNumber)
								
								For ($Lon_j; 1; $Lon_privateElementNumber; 1)
									
									GET LIST ITEM PARAMETER:C985($Lon_list; $Lon_reference; "private."+String:C10($Lon_privateElementNumber); $Txt_value)
									$Txt_xmlTest:=DOM Parse XML variable:C720($Txt_value)
									
									If (OK=1)
										
										DOM CLOSE XML:C722($Txt_xmlTest)
										$Txt_value:=Replace string:C233($Txt_value; "\r\n"; "\r")
										$Txt_value:=Replace string:C233($Txt_value; "\n"; "\r")
										$Txt_value:=Replace string:C233($Txt_value; "\t"; "    ")
										SEND PACKET:C103($Gmt_target; ("    "*4)+$Txt_value+"\r")
										
									End if 
								End for 
								//}
								
								GET LIST ITEM PARAMETER:C985($Lon_list; $Lon_reference; "_note"; $Txt_note)
								
								If (Length:C16($Txt_note)>0)
									
									SAX OPEN XML ELEMENT:C853($Gmt_target; "note")  //<note>
									SAX ADD XML ELEMENT VALUE:C855($Gmt_target; $Txt_note)
									SAX CLOSE XML ELEMENT:C854($Gmt_target)  //</note>
									
								End if 
								
								SAX CLOSE XML ELEMENT:C854($Gmt_target)  //</trans-unit>
								
							End if 
						End if 
					End for 
					
					CLEAR LIST:C377($Lon_list)
					
					If ($Boo_groupOpened)  //last opened group
						
						SAX CLOSE XML ELEMENT:C854($Gmt_target)  //</group>
						
					End if 
					
					SAX CLOSE XML ELEMENT:C854($Gmt_target)  //</body>
					
				End if 
				
				SAX CLOSE XML ELEMENT:C854($Gmt_target)  //</file>
				
			End if 
			
			SAX CLOSE XML ELEMENT:C854($Gmt_target)  //</xliff>
			
		End if 
		
		CLOSE DOCUMENT:C267($Gmt_target)
		
	End if 
	
Else 
	
	GET LIST ITEM:C378(<>Lst_files; List item position:C629(<>Lst_files; $Lon_currentFile); $Lon_currentFile; $Txt_fileName)
	$Txt_fileName:=$Txt_fileName+".xlf"
	
	XLIFF_EDITOR_SAVE_FILE($Lon_currentFile; <>Txt_sourceLang; <>Txt_targetLang; $Txt_fileName)  //EN - FR
	$Txt_path_1:=DOCUMENT
	
	If (<>Txt_targetLang#<>Txt_sourceLang)
		
		$Txt_fileName:=Replace string:C233($Txt_fileName; \
			Uppercase:C13(Substring:C12(<>Txt_targetLang; 1; 2))+".xlf"; \
			Uppercase:C13(Substring:C12(<>Txt_sourceLang; 1; 2))+".xlf")
		XLIFF_EDITOR_SAVE_FILE($Lon_currentFile; <>Txt_sourceLang; <>Txt_sourceLang; $Txt_fileName)  //EN - EN
		$Txt_path_2:=DOCUMENT
		
	End if 
	
	// Modified by vdl (28/05/08)
	// In C/S mode: Update the server {
	If (Application type:C494=4D Remote mode:K5:5)
		
		//For test purpose, a component can give the path of the target folder
		//In this case we don't want to update the server {
		$Txt_errorHandlerMethod:=Method called on error:C704
		ON ERR CALL:C155("NO_ERROR")
		EXECUTE METHOD:C1007("Resources_Target_Path"; $Txt_buffer)
		ON ERR CALL:C155($Txt_errorHandlerMethod)
		//}
		
		If (Length:C16($Txt_buffer)=0)
			
			//We don't want to be synchronized :
			// Get the actual configuration of the resources' folder update...
			$Lon_state:=Get database parameter:C643(48)
			
			//… and set the configuration to None (0).
			SET DATABASE PARAMETER:C642(48; 0)
			
			//Get the cache structure folder path
			$Txt_structureFolderPath:=Get 4D folder:C485(4D Client database folder:K5:13; *)
			$Txt_separator:=$Txt_structureFolderPath[[Length:C16($Txt_structureFolderPath)]]
			
			//Put xliff file into a buffer blob
			DOCUMENT TO BLOB:C525($Txt_path_1; $Blb_buffer)
			
			If (OK=1)
				
				//Convert path to relative...
				$Txt_path_1:=Replace string:C233($Txt_path_1; $Txt_structureFolderPath; ""; 1)
				
				// ... & posix.
				$Txt_path_1:=Replace string:C233($Txt_path_1; $Txt_separator; "/")
				
				//Put path and document into a blob.
				VARIABLE TO BLOB:C532($Txt_path_1; $Blb_1)
				VARIABLE TO BLOB:C532($Blb_buffer; $Blb_1; *)
				SET BLOB SIZE:C606($Blb_buffer; 0)
				
				COMPRESS BLOB:C534($Blb_1)
				
				If (OK=1)
					
					If (Length:C16($Txt_path_2)>0)
						
						DOCUMENT TO BLOB:C525($Txt_path_2; $Blb_buffer)
						
						If (OK=1)
							
							//Convert path to relative & posix.
							$Txt_path_2:=Replace string:C233($Txt_path_2; $Txt_structureFolderPath; ""; 1)
							
							// Modified by Vincent de Lachaux (30/10/08)
							// Bug reported by Michaël DURANSON
							// http://forums.4d.fr/Post/FR/2221626/1/2221627#2221627 {
							// -> Change "$Txt_path_1" to "$Txt_path_2"
							//$Txt_path_1:=Remplacer chaine($Txt_path_2;$Txt_separator;"/")
							$Txt_path_2:=Replace string:C233($Txt_path_2; $Txt_separator; "/")
							//}
							
							//Put path and document into a blob.
							VARIABLE TO BLOB:C532($Txt_path_2; $Blb_2)
							VARIABLE TO BLOB:C532($Blb_buffer; $Blb_2; *)
							SET BLOB SIZE:C606($Blb_buffer; 0)
							
							COMPRESS BLOB:C534($Blb_2)
							
							If (OK=1)
								
								env_UPDATE_RESOURCES($Blb_1; $Blb_2)
								SET BLOB SIZE:C606($Blb_1; 0)
								SET BLOB SIZE:C606($Blb_2; 0)
								
							End if 
						End if 
						
					Else 
						
						env_UPDATE_RESOURCES($Blb_1)
						SET BLOB SIZE:C606($Blb_1; 0)
						
					End if 
				End if 
			End if 
			
			// Restore the previous configuration of the resources' folder update.
			SET DATABASE PARAMETER:C642(48; $Lon_state)
			
		End if 
	End if 
	//}
	
End if 