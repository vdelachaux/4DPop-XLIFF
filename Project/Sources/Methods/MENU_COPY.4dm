//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : MENU_COPY
// Created 27/10/06 by vdl
// ----------------------------------------------------
// Description
// Associated to Edit > Copy
// Copy an item to be paste in form editor (static text or properties list)
// Modified 09/02/07 by vdl
// Adding the private pastboard to copy/past from/to the editor
// ----------------------------------------------------
// Modified by Vincent de Lachaux (11/07/08)
// Add the ":ID,Index" drop asked by René Ricard
// http://forums.4d.fr/Post/FR/2030266/1/2048167#2048167
// ----------------------------------------------------
C_BLOB:C604($Blb_Buffer)
C_BOOLEAN:C305($Boo_compatibility; $Boo_Expanded)
C_LONGINT:C283($Lon_End; $Lon_Parent; $Lon_Reference; $Lon_Start; $Lon_Sublist; $Lon_Type)
C_POINTER:C301($Ptr_Object)
C_TEXT:C284($Txt_Buffer; $Txt_Element; $Txt_Value)

$Ptr_Object:=Focus object:C278

If (Is nil pointer:C315($Ptr_Object))
	
	$Ptr_Object:=-><>Lst_strings
	
End if 

Case of 
		
		//……………………………………………………………………………
	: ($Ptr_Object=(-><>Lst_strings))
		
		If (Selected list items:C379(<>Lst_strings)#0)
			
			GET LIST ITEM:C378(<>Lst_strings; *; $Lon_Reference; $Txt_Element; $Lon_Sublist; $Boo_Expanded)
			
			If ($Lon_Reference>0)  //trans-unit
				
				//Reference xliff string as text (to paste in property list or a static text)
				// Added by Vincent de Lachaux (11/07/08)
				
				DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "drop-syntax"; $Boo_compatibility)
				
				If ($Boo_compatibility)
					
					$Lon_Parent:=List item parent:C633(<>Lst_strings; $Lon_Reference)
					GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_Parent; "id"; $Txt_Buffer)  //ID
					
					If (Length:C16($Txt_Buffer)>0)
						
						GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_Reference; "id"; $Txt_Value)  //Index
						
						If (Length:C16($Txt_Value)>0)
							
							$Txt_Buffer:=":"+$Txt_Buffer+","+$Txt_Value
							
						Else 
							
							BEEP:C151
							
						End if 
					End if 
					
				Else 
					
					$Txt_Buffer:=":xliff:"+$Txt_Element
					
				End if 
				
				SET TEXT TO PASTEBOARD:C523($Txt_Buffer)
				
				//trans-unit definition as private tag
				VARIABLE TO BLOB:C532($Txt_Element; $Blb_Buffer; *)
				VARIABLE TO BLOB:C532(<>tTxt_attributeNames; $Blb_Buffer; *)
				VARIABLE TO BLOB:C532(<>tTxt_attributeValues; $Blb_Buffer; *)
				GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_Reference; "_source"; $Txt_Buffer)
				VARIABLE TO BLOB:C532($Txt_Buffer; $Blb_Buffer; *)
				GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_Reference; "_target"; $Txt_Buffer)
				VARIABLE TO BLOB:C532($Txt_Buffer; $Blb_Buffer; *)
				APPEND DATA TO PASTEBOARD:C403("private.xliff-editor.trans-unit"; $Blb_Buffer)
				
			Else   //group
				
				//group resname as text
				SET TEXT TO PASTEBOARD:C523($Txt_Element)
				
				//group definition as private tag
				LIST TO BLOB:C556($Lon_Sublist; $Blb_Buffer; *)
				VARIABLE TO BLOB:C532(<>tTxt_attributeNames; $Blb_Buffer; *)
				VARIABLE TO BLOB:C532(<>tTxt_attributeValues; $Blb_Buffer; *)
				APPEND DATA TO PASTEBOARD:C403("private.xliff-editor.group"; $Blb_Buffer)
				
			End if 
			
			SET BLOB SIZE:C606($Blb_Buffer; 0)
			ENABLE MENU ITEM:C149(2; 5)
			
		End if 
		
		//……………………………………………………………………………
	Else 
		
		//Standard copy of the selected text if any
		$Lon_Type:=Type:C295($Ptr_Object->)
		
		If ($Lon_Type=Is alpha field:K8:1)\
			 | ($Lon_Type=Is text:K8:3)\
			 | ($Lon_Type=Is string var:K8:2)
			
			$Txt_Buffer:=Get edited text:C655
			GET HIGHLIGHT:C209($Ptr_Object->; $Lon_Start; $Lon_End)
			
			If ($Lon_End>$Lon_Start)
				
				$Txt_Buffer:=Substring:C12($Txt_Buffer; $Lon_Start; $Lon_End-$Lon_Start)
				
				If (Length:C16($Txt_Buffer)>0)
					
					SET TEXT TO PASTEBOARD:C523($Txt_Buffer)
					ENABLE MENU ITEM:C149(2; 5)
					
				End if 
			End if 
		End if 
		
		//……………………………………………………………………………
End case 