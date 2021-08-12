//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : EDITOR_NEW_UNIT
// Database: 4DPop XLIFF
// ID[342DB35A2C814A50AC876306BEE4A9E3]
// Created #5-6-2013 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($Boo_expanded)
C_LONGINT:C283($Lon_group; $Lon_parameters; $Lon_ref; $Lon_unitCount; $Lst_item)
C_TEXT:C284($Txt_resname)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
GET LIST ITEM:C378(<>Lst_strings; *; $Lon_ref; $Txt_resname; $Lst_item; $Boo_expanded)

If ($Lon_ref<0)  //Group
	
	If (Not:C34(Is a list:C621($Lst_item)))
		
		$Lst_item:=New list:C375
		
		SET LIST ITEM:C385(<>Lst_strings; $Lon_ref; $Txt_resname; $Lon_ref; $Lst_item; $Boo_expanded)
		
	End if 
	
Else 
	
	$Lon_group:=List item parent:C633(<>Lst_strings; $Lon_ref)
	
	GET LIST ITEM:C378(<>Lst_strings; List item position:C629(<>Lst_strings; $Lon_group); $Lon_ref; $Txt_resname; $Lst_item; $Boo_expanded)
	
End if 

$Lon_unitCount:=(OBJECT Get pointer:C1124(Object named:K67:5; "count.unit"))->
(OBJECT Get pointer:C1124(Object named:K67:5; "count.unit"))->:=$Lon_unitCount+1

<>vLast_unit_ID:=<>vLast_unit_ID+1

$Txt_resname:=Replace string:C233(Get localized string:C991("NewItem"); "{id}"; String:C10(lsth_Lon_CountFirstLevelItems(->$Lst_item)+1))

APPEND TO LIST:C376($Lst_item; $Txt_resname; <>vLast_unit_ID)
SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_unit_ID; "_type"; "unit")
SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_unit_ID; "_new"; True:C214)
SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_unit_ID; "id"; <>vLast_unit_ID)
SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_unit_ID; "resname"; $Txt_resname)

SET LIST ITEM PARAMETER:C986(<>Lst_strings; <>vLast_unit_ID; Additional text:K28:7; <>vLast_unit_ID)

APPEND TO ARRAY:C911(<>tTxt_attributeNames; "id")
APPEND TO ARRAY:C911(<>tTxt_attributeValues; String:C10(<>vLast_unit_ID))
APPEND TO ARRAY:C911(<>tTxt_attributeNames; "resname")
APPEND TO ARRAY:C911(<>tTxt_attributeValues; $Txt_resname)

SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_strings; <>vLast_unit_ID)
OBJECT SET SCROLL POSITION:C906(<>Lst_strings; List item position:C629(<>Lst_strings; <>vLast_unit_ID))

// ----------------------------------------------------
// End