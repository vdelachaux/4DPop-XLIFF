//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : env_Txt_HostFolder
// Created 12/01/07 by vdl
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_i)
C_TEXT:C284($kTxt_Separator; $Txt_EntryPoint; $Txt_Path)

$Txt_EntryPoint:=$1

$kTxt_Separator:=System folder:C487[[Length:C16(System folder:C487)]]

//Get the database folder path
$Txt_Path:=Structure file:C489(*)
For ($Lon_i; Length:C16($Txt_Path); 1; -1)
	If ($Txt_Path[[$Lon_i]]=$kTxt_Separator)
		$Txt_Path:=Substring:C12($Txt_Path; 1; $Lon_i)
		$Lon_i:=0
	End if 
End for 

If (Count parameters:C259>0)
	//Append folder
	$Txt_Path:=$Txt_Path+$Txt_EntryPoint+$kTxt_Separator
End if 

$0:=$Txt_Path
