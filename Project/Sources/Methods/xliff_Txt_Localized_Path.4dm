//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : xliff_Txt_Localized_Path
// Created 20/01/07 by Vincent de Lachaux
// Modified 26/01/07 by Vincent de Lachaux
// - Allow to return the localized path for the ".lproj" folder
// ----------------------------------------------------
// Description
// Return the localized full path for a xliff file if $1 specified
// or the localized path for the ".lproj" folder if $1 is not specified
// ----------------------------------------------------
// Syntax
// xliff_Txt_Localized_Path {(FileName)} -> String
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_OK)
C_LONGINT:C283($Lon_i; $Lon_Parameters)
C_TEXT:C284($Txt_File; $Txt_Path; $kTxt_Separator)

If (False:C215)
	C_TEXT:C284(xliff_Txt_Localized_Path; $0)
	C_TEXT:C284(xliff_Txt_Localized_Path; $1)
End if 

$Lon_Parameters:=Count parameters:C259
If ($Lon_Parameters>0)
	$Txt_File:=$1
End if 

$kTxt_Separator:=System folder:C487[[Length:C16(System folder:C487)]]

//Get the database folder path
$Txt_Path:=Structure file:C489

For ($Lon_i; Length:C16($Txt_Path); 1; -1)
	If ($Txt_Path[[$Lon_i]]=$kTxt_Separator)
		$Txt_Path:=Substring:C12($Txt_Path; 1; $Lon_i)
		$Lon_i:=0
	End if 
End for 

//Append resources folder
$Txt_Path:=$Txt_Path+"Resources"+$kTxt_Separator
$Boo_OK:=(Test path name:C476($Txt_Path)=Is a folder:K24:2)

$Txt_Path:=Get 4D folder:C485(Current resources folder:K5:16)
$kTxt_Separator:=$Txt_Path[[Length:C16($Txt_Path)]]

//Append localized .lproj folder
If ($Boo_OK)
	C_TEXT:C284($0)
	C_TEXT:C284($1)
	
	C_BOOLEAN:C305($Boo_OK)
	C_LONGINT:C283($Lon_i; $Lon_Parameters)
	C_TEXT:C284($kTxt_Separator; $Txt_File; $Txt_Langue; $Txt_Path)
	If (Command name:C538(215)="False")
		//US
		$Txt_Path:=$Txt_Path+"English.lproj"+$kTxt_Separator
		$Boo_OK:=(Test path name:C476($Txt_Path)=Is a folder:K24:2)
		If (Not:C34($Boo_OK))
			$Txt_Path:=Replace string:C233($Txt_Path; "English.lproj"; "En.lproj")
			$Boo_OK:=(Test path name:C476($Txt_Path)=Is a folder:K24:2)
		End if 
	Else 
		//FR
		$Txt_Path:=$Txt_Path+"French.lproj"+$kTxt_Separator
		$Boo_OK:=(Test path name:C476($Txt_Path)=Is a folder:K24:2)
		If (Not:C34($Boo_OK))
			$Txt_Path:=Replace string:C233($Txt_Path; "French.lproj"; "Fr.lproj")
			$Boo_OK:=(Test path name:C476($Txt_Path)=Is a folder:K24:2)
		End if 
	End if 
End if 

//Append file
If ($Boo_OK) & (Length:C16($Txt_File)>0)  //26/01/06
	If ($Txt_File#"@.xlf")
		$Txt_File:=$Txt_File+".xlf"
	End if 
	$Txt_Path:=$Txt_Path+$Txt_File
	$Boo_OK:=(Test path name:C476($Txt_Path)=Is a document:K24:1)
End if 

If ($Boo_OK)
	$0:=$Txt_Path
End if 
