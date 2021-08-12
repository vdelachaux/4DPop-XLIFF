//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : XLIFF_EDITOR_DELETE
// ID[8283ECE645E0468CB1BBA80D43171940]
// Created 26/03/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Deletion of a file, group or trans-unit
// ----------------------------------------------------
// Declarations
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_expanded)
C_LONGINT:C283($Lon_groupCount; $Lon_parameters; $Lon_ref; $Lon_unitCount; $Lst_unit)
C_PICTURE:C286($Pic_buffer; $Pic_delete)
C_TEXT:C284($Txt_name; $Txt_target; $Txt_Target_Path)

If (False:C215)
	C_TEXT:C284(EDITOR_DELETE; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	If ($Lon_parameters>=1)
		
		$Txt_target:=$1
		
	End if 
	
	If (Length:C16($Txt_target)=0)
		
		$Txt_target:=Choose:C955(OBJECT Get name:C1087(Object with focus:K67:3)="list.unit"; "delete_element"; "delete_file")
		
	End if 
	
	READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+"Images"+Folder separator:K24:12+"ListFatal.tiff"; $Pic_delete)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//……………………………………………………………
	: ($Txt_target="delete_element")
		
		GET LIST ITEM:C378(<>Lst_strings; *; $Lon_ref; $Txt_name; $Lst_unit; $Boo_expanded)
		
		GET LIST ITEM ICON:C951(<>Lst_strings; $Lon_ref; $Pic_buffer)
		SET LIST ITEM ICON:C950(<>Lst_strings; $Lon_ref; $Pic_delete)
		
		If ($Lon_ref<0)  //group
			
			//Are you sure that you want to delete the group "{groupname}" ?
			CONFIRM:C162(Replace string:C233(Get localized string:C991("DeleteGroup"); "{groupname}"; $Txt_name))
			
			If (OK=1)
				
				$Lon_groupCount:=(OBJECT Get pointer:C1124(Object named:K67:5; "count.group"))->
				$Lon_groupCount:=$Lon_groupCount-1
				(OBJECT Get pointer:C1124(Object named:K67:5; "count.group"))->:=$Lon_groupCount
				
				$Lon_unitCount:=(OBJECT Get pointer:C1124(Object named:K67:5; "count.unit"))->
				$Lon_unitCount:=$Lon_unitCount-Count list items:C380($Lst_unit; *)
				(OBJECT Get pointer:C1124(Object named:K67:5; "count.unit"))->:=$Lon_unitCount
				
			End if 
			
		Else   //trans-unit
			
			//Are you sure that you want to delete the item "{itemname}" ?
			CONFIRM:C162(Replace string:C233(Get localized string:C991("DeleteItem"); "{itemname}"; $Txt_name))
			
			If (OK=1)
				
				$Lon_unitCount:=(OBJECT Get pointer:C1124(Object named:K67:5; "count.unit"))->
				$Lon_unitCount:=$Lon_unitCount-1
				(OBJECT Get pointer:C1124(Object named:K67:5; "count.unit"))->:=$Lon_unitCount
				
			End if 
		End if 
		
		If (OK=1)
			
			lsth_DELETE_ITEM(<>Lst_strings; $Lon_ref)
			
			EDITOR_MODIFIED
			
			form_timerEvent(2; -1)
			
		Else 
			
			SET LIST ITEM ICON:C950(<>Lst_strings; $Lon_ref; $Pic_buffer)
			
		End if 
		
		//……………………………………………………………
	: ($Txt_target="delete_file")
		
		GET LIST ITEM:C378(<>Lst_files; *; $Lon_ref; $Txt_name; $Lst_unit; $Boo_expanded)
		
		GET LIST ITEM ICON:C951(<>Lst_files; $Lon_ref; $Pic_buffer)
		SET LIST ITEM ICON:C950(<>Lst_files; $Lon_ref; $Pic_delete)
		
		//Are you sure that you want to delete the file "{filename}" ?
		CONFIRM:C162(Replace string:C233(Get localized string:C991("DeleteFile"); "{filename}"; $Txt_name))
		
		If (OK=1)
			
			GET LIST ITEM PARAMETER:C985(<>Lst_files; $Lon_ref; "fullpath"; $Txt_Target_Path)
			
			If (Test path name:C476($Txt_Target_Path)=Is a document:K24:1)
				
				DELETE DOCUMENT:C159($Txt_Target_Path)
				
			End if 
			
			lsth_DELETE_ITEM(<>Lst_files; $Lon_ref)
			
			form_timerEvent(1; -1)
			
		Else 
			
			SET LIST ITEM ICON:C950(<>Lst_files; $Lon_ref; $Pic_buffer)
			
		End if 
		
		//________________________________________
End case 

// ----------------------------------------------------
// End