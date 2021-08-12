//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : lsth_Lon_CountFirstLevelItems
// Created 05/10/06 by vdl
// ----------------------------------------------------
// Description
// Compter le nombre d'éléments du premier niveau d'une liste
// ----------------------------------------------------
C_LONGINT:C283($0)
C_POINTER:C301($1)  //List reference

C_LONGINT:C283($Lon_List; $Lon_i; $Lon_Reference; $Lon_SubList)
C_TEXT:C284($Txt_Element)
C_BOOLEAN:C305($Boo_Expanded)

$Lon_List:=Copy list:C626($1->)

For ($Lon_i; 1; Count list items:C380($Lon_List; *); 1)
	GET LIST ITEM:C378($Lon_List; $Lon_i; $Lon_Reference; $Txt_Element; $Lon_SubList; $Boo_Expanded)
	If (Is a list:C621($Lon_SubList)) & ($Boo_Expanded)
		SET LIST ITEM:C385($Lon_List; $Lon_Reference; $Txt_Element; $Lon_Reference; $Lon_SubList; False:C215)
	End if 
End for 

$0:=Count list items:C380($Lon_List)

CLEAR LIST:C377($Lon_List)
