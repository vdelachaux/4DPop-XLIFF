//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : lstb_AUTOMATIC_SCROOLBARS
// Created 07/12/06 by vdl
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_POINTER:C301($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($Boo_H_Scroolbar; $Boo_V_Scroolbar)
C_LONGINT:C283($Lon_Bottom; $Lon_i; $Lon_Left; $Lon_MaxHeight; $Lon_MaxWidth; $Lon_Right; $Lon_Top)
C_POINTER:C301($Ptr_object)

ARRAY BOOLEAN:C223($tabVisibles; 0)
ARRAY POINTER:C280($tabStyles; 0)
ARRAY POINTER:C280($tabVarCols; 0)
ARRAY POINTER:C280($tabVarEntêtes; 0)
ARRAY TEXT:C222($tabNomsCols; 0)
ARRAY TEXT:C222($tabNomsEntêtes; 0)

If (False:C215)
	C_POINTER:C301(lstb_AUTOMATIC_SCROOLBARS; $1)
	C_TEXT:C284(lstb_AUTOMATIC_SCROOLBARS; $2)
End if 

If (Count parameters:C259=1)
	
	$Ptr_object:=$1
	
Else 
	
	$Ptr_object:=OBJECT Get pointer:C1124(Object named:K67:5; $2)
	
End if 

If (LISTBOX Get property:C917($Ptr_object->; lk display header:K53:4)=1)
	$Lon_MaxHeight:=LISTBOX Get property:C917($Ptr_object->; _o_lk header height:K53:5)
End if 

$Boo_H_Scroolbar:=(LISTBOX Get property:C917($Ptr_object->; _o_lk display hor scrollbar:K53:6)=1)
If ($Boo_H_Scroolbar)
	$Lon_MaxHeight:=$Lon_MaxHeight+LISTBOX Get property:C917($Ptr_object->; lk hor scrollbar height:K53:7)
End if 

$Lon_MaxHeight:=$Lon_MaxHeight+(LISTBOX Get rows height:C836($Ptr_object->)*LISTBOX Get number of rows:C915($Ptr_object->))

$Boo_V_Scroolbar:=(LISTBOX Get property:C917($Ptr_object->; _o_lk display ver scrollbar:K53:8)=1)
If ($Boo_V_Scroolbar)
	$Lon_MaxWidth:=$Lon_MaxWidth+LISTBOX Get property:C917($Ptr_object->; lk ver scrollbar width:K53:9)
End if 

LISTBOX GET ARRAYS:C832($Ptr_object->; $tabNomsCols; $tabNomsEntêtes; $tabVarCols; $tabVarEntêtes; $tabVisibles; $tabStyles)

For ($Lon_i; 1; Size of array:C274($tabNomsCols); 1)
	If ($tabVisibles{$Lon_i})
		$Lon_MaxWidth:=$Lon_MaxWidth+LISTBOX Get column width:C834(*; $tabNomsCols{$Lon_i})
	End if 
End for 

OBJECT GET COORDINATES:C663($Ptr_object->; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
OBJECT SET SCROLLBAR:C843($Ptr_object->; ($Lon_Right-$Lon_Left)<$Lon_MaxWidth; ($Lon_Bottom-$Lon_Top)<$Lon_MaxHeight)