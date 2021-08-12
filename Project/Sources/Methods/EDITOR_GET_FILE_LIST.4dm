//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : XLIFF_EDITOR_GET_FILE_LIST
// ID[743A0047494C41B6B2EB1621F9FB9456]
// Created 22/03/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Load the XLIFF files
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($Boo_standalone)
C_LONGINT:C283($Lon_color; $Lon_i; $Lon_parameters; $Lon_saxEvent; $Lon_styles; $Lon_x)
C_TIME:C306($Gmt_docRef)
C_PICTURE:C286($Pic_buffer)
C_TEXT:C284($Dom_root; $Txt_buffer; $Txt_dtdFilePath; $Txt_dtdFolder; $Txt_encoding; $Txt_error; $Txt_errorMethod; $Txt_name)
C_TEXT:C284($Txt_prefix; $Txt_targetFolder; $Txt_targetPath; $Txt_version)

ARRAY TEXT:C222($tTxt_attributNames; 0)
ARRAY TEXT:C222($tTxt_attributValues; 0)
ARRAY TEXT:C222($tTxt_files; 0)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "target_folder"; $Txt_targetFolder)
DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "dtd_folder"; $Txt_dtdFolder)

If (Length:C16($Txt_targetFolder)=0)
	
	$Txt_targetPath:=Select folder:C670(Get localized string:C991("SelectTheTargetResourceFolder"))
	
	If (OK=1)
		
		$Txt_targetFolder:=$Txt_targetPath
		
		PREFERENCES("database.target.set"; ->$Txt_targetFolder)
		
	End if 
End if 

If (Length:C16($Txt_targetFolder)>0)
	
	$Txt_targetPath:=xliff_Txt_Language("Folder.Path.Validated"; $Txt_targetFolder; <>Txt_targetLang)
	
End if 

<>Lst_files:=New list:C375

