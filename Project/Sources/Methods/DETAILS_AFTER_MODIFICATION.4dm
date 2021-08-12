//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : DETAILS_AFTER_MODIFICATION
// ID[7E5E62766E5C4F56969B19AA17EE2900]
// Created 26/03/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// To be abble to execute code after a self managed paste we must use an external method
// ----------------------------------------------------
// Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($Boo_expanded; $Boo_modified; $Boo_translate)
C_LONGINT:C283($Lon_i; $Lon_parameters; $Lon_ref; $Lon_x; $Lst_units)
C_PICTURE:C286($Pic_buffer)
C_POINTER:C301($Ptr_source; $Ptr_target)
C_TEXT:C284($kTxt_source; $kTxt_target; $Txt_buffer; $Txt_objectName; $Txt_value)

ARRAY LONGINT:C221($tLon_find; 0)

If (False:C215)
	C_TEXT:C284(DETAILS_AFTER_MODIFICATION; $1)
	C_TEXT:C284(DETAILS_AFTER_MODIFICATION; $2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	If ($Lon_parameters>=1)
		
		$Txt_value:=$1
		
	Else 
		
		$Txt_value:=Get edited text:C655
		
	End if 
	
	If ($Lon_parameters>=2)
		
		$Txt_objectName:=$2
		
	Else 
		
		$Txt_objectName:=Choose:C955(OBJECT Get name:C1087(Object current:K67:2)=""; OBJECT Get name:C1087(Object with focus:K67:3); OBJECT Get name:C1087(Object current:K67:2))
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Txt_objectName="resname_box")
		
		GET LIST ITEM:C378(<>Lst_strings; *; $Lon_ref; $Txt_buffer; $Lst_units; $Boo_expanded)
		
		$Boo_modified:=Not:C34(str_gBoo_Equal($Txt_buffer; $Txt_value))
		
		If ($Boo_modified)
			
			$Lon_x:=Find in array:C230(<>tTxt_attributeNames; "resname")
			
			If ($Lon_x<0)
				
				APPEND TO ARRAY:C911(<>tTxt_attributeNames; "resname")
				APPEND TO ARRAY:C911(<>tTxt_attributeValues; $Txt_value)
				
			Else 
				
				<>tTxt_attributeValues{$Lon_x}:=$Txt_value
				
			End if 
			
			SET LIST ITEM PARAMETER:C986(<>Lst_strings; *; "resname"; $Txt_value)
			
			SET LIST ITEM:C385(<>Lst_strings; $Lon_ref; $Txt_value; $Lon_ref; $Lst_units; $Boo_expanded)
			
			If ($Lst_units=0)  //trans-unit or empty group
				
				//revert duplicate of the old value if any {
				$tLon_find{0}:=Find in list:C952(<>Lst_strings; $Txt_buffer; 1; $tLon_find; *)
				
				If (Size of array:C274($tLon_find)>1)
					
					$Pic_buffer:=util_getResourceImage("Images/ListFatal.tiff")
					
				Else 
					
					CLEAR VARIABLE:C89($Pic_buffer)
					
				End if 
				
				For ($Lon_i; 1; Size of array:C274($tLon_find); 1)
					
					SET LIST ITEM ICON:C950(<>Lst_strings; $tLon_find{$Lon_i}; $Pic_buffer)
					
				End for 
				
				//}
				
				//Mark duplicate of the current value {
				$tLon_find{0}:=Find in list:C952(<>Lst_strings; $Txt_value; 1; $tLon_find; *)
				
				If (Size of array:C274($tLon_find)>1)\
					 | ($tLon_find{0}#$Lon_ref)
					
					$Pic_buffer:=util_getResourceImage("Images/ListFatal.tiff")
					
				Else 
					
					CLEAR VARIABLE:C89($Pic_buffer)
					
				End if 
				
				SET LIST ITEM ICON:C950(<>Lst_strings; $Lon_ref; $Pic_buffer)
				
				If (Picture size:C356($Pic_buffer)>0)
					
					For ($Lon_i; 1; Size of array:C274($tLon_find); 1)
						
						SET LIST ITEM ICON:C950(<>Lst_strings; $tLon_find{$Lon_i}; $Pic_buffer)
						
					End for 
					
				Else 
					
					$tLon_find{0}:=Find in list:C952(<>Lst_strings; $Txt_buffer; 1; $tLon_find; *)
					
					If (Size of array:C274($tLon_find)>1)
						
						$Pic_buffer:=util_getResourceImage("Images/ListFatal.tiff")
						
					Else 
						
						CLEAR VARIABLE:C89($Pic_buffer)
						
					End if 
					
					For ($Lon_i; 1; Size of array:C274($tLon_find); 1)
						
						SET LIST ITEM ICON:C950(<>Lst_strings; $tLon_find{$Lon_i}; $Pic_buffer)
						
					End for 
				End if 
				//}
				
			End if 
		End if 
		
		//______________________________________________________
	: ($Txt_objectName="id_box")
		
		GET LIST ITEM PARAMETER:C985(<>Lst_strings; *; "id"; $Txt_buffer)
		
		$Boo_modified:=Not:C34(str_gBoo_Equal($Txt_buffer; $Txt_value))
		
		If ($Boo_modified)
			
			SET LIST ITEM PARAMETER:C986(<>Lst_strings; *; "id"; $Txt_value)
			SET LIST ITEM PARAMETER:C986(<>Lst_strings; *; Additional text:K28:7; $Txt_value)
			
		End if 
		
		//______________________________________________________
	: ($Txt_objectName="unit_source_box@")\
		 | ($Txt_objectName="unit_source_M_box")
		
		GET LIST ITEM PARAMETER:C985(<>Lst_strings; *; "_source"; $Txt_buffer)
		$Boo_modified:=Not:C34(str_gBoo_Equal($Txt_buffer; $Txt_value))
		
		If ($Boo_modified)
			
			SET LIST ITEM PARAMETER:C986(<>Lst_strings; *; "_source"; $Txt_value)
			
		End if 
		
		//______________________________________________________
	: ($Txt_objectName="unit_target_box@")\
		 | ($Txt_objectName="unit_target_M_box")
		
		GET LIST ITEM PARAMETER:C985(<>Lst_strings; *; "_target"; $Txt_buffer)
		$Boo_modified:=Not:C34(str_gBoo_Equal($Txt_buffer; $Txt_value))
		
		If ($Boo_modified)
			
			SET LIST ITEM PARAMETER:C986(<>Lst_strings; *; "_target"; $Txt_value)
			
		End if 
		
		//______________________________________________________
	: ($Txt_objectName="unit_translate@")
		
		$kTxt_source:="unit_source_box.resize"
		$kTxt_target:="unit_target_box.move.resize"
		
		$Ptr_source:=OBJECT Get pointer:C1124(Object named:K67:5; $kTxt_source)
		$Ptr_target:=OBJECT Get pointer:C1124(Object named:K67:5; $kTxt_target)
		
		//Get translate attribute position
		$Lon_x:=Find in array:C230(<>tTxt_attributeNames; "translate")
		$Boo_translate:=Self:C308->=0
		
		If ($Boo_translate)  // translate="yes"
			
			If ($Lon_x>0)
				
				//Remove the attribute
				DELETE FROM ARRAY:C228(<>tTxt_attributeNames; $Lon_x; 1)
				DELETE FROM ARRAY:C228(<>tTxt_attributeValues; $Lon_x; 1)
				
			End if 
			
			GET LIST ITEM PARAMETER:C985(<>Lst_strings; *; "_target"; $Ptr_target->)
			
			If (Length:C16($Ptr_target->)=0)
				
				$Ptr_target->:=$Ptr_source->
				SET LIST ITEM PARAMETER:C986(<>Lst_strings; *; "_target"; $Ptr_target->)
				
			End if 
			
		Else   // translate="no"
			
			If ($Lon_x>0)
				
				<>tTxt_attributeValues{$Lon_x}:="no"
				
			Else 
				
				APPEND TO ARRAY:C911(<>tTxt_attributeNames; "translate")
				APPEND TO ARRAY:C911(<>tTxt_attributeValues; "no")
				
			End if 
			
			$Ptr_target->:=""
			
		End if 
		
		SET LIST ITEM PARAMETER:C986(<>Lst_strings; *; "translate"; Choose:C955($Boo_translate; "yes"; "no"))
		OBJECT SET ENTERABLE:C238(*; "@target@"; $Boo_translate)
		OBJECT SET VISIBLE:C603(*; "@target@"; $Boo_translate)
		
		$Boo_modified:=True:C214
		
		//______________________________________________________
	: ($Txt_objectName="unit_target_down.move")
		
		(OBJECT Get pointer:C1124(Object named:K67:5; "unit_target_box.move.resize"))->:=\
			(OBJECT Get pointer:C1124(Object named:K67:5; "unit_source_box.resize"))->
		
		(OBJECT Get pointer:C1124(Object named:K67:5; "unit_target_M_box"))->:=\
			(OBJECT Get pointer:C1124(Object named:K67:5; "unit_source_M_box"))->
		
		$Boo_modified:=True:C214
		
		//______________________________________________________
	: ($Txt_objectName="unit_target_up.move")
		
		(OBJECT Get pointer:C1124(Object named:K67:5; "unit_source_M_box"))->:=\
			(OBJECT Get pointer:C1124(Object named:K67:5; "unit_target_M_box"))->
		
		$Boo_modified:=True:C214
		
		//______________________________________________________
	Else 
		
		TRACE:C157
		
		//______________________________________________________
End case 

If ($Boo_modified)
	
	EDITOR_MODIFIED
	
End if 

// ----------------------------------------------------
// End