//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : util_PASTE
// Created 01/08/07 by Vincent de Lachaux
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
C_POINTER:C301($1)

C_LONGINT:C283($Lon_End; $Lon_Start)
C_POINTER:C301($Ptr_Object)
C_TEXT:C284($Txt_Buffer)

If (False:C215)
	C_POINTER:C301(util_PASTE; $1)
End if 

$Ptr_Object:=$1
$Txt_Buffer:=Get text from pasteboard:C524
If (Length:C16($Txt_Buffer)>0)
	GET HIGHLIGHT:C209($Ptr_Object->; $Lon_Start; $Lon_End)
	$Ptr_Object->:=Substring:C12(Get edited text:C655; 1; $Lon_Start-1)+$Txt_Buffer+Substring:C12(Get edited text:C655; $Lon_End)
	$Lon_End:=$Lon_Start+Length:C16($Txt_Buffer)
	HIGHLIGHT TEXT:C210($Ptr_Object->; $Lon_End; $Lon_End)
End if 
