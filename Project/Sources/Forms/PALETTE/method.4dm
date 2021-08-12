C_BOOLEAN:C305($Boo_quit; $Boo_visible)
C_LONGINT:C283($Lon_; $Lon_Attributes; $Lon_Bottom; $Lon_dummy; $Lon_Event; $Lon_i; $Lon_Left; $Lon_Offset; $Lon_origin; $Lon_Parent)
C_LONGINT:C283($Lon_ref; $Lon_Right; $Lon_state; $Lon_Tempo_Minuteur; $Lon_time; $Lon_timer; $Lon_timerEvent; $Lon_Top; $Lon_typeEditor; $Lon_UID)
C_LONGINT:C283($Lon_x)
C_POINTER:C301($Ptr_Array)
C_TEXT:C284($Txt_Buffer; $Txt_Element; $Txt_Name; $Txt_Path; $Txt_Value)


$Lon_Tempo_Minuteur:=-1

$Lon_Event:=$Lon_Event+(Form event code:C388*Num:C11($Lon_Event=0))

Case of   //……………………………………………………………………………
	: ($Lon_Event=On Load:K2:1)
		
		//OBJET FIXER BARRES DEFILEMENT(<>Txt_Source;Faux;Faux)
		//OBJET FIXER BARRES DEFILEMENT(<>Txt_Target;Faux;Faux)
		
		//OBJET FIXER SAISISSABLE(<>Txt_ID;Faux)
		//OBJET FIXER SAISISSABLE(<>Txt_Resname;Faux)
		//OBJET FIXER SAISISSABLE(<>Txt_Source;Faux)
		//OBJET FIXER SAISISSABLE(<>Txt_Target;Faux)
		//INACTIVER BOUTON(<>bNoTranslate)
		//INACTIVER BOUTON(<>bSort)
		
		//<>Lon_Window_Type:=Lon_typeEditorWindow
		//Lon_typeEditorWindow:=-<>Lon_Window_Type
		
		//Si (<>Lon_Window_Type=1)  //Editor window
		//
		//  //Si (<>Lon_Platform=Windows) | <>Boo_VISTA
		//  //
		//  //<>Lon_Editor_Onglet:=Nouvelle liste
		//  //AJOUTER A LISTE(<>Lon_Editor_Onglet;Lire traduction chaine("EditionButton");1)
		//  //AJOUTER A LISTE(<>Lon_Editor_Onglet;Lire traduction chaine("SourceButton");2)
		//  //
		//  //  //Si (<>Boo_VISTA)
		//  //  //CHANGER PROPRIETES LISTE(<>Lst_files;1;0;28)
		//  //  //CHANGER PROPRIETES LISTE(<>XLIFF_Lst_units;1;-1)
		//  //  //Fin de si
		//  //
		//  //Sinon
		//
		//  //Set preference's apparence
		//PREFERENCES ("look";->$Lon_Metal)
		//Si ($Lon_Metal>0)
		//OBJET FIXER VISIBLE(*;"Header.Background";Faux)
		//  //CHOIX VISIBLE(*;"File.List.Top";Faux)
		//OBJET FIXER VISIBLE(*;"Foot_R";Faux)
		//OBJET FIXER VISIBLE(*;"Foot_Left";Faux)
		//OBJET FIXER VISIBLE(*;"info.bottom";Faux)
		//OBJET FIXER VISIBLE(*;"_Background";Faux)
		//Fin de si
		//
		//  //Put offscreen the infos' splitter
		//OBJET DEPLACER(*;"Splitter.Infos";-1000;-1000;-1000;-1000;*)
		//
		//  //Fin de si
		//
		//  //Set the Vertical splitter to the saved position
		//OBJET LIRE COORDONNEES(*;"Splitter.Vertical";$Lon_Left;$Lon_Top;$Lon_Right;$Lon_Bottom)
		//PREFERENCES ("splitter.v";->$Lon_Right)
		//<>bSplitter_Vertical:=$Lon_Right-$Lon_Left
		//Obj_CENTER ("splitter.horizontal.hanchor";"list.unit";Centrée horizontalement;<>bSplitter_Vertical)
		//  //Set the Horizontal splitter to the saved position
		//OBJET LIRE COORDONNEES(*;"splitter.horizontal";$Lon_Left;$Lon_Top;$Lon_Right;$Lon_Bottom)
		//PREFERENCES ("splitter.h";->$Lon_Bottom)
		//<>bSplitter_Horizontal:=$Lon_Bottom-$Lon_Top
		//
		//OBJET FIXER VISIBLE(*;"_Spinner";Vrai)
		//
		//Fin de si
		
		<>Boo_displayAttributs:=False:C215
		
		form_timerEvent(-1; 10)
		
		//……………………………………………………………………………
	: ($Lon_Event=On Outside Call:K2:11)
		
		If (<>Boo_quit)
			
			SET TIMER:C645(0)
			
			CANCEL:C270
			
		End if 
		
		//……………………………………………………………………………
	: ($Lon_Event=On Timer:K2:25)
		SET TIMER:C645(0)
		
		$Lon_timerEvent:=form_timerEvent
		$Lon_timer:=-1
		
		Case of 
				//.....................................................
			: ($Lon_timerEvent=-1)  //Initializes   
				
				//Create the xliff files' list
				//If (<>Lst_files=0)
				
				//EDITOR_Boo_handler ("Init")
				//  //Si (<>Lon_Platform=Windows)
				//  //  //Si (<>Boo_VISTA)
				//  //  //CHANGER PROPRIETES LISTE(<>Lst_files;0;0;28)
				//  //  //Fin de si 
				//  //Fin de si 
				
				//End if 
				
				//Create the xliff files' list if any
				If (Not:C34(Is a list:C621(<>Lst_files)))
					
					EDITOR_GET_FILE_LIST
					
				End if 
				
				GOTO OBJECT:C206(<>Lst_files)
				
				//Get and select the last used file
				PREFERENCES("file"; ->$Txt_buffer)
				$Lon_ref:=Find in list:C952(<>Lst_files; $Txt_buffer; 1; *)
				SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_files; Choose:C955($Lon_ref#0; $Lon_ref; 1))
				
				//Do update the vertical scroolbar of lists
				//Lsth_DISPLAY_SCROLLBAR (-><>Lst_files)
				
				GET WINDOW RECT:C443($Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom; Current form window:C827)
				If ($Lon_Top<0)
					$Lon_Bottom:=$Lon_Bottom+Abs:C99($Lon_Top)
					$Lon_Top:=0
				End if 
				If ($Lon_Top<(Menu bar height:C440+Tool bar height:C1016+30))
					$Lon_Offset:=$Lon_Bottom-$Lon_Top
					$Lon_Top:=Menu bar height:C440+Tool bar height:C1016+30
					$Lon_Bottom:=$Lon_Top+$Lon_Offset
					SET WINDOW RECT:C444($Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom; Current form window:C827)
				End if 
				
				//Do parses selected current file
				form_timerEvent(1; 20)
				//<>Lon_timerEvent:=1
				//$Lon_Tempo_Minuteur:=20
				
				//.....................................................
			: ($Lon_timerEvent=1)  //Parses the current selected file
				
				EDITOR_LOAD_FILE
				
				//OBJET FIXER VISIBLE(*;"unit@";Faux)
				//
				//INFORMATION ELEMENT(<>Lst_files;*;$Lon_Reference;$Txt_Buffer)
				//Si ($Lon_Reference#0)
				//Si ($Lon_Reference#<>Lon_currentFile)
				//Si (EDITOR_save ("save"))
				//<>Lon_currentFile:=$Lon_Reference
				//SUPPRIMER DANS TABLEAU(<>tTxt_dumpLines;1;Taille tableau(<>tTxt_dumpLines))
				//Sinon 
				//$Lon_Reference:=0
				//Fin de si 
				//Fin de si 
				//Fin de si 
				//
				//Si ($Lon_Reference#0)
				//<>Txt_Search:=""
				//  //<>Txt_Source:=""
				//  //<>Txt_Target:=""
				//<>Txt_ID:=""
				//<>Txt_Resname:=""
				//<>Txt_fileDump:=""
				//<>bNoTranslate:=0
				//<>Txt_CurrentFileName:=$Txt_Buffer
				//OBJET FIXER TITRE(<>bFiles;$Txt_Buffer)
				//
				//Si (Liste existante(<>Lst_strings))
				//SUPPRIMER LISTE(<>Lst_strings;*)
				//Fin de si 
				//
				//Si (<>Lon_currentFile#0)
				//
				//LIRE PARAMETRE ELEMENT(<>Lst_files;<>Lon_currentFile;"fullpath";$Txt_Path)
				//<>Lst_strings:=XLIFF_parseFile ($Txt_Path)
				//
				//  //Default values for xliff
				//EDITOR_Boo_handler ("default_xliff_attributes";-><>tTxt_xliff_attributeNames;-><>tTxt_xliff_attributeValues)
				//
				//  //Default values for file
				//EDITOR_Boo_handler ("default_file_attributes";-><>tTxt_file_attributeNames;-><>tTxt_file_attributeValues)
				//
				//$Lon_x:=Chercher dans tableau(<>tTxt_prop_groupNames;"resname-prefix")
				//Si ($Lon_x>0)
				//<>Txt_prefix:=<>tTxt_prop_groupValues{$Lon_x}
				//Sinon 
				//<>Txt_prefix:=""
				//Fin de si 
				//
				//$Lon_x:=Chercher dans tableau(<>tTxt_prop_groupNames;"resname-separator")
				//Si ($Lon_x>0)
				//<>Txt_prefixSeparator:=<>tTxt_prop_groupValues{$Lon_x}
				//Sinon 
				//<>Txt_prefixSeparator:=""
				//Fin de si 
				//
				//$Lon_x:=Chercher dans tableau(<>tTxt_file_attributeNames;"source-language")
				//Si ($Lon_x>0)
				//<>Txt_sourceLanguage:=Sous chaine(<>tTxt_file_attributeValues{$Lon_x};1;2)
				//Sinon 
				//<>Txt_sourceLanguage:=<>Txt_sourceLang
				//Fin de si 
				//OBJET FIXER FORMATAGE(*;"unit_source_icon@";";#;#Images/Lang_"+Chaine(Chercher dans tableau(<>tTxt_languageCodes;<>Txt_sourceLanguage);"00")+".gif;;;;1966;;;;")
				//
				//$Lon_x:=Chercher dans tableau(<>tTxt_file_attributeNames;"target-language")
				//Si ($Lon_x>0)
				//<>Txt_targetLanguage:=Sous chaine(<>tTxt_file_attributeValues{$Lon_x};1;2)
				//Sinon 
				//<>Txt_targetLanguage:=<>Txt_targetLang
				//Fin de si 
				//OBJET FIXER FORMATAGE(*;"unit_target_icon.move";";#;#Images/Lang_"+Chaine(Chercher dans tableau(<>tTxt_languageCodes;<>Txt_targetLanguage);"00")+".gif;;;;1966;;;;")
				//
				//Si (FORM Lire page courante=2)
				//EDITOR_Boo_handler ("dump")
				//Sinon 
				//REDESSINER FENETRE
				//Fin de si 
				//
				//Sinon 
				//
				//<>Lst_strings:=Nouvelle liste
				//
				//Fin de si 
				//
				//INACTIVER LIGNE MENU(1;3)
				//INACTIVER LIGNE MENU(1;4)
				//
				//Sinon 
				//
				//SELECTIONNER ELEMENTS PAR REFERENCE(<>Lst_files;<>Lon_currentFile)
				//
				//Fin de si 
				//
				//EDITOR_SCREEN_UPDATE 
				//Lsth_DISPLAY_SCROLLBAR (-><>Lst_strings)
				//OBJET FIXER VISIBLE(*;"_Spinner";Faux)
				
				form_timerEvent(1; -1)
				
				//.....................................................
			: ($Lon_timerEvent=2)  //Displays the current selected element
				//<>Txt_Source:=""
				//<>Txt_Target:=""
				<>Txt_ID:=""
				<>Txt_Resname:=""
				<>bNoTranslate:=0
				
				DELETE FROM ARRAY:C228(<>tTxt_attributeNames; 1; Size of array:C274(<>tTxt_attributeNames))
				DELETE FROM ARRAY:C228(<>tTxt_attributeValues; 1; Size of array:C274(<>tTxt_attributeValues))
				
				If (Selected list items:C379(<>Lst_strings)>0)
					
					OBJECT SET ENTERABLE:C238(<>Txt_ID; True:C214)
					OBJECT SET ENTERABLE:C238(<>Txt_Resname; True:C214)
					
					GET LIST ITEM:C378(<>Lst_strings; *; $Lon_ref; <>Txt_Resname)
					
					$Lon_Parent:=List item parent:C633(<>Lst_strings; $Lon_ref)
					If ($Lon_Parent#0)  //trans-unit
						GET LIST ITEM:C378(<>Lst_strings; List item position:C629(<>Lst_strings; $Lon_Parent); $Lon_x; $Txt_Element)
						//Si ($Lon_x#Lon_Current_Group)
						//Lon_Current_Group:=$Lon_x
						//Fin de si
					End if 
					
					GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_ref; "_type"; $Txt_Value)
					If ($Txt_Value="group")
						$Ptr_Array:=-><>tTxt_group_Attribute_Names
					Else 
						$Ptr_Array:=-><>tTxt_unit_Attribute_Names
						
					End if 
					GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_ref; "_attributes.index"; $Lon_Attributes)
					For ($Lon_i; 1; Size of array:C274($Ptr_Array->); 1)
						If ($Lon_Attributes ?? $Lon_i)
							$Txt_Name:=$Ptr_Array->{$Lon_i}
							GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_ref; $Txt_Name; $Txt_Value)
							APPEND TO ARRAY:C911(<>tTxt_attributeNames; $Txt_Name)
							APPEND TO ARRAY:C911(<>tTxt_attributeValues; $Txt_Value)
							Case of 
									//………………………………
								: ($Txt_Name="id")
									<>Txt_ID:=$Txt_Value
									//………………………………
								: ($Txt_Name="resname")
									<>Txt_Resname:=$Txt_Value
									//………………………………
								: ($Txt_Name="translate")
									<>bNoTranslate:=Num:C11($Txt_Value="no")
									//………………………………
							End case 
						End if 
					End for 
					
				End if 
				
				EDITOR_SCREEN_UPDATE
				//.....................................................
			: ($Lon_timerEvent=200)  //Open/Close info+
				$Boo_visible:=Not:C34(OBJECT Get visible:C1075(*; "info.bottom"))
				
				OBJECT GET COORDINATES:C663(*; "info.bottom"; $Lon_; $Lon_top; $Lon_; $Lon_bottom)
				OBJECT GET COORDINATES:C663(*; "info.header"; $Lon_; $Lon_top; $Lon_; $Lon_)
				$Lon_offset:=$Lon_bottom-$Lon_top
				
				If ($Boo_visible)
					
					$Lon_offset:=-$Lon_offset
					
				End if 
				
				OBJECT MOVE:C664(*; "@Info._Resize"; 0; 0; 0; $Lon_offset)
				OBJECT MOVE:C664(*; "info.@"; 0; $Lon_offset)
				
				OBJECT SET VISIBLE:C603(*; "info.bottom"; $Boo_visible)
				OBJECT SET VISIBLE:C603(*; "Close.Info"; $Boo_visible)
				
				//Lsth_DISPLAY_SCROLLBAR (-><>Lst_strings)
				
				//.....................................................
			: ($Lon_timerEvent=100)  //Backup
				//XLIFF_EDITOR_Boo_Main (Dial_Txt_Action)
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
				
		End case 
		
		$Lon_timerEvent:=form_timerEvent
		form_timerEvent($Lon_timerEvent; Choose:C955($Lon_timerEvent#0; $Lon_timer; 60*5*Num:C11(env_Boo_Is_a_Component)))
		
		//……………………………………………………………………………
	: ($Lon_Event=On Menu Selected:K2:14)
		
		EDITOR_MENUS("execute")
		
		//……………………………………………………………………………
	: ($Lon_Event=On Resize:K2:27)
		
		//Do update the vertical scroolbar of lists
		//Lsth_DISPLAY_SCROLLBAR (-><>Lst_files)
		//Lsth_DISPLAY_SCROLLBAR (-><>Lst_strings)
		
		//……………………………………………………………………………
	: ($Lon_Event=On Close Box:K2:21)
		
		DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "editor"; $Lon_typeEditor)
		DOM SET XML ATTRIBUTE:C866(<>Dom_object; "editor"; -$Lon_typeEditor)
		
		CANCEL:C270
		
		//……………………………………………………………………………
	: ($Lon_Event=On Unload:K2:2)
		
		//EFFACER VARIABLE(<>Txt_Source)
		//EFFACER VARIABLE(<>Txt_Target)
		CLEAR VARIABLE:C89(<>Txt_ID)
		CLEAR VARIABLE:C89(<>Txt_Resname)
		CLEAR VARIABLE:C89(<>Txt_fileDump)
		CLEAR VARIABLE:C89(<>bNoTranslate)
		//EFFACER VARIABLE(<>Lon_currentFile)
		
		//Keep the current file
		GET LIST ITEM:C378(<>Lst_files; *; $Lon_dummy; $Txt_buffer)
		PREFERENCES("file.Set"; ->$Txt_buffer)
		
		//……………………………………………………………………………
End case 