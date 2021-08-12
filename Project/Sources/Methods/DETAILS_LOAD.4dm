//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : DETAILS_LOAD
// Database: 4DPop XLIFF
// ID[F8A5A7D3CC3B452A9E2580E0A979AAAC]
// Created #5-6-2013 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_i; $Lon_parameters; $Lon_reference)
C_POINTER:C301($Ptr_array; $Ptr_id; $Ptr_noTranslate; $Ptr_resname; $Ptr_source; $Ptr_stringList; $Ptr_target)
C_TEXT:C284($kTxt_id; $kTxt_noTranslate; $kTxt_resname; $kTxt_source; $kTxt_stringList; $kTxt_target; $Txt_platform; $Txt_value)

ARRAY TEXT:C222($tTxt_names; 0)
ARRAY TEXT:C222($tTxt_values; 0)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	$kTxt_resname:="resname_box"
	$kTxt_id:="id_box"
	$kTxt_source:="unit_source_box.resize"
	$kTxt_noTranslate:="unit_translate.move"
	$kTxt_target:="unit_target_box.move.resize"
	
	$Ptr_stringList:=OBJECT Get pointer:C1124(Object named:K67:5; $kTxt_stringList)
	
	$Ptr_resname:=OBJECT Get pointer:C1124(Object named:K67:5; $kTxt_resname)
	$Ptr_id:=OBJECT Get pointer:C1124(Object named:K67:5; $kTxt_id)
	$Ptr_source:=OBJECT Get pointer:C1124(Object named:K67:5; $kTxt_source)
	$Ptr_noTranslate:=OBJECT Get pointer:C1124(Object named:K67:5; $kTxt_noTranslate)
	$Ptr_target:=OBJECT Get pointer:C1124(Object named:K67:5; $kTxt_target)
	
	$Txt_platform:="mac_win"
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
CLEAR VARIABLE:C89($Ptr_resname->)
CLEAR VARIABLE:C89($Ptr_id->)
CLEAR VARIABLE:C89($Ptr_source->)
CLEAR VARIABLE:C89($Ptr_noTranslate->)
CLEAR VARIABLE:C89($Ptr_target->)

CLEAR VARIABLE:C89(<>tTxt_attributeNames)
CLEAR VARIABLE:C89(<>tTxt_attributeValues)

If (Selected list items:C379(<>Lst_strings)>0)
	
	OBJECT SET ENTERABLE:C238(*; $kTxt_resname; True:C214)
	OBJECT SET ENTERABLE:C238(*; $kTxt_id; True:C214)
	
	$Lon_reference:=Selected list items:C379(<>Lst_strings; *)
	
	GET LIST ITEM PARAMETER:C985(<>Lst_strings; *; "_type"; $Txt_value)
	$Ptr_array:=Choose:C955($Txt_value="group"; -><>tTxt_group_Attribute_Names; -><>tTxt_unit_Attribute_Names)
	
	GET LIST ITEM PARAMETER ARRAYS:C1195(<>Lst_strings; *; $tTxt_names; $tTxt_values)
	
	For ($Lon_i; 1; Size of array:C274($tTxt_names); 1)
		
		Case of 
				
				//________________________________________
			: ($tTxt_names{$Lon_i}="4d_@")
				
				//________________________________________
			: ($tTxt_names{$Lon_i}="private.@")
				
				//________________________________________
			: ($tTxt_names{$Lon_i}="_@")
				
				//________________________________________
			: ($tTxt_names{$Lon_i}="d4:includeIf")\
				 & (Length:C16($tTxt_values{$Lon_i})=0)
				
				//________________________________________
				
			Else 
				
				APPEND TO ARRAY:C911(<>tTxt_attributeNames; $tTxt_names{$Lon_i})
				APPEND TO ARRAY:C911(<>tTxt_attributeValues; $tTxt_values{$Lon_i})
				
				Case of 
						
						//………………………………
					: ($tTxt_names{$Lon_i}="d4:includeIf")
						
						$Txt_platform:=$tTxt_values{$Lon_i}
						
						//………………………………
					: ($tTxt_names{$Lon_i}="id")
						
						$Ptr_id->:=$tTxt_values{$Lon_i}
						
						//………………………………
					: ($tTxt_names{$Lon_i}="resname")
						
						$Ptr_resname->:=$tTxt_values{$Lon_i}
						
						//………………………………
					: ($tTxt_names{$Lon_i}="translate")
						
						$Ptr_noTranslate->:=Choose:C955($tTxt_values{$Lon_i}="no"; 1; 0)
						
						//………………………………
				End case 
				
				//________________________________________
		End case 
	End for 
	
	DETAILS_platform($Txt_platform)
	
End if 

EDITOR_SCREEN_UPDATE

// ----------------------------------------------------
// End