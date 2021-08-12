//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : XLIFF_EDITOR_INFORMATIONS
// Created 08/08/07 by Vincent de Lachaux
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
C_TEXT:C284($1)

C_BLOB:C604($Blb_Buffer)
C_BOOLEAN:C305($Boo_Invisible; $Boo_Locked)
C_DATE:C307($Dat_Created; $Dat_Modified)
C_LONGINT:C283($Lon_Event; $Lon_File; $Lon_Group; $Lon_Type; $Lon_Unit; $Lon_Window)
C_TIME:C306($Gmt_Created; $Gmt_Modified)
C_TEXT:C284($Txt_Buffer; $Txt_Entrypoint; $Txt_Format)

If (False:C215)
	C_TEXT:C284(XLIFF_EDITOR_INFORMATIONS; $1)
End if 

$Txt_Entrypoint:=$1

Case of 
		//______________________________________________________
	: ($Txt_Entrypoint="FORM_METHOD")
		
		$Lon_Event:=Form event code:C388
		
		Case of 
				//.....................................................    
			: ($Lon_event=On Load:K2:1)
				
				Obj_CENTER("00_Hanchor_1"; "xliff_group"; Horizontally centered:K39:1)
				OBJECT MOVE:C664(*; "00_Splitter_Stop_@"; -10; 0)
				
				GET LIST ITEM PARAMETER:C985(<>Lst_files; *; "fullpath"; <>Txt_CurrentFile_Path)
				GET DOCUMENT PROPERTIES:C477(<>Txt_CurrentFile_Path; $Boo_Locked; $Boo_Invisible; $Dat_Created; $Gmt_Created; $Dat_Modified; $Gmt_Modified)
				<>Txt_Creation:=String:C10($Dat_Created)+" à "+String:C10($Gmt_Created)
				<>Txt_Modification:=String:C10($Dat_Modified)+" à "+String:C10($Gmt_Modified)
				<>Txt_Size:=doc_gTxt_BytesToString(Get document size:C479(<>Txt_CurrentFile_Path))
				If (Position:C15(Get localized string:C991("Bytes"); <>Txt_Size)=0)
					<>Txt_Size:=<>Txt_Size+" ("+doc_gTxt_BytesToString(Get document size:C479(<>Txt_CurrentFile_Path); "O")+")"
				End if 
				doc_OBJET_LOCATION(<>Txt_CurrentFile_Path; "File_Path"; On Load:K2:1; Align center:K42:3)
				DOCUMENT TO BLOB:C525(<>Txt_CurrentFile_Path; $Blb_Buffer)
				If (OK=1)
					$Txt_Buffer:=BLOB to text:C555($Blb_Buffer; Mac text without length:K22:10)
					$Lon_File:=str_gLon_Occurence_Number($Txt_Buffer; "<file ")
					$Lon_Group:=str_gLon_Occurence_Number($Txt_Buffer; "<group ")
					$Lon_Unit:=str_gLon_Occurence_Number($Txt_Buffer; "<trans-unit ")
					<>Txt_Buffer:="Nb file : "+String:C10($Lon_File)+"\rNb group : "+String:C10($Lon_Group)+"\rNb trans-unit : "+String:C10($Lon_Unit)
				End if 
				
				<>Lon_Onglet:=Load list:C383("File_Infos")
				//.....................................................    
			: ($Lon_event=On Unload:K2:2)
				If (Is a list:C621(<>Lon_Onglet))
					CLEAR LIST:C377(<>Lon_Onglet; *)
				End if 
				//.....................................................    
			: ($Lon_event=On Resize:K2:27)
				Obj_CENTER("00_Hanchor_1"; "xliff_group"; Horizontally centered:K39:1)
				//.....................................................    
		End case 
		
		
		//______________________________________________________
	Else 
		TRACE:C157
		//______________________________________________________
End case 
