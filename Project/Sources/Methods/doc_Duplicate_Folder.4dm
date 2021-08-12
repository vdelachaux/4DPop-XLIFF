//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : doc_Duplicate_Folder
// Created 19/05/07 by Vincent de Lachaux
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_i)
C_TEXT:C284($kTxt_Separator; $Txt_Source_Path; $Txt_Target_Path)

ARRAY TEXT:C222($tTxt_Files; 0)
ARRAY TEXT:C222($tTxt_Folders; 0)

If (False:C215)
	C_TEXT:C284(doc_Duplicate_Folder; $1)
	C_TEXT:C284(doc_Duplicate_Folder; $2)
End if 

$Txt_Source_Path:=$1
$Txt_Target_Path:=$2
$kTxt_Separator:=Get 4D folder:C485[[Length:C16(Get 4D folder:C485)]]

If (Test path name:C476($Txt_Source_Path)=Is a folder:K24:2)
	
	If (Test path name:C476($Txt_Target_Path)#Is a folder:K24:2)
		CREATE FOLDER:C475($Txt_Target_Path)
	End if 
	
	If (OK=1)
		
		DOCUMENT LIST:C474($Txt_Source_Path; $tTxt_Files)
		For ($Lon_i; 1; Size of array:C274($tTxt_Files); 1)
			COPY DOCUMENT:C541($Txt_Source_Path+$tTxt_Files{$Lon_i}; $Txt_Target_Path+$tTxt_Files{$Lon_i})
			If (OK=0)
				$Lon_i:=Size of array:C274($tTxt_Files)+1
			End if 
		End for 
		
		If (OK=1)
			FOLDER LIST:C473($Txt_Source_Path; $tTxt_Folders)
			For ($Lon_i; 1; Size of array:C274($tTxt_Folders); 1)
				doc_Duplicate_Folder($Txt_Source_Path+$tTxt_Folders{$Lon_i}+$kTxt_Separator; $Txt_Target_Path+$tTxt_Folders{$Lon_i}+$kTxt_Separator)
				If (OK=0)
					$Lon_i:=Size of array:C274($tTxt_Folders)+1
				End if 
			End for 
		End if 
	End if 
	
Else 
	
	OK:=0
	
End if 
