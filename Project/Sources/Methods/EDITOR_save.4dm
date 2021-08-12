//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : EDITOR_SAVE
// ID[8B3621D7A5FB46E189D7DC7D33AD69E7]
// Created 30/03/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($Boo_fromMenu; $Boo_modified; $Boo_ok; $Boo_save)
C_LONGINT:C283($Lon_buffer; $Lon_fileRef; $Lon_parameters; $Lon_typeEditor)
C_POINTER:C301($Ptr_currentFile)
C_TEXT:C284($Txt_entryPoint; $Txt_fileName)

If (False:C215)
	C_BOOLEAN:C305(EDITOR_save; $0)
	C_TEXT:C284(EDITOR_save; $1)
	C_LONGINT:C283(EDITOR_save; $2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	If ($Lon_parameters>=1)
		
		$Txt_entryPoint:=Replace string:C233($1; "save"; "")
		
	End if 
	
	If ($Lon_parameters>=2)
		
		$Lon_fileRef:=$2
		
	Else 
		
		$Ptr_currentFile:=OBJECT Get pointer:C1124(Object named:K67:5; "current-file")
		
		//http://forums.4d.fr/Post/FR/16454692/1/16455688#16455688
		//$Lon_fileRef:=$Ptr_currentFile->
		If (Not:C34(Is nil pointer:C315($Ptr_currentFile)))
			
			$Lon_fileRef:=$Ptr_currentFile->
			
		End if 
	End if 
	
	$Boo_ok:=(Selected list items:C379(<>Lst_files)=0)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

If (Not:C34($Boo_ok))
	
	GET LIST ITEM PARAMETER:C985(<>Lst_files; $Lon_fileRef; "modified"; $Boo_modified)
	
	$Boo_ok:=Not:C34($Boo_modified)
	
	If (Not:C34($Boo_ok))
		
		$Boo_fromMenu:=($Txt_entryPoint="_menu@")
		
		GET LIST ITEM:C378(<>Lst_files; $Lon_fileRef; $Lon_buffer; $Txt_fileName)
		
		If ($Boo_fromMenu)
			
			$Txt_entryPoint:=Replace string:C233($Txt_entryPoint; "_menu"; "")
			
			$Boo_save:=True:C214
			$Boo_ok:=True:C214
			
		Else 
			
			CONFIRM:C162(Replace string:C233(Get localized string:C991("SaveModification"); "{file}"; $Txt_fileName)\
				; Get localized string:C991("SaveButton"); Get localized string:C991("CommonIgnore"))
			
			$Boo_save:=(OK=1)  //1 = OK
			$Boo_ok:=(OK#-1)  //-1 = Annuler
			
		End if 
		
		If ($Boo_save)
			
			XLIFF_EDITOR_SAVE_FILE($Lon_fileRef)
			
			If ($Boo_fromMenu)
				
				
			End if 
		End if 
		
		If ($Boo_ok)
			
			SET LIST ITEM PARAMETER:C986(<>Lst_files; *; "modified"; False:C215)
			
		End if 
	End if 
End if 

OBJECT SET VISIBLE:C603(*; "_Spinner"; False:C215)

Case of 
		//………………………………
	: (Not:C34($Boo_ok))
		
		//………………………………
	: ($Txt_entryPoint="_validate")
		
		EDITOR_Boo_handler("validate_file")
		
		//………………………………
	: ($Txt_entryPoint="_switch")
		
		DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "editor"; $Lon_typeEditor)
		DOM SET XML ATTRIBUTE:C866(<>Dom_object; "editor"; 1+Num:C11($Lon_typeEditor=1))
		
		CANCEL:C270
		
		//………………………………
	: ($Txt_entryPoint="_close")
		
		DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "editor"; $Lon_typeEditor)
		DOM SET XML ATTRIBUTE:C866(<>Dom_object; "editor"; -$Lon_typeEditor)
		
		CANCEL:C270
		
		//………………………………
End case 

If ($Boo_ok)
	
	DISABLE MENU ITEM:C150(1; 3)
	DISABLE MENU ITEM:C150(1; 4)
	
End if 

$0:=$Boo_ok

// ----------------------------------------------------
// End