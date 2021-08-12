//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : xliff_Property_Group
// Created 06/08/07 by Vincent de Lachaux
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_BOOLEAN:C305($3)
C_TEXT:C284($4)

C_BOOLEAN:C305($Boo_Set)
C_LONGINT:C283($Lon_x)
C_TEXT:C284($Txt_Entrypoint; $Txt_Label; $Txt_Value)

If (False:C215)
	C_TEXT:C284(xliff_Property_Group; $0)
	C_TEXT:C284(xliff_Property_Group; $1)
	C_TEXT:C284(xliff_Property_Group; $2)
	C_BOOLEAN:C305(xliff_Property_Group; $3)
	C_TEXT:C284(xliff_Property_Group; $4)
End if 

$Txt_Entrypoint:=$1
$Txt_Label:=$2

$Lon_x:=Find in array:C230(<>tTxt_prop_groupNames; $Txt_Label)

Case of 
		//______________________________________________________
	: (Count parameters:C259<2)
		TRACE:C157
		//______________________________________________________
	: ($Txt_Entrypoint="Get")
		If ($Lon_x>0)
			$Txt_Value:=<>tTxt_prop_groupValues{$Lon_x}
		End if 
		//______________________________________________________
	: (Count parameters:C259<4)
		TRACE:C157
		//______________________________________________________
	: ($Txt_Entrypoint="Set")
		
		$Boo_Set:=$3
		$Txt_Value:=$4
		
		If ($Boo_Set)
			
			If ($Lon_x>0)
				If (Not:C34(str_gBoo_Equal(<>tTxt_prop_groupValues{$Lon_x}; $Txt_Value)))
					<>tTxt_prop_groupValues{$Lon_x}:=$Txt_Value
					EDITOR_MODIFIED
				End if 
			Else 
				APPEND TO ARRAY:C911(<>tTxt_prop_groupNames; $Txt_Label)
				APPEND TO ARRAY:C911(<>tTxt_prop_groupValues; $Txt_Value)
				EDITOR_MODIFIED
			End if 
			
		Else 
			
			If ($Lon_x>0)
				DELETE FROM ARRAY:C228(<>tTxt_prop_groupNames; $Lon_x; 1)
				DELETE FROM ARRAY:C228(<>tTxt_prop_groupValues; $Lon_x; 1)
				EDITOR_MODIFIED
			End if 
			
		End if 
		//______________________________________________________
	Else 
		TRACE:C157
		//______________________________________________________
End case 

$0:=$Txt_Value
