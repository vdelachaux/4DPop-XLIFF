//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : XLIFF_EDITOR_PROPERTIES
// Created 06/08/07 by Vincent de Lachaux
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($Lon_Bottom; $Lon_dummy; $Lon_Event; $Lon_Height; $Lon_i; $Lon_Left; $Lon_platform; $Lon_Right)
C_LONGINT:C283($Lon_Tittle_Right; $Lon_Top; $Lon_Width; $Lon_Window; $Lon_x)
C_POINTER:C301($Ptr_object)
C_TEXT:C284($Txt_Buffer; $Txt_Entrypoint; $Txt_Format; $Txt_Object; $Txt_targetFolderPath)

ARRAY TEXT:C222($tTxt_Names; 0)

If (False:C215)
	C_TEXT:C284(XLIFF_EDITOR_PROPERTIES; $1)
End if 

$Txt_Entrypoint:=$1

Case of 
		
		
		//______________________________________________________
	: ($Txt_EntryPoint="targetFolder")
		
		If (Macintosh option down:C545)
			
			$Txt_targetFolderPath:=Get 4D folder:C485(Current resources folder:K5:16)
			
		Else 
			
			$Txt_targetFolderPath:=Select folder:C670(Get localized string:C991("SelectTheTargetResourceFolder"))
			
		End if 
		
		If (OK=1)
			
			//<>Txt_targetFolderPath:=$Txt_Target_Path
			DOM SET XML ATTRIBUTE:C866(<>Dom_object; "target_folder"; $Txt_targetFolderPath)
			
			OBJECT SET ENABLED:C1123(*; "File_Path"; True:C214)
			
			//doc_OBJET_LOCATION (<>Txt_targetFolderPath;"File_Path";Sur chargement)
			doc_OBJET_LOCATION($Txt_targetFolderPath; "File_Path"; On Load:K2:1)
			
		End if 
		
		//______________________________________________________
	: ($Txt_EntryPoint="dialog@")  //Preferences dialog
		
		<>xliff_Lon_Preference_Page:=0
		<>xliff_Lon_Preference_Page:=Num:C11(Replace string:C233($Txt_Entrypoint; "dialog_"; ""))
		
		$Txt_Format:="PREFERENCES"
		
		$Lon_Window:=Open form window:C675($Txt_Format; Sheet form window:K39:12; Horizontally centered:K39:1; 262144)  //;*)
		DIALOG:C40($Txt_Format)
		CLOSE WINDOW:C154
		
		form_timerEvent(form_timerEvent; -1)
		
		//______________________________________________________
	Else 
		TRACE:C157
		//______________________________________________________
End case 

