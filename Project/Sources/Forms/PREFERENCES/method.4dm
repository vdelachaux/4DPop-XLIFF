C_LONGINT:C283($Lon_Bottom; $Lon_dummy; $Lon_formEvent; $Lon_Height; $Lon_i; $Lon_Left; $Lon_platform; $Lon_Right)
C_LONGINT:C283($Lon_Tittle_Right; $Lon_Top; $Lon_Width; $Lon_x)
C_POINTER:C301($Ptr_object)
C_TEXT:C284($Txt_Buffer; $Txt_Object; $Txt_targetFolderPath)

$Lon_formEvent:=Form event code:C388

Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		//<>xliff_Lon_Preference_Page:=1
		
		OBJECT SET ENABLED:C1123(*; "Page.3"; Selected list items:C379(<>Lst_files)#0)
		
		PREFERENCES("default-values"\
			; OBJECT Get pointer:C1124(Object named:K67:5; "01.Comment.App.Scroll.Box"))
		
		DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "target_folder"; $Txt_targetFolderPath)
		
		If (env_Boo_Is_a_Component)
			
			OBJECT SET ENABLED:C1123(*; "bResFolderOpen"; False:C215)
			
		Else 
			
			OBJECT SET ENABLED:C1123(*; "bResFolderOpen"; True:C214)
			
			If (Length:C16($Txt_targetFolderPath)>0)
				
				OBJECT SET TITLE:C194(*; "bResFolderOpen"; Get localized string:C991("ChangeButton"))
				
			End if 
		End if 
		
		doc_OBJET_LOCATION($Txt_targetFolderPath; "File_Path"; $Lon_formEvent)
		
		<>Txt_prefix:=xliff_Property_Group("Get"; "prefix")
		
		If (Length:C16(<>Txt_prefix)>0)
			
			OBJECT SET ENTERABLE:C238(<>Txt_prefix; True:C214)
			OBJECT SET ENTERABLE:C238(<>Txt_prefixSeparator; False:C215)
			
		Else 
			
			OBJECT SET ENTERABLE:C238(<>Txt_prefix; False:C215)
			OBJECT SET ENTERABLE:C238(<>Txt_prefixSeparator; True:C214)
			
		End if 
		
		<>Txt_prefixSeparator:=xliff_Property_Group("Get"; "separator")
		
		<>cb_1:=Num:C11(xliff_Property_Group("Get"; "autofill")="true")
		
		ARRAY TEXT:C222(<>tTxt_Sources; 0)
		ARRAY TEXT:C222(<>tTxt_Targets; 0)
		$Lon_i:=0
		
		Repeat 
			
			$Lon_i:=$Lon_i+1
			$Txt_Buffer:=Get localized string:C991("Languages_"+String:C10($Lon_i))
			
			If (OK=1)
				
				APPEND TO ARRAY:C911(<>tTxt_Sources; $Txt_Buffer)
				
			End if 
		Until (OK=0)
		
		ARRAY TEXT:C222($tTxt_languageCodes; 0x0000)
		LIST TO ARRAY:C288("managed_language_codes"; $tTxt_languageCodes)
		
		<>tTxt_Sources:=Find in array:C230($tTxt_languageCodes; Substring:C12(<>Txt_sourceLang; 1; 2))
		COPY ARRAY:C226(<>tTxt_Sources; <>tTxt_Targets)
		<>tTxt_Targets:=Find in array:C230($tTxt_languageCodes; Substring:C12(<>Txt_targetLang; 1; 2))
		
		//================================ File
		$Ptr_object:=OBJECT Get pointer:C1124(Object named:K67:5; "file.xliff.version")
		GET LIST ITEM PARAMETER:C985(<>Lst_files; *; "file.version"; $Ptr_object->)
		
		$Ptr_object:=OBJECT Get pointer:C1124(Object named:K67:5; "file.xml.encoding")
		GET LIST ITEM PARAMETER:C985(<>Lst_files; *; "file.encoding"; $Ptr_object->)
		
		$Ptr_object:=OBJECT Get pointer:C1124(Object named:K67:5; "file.comment")
		GET LIST ITEM PARAMETER:C985(<>Lst_files; *; "file.comment"; $Ptr_object->)
		
		//================================ /File
		
		//================================ Advanded
		//drop string format (compatibility)
		DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "drop-syntax"; $Lon_dummy)
		(OBJECT Get pointer:C1124(Object named:K67:5; "drop_string"))->:=$Lon_dummy
		(OBJECT Get pointer:C1124(Object named:K67:5; "drop_resname"))->:=1-$Lon_dummy
		
		//look metal
		//PREFERENCES ("look";OBJECT Get pointer(Object named;"look.metal"))
		//PLATFORM PROPERTIES($Lon_platform)
		//OBJECT SET ENABLED(*;"look.metal";$Lon_platform=Mac OS)
		//================================ /Advanded
		
		//================================ Completion
		PREFERENCES("resname-auto-fill"\
			; OBJECT Get pointer:C1124(Object named:K67:5; "ignored_characters")\
			; OBJECT Get pointer:C1124(Object named:K67:5; "max_resname_size"))
		
		//================================ /Completion
		
		If (<>xliff_Lon_Preference_Page>0)
			
			//win_RESIZE_FROM_PAGE (<>xliff_Lon_Preference_Page)
			
			//SELECT LIST ITEMS BY REFERENCE(<>Lst_Preferences;<>xliff_Lon_Preference_Page)
			//FORM GOTO PAGE(<>xliff_Lon_Preference_Page)
			
		Else 
			
			OBJECT GET COORDINATES:C663(*; "Page."+String:C10(<>xliff_Lon_Preference_Page); $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
			OBJECT MOVE:C664(*; "Page.Selected"; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom; *)
			
		End if 
		
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($Lon_formEvent=On Page Change:K2:54)
		
		<>xliff_Lon_Preference_Page:=FORM Get current page:C276
		
		win_RESIZE_FROM_PAGE(<>xliff_Lon_Preference_Page)
		OBJECT GET COORDINATES:C663(*; "Page."+String:C10(<>xliff_Lon_Preference_Page); $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
		OBJECT MOVE:C664(*; "Page.Selected"; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom; *)
		
		//______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		If (<>xliff_Lon_Preference_Page>0)
			
			FORM GOTO PAGE:C247(<>xliff_Lon_Preference_Page)
			OBJECT GET COORDINATES:C663(*; "Page."+String:C10(<>xliff_Lon_Preference_Page); $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
			OBJECT MOVE:C664(*; "Page.Selected"; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom; *)
			
		End if 
		
		If (FORM Get current page:C276=1)
			
			DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "target_folder"; $Txt_targetFolderPath)
			
			If (Length:C16($Txt_targetFolderPath)=0)
				
				XLIFF_EDITOR_PROPERTIES("targetFolder")
				
			End if 
		End if 
		
		//______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "target_folder"; $Txt_targetFolderPath)
		
		If (<>bEscape=0)
			
			xliff_Property_Group("Set"; "prefix"; <>bR_4=1; <>Txt_prefix)
			xliff_Property_Group("Set"; "separator"; Length:C16(<>Txt_prefixSeparator)>0; <>Txt_prefixSeparator)
			xliff_Property_Group("Set"; "autofill"; <>cb_1=1; "true")
			
			PREFERENCES("xliff.Set"\
				; OBJECT Get pointer:C1124(Object named:K67:5; "file.xliff.version")\
				; OBJECT Get pointer:C1124(Object named:K67:5; "file.xml.encoding"))
			
			If (Selected list items:C379(<>Lst_files)>0)
				
				SET LIST ITEM PARAMETER:C986(<>Lst_files; *; "file.version"; (OBJECT Get pointer:C1124(Object named:K67:5; "file.xliff.version"))->)
				SET LIST ITEM PARAMETER:C986(<>Lst_files; *; "file.encoding"; (OBJECT Get pointer:C1124(Object named:K67:5; "file.xml.encoding"))->)
				
			End if 
			
			PREFERENCES("default-values.Set"\
				; OBJECT Get pointer:C1124(Object named:K67:5; "01.Comment.App.Scroll.Box"))
			
			PREFERENCES("resname-auto-fill.Set"\
				; OBJECT Get pointer:C1124(Object named:K67:5; "ignored_characters")\
				; OBJECT Get pointer:C1124(Object named:K67:5; "max_resname_size"))
			
			DOM SET XML ATTRIBUTE:C866(<>Dom_object; \
				"ignored_characters"; (OBJECT Get pointer:C1124(Object named:K67:5; "ignored_characters"))->\
				; "max_resname_size"; (OBJECT Get pointer:C1124(Object named:K67:5; "max_resname_size"))->)
			
			$Ptr_object:=OBJECT Get pointer:C1124(Object named:K67:5; "drop_string")
			PREFERENCES("dropInForm.Set"; $Ptr_object)
			DOM SET XML ATTRIBUTE:C866(<>Dom_object; "drop-syntax"; $Ptr_object->)
			
			//$Ptr_object:=OBJECT Get pointer(Object named;"look.metal")
			//PREFERENCES ("look.Set";$Ptr_object)
			
			ARRAY TEXT:C222($tTxt_languageCodes; 0x0000)
			LIST TO ARRAY:C288("managed_language_codes"; $tTxt_languageCodes)
			
			If (<>Txt_sourceLang#$tTxt_languageCodes{<>tTxt_Sources})\
				 | (<>Txt_targetLang#$tTxt_languageCodes{<>tTxt_Targets})
				
				<>Txt_sourceLang:=$tTxt_languageCodes{<>tTxt_Sources}
				<>Txt_targetLang:=$tTxt_languageCodes{<>tTxt_Targets}
				PREFERENCES("database.language.Set"; -><>Txt_sourceLang; -><>Txt_targetLang)
				form_timerEvent(2)
				
			End if 
			
			If (Not:C34(env_Boo_Is_a_Component))
				
				PREFERENCES("database.target"; ->$Txt_Buffer)
				
				If ($Txt_Buffer#$Txt_targetFolderPath)
					
					PREFERENCES("database.target.Set"; ->$Txt_targetFolderPath)
					
					If (Is a list:C621(<>Lst_files))
						
						CLEAR LIST:C377(<>Lst_files; *)
						
					End if 
					
					<>Lst_files:=0
					
					If (Is a list:C621(<>Lst_strings))
						
						CLEAR LIST:C377(<>Lst_strings; *)
						
					End if 
					
					<>Lst_strings:=0
					
				End if 
			End if 
		End if 
		
		//______________________________________________________
End case 