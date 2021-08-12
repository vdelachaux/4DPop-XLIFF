//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : FILE_GetLastItemFromPath
// Created 05/02/07 by vdl
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_Found)
C_LONGINT:C283($Lon_Size; $Lon_x)
C_TEXT:C284($kTxt_Separator; $Txt_Path)

$kTxt_Separator:=System folder:C487[[Length:C16(System folder:C487)]]

If (Count parameters:C259=1)
	
	$Txt_Path:=$1
	
	If (Length:C16($Txt_Path)>0) & (Position:C15($kTxt_Separator; $Txt_Path)>0)
		
		$Lon_Size:=Length:C16($Txt_Path)
		If ($Txt_Path[[$Lon_Size]]=$kTxt_Separator)
			$Lon_Size:=$Lon_Size-1  //si c'est un dossier on remonte d'un cran
		End if 
		
		While ($Lon_Size>0) & ($Boo_Found=False:C215)  //on remonte la chaine jusqu'a trouver un autre séparateur
			If ($Txt_Path[[$Lon_Size]]=$kTxt_Separator)
				$Boo_Found:=True:C214
			Else 
				$Lon_Size:=$Lon_Size-1
			End if 
		End while 
		If ($Boo_Found)
			$Txt_Path:=Substring:C12($Txt_Path; $Lon_Size+1)  //last item (si c'est un dossier ca restera un dossier (finira par un séparateur)
		End if 
	End if 
End if 

$0:=$Txt_Path