If (Asserted:C1132(Test path name:C476($Txt_targetPath)=Is a folder:K24:2))
	
	//List the xliff files
	DOCUMENT LIST:C474($Txt_targetPath; $tTxt_files)
	
	$Txt_errorMethod:=Method called on error:C704
	ON ERR CALL:C155("NO_ERROR")
	//================================================================== NO ERROR [
	For ($Lon_i; 1; Size of array:C274($tTxt_files); 1)
		
		Case of 
				
				//……………………………………………………………………………
			: ($tTxt_files{$Lon_i}=".@")
				
				//……………………………………………………………………………
			: ($tTxt_files{$Lon_i}#"@.xlf")
				
				//……………………………………………………………………………
			Else 
				
				APPEND TO LIST:C376(<>Lst_files; Replace string:C233($tTxt_files{$Lon_i}; ".xlf"; ""); $Lon_i)
				SET LIST ITEM PARAMETER:C986(<>Lst_files; 0; "fullpath"; $Txt_targetPath+$tTxt_files{$Lon_i})
				
				$Lon_styles:=Plain:K14:1
				$Pic_buffer:=util_getResourceImage("Images/ListValid.tiff")
				$Lon_color:=Foreground color:K23:1
				$Txt_version:=""
				
				$Dom_root:=DOM Parse XML source:C719($Txt_targetPath+$tTxt_files{$Lon_i}; False:C215)
				
				If (OK=1)
					
					$Pic_buffer:=util_getResourceImage("Images/ListValid.tiff")
					$Lon_color:=Foreground color:K23:1
					SET LIST ITEM PARAMETER:C986(<>Lst_files; 0; "ID PUBLIC"; DOM Get XML information:C721($Dom_root; PUBLIC ID:K45:1))
					SET LIST ITEM PARAMETER:C986(<>Lst_files; 0; "ID SYSTEM"; DOM Get XML information:C721($Dom_root; SYSTEM ID:K45:2))
					//DOCTYPE is no more recommended
					//SET LIST ITEM PARAMETER(<>Lst_files;0;"Nom DOCTYPE";DOM Get XML information($Dom_root;DOCTYPE Name))
					SET LIST ITEM PARAMETER:C986(<>Lst_files; 0; "file.encoding"; DOM Get XML information:C721($Dom_root; Encoding:K45:4))
					
				Else 
					
					XML GET ERROR:C732($Dom_root; $Txt_error)
					SET LIST ITEM PARAMETER:C986(<>Lst_files; 0; "!error"; $Txt_error)
					$Pic_buffer:=util_getResourceImage("Images/ListAlert.tiff")
					
				End if 
				
				DOM CLOSE XML:C722($Dom_root)
				
				$Gmt_docRef:=Open document:C264($Txt_targetPath+$tTxt_files{$Lon_i}; Read mode:K24:5)
				
				If (OK=1)
					
					Repeat 
						
						$Lon_saxEvent:=SAX Get XML node:C860($Gmt_docRef)
						
						Case of 
								
								//.....................................................
							: ($Lon_saxEvent=XML start document:K45:7)
								
								SAX GET XML DOCUMENT VALUES:C873($Gmt_docRef; $Txt_encoding; $Txt_version; $Boo_standalone)
								
								If (OK=1)
									
									SET LIST ITEM PARAMETER:C986(<>Lst_files; 0; "xml.standalone"; $Boo_standalone)
									
								End if 
								
								//.....................................................
							: ($Lon_saxEvent=XML comment:K45:8)
								
								SAX GET XML COMMENT:C874($Gmt_docRef; $Txt_buffer)
								
								If (OK=1)
									
									$Txt_buffer:=Replace string:C233($Txt_buffer; "\r\n"; "\r")
									$Txt_buffer:=Replace string:C233($Txt_buffer; "\n"; "\r")
									SET LIST ITEM PARAMETER:C986(<>Lst_files; 0; "file.comment"; $Txt_buffer)
									
								Else 
									
									$Pic_buffer:=util_getResourceImage("Images/ListFatal.tiff")
									
								End if 
								
								//.....................................................
							: ($Lon_saxEvent=XML start element:K45:10)
								
								SAX GET XML ELEMENT:C876($Gmt_docRef; $Txt_name; $Txt_prefix; $tTxt_attributNames; $tTxt_attributValues)
								
								Case of 
										
										//……………………………
									: ($Txt_name="xliff")
										
										$Lon_x:=Find in array:C230($tTxt_attributNames; "version")
										
										If ($Lon_x>0)
											
											$Txt_version:=$tTxt_attributValues{$Lon_x}
											
										End if 
										
										//……………………………
									: ($Txt_name="file")
										
										//……………………………
									: ($Txt_name="header")
										
										//……………………………
									: ($Txt_name="body")
										
										$Lon_saxEvent:=XML end document:K45:15  //<--  Stop
										
										//……………………………
								End case 
								
								//.....................................................
							: (OK=0) | ($Lon_saxEvent=-1)
								
								BEEP:C151
								$Lon_saxEvent:=XML end document:K45:15  //<--  Stop
								
								//.....................................................
						End case 
						
					Until ($Lon_saxEvent=XML end document:K45:15)
					
					CLOSE DOCUMENT:C267($Gmt_docRef)
					
				Else 
					
					$Lon_styles:=Italic:K14:3
					$Pic_buffer:=util_getResourceImage("Images/ListFatal.tiff")
					$Lon_color:=0x00FF0000
					
				End if 
				
				If (OK=1)
					
					If (Length:C16($Txt_version)>0)
						
						$Txt_dtdFilePath:=$Txt_dtdFolder+"xliff_"+$Txt_version+".dtd"
						
						If (Test path name:C476($Txt_dtdFilePath)=Is a document:K24:1)
							
							//$Dom_root:=DOM Parse XML source($Txt_targetPath+$tTxt_files{$Lon_i};True;$Txt_dtdFilePath)
							$Dom_root:=DOM Parse XML source:C719($Txt_targetPath+$tTxt_files{$Lon_i})
							
							If (OK=0)
								
								$Lon_styles:=Italic:K14:3
								$Pic_buffer:=util_getResourceImage("Images/ListAlert.tiff")
								XML GET ERROR:C732($Dom_root; $Txt_error)
								SET LIST ITEM PARAMETER:C986(<>Lst_files; 0; "!error"; $Txt_error)
								
							End if 
							
						Else 
							
							$Lon_styles:=Italic:K14:3
							$Pic_buffer:=util_getResourceImage("Images/ListAlert.tiff")
							$Txt_error:="The "+$Txt_version+" DTD file is missing in the \"DTD\" folder."
							SET LIST ITEM PARAMETER:C986(<>Lst_files; 0; "!error"; $Txt_error)
							
						End if 
						
						SET LIST ITEM PARAMETER:C986(<>Lst_files; 0; "file.version"; $Txt_version)
						
					End if 
				End if 
				
				SET LIST ITEM PROPERTIES:C386(<>Lst_files; 0; False:C215; $Lon_styles; 0; $Lon_color)
				SET LIST ITEM ICON:C950(<>Lst_files; 0; $Pic_buffer)
				
				//……………………………………………………………………………
		End case 
	End for 
	
	//================================================================== NO ERROR ]
	ON ERR CALL:C155($Txt_errorMethod)
	
	SELECT LIST ITEMS BY POSITION:C381(<>Lst_files; <>Xliff_vLon_Current)
	
	//form_timerEvent (1)
	
End if 

// ----------------------------------------------------
// End