//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : util_getResourceImage
// Created 08/08/07 by Vincent de Lachaux
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
C_PICTURE:C286($0)
C_TEXT:C284($1)

C_PICTURE:C286($Pic_buffer)
C_TEXT:C284($Txt_path)

If (False:C215)
	C_PICTURE:C286(util_getResourceImage; $0)
	C_TEXT:C284(util_getResourceImage; $1)
End if 

$Txt_path:=Get 4D folder:C485(Current resources folder:K5:16)

$Txt_path:=$Txt_path+$1
$Txt_path:=Replace string:C233($Txt_path; "/"; Folder separator:K24:12)

If (Test path name:C476($Txt_path)=Is a document:K24:1)
	
	READ PICTURE FILE:C678($Txt_path; $Pic_buffer)
	
	If (OK=1)
		
		$0:=$Pic_buffer
		
	End if 
End if 