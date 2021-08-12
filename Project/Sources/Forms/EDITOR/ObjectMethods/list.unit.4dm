C_LONGINT:C283($0)

C_BLOB:C604($Blb_buffer)
C_BOOLEAN:C305($Boo_compatibility; $Boo_expanded; $Boo_formEditor; $Boo_selected)
C_LONGINT:C283($Lon_destination; $Lon_destinationReference; $Lon_destinationSublist; $Lon_formEvent; $Lon_i; $Lon_offset; $Lon_parent; $Lon_process)
C_LONGINT:C283($Lon_ref; $Lon_source; $Lon_sourceReference; $Lon_sourceSublist; $Lon_transunit; $Lon_x; $Lon_y; $Lst_units)
C_LONGINT:C283($Win_hdl)
C_POINTER:C301($Ptr_id; $Ptr_source)
C_TEXT:C284($Txt_buffer; $Txt_element; $Txt_resname; $Txt_source; $Txt_target; $Txt_type; $Txt_value)

$Lon_formEvent:=Form event code:C388

Case of 
		
		//.....................................................
	: ($Lon_formEvent=On Double Clicked:K2:5)
		
		If (List item parent:C633(<>Lst_strings; *)#0)  //Transunit
			
			EDITOR_Boo_handler("note")
			
		End if 
		
		//.....................................................
	: ($Lon_formEvent=On Clicked:K2:4)
		
		If (Contextual click:C713)
			
			EDITOR_MENUS("stringList")
			
		End if 
		
		//________________________________________
	: ($Lon_formEvent=On Selection Change:K2:29)
		
		$Boo_selected:=Selected list items:C379(Self:C308->)>0
		OBJECT SET VISIBLE:C603(*; "details.subform"; $Boo_selected)
		OBJECT SET ENABLED:C1123(*; "toolbar.sort"; $Boo_selected)
		
		object_TOUCH("details.subform")
		
		$Ptr_id:=OBJECT Get pointer:C1124(Object named:K67:5; "search.list.id")
		ASSERT:C1129(Not:C34(Is nil pointer:C315($Ptr_id)))
		
		$Lon_x:=Find in array:C230($Ptr_id->; Selected list items:C379(<>Lst_strings; *))
		LISTBOX SELECT ROW:C912(*; "search.list"; Choose:C955($Lon_x>0; $Lon_x; 0); lk replace selection:K53:1)
		
		
		//.....................................................
	: ($Lon_formEvent=On Delete Action:K2:56)
		
		EDITOR_DELETE("delete_element")
		
		//.....................................................
	: ($Lon_formEvent=On Drag Over:K2:13)
		
		If (Pasteboard data size:C400("private.xliff-editor.group")>0)\
			 | (Pasteboard data size:C400("private.xliff-editor.trans-unit")>0)
			
			$0:=0
			
		Else 
			
			$0:=-1
			
		End if 
		
		//.....................................................
	: ($Lon_formEvent=On Drop:K2:12)
		
		_O_DRAG AND DROP PROPERTIES:C607($Ptr_source; $Lon_source; $Lon_process)
		$Lon_destination:=Drop position:C608
		GET LIST ITEM:C378(<>Lst_strings; $Lon_source; $Lon_sourceReference; $Txt_buffer)
		GET LIST ITEM:C378(<>Lst_strings; $Lon_destination; $Lon_destinationReference; $Txt_buffer)
		
		Case of 
				
				//……………………………………………………………………………
			: (Pasteboard data size:C400("private.xliff-editor.group")>0)
				
				//……………………………………………………………………………
			: (Pasteboard data size:C400("private.xliff-editor.trans-unit")>0)  //Trans-unit Internal drag & drop
				
				$Lon_parent:=List item parent:C633(<>Lst_strings; $Lon_sourceReference)
				GET LIST ITEM:C378(<>Lst_strings; List item position:C629(<>Lst_strings; $Lon_parent); $Lon_ref; $Txt_buffer; $Lon_sourceSublist; $Boo_expanded)
				
				If ($Lon_destinationReference>0)
					
					$Lon_parent:=List item parent:C633(<>Lst_strings; $Lon_destinationReference)
					GET LIST ITEM:C378(<>Lst_strings; List item position:C629(<>Lst_strings; $Lon_parent); $Lon_ref; $Txt_buffer; $Lon_destinationSublist; $Boo_expanded)
					
				End if 
				
				If (Is a list:C621($Lon_destinationSublist))
					
					//Get private trans-unit informations
					GET PASTEBOARD DATA:C401("private.xliff-editor.trans-unit"; $Blb_buffer)
					
					If (OK=1)
						
						BLOB TO VARIABLE:C533($Blb_buffer; $Txt_element; $Lon_offset)
						DELETE FROM ARRAY:C228(<>tTxt_attributeNames; 1; Size of array:C274(<>tTxt_attributeNames))
						BLOB TO VARIABLE:C533($Blb_buffer; <>tTxt_attributeNames; $Lon_offset)
						DELETE FROM ARRAY:C228(<>tTxt_attributeValues; 1; Size of array:C274(<>tTxt_attributeValues))
						BLOB TO VARIABLE:C533($Blb_buffer; <>tTxt_attributeValues; $Lon_offset)
						BLOB TO VARIABLE:C533($Blb_buffer; $Txt_source; $Lon_offset)
						BLOB TO VARIABLE:C533($Blb_buffer; $Txt_target; $Lon_offset)
						
						If (Macintosh option down:C545)
							
							//Duplication
							<>vLast_unit_ID:=<>vLast_unit_ID+1
							<>tTxt_attributeValues{Find in array:C230(<>tTxt_attributeNames; "id")}:=String:C10(<>vLast_unit_ID)
							
						Else 
							
							DELETE FROM LIST:C624(<>Lst_strings; $Lon_sourceReference)
							
						End if 
						
						$Txt_buffer:=$Txt_element
						
						While (Find in list:C952(<>Lst_strings; $Txt_element; 1)>0)
							
							$Lon_x:=$Lon_x+1
							$Txt_element:=$Txt_buffer+"_"+String:C10($Lon_x)
							
						End while 
						
						<>tTxt_attributeValues{Find in array:C230(<>tTxt_attributeNames; "resname")}:=$Txt_element
						
						INSERT IN LIST:C625($Lon_destinationSublist; $Lon_destinationReference; $Txt_element; <>vLast_unit_ID)
						SET LIST ITEM PARAMETER:C986($Lon_destinationSublist; <>vLast_unit_ID; "_type"; "unit")
						SET LIST ITEM PARAMETER:C986($Lon_destinationSublist; <>vLast_unit_ID; "_source"; $Txt_source)
						SET LIST ITEM PARAMETER:C986($Lon_destinationSublist; <>vLast_unit_ID; "_target"; $Txt_target)
						SET LIST ITEM PARAMETER:C986($Lon_destinationSublist; <>vLast_unit_ID; Additional text:K28:7; String:C10(<>vLast_unit_ID))
						
						SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_strings; <>vLast_unit_ID)
						OBJECT SET SCROLL POSITION:C906(<>Lst_strings; List item position:C629(<>Lst_strings; <>vLast_unit_ID))
						EDITOR_MODIFIED
						GOTO OBJECT:C206(<>Txt_Resname)
						
						form_timerEvent(2; -1)
						
					End if 
				End if 
				
				//……………………………………………………………………………
			Else 
				
				BEEP:C151
				
				//……………………………………………………………………………
		End case 
		
		//.....................................................
	: ($Lon_formEvent=On Begin Drag Over:K2:44)  //drag from the list to method or form editor
		
		CLEAR PASTEBOARD:C402
		GET LIST ITEM:C378(<>Lst_strings; *; $Lon_ref; $Txt_resname; $Lst_units; $Boo_expanded)
		VARIABLE TO BLOB:C532($Txt_resname; $Blb_buffer; *)
		
		//Get the window kind (method or form editor) to determine what to put in the drag container
		$Win_hdl:=Current form window:C827
		$Win_hdl:=Choose:C955(Window kind:C445($Win_hdl)=Floating window:K27:4; \
			Frontmost window:C447; \
			Next window:C448($Win_hdl))
		
		//http://forums.4d.fr/Post/FR/16198779/2/16465822#16465822
		//$Boo_formEditor:=(Position(Get localized string("4D_Form"+xliff_Txt_Language ("Application.Language"));Get window title($Win_hdl))#0)
		$Txt_buffer:=Get window title:C450($Win_hdl)
		
		If (Position:C15("-"; $Txt_buffer)>0)  //compatibility with 4DPop Windows, if any
			
			$Txt_buffer:=Delete string:C232($Txt_buffer; 1; Position:C15("-"; $Txt_buffer)+1)
			
		End if 
		
		$Boo_formEditor:=(Position:C15(Get localized string:C991("4D_Form"+xliff_Txt_Language("Application.Language")); $Txt_buffer)=1)
		
		//Modifier to invert
		$Boo_formEditor:=Choose:C955($Boo_formEditor; ($Boo_formEditor & (Not:C34(Macintosh option down:C545 | Windows Alt down:C563))); (Macintosh option down:C545 | Windows Alt down:C563))
		
		GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_ref; "_type"; $Txt_type)
		
		If ($Txt_type="unit")  //<trans-unit>
			
			If (Length:C16($Txt_resname)>0)
				
				GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_ref; "_source"; $Txt_source)
				
				If ($Boo_formEditor)  //Paste as reference
					
					// Added by Vincent de Lachaux (11/07/08) {
					//If (<>bPaste_ID=1)
					DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "drop-syntax"; $Boo_compatibility)
					
					If ($Boo_compatibility)
						
						$Lon_parent:=List item parent:C633(<>Lst_strings; $Lon_ref)
						GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_parent; "id"; $Txt_buffer)  //ID
						
						If (Length:C16($Txt_buffer)>0)
							
							GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_ref; "id"; $Txt_value)  //Index
							
							If (Length:C16($Txt_value)>0)
								
								$Txt_buffer:=":"+$Txt_buffer+","+$Txt_value
								
							Else 
								
								BEEP:C151
								
							End if 
						End if 
						
					Else   //}
						
						$Txt_buffer:=":xliff:"+$Txt_resname
						
					End if 
					
				Else 
					
					If (Shift down:C543)  //Paste as comment
						
						$Txt_buffer:="//"+Replace string:C233($Txt_source; "\n"; " ")
						
					Else   //Paste code
						
						$Lon_x:=Position:C15("{"; $Txt_source)
						
						If ($Lon_x>0)
							
							//Replace string(Get localized string("Resname");"{xxxx}";)
							$Lon_y:=Position:C15("}"; $Txt_source)
							$Txt_buffer:=Command name:C538(233)+"("\
								+Command name:C538(991)+"(\""+$Txt_resname+"\");\""\
								+Substring:C12($Txt_source; $Lon_x; $Lon_y-$Lon_x+1)\
								+"\";Replacement)"
							
						Else 
							
							//Get localized string("Resname")
							$Txt_buffer:=Command name:C538(991)+"(\""+$Txt_resname+"\")"
							
						End if 
					End if 
				End if 
				
				SET TEXT TO PASTEBOARD:C523($Txt_buffer)
				
				//trans-unit definition as private tag
				VARIABLE TO BLOB:C532(<>tTxt_attributeNames; $Blb_buffer; *)
				VARIABLE TO BLOB:C532(<>tTxt_attributeValues; $Blb_buffer; *)
				GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_ref; "_source"; $Txt_buffer)
				VARIABLE TO BLOB:C532($Txt_buffer; $Blb_buffer; *)
				GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_ref; "_target"; $Txt_buffer)
				VARIABLE TO BLOB:C532($Txt_buffer; $Blb_buffer; *)
				APPEND DATA TO PASTEBOARD:C403("private.xliff-editor.trans-unit"; $Blb_buffer)
				
			Else 
				
				// Added by Vincent de Lachaux (11/07/08)
				// Compatibility mode with STR# (Without resname) {
				//If (<>bPaste_ID=1)
				DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "drop-syntax"; $Boo_compatibility)
				
				If ($Boo_compatibility)
					
					$Lon_parent:=List item parent:C633(<>Lst_strings; $Lon_ref)
					GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_parent; "id"; $Txt_buffer)  //ID
					
					If (Length:C16($Txt_buffer)>0)
						
						GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_ref; "id"; $Txt_value)  //Index
						
						If (Length:C16($Txt_value)>0)
							
							$Txt_buffer:=":"+$Txt_buffer+","+$Txt_value
							
						Else 
							
							BEEP:C151
							
						End if 
					End if 
					
				Else 
					
					BEEP:C151
					
				End if   //}
			End if 
			
		Else   //<group>
			
			If ($Boo_formEditor)
				
				BEEP:C151
				
			Else 
				
				$Lon_transunit:=Count list items:C380($Lst_units)
				
				If ($Lon_transunit>0)
					
					$Txt_buffer:=Command name:C538(222)+"($tTxt_Resource;"+String:C10($Lon_transunit)+")\r"  //ARRAY TEXT
					GET LIST ITEM:C378($Lst_units; 1; $Lon_ref; $Txt_element)
					
					If ($Txt_element=($Txt_resname+"_1"))
						
						$Txt_resname:=$Txt_resname+"_"\
							+Get localized string:C991("xliff_For")+"($Lon_i;1;"+String:C10($Lon_transunit)+";1)\r"\
							+"$tTxt_Resource{$Lon_i}:="+Command name:C538(991)+"(\""+$Txt_resname+"\"+"+Command name:C538(10)+"($Lon_i)"+")\r"\
							+Get localized string:C991("xliff_EndFor")+"\r"
						
					Else 
						
						For ($Lon_i; 1; $Lon_transunit; 1)
							
							GET LIST ITEM:C378($Lst_units; $Lon_i; $Lon_ref; $Txt_resname)
							$Txt_buffer:=$Txt_buffer\
								+"$tTxt_Resource{"+String:C10($Lon_i)+"}:="\
								+Command name:C538(991)+"(\""+$Txt_resname+"\")\r"
							
						End for 
					End if 
				End if 
				
				SET TEXT TO PASTEBOARD:C523($Txt_buffer)
				
				//group definition as private tag
				LIST TO BLOB:C556($Lst_units; $Blb_buffer; *)
				VARIABLE TO BLOB:C532(<>tTxt_attributeNames; $Blb_buffer; *)
				VARIABLE TO BLOB:C532(<>tTxt_attributeValues; $Blb_buffer; *)
				APPEND DATA TO PASTEBOARD:C403("private.xliff-editor.group"; $Blb_buffer)
				
			End if 
		End if 
		
		//.....................................................
		
	Else 
		
		OBJECT SET VISIBLE:C603(*; "details.subform"; Selected list items:C379(Self:C308->)>0)
		
		form_timerEvent(2; -1)
		
		//.....................................................
End case 