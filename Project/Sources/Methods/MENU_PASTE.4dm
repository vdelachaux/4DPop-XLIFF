//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : MENU_PASTE
// Created 08/02/07 by vdl
// Modified 09/02/07 by vdl
// Adding the private pastboard to copy/past from/to the editor
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_BLOB:C604($Blb_buffer)
C_BOOLEAN:C305($Boo_expanded)
C_LONGINT:C283($Lon_i; $Lon_id; $Lon_offset; $Lon_parent; $Lon_position; $Lon_reference; $Lon_x; $Lst_item)
C_POINTER:C301($Ptr_object)
C_TEXT:C284($Txt_buffer; $Txt_resname; $Txt_source; $Txt_target)

$Ptr_object:=Focus object:C278

If (Is nil pointer:C315($Ptr_object))
	
	$Ptr_object:=-><>Lst_strings
	
End if 

If ($Ptr_object=(-><>Lst_strings))
	
	Case of 
			
			//______________________________________________________
		: (Pasteboard data size:C400("private.xliff-editor.group")>0)
			
			GET PASTEBOARD DATA:C401("private.xliff-editor.group"; $Blb_buffer)
			
			If (OK=1)
				
				$Lst_item:=BLOB to list:C557($Blb_buffer; $Lon_offset)
				BLOB TO VARIABLE:C533($Blb_buffer; <>tTxt_attributeNames; $Lon_offset)
				BLOB TO VARIABLE:C533($Blb_buffer; <>tTxt_attributeValues; $Lon_offset)
				
				For ($Lon_i; 1; Count list items:C380($Lst_item); 1)
					
					GET LIST ITEM:C378($Lst_item; $Lon_i; $Lon_reference; $Txt_resname)
					$Txt_buffer:=$Txt_resname
					
					While (Find in list:C952(<>Lst_strings; $Txt_resname; 1)>0)
						
						$Lon_x:=$Lon_x+1
						$Txt_resname:=$Txt_buffer+"_"+String:C10($Lon_x)
						
					End while 
					
					<>tTxt_attributeValues{Find in array:C230(<>tTxt_attributeNames; "resname")}:=$Txt_resname
					<>vLast_unit_ID:=<>vLast_unit_ID+1
					SET LIST ITEM:C385($Lst_item; $Lon_reference; $Txt_resname; <>vLast_unit_ID)
					SET LIST ITEM PARAMETER:C986($Lst_item; <>vLast_unit_ID; Additional text:K28:7; <>vLast_unit_ID)
					SET LIST ITEM PARAMETER:C986($Lst_item; <>vLast_unit_ID; "id"; <>vLast_unit_ID)
					SET LIST ITEM PARAMETER:C986($Lst_item; <>vLast_unit_ID; "resname"; $Txt_resname)
					SET LIST ITEM PROPERTIES:C386($Lst_item; <>vLast_unit_ID; False:C215; Plain:K14:1; 0; Foreground color:K23:1)
					
				End for 
				
				$Txt_resname:=Get text from pasteboard:C524
				
				If (Find in list:C952(<>Lst_strings; $Txt_resname; 0)>0)
					
					$Txt_resname:=$Txt_resname+" - Copy"
					$Lon_x:=Find in array:C230(<>tTxt_attributeNames; "resname")
					<>tTxt_attributeValues{$Lon_x}:=$Txt_resname
					
				End if 
				
				<>vLast_Group_UID:=<>vLast_Group_UID-1
				APPEND TO LIST:C376(<>Lst_strings; $Txt_resname; <>vLast_Group_UID; $Lst_item; True:C214)
				SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_Group_UID; "_type"; "group")
				
				SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_strings; <>vLast_Group_UID)
				OBJECT SET SCROLL POSITION:C906(<>Lst_strings; List item position:C629(<>Lst_strings; <>vLast_Group_UID))
				EDITOR_MODIFIED
				GOTO OBJECT:C206(<>Txt_Resname)
				form_timerEvent(2; -1)
				
			End if 
			
			//______________________________________________________
		: (Pasteboard data size:C400("private.xliff-editor.trans-unit")>0)
			
			GET LIST ITEM:C378(<>Lst_strings; *; $Lon_id; $Txt_resname; $Lst_item; $Boo_expanded)
			
			If ($Lon_id>0)
				
				$Lon_parent:=List item parent:C633(<>Lst_strings; $Lon_id)
				GET LIST ITEM:C378(<>Lst_strings; List item position:C629(<>Lst_strings; $Lon_parent); $Lon_reference; $Txt_resname; $Lst_item; $Boo_expanded)
				$Lon_position:=List item position:C629($Lst_item; $Lon_id)
				
			Else 
				
				$Lon_reference:=$Lon_id
				
			End if 
			
			If ($Lon_reference<0)
				
				GET PASTEBOARD DATA:C401("private.xliff-editor.trans-unit"; $Blb_buffer)
				
				If (OK=1)
					
					BLOB TO VARIABLE:C533($Blb_buffer; $Txt_resname; $Lon_offset)
					BLOB TO VARIABLE:C533($Blb_buffer; <>tTxt_attributeNames; $Lon_offset)
					BLOB TO VARIABLE:C533($Blb_buffer; <>tTxt_attributeValues; $Lon_offset)
					BLOB TO VARIABLE:C533($Blb_buffer; $Txt_source; $Lon_offset)
					BLOB TO VARIABLE:C533($Blb_buffer; $Txt_target; $Lon_offset)
					
					$Txt_buffer:=$Txt_resname
					
					While (Find in list:C952(<>Lst_strings; $Txt_resname; 1)>0)
						
						$Lon_x:=$Lon_x+1
						$Txt_resname:=$Txt_buffer+"_"+String:C10($Lon_x)
						
					End while 
					
					<>tTxt_attributeValues{Find in array:C230(<>tTxt_attributeNames; "resname")}:=$Txt_resname
					<>vLast_unit_ID:=<>vLast_unit_ID+1
					
					If ($Lon_position=0)\
						 | ($Lon_position>=Count list items:C380($Lst_item))
						
						APPEND TO LIST:C376($Lst_item; $Txt_resname; <>vLast_unit_ID)
						
					Else 
						
						INSERT IN LIST:C625($Lst_item; $Lon_position+1; $Txt_resname; <>vLast_unit_ID)
						
					End if 
					
					SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_unit_ID; Additional text:K28:7; String:C10(<>vLast_unit_ID))
					SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_unit_ID; "_type"; "unit")
					SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_unit_ID; "_source"; $Txt_source)
					SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_unit_ID; "_target"; $Txt_target)
					SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_unit_ID; "id"; <>vLast_unit_ID)
					SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_unit_ID; "resname"; $Txt_resname)
					
					SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_strings; <>vLast_unit_ID)
					OBJECT SET SCROLL POSITION:C906(<>Lst_strings; List item position:C629(<>Lst_strings; <>vLast_unit_ID))
					
					EDITOR_MODIFIED
					
					form_timerEvent(2; -1)
					
					//Edit resname
					POST KEY:C465(Tab:K15:37; 0; Current process:C322)
					
				End if 
			End if 
			
			//______________________________________________________
		Else 
			
			//______________________________________________________
	End case 
	
Else 
	
	util_PASTE($Ptr_object)
	DETAILS_AFTER_MODIFICATION($Ptr_object->)
	
End if 