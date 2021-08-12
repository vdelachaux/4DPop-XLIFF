//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : PREFERENCES
// Created 27/10/06 by vdl
// ----------------------------------------------------
// Modified by Vincent de Lachaux (21/03/12)
// v13 refactoring
// ----------------------------------------------------
// Description
// get/set preferences
// ----------------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301(${2})

C_BOOLEAN:C305($Boo_write)
C_LONGINT:C283($Lon_buffer)
C_TEXT:C284($Dom_element; $Dom_root; $Txt_buffer; $Txt_entryPoint; $Txt_errorMethod; $Txt_path; $Txt_Source_Language; $Txt_Target_Language)
C_TEXT:C284($Txt_XPATH)

If (False:C215)
	C_TEXT:C284(PREFERENCES; $1)
	C_POINTER:C301(PREFERENCES; ${2})
End if 

$Txt_entryPoint:=$1

If ($Txt_entryPoint="@database.@")
	
	//database preferences
	$Txt_entryPoint:=Replace string:C233($Txt_entryPoint; "database."; "")
	$Txt_path:=env_Txt_HostFolder("Preferences")
	
Else 
	
	//general preferences
	$Txt_path:=Get 4D folder:C485
	
End if 

$Txt_path:=$Txt_path+"4DPop XLIFF.xml"

$Txt_errorMethod:=Method called on error:C704
ON ERR CALL:C155("NO_ERROR")  // =============================== [[

If (Test path name:C476($Txt_path)#Is a document:K24:1)
	
	$Dom_root:=DOM Create XML Ref:C861("body")
	DOM SET XML DECLARATION:C859($Dom_root; "UTF-8"; False:C215; True:C214)
	
Else 
	
	$Dom_root:=DOM Parse XML source:C719($Txt_path)
	
End if 

If (Asserted:C1132(OK=1))
	
	$Boo_write:=($Txt_entryPoint="@.set")
	
	If ($Boo_write)
		
		$Txt_entryPoint:=Replace string:C233($Txt_entryPoint; ".set"; "")
		
	End if 
	
	$Txt_XPATH:="body/editor/"+$Txt_entryPoint
	$Dom_element:=DOM Find XML element:C864($Dom_root; $Txt_XPATH)
	
	Case of 
			
			//______________________________________________________
		: ($Txt_entryPoint="resname-auto-fill")
			
			If ($Boo_write)
				
				If (OK=0)
					
					$Dom_element:=DOM Create XML element:C865($Dom_root; $Txt_XPATH; \
						"escaped"; $2->; \
						"maxsize"; $3->)
					
				Else 
					
					DOM SET XML ATTRIBUTE:C866($Dom_element; \
						"escaped"; $2->; \
						"maxsize"; $3->)
					
				End if 
				
			Else 
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "escaped"; $Txt_buffer)
				$2->:=Choose:C955((OK=0) | (Length:C16($Txt_buffer)=0); \
					"' '‘’\"</>…(%).:;,\\+-*=\\r\\n\\t"; \
					$Txt_buffer)
				
				If (Count parameters:C259>=3)
					
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "maxsize"; $Lon_buffer)
					$3->:=Choose:C955((OK=0); \
						0; \
						$Lon_buffer)
					
				End if 
			End if 
			
			//______________________________________________________
		: ($Txt_entryPoint="default-values")
			
			If ($Boo_write)
				
				If (OK=0)
					
					$Dom_element:=DOM Create XML element:C865($Dom_root; $Txt_XPATH; \
						"comment"; $2->)
					
				Else 
					
					DOM SET XML ATTRIBUTE:C866($Dom_element; \
						"comment"; $2->)
					
				End if 
				
			Else 
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "comment"; $Txt_buffer)
				$2->:=Choose:C955((OK=0) | (Length:C16($Txt_buffer)=0); \
					Get localized string:C991("XliffComment"); \
					$Txt_buffer)
				
				If (Count parameters:C259>=3)
					
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "datatype"; $Txt_buffer)
					$3->:=Choose:C955((OK=0) | (Length:C16($Txt_buffer)=0); \
						"x-STR#"; \
						$Txt_buffer)
					
					If (Count parameters:C259>=4)
						
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "original"; $Txt_buffer)
						$4->:=Choose:C955((OK=0) | (Length:C16($Txt_buffer)=0); \
							"undefined"; \
							$Txt_buffer)
						
					End if 
				End if 
			End if 
			
			//______________________________________________________
		: ($Txt_entryPoint="dropInForm")
			
			If ($Boo_write)
				
				If (OK=0)
					
					$Dom_element:=DOM Create XML element:C865($Dom_root; $Txt_XPATH; \
						"dropInForm"; $2->)
					
				Else 
					
					DOM SET XML ATTRIBUTE:C866($Dom_element; \
						"dropInForm"; $2->)
					
				End if 
				
			Else 
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "dropInForm"; $Lon_buffer)
				$2->:=Choose:C955((OK=0); \
					0; \
					$Lon_buffer)
				
			End if 
			
			//______________________________________________________
		: ($Txt_entryPoint="look")
			
			If ($Boo_write)
				
				If (OK=0)
					
					$Dom_element:=DOM Create XML element:C865($Dom_root; $Txt_XPATH; \
						"metal"; $2->)
					
				Else 
					
					DOM SET XML ATTRIBUTE:C866($Dom_element; \
						"metal"; $2->)
					
				End if 
				
			Else 
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "metal"; $Lon_buffer)
				$2->:=Choose:C955((OK=0); \
					0; \
					$Lon_buffer)
				
			End if 
			
			//______________________________________________________
		: ($Txt_entryPoint="xliff")
			
			If ($Boo_write)
				
				If (OK=0)
					
					$Dom_element:=DOM Create XML element:C865($Dom_root; $Txt_XPATH; \
						"version"; $2->; \
						"encoding"; $3->)
					
				Else 
					
					DOM SET XML ATTRIBUTE:C866($Dom_element; \
						"version"; $2->; \
						"encoding"; $3->)
					
				End if 
				
			Else 
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "version"; $Txt_buffer)
				$2->:=Choose:C955((OK=0) | (Length:C16($Txt_buffer)=0); \
					"1.0"; \
					$Txt_buffer)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "encoding"; $Txt_buffer)
				$3->:=Choose:C955((OK=0) | (Length:C16($Txt_buffer)=0); \
					"UTF-8"; \
					$Txt_buffer)
				
			End if 
			
			//______________________________________________________
		: ($Txt_entryPoint="language")
			
			If ($Boo_write)
				
				If (OK=0)
					
					$Dom_element:=DOM Create XML element:C865($Dom_root; $Txt_XPATH; \
						"source-language"; $2->; \
						"target-language"; $3->)
					
				Else 
					
					DOM SET XML ATTRIBUTE:C866($Dom_element; \
						"source-language"; $2->; \
						"target-language"; $3->)
					
				End if 
				
			Else 
				
				If (OK=1)
					
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "source-language"; $Txt_Source_Language)
					
					If (OK=1)
						
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "target-language"; $Txt_Target_Language)
						
					End if 
				End if 
				
				If (OK=1)
					
					$2->:=$Txt_Source_Language
					$3->:=$Txt_Target_Language
					
				Else 
					
					XLIFF_DEFAULT_LANGUAGES($2; $3)
					
				End if 
			End if 
			
			//______________________________________________________
		: ($Txt_entryPoint="window@")
			
			If ($Boo_write)
				
				If (OK=0)
					
					$Dom_element:=DOM Create XML element:C865($Dom_root; $Txt_XPATH; \
						"left"; $2->; \
						"top"; $3->; \
						"right"; $4->; \
						"bottom"; $5->)
					
				Else 
					
					DOM SET XML ATTRIBUTE:C866($Dom_element; \
						"left"; $2->; \
						"top"; $3->; \
						"right"; $4->; \
						"bottom"; $5->)
					
				End if 
				
			Else 
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "left"; $Lon_buffer)
				$2->:=Choose:C955((OK=0); \
					-1; \
					$Lon_buffer)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "top"; $Lon_buffer)
				$3->:=Choose:C955((OK=0); \
					-1; \
					$Lon_buffer)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "right"; $Lon_buffer)
				$4->:=Choose:C955((OK=0); \
					-1; \
					$Lon_buffer)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "bottom"; $Lon_buffer)
				$5->:=Choose:C955((OK=0); \
					-1; \
					$Lon_buffer)
				
			End if 
			
			//______________________________________________________
		: ($Txt_entryPoint="splitter@")
			
			If ($Boo_write)
				
				If (OK=0)
					
					$Dom_element:=DOM Create XML element:C865($Dom_root; $Txt_XPATH; \
						"value"; $2->)
					
				Else 
					
					DOM SET XML ATTRIBUTE:C866($Dom_element; \
						"value"; $2->)
					
				End if 
				
			Else 
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "value"; $Lon_buffer)
				$2->:=Choose:C955((OK=0); \
					1; \
					$Lon_buffer)
				
			End if 
			
			//______________________________________________________
		: ($Txt_entryPoint="tool")
			
			If ($Boo_write)
				
				If (OK=0)
					
					$Dom_element:=DOM Create XML element:C865($Dom_root; $Txt_XPATH; \
						"id"; $2->)
					
				Else 
					
					DOM SET XML ATTRIBUTE:C866($Dom_element; \
						"id"; $2->)
					
				End if 
				
			Else 
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "id"; $Lon_buffer)
				$2->:=Choose:C955((OK=0); \
					1; \
					$Lon_buffer)
				
			End if 
			
			//______________________________________________________
		: ($Txt_entryPoint="file")
			
			If ($Boo_write)
				
				If (OK=0)
					
					$Dom_element:=DOM Create XML element:C865($Dom_root; $Txt_XPATH; \
						"name"; $2->)
				Else 
					
					DOM SET XML ATTRIBUTE:C866($Dom_element; \
						"name"; $2->)
					
				End if 
				
			Else 
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "name"; $Txt_buffer)
				$2->:=Choose:C955((OK=0); \
					""; \
					$Txt_buffer)
				
			End if 
			
			//______________________________________________________
		: ($Txt_entryPoint="_target")
			
			If ($Boo_write)
				
				If (OK=0)
					
					$Dom_element:=DOM Create XML element:C865($Dom_root; $Txt_XPATH; \
						"path"; $2->)
					
				Else 
					
					DOM SET XML ATTRIBUTE:C866($Dom_element; \
						"path"; $2->)
					
				End if 
				
			Else 
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "path"; $2->)
				
				If (OK=0)
					
					If (Structure file:C489(*)#Structure file:C489)
						
						//~/Host Database/Ressources/
						$2->:=doc_gTxt_Path("append.folder"; doc_gTxt_Path("structure.folder"); "Resources")
						$2->:=doc_gTxt_Path("create.hierarchy"; $2->)
						
					Else 
						
						$2->:=""  //"structure"
						
					End if 
				End if 
			End if 
			
			//______________________________________________________
		Else 
			
			ASSERT:C1129(False:C215; "Unknown entry point: \""+$Txt_entryPoint+"\"")
			
			//______________________________________________________
	End case 
	
	If ($Boo_write)
		
		DOM EXPORT TO FILE:C862($Dom_root; $Txt_path)
		
	End if 
	
	DOM CLOSE XML:C722($Dom_root)
	
End if 

ON ERR CALL:C155($Txt_errorMethod)  //  ============================ ]]