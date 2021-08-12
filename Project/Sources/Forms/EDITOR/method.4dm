// ----------------------------------------------------
// Form method : EDITOR
// Created 23/03/12 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($Boo_quit; $Boo_visible)
C_LONGINT:C283($Lon_; $Lon_bottom; $Lon_formEvent; $Lon_i; $Lon_left; $Lon_offset; $Lon_origin; $Lon_ref)
C_LONGINT:C283($Lon_right; $Lon_state; $Lon_time; $Lon_timer; $Lon_timerEvent; $Lon_top; $Lon_typeEditor; $Lon_UID)
C_TEXT:C284($Txt_buffer; $Txt_name)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388

// ----------------------------------------------------
Case of 
		//______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		OBJECT SET ENABLED:C1123(*; "toolbar.sort"; False:C215)
		OBJECT SET VISIBLE:C603(*; "_Spinner"; True:C214)
		
		form_timerEvent(-1; -1)
		
		//______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		$Lon_timerEvent:=form_timerEvent
		$Lon_timer:=-1
		
		Case of 
				
				//.....................................................
			: ($Lon_timerEvent=-1)  //Initializes
				
				//Move the window if it's under the menu bar or the toolbar {
				GET WINDOW RECT:C443($Lon_left; $Lon_top; $Lon_right; $Lon_bottom; Current form window:C827)
				
				If ($Lon_top<0)
					
					$Lon_bottom:=$Lon_bottom+Abs:C99($Lon_top)
					$Lon_top:=0
					
				End if 
				
				If ($Lon_top<(Menu bar height:C440+Tool bar height:C1016+30))
					
					$Lon_offset:=$Lon_bottom-$Lon_top
					$Lon_top:=Menu bar height:C440+Tool bar height:C1016+30
					$Lon_bottom:=$Lon_top+$Lon_offset
					SET WINDOW RECT:C444($Lon_left; $Lon_top; $Lon_right; $Lon_bottom; Current form window:C827)
					
				End if   //}
				
				//Create the xliff files' list if any
				If (Not:C34(Is a list:C621(<>Lst_files)))
					
					EDITOR_GET_FILE_LIST
					
				End if 
				
				GOTO OBJECT:C206(<>Lst_files)
				
				//Get and select the last used file
				PREFERENCES("file"; ->$Txt_buffer)
				$Lon_ref:=Find in list:C952(<>Lst_files; $Txt_buffer; 1; *)
				SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_files; Choose:C955($Lon_ref#0; $Lon_ref; 1))
				
				object_TOUCH("details.subform")
				
				//Parse selected current file
				form_timerEvent(1)
				
				//.....................................................
			: ($Lon_timerEvent=1)  //Parses the current selected file
				
				OBJECT SET VISIBLE:C603(*; "details.subform"; False:C215)
				
				EDITOR_LOAD_FILE
				
				//.....................................................
			: ($Lon_timerEvent=2)  //Displays the current selected element
				
				OBJECT SET VISIBLE:C603(*; "details.subform"; True:C214)
				
				object_TOUCH("details.subform")
				object_TOUCH("attributes.form")
				
				//.....................................................
			: ($Lon_timerEvent=200)  //Open/Close info+
				
				EDITOR_HIDE_SHOW_ATTRIBUTES
				
				//.....................................................
			: (env_Boo_Is_a_Component)
				
				$Boo_quit:=True:C214
				
				For ($Lon_i; 1; Count tasks:C335; 1)
					
					PROCESS PROPERTIES:C336($Lon_i; $Txt_name; $Lon_state; $Lon_time; $Boo_visible; $Lon_UID; $Lon_origin)
					
					If ($Lon_origin=Design process:K36:9)
						
						$Boo_quit:=False:C215
						$Lon_i:=MAXLONG:K35:2-1
						
					End if 
				End for 
				
				If ($Boo_quit)
					
					DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "editor"; $Lon_typeEditor)
					DOM SET XML ATTRIBUTE:C866(<>Dom_object; "editor"; -$Lon_typeEditor)
					
					CANCEL:C270
					
				End if 
				
				//----------------------------------------
		End case 
		
		$Lon_timerEvent:=form_timerEvent
		form_timerEvent($Lon_timerEvent; \
			Choose:C955($Lon_timerEvent#0; $Lon_timer; 60*5*Num:C11(env_Boo_Is_a_Component)))
		
		//______________________________________________________
	: ($Lon_formEvent=On Outside Call:K2:11)
		
		If (<>Boo_quit | Process aborted:C672)
			
			EDITOR_save("save_menu_close")
			
		End if 
		
		//______________________________________________________
	: ($Lon_formEvent=On Menu Selected:K2:14)
		
		EDITOR_MENUS("execute")
		
		//______________________________________________________
	: ($Lon_formEvent=On Resize:K2:27)
		
		//Resize and  move dynamic objects
		EXECUTE METHOD IN SUBFORM:C1085("details.subform"; "DETAILS_ON_RESIZE"; *; $Lon_formEvent)
		
		//______________________________________________________
	: ($Lon_formEvent=On Close Box:K2:21)
		
		EDITOR_save("save_close")
		
		//______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		//Keep the current file
		GET LIST ITEM:C378(<>Lst_files; *; $Lon_; $Txt_buffer)
		PREFERENCES("file.Set"; ->$Txt_buffer)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessarily")
		
		//______________________________________________________
End case 