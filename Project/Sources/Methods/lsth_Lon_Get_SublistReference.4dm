//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : lsth_Lon_Get_SublistReference
// Created 18/08/06 by vdl
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
C_LONGINT:C283($0)
C_POINTER:C301($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($3)

C_LONGINT:C283($Lon_Reference; $Lon_SubList)
C_TEXT:C284($Txt_Item)
C_BOOLEAN:C305($Boo_Expanded)

If (Count parameters:C259>1)
	GET LIST ITEM:C378($1->; $2; $Lon_Reference; $Txt_Item; $Lon_SubList; $Boo_Expanded)
Else 
	GET LIST ITEM:C378($1->; *; $Lon_Reference; $Txt_Item; $Lon_SubList; $Boo_Expanded)
End if 

If (Not:C34(Is a list:C621($Lon_SubList))) & (Count parameters:C259>2)
	If ($3)
		$Lon_SubList:=New list:C375
		SET LIST ITEM:C385($1->; $Lon_Reference; $Txt_Item; $Lon_Reference; $Lon_SubList; $Boo_Expanded)
	End if 
End if 

$0:=$Lon_SubList
