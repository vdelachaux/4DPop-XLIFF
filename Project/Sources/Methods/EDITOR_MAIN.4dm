//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : XLIFF_EDITOR_MAIN
// Created 10/10/06 by vdl
// ----------------------------------------------------
// Modified by Vincent de Lachaux (21/03/12)
// v13 refactoring
// ----------------------------------------------------
// Description
// main method
// ----------------------------------------------------
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($Boo_dummy)
C_LONGINT:C283($Lon_bottom; $Lon_dummy; $Lon_frontmostWindow; $Lon_i; $Lon_left; $Lon_origin; $Lon_right; $Lon_texture)
C_LONGINT:C283($Lon_top; $Lon_typeEditor; $Lon_windowRef)
C_TEXT:C284($Txt_dummy; $Txt_entryPoint; $Txt_form; $Txt_name)

If (False:C215)
	C_TEXT:C284(EDITOR_MAIN; $1)
	C_LONGINT:C283(EDITOR_MAIN; $2)
End if 

If (Count parameters:C259>0)
	
	$Txt_entryPoint:=$1
	
End if 

Case of 
		
		//______________________________________________________
	: (Length:C16($Txt_entryPoint)=0)
		
		Case of 
				
				//………………………………………………………………
			: (Form event code:C388=On Close Box:K2:21)
				
				//Nothing here ;-)
				
				//………………………………………………………………
			Else 
				
				BRING TO FRONT:C326(New process:C317(Current method name:C684; 0; "$4DPop_"+Get localized string:C991("WindowEditor"); "run"; *))
				
				//………………………………………………………………
		End case 
		
		//______________________________________________________
	: ($Txt_entryPoint="run")
		
		EDITOR_MAIN("init")
		
		//get the last window type used
		PREFERENCES("tool"; ->$Lon_typeEditor)
		$Lon_typeEditor:=Choose:C955(($Lon_typeEditor=0) | Shift down:C543; 1; $Lon_typeEditor)
		DOM SET XML ATTRIBUTE:C866(<>Dom_object; "editor"; $Lon_typeEditor)
		
		PREFERENCES("dropInForm"; ->$Lon_dummy)
		DOM SET XML ATTRIBUTE:C866(<>Dom_object; "drop-syntax"; $Lon_dummy)
		
		//Install menu bar
		EDITOR_MENUS("install")
		
		CLEAR VARIABLE:C89(<>Boo_quit)
		
		Repeat 
			
			PREFERENCES("window."+String:C10($Lon_typeEditor); ->$Lon_left; ->$Lon_top; ->$Lon_right; ->$Lon_bottom)
			
			$Lon_left:=Choose:C955(Shift down:C543 & Macintosh option down:C545; -1; $Lon_left)
			
			BRING TO FRONT:C326(Current process:C322)
			
			//======================================================================================================= NO ERROR [
			ON ERR CALL:C155("dev_ON_ERROR")
			
			Case of 
					
					//………………………………
				: (<>Boo_quit)
					
					//………………………………
				: ($Lon_typeEditor=1)  //Display the Editor
					
					$Txt_form:="EDITOR"
					
					If ($Lon_left=-1) | True:C214
						
						$Lon_windowRef:=Open form window:C675($Txt_form; Plain form window:K39:10+$Lon_texture; Horizontally centered:K39:1; Vertically centered:K39:4; *)
						
					Else 
						
						$Lon_windowRef:=Open window:C153($Lon_left; $Lon_top; $Lon_right; $Lon_bottom; Plain window:K34:13+$Lon_texture+4096; Get localized string:C991("WindowEditor"); "XLIFF_Editor")
						
					End if 
					
					RECOVER_WINDOW
					
					DIALOG:C40($Txt_form)
					
					//………………………………
				: ($Lon_typeEditor=2)  //Display the Palette
					
					$Txt_form:="PALETTE"
					
					If ($Lon_left=-1) | True:C214
						
						$Lon_windowRef:=Open form window:C675($Txt_form; Palette form window:K39:9; On the left:K39:2; At the top:K39:5; *)
						
					Else 
						
						$Lon_windowRef:=Open window:C153($Lon_left; $Lon_top; $Lon_right; $Lon_bottom; -(Palette window:K34:3+$Lon_texture+1+2+4+4096); Get localized string:C991("WindowPalette"); "XLIFF_Editor")
						
					End if 
					
					RECOVER_WINDOW
					
					DIALOG:C40($Txt_form)
					
					//………………………………
			End case 
			
			ON ERR CALL:C155("")
			
			//======================================================================================================= NO ERROR ]
			
			//Keep the window position…
			GET WINDOW RECT:C443($Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
			PREFERENCES("window."+String:C10($Lon_typeEditor)+".Set"; ->$Lon_left; ->$Lon_top; ->$Lon_right; ->$Lon_bottom)
			
			//…before closing
			CLOSE WINDOW:C154
			
			CLEAR VARIABLE:C89($Lon_left)
			CLEAR VARIABLE:C89($Lon_top)
			CLEAR VARIABLE:C89($Lon_right)
			CLEAR VARIABLE:C89($Lon_bottom)
			
			DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "editor"; $Lon_typeEditor)
			
		Until ($Lon_typeEditor<0) | Process aborted:C672
		
		//Keep the last window type used
		$Lon_typeEditor:=Abs:C99($Lon_typeEditor)
		PREFERENCES("tool.Set"; ->$Lon_typeEditor)
		
		<>Boo_quit:=True:C214
		
		//Release menu bar
		EDITOR_MENUS("uninstall")
		
		//clear memory
		EDITOR_MAIN("deinit")
		
		//______________________________________________________
	: ($Txt_entryPoint="deinit")
		
		For ($Lon_i; 1; DOM Count XML attributes:C727(<>Dom_object); 1)
			
			DOM GET XML ATTRIBUTE BY INDEX:C729(<>Dom_object; $Lon_i; $Txt_name; $Txt_dummy)
			
			Case of 
					
					//______________________________________________________
				: ($Txt_name="hidden-window")
					
					DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; $Txt_name; $Lon_frontmostWindow)
					
					If ($Lon_frontmostWindow#0)
						
						SHOW WINDOW:C435($Lon_frontmostWindow)
						
					End if 
					
					//______________________________________________________
			End case 
		End for 
		
		//DOM FERMER XML(<>Dom_object)
		//EFFACER VARIABLE(<>Dom_object)
		
		CLEAR LIST:C377(<>Lst_files; *)
		CLEAR VARIABLE:C89(<>Lst_files)
		
		CLEAR LIST:C377(<>Lst_strings; *)
		CLEAR VARIABLE:C89(<>Lst_strings)
		
		//EFFACER VARIABLE(<>Txt_Source)
		//EFFACER VARIABLE(<>Txt_Target)
		CLEAR VARIABLE:C89(<>Txt_ID)
		CLEAR VARIABLE:C89(<>Txt_Resname)
		CLEAR VARIABLE:C89(<>Txt_fileDump)
		CLEAR VARIABLE:C89(<>bNoTranslate)
		
		//EFFACER VARIABLE(<>Lon_currentFile)
		
		CLEAR VARIABLE:C89(<>tBoo_attributes)
		CLEAR VARIABLE:C89(<>tTxt_attributeNames)
		CLEAR VARIABLE:C89(<>tTxt_attributeValues)
		
		//EFFACER VARIABLE(<>tTxt_languageCodes)
		
		CLEAR VARIABLE:C89(<>tTxt_Sources)
		CLEAR VARIABLE:C89(<>tTxt_Targets)
		
		CLEAR VARIABLE:C89(<>tBoo_xliff_Attributes_ListBox)
		CLEAR VARIABLE:C89(<>tTxt_xliff_attributeNames)
		CLEAR VARIABLE:C89(<>tTxt_xliff_attributeValues)
		
		CLEAR VARIABLE:C89(<>tBoo_file_Attributes_ListBox)
		CLEAR VARIABLE:C89(<>tTxt_file_attributeNames)
		CLEAR VARIABLE:C89(<>tTxt_file_attributeValues)
		
		CLEAR VARIABLE:C89(<>tBoo_file_Notes_ListBox)
		CLEAR VARIABLE:C89(<>tTxt_file_Notes)
		
		CLEAR VARIABLE:C89(<>tTxt_prop_groupNames)
		CLEAR VARIABLE:C89(<>tTxt_prop_groupValues)
		
		//CLEAR VARIABLE(<>tBoo_dump)
		//CLEAR VARIABLE(<>tTxt_dumpLines)
		//CLEAR VARIABLE(<>tLon_dumpLines)
		//<>tLon_dumpLines{0}:=0
		
		CLEAR VARIABLE:C89(<>tTxt_unit_Attribute_Names)
		CLEAR VARIABLE:C89(<>tTxt_group_Attribute_Names)
		
		//CLEAR VARIABLE(<>tTxt_Search)
		
		//______________________________________________________
	: ($Txt_entryPoint="init")
		
		
		SET ASSERT ENABLED:C1131(Not:C34(Is compiled mode:C492))
		
		$Lon_frontmostWindow:=Frontmost window:C447
		
		Case of 
				
				//……………………………………………
			: (Undefined:C82(<>Boo_initialized))  //Interpreted component
				
				COMPILER_Editor
				
				//……………………………………………
			: (Not:C34(<>Boo_initialized))  //Compiled component
				
				COMPILER_Editor
				
				//……………………………………………
			: (env_Boo_Is_a_Component)
				
				//Nothing to do
				
				//……………………………………………
			Else 
				
				PROCESS PROPERTIES:C336(Window process:C446($Lon_frontmostWindow); $Txt_dummy; $Lon_dummy; $Lon_dummy; $Boo_dummy; $Lon_dummy; $Lon_origin)
				
				If ($Lon_origin#Design process:K36:9)
					
					HIDE WINDOW:C436($Lon_frontmostWindow)
					DOM SET XML ATTRIBUTE:C866(<>Dom_object; "hidden-window"; $Lon_frontmostWindow)
					
				End if 
				
				//……………………………………………
		End case 
		
		<>Xliff_vLon_Current:=<>Xliff_vLon_Current+Num:C11(<>Xliff_vLon_Current=0)
		
		SET DATABASE LOCALIZATION:C1104(Get database localization:C1009(User system localization:K5:23); *)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point: \""+$Txt_entryPoint+"\"")
		
		//______________________________________________________
End case 