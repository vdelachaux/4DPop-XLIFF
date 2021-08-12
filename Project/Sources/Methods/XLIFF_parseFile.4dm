//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : XLIFF_parseFile
// Created 10/10/06 by vdl
// ----------------------------------------------------
// Modified by Vincent de Lachaux (31/10/08)
// For a non destructive management of the unknown elements
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)

C_BLOB:C604($Blb_buffer)
C_BOOLEAN:C305($Boo_CDATA; $Boo_noTranslate)
C_LONGINT:C283($Lon_attributeNumber; $Lon_count; $Lon_group; $Lon_groupCount; $Lon_i; $Lon_j)
C_LONGINT:C283($Lon_privateElementNumber; $Lon_unit; $Lon_unitCount; $Lon_x; $Lst_groups; $Lst_units)
C_PICTURE:C286($Pic_collapsed; $Pic_note)
C_POINTER:C301($Ptr_Search_id; $Ptr_Search_order; $Ptr_Search_resname; $Ptr_Search_source; $Ptr_Search_target)
C_TEXT:C284($Dom_file; $Dom_header; $Dom_node; $Dom_root; $Txt_CDATA; $Txt_errorHandlerMethod)
C_TEXT:C284($Txt_groupName; $Txt_name; $Txt_note; $Txt_path; $Txt_reference; $Txt_source)
C_TEXT:C284($Txt_sourceReference; $Txt_target; $Txt_targetReference; $Txt_unit_name; $Txt_value)

ARRAY LONGINT:C221($tLon_id; 0)
ARRAY TEXT:C222($tDom_groups; 0)
ARRAY TEXT:C222($tDom_units; 0)
ARRAY TEXT:C222($tTxt_group_attributeNames; 0)
ARRAY TEXT:C222($tTxt_group_attributeValues; 0)
ARRAY TEXT:C222($tTxt_privateElements; 0)
ARRAY TEXT:C222($tTxt_resname; 0)
ARRAY TEXT:C222($tTxt_source; 0)
ARRAY TEXT:C222($tTxt_target; 0)
ARRAY TEXT:C222($tTxt_unit_attributeNames; 0)
ARRAY TEXT:C222($tTxt_unit_attributeValues; 0)

If (False:C215)
	C_LONGINT:C283(XLIFF_parseFile; $0)
	C_TEXT:C284(XLIFF_parseFile; $1)
End if 

$Txt_path:=$1

<>vLast_Group_UID:=0
<>vLast_unit_ID:=0

$Lon_groupCount:=0
$Lon_unitCount:=0

CLEAR VARIABLE:C89(<>tTxt_xliff_attributeNames)
CLEAR VARIABLE:C89(<>tTxt_xliff_attributeValues)
CLEAR VARIABLE:C89(<>tTxt_file_attributeNames)
CLEAR VARIABLE:C89(<>tTxt_file_attributeValues)
CLEAR VARIABLE:C89(<>tTxt_file_Notes)
CLEAR VARIABLE:C89(<>tTxt_prop_groupNames)
CLEAR VARIABLE:C89(<>tTxt_prop_groupValues)
CLEAR VARIABLE:C89(<>tTxt_unit_Attribute_Names)
CLEAR VARIABLE:C89(<>tTxt_group_Attribute_Names)
CLEAR VARIABLE:C89(<>tTxt_filePrivateHeaderElements)

$Pic_note:=util_getResourceImage("Images/note.png")

$Lst_groups:=New list:C375

If (Length:C16($Txt_path)>0)
	
	If (Test path name:C476($Txt_path)=Is a document:K24:1)
		
		$Txt_errorHandlerMethod:=Method called on error:C704
		ON ERR CALL:C155("NO_ERROR")
		$Dom_root:=DOM Parse XML source:C719($Txt_path; False:C215)
		
		If (OK=1)
			
			//<xliff>
			xml_GET_ATTRIBUTES_ARRAYS($Dom_root; -><>tTxt_xliff_attributeNames; -><>tTxt_xliff_attributeValues)
			
			//<file>
			$Dom_file:=DOM Find XML element:C864($Dom_root; "xliff/file/")
			
			If (OK=1)
				
				xml_GET_ATTRIBUTES_ARRAYS($Dom_file; -><>tTxt_file_attributeNames; -><>tTxt_file_attributeValues)
				
				// Modified by Vincent de Lachaux (31/10/08)
				// For a non destructive management of the unknown elements for <header> {
				$Dom_header:=DOM Find XML element:C864($Dom_root; "xliff/file/header/")
				
				If (OK=1)
					
					$Dom_node:=DOM Get first child XML element:C723($Dom_header; $Txt_name; $Txt_value)
					
					If (OK=1)
						
						Repeat 
							
							Case of 
									
									//……………………………………………………
								: ($Txt_name="note")
									
									APPEND TO ARRAY:C911(<>tTxt_file_Notes; $Txt_value)
									
									//……………………………………………………
								: ($Txt_name="prop-group")
									
									DOM GET XML ATTRIBUTE BY NAME:C728($Dom_node; "name"; $Txt_name)
									
									If (OK=1) & ($Txt_name="Xliff-Editor.4dbase")  //I know this ;-)
										
										For ($Lon_i; 1; DOM Count XML elements:C726($Dom_node; "prop"); 1)
											
											$Txt_reference:=DOM Get XML element:C725($Dom_node; "prop"; $Lon_i; $Txt_value)
											DOM GET XML ATTRIBUTE BY NAME:C728($Txt_reference; "prop-type"; $Txt_name)
											APPEND TO ARRAY:C911(<>tTxt_prop_groupNames; $Txt_name)
											APPEND TO ARRAY:C911(<>tTxt_prop_groupValues; $Txt_value)
											
										End for 
										
									Else 
										
										//<prop-group> from another editor to preserve
										DOM EXPORT TO VAR:C863($Dom_node; $Blb_buffer)
										APPEND TO ARRAY:C911(<>tTxt_filePrivateHeaderElements; BLOB to text:C555($Blb_buffer; UTF8 text without length:K22:17))
										SET BLOB SIZE:C606($Blb_buffer; 0)
										
									End if 
									
									//……………………………………………………
								Else 
									
									//Other element to preserve
									DOM EXPORT TO VAR:C863($Dom_node; $Blb_buffer)
									APPEND TO ARRAY:C911(<>tTxt_filePrivateHeaderElements; BLOB to text:C555($Blb_buffer; UTF8 text without length:K22:17))
									SET BLOB SIZE:C606($Blb_buffer; 0)
									
									//……………………………………………………
							End case 
							
							$Dom_node:=DOM Get next sibling XML element:C724($Dom_node; $Txt_name; $Txt_value)
							
						Until (OK=0)
					End if 
				End if 
				//}
				
			End if 
			
			//<group>
			$tDom_groups{0}:=DOM Find XML element:C864($Dom_root; "/xliff/file/body/group"; $tDom_groups)
			
			If (OK=1)
				
				For ($Lon_group; 1; Size of array:C274($tDom_groups); 1)
					
					<>vLast_Group_UID:=<>vLast_Group_UID-1
					
					//Get the group attributes
					xml_GET_ATTRIBUTES_ARRAYS($tDom_groups{$Lon_group}; ->$tTxt_group_attributeNames; ->$tTxt_group_attributeValues)
					
					$tDom_units{0}:=DOM Find XML element:C864($tDom_groups{$Lon_group}; "/group/trans-unit"; $tDom_units)
					
					$Lst_units:=New list:C375
					
					If (OK=1)
						
						$Lon_unitCount:=$Lon_unitCount+Size of array:C274($tDom_units)
						
						For ($Lon_unit; 1; Size of array:C274($tDom_units); 1)
							
							CLEAR VARIABLE:C89($Txt_unit_name)
							CLEAR VARIABLE:C89($Txt_target)
							CLEAR VARIABLE:C89($Txt_source)
							CLEAR VARIABLE:C89($Txt_note)
							CLEAR VARIABLE:C89($tTxt_privateElements)
							CLEAR VARIABLE:C89($Boo_CDATA)
							
							<>vLast_unit_ID:=<>vLast_unit_ID+1
							
							xml_GET_ATTRIBUTES_ARRAYS($tDom_units{$Lon_unit}; ->$tTxt_unit_attributeNames; ->$tTxt_unit_attributeValues)
							
							$Dom_node:=DOM Get first child XML element:C723($tDom_units{$Lon_unit}; $Txt_name; $Txt_value)
							
							If (OK=1)
								
								Repeat 
									
									Case of 
											
											//…………………………………………………………………………………………………………………………………………………
										: ($Txt_name="source")
											
											DOM GET XML ELEMENT VALUE:C731($Dom_node; $Txt_value; $Txt_CDATA)
											$Txt_CDATA:=Replace string:C233($Txt_CDATA; "<br/>"; "\r")
											$Boo_CDATA:=($Boo_CDATA | (Length:C16($Txt_CDATA)>0))
											$Txt_source:=Choose:C955($Boo_CDATA; $Txt_CDATA; $Txt_value)
											
											$Txt_sourceReference:=$Dom_node
											$Lon_x:=Find in array:C230($tTxt_unit_attributeNames; "translate")
											
											If ($Lon_x>0)
												
												$Boo_noTranslate:=($tTxt_unit_attributeValues{$Lon_x}="no")
												
											Else 
												
												$Boo_noTranslate:=False:C215
												
											End if 
											
											//…………………………………………………………………………………………………………………………………………………
										: ($Txt_name="target")
											
											DOM GET XML ELEMENT VALUE:C731($Dom_node; $Txt_value; $Txt_CDATA)
											$Txt_CDATA:=Replace string:C233($Txt_CDATA; "<br/>"; "\r")
											$Boo_CDATA:=($Boo_CDATA | (Length:C16($Txt_CDATA)>0))
											$Txt_target:=Choose:C955($Boo_CDATA; $Txt_CDATA; $Txt_value)
											
											$Txt_targetReference:=$Dom_node
											
											//…………………………………………………………………………………………………………………………………………………
										: ($Txt_name="note")
											
											$Txt_note:=$Txt_value
											
											//…………………………………………………………………………………………………………………………………………………
										Else 
											
											//It's non-standard information to preserve
											SET BLOB SIZE:C606($Blb_buffer; 0)
											DOM EXPORT TO VAR:C863($Dom_node; $Blb_buffer)
											APPEND TO ARRAY:C911($tTxt_privateElements; BLOB to text:C555($Blb_buffer; UTF8 text without length:K22:17))
											
											//…………………………………………………………………………………………………………………………………………………
									End case 
									
									$Dom_node:=DOM Get next sibling XML element:C724($Dom_node; $Txt_name; $Txt_value)
									
								Until (OK=0)
								
								$Txt_target:=Choose:C955($Boo_noTranslate; $Txt_source; $Txt_target)
								//}
								
								//Add TransUnit
								$Lon_x:=Find in array:C230($tTxt_unit_attributeNames; "resname")
								
								If ($Lon_x>0)
									
									$Txt_unit_name:=$tTxt_unit_attributeValues{$Lon_x}
									
								End if 
								
								APPEND TO LIST:C376($Lst_units; $Txt_unit_name; <>vLast_unit_ID)
								SET LIST ITEM PARAMETER:C986($Lst_units; <>vLast_unit_ID; "_type"; "unit")
								SET LIST ITEM PARAMETER:C986($Lst_units; <>vLast_unit_ID; "_styled"; $Boo_CDATA)
								SET LIST ITEM PARAMETER:C986($Lst_units; <>vLast_unit_ID; "_source"; $Txt_source)
								SET LIST ITEM PARAMETER:C986($Lst_units; <>vLast_unit_ID; "_target"; $Txt_target)
								SET LIST ITEM PARAMETER:C986($Lst_units; <>vLast_unit_ID; "_note"; $Txt_note)
								
								SET LIST ITEM PROPERTIES:C386($Lst_units; 0; False:C215; Plain:K14:1; 0; 0x00878988)
								
								APPEND TO ARRAY:C911($tLon_id; <>vLast_unit_ID)
								APPEND TO ARRAY:C911($tTxt_resname; $Txt_unit_name)
								APPEND TO ARRAY:C911($tTxt_source; $Txt_source)
								APPEND TO ARRAY:C911($tTxt_target; $Txt_target)
								
								If (Length:C16($Txt_note)>0)
									
									SET LIST ITEM ICON:C950($Lst_units; <>vLast_unit_ID; $Pic_note)
									
								End if 
								
								//Attributes {
								$Lon_attributeNumber:=0
								
								For ($Lon_j; 1; Size of array:C274($tTxt_unit_attributeNames); 1)
									
									$Lon_x:=Find in array:C230(<>tTxt_unit_Attribute_Names; $tTxt_unit_attributeNames{$Lon_j})
									
									If ($Lon_x=-1)
										
										If (Size of array:C274(<>tTxt_unit_Attribute_Names)<31)
											
											APPEND TO ARRAY:C911(<>tTxt_unit_Attribute_Names; $tTxt_unit_attributeNames{$Lon_j})
											$Lon_x:=Size of array:C274(<>tTxt_unit_Attribute_Names)
											
										Else 
											
											$Lon_x:=0
											
										End if 
									End if 
									
									$Lon_attributeNumber:=$Lon_attributeNumber ?+ $Lon_x
									SET LIST ITEM PARAMETER:C986($Lst_units; <>vLast_unit_ID; $tTxt_unit_attributeNames{$Lon_j}; $tTxt_unit_attributeValues{$Lon_j})
									
									If ($tTxt_unit_attributeNames{$Lon_j}="id")
										
										SET LIST ITEM PARAMETER:C986($Lst_units; <>vLast_unit_ID; Additional text:K28:7; $tTxt_unit_attributeValues{$Lon_j})
										
									End if 
								End for 
								
								SET LIST ITEM PARAMETER:C986($Lst_units; <>vLast_unit_ID; "_attributes.index"; $Lon_attributeNumber)
								//}
								
								//Keep the non-standard informations {
								$Lon_privateElementNumber:=0
								
								For ($Lon_j; 1; Size of array:C274($tTxt_privateElements); 1)
									
									$Lon_privateElementNumber:=$Lon_privateElementNumber+1
									SET LIST ITEM PARAMETER:C986($Lst_units; <>vLast_unit_ID; "private."+String:C10($Lon_privateElementNumber); $tTxt_privateElements{$Lon_j})
									
								End for 
								
								SET LIST ITEM PARAMETER:C986($Lst_units; <>vLast_unit_ID; "private.number"; $Lon_privateElementNumber)
								//}
								
							End if 
						End for 
						
						$Lon_x:=Find in array:C230($tTxt_group_attributeNames; "resname")
						
						If ($Lon_x>0)
							
							$Txt_groupName:=$tTxt_group_attributeValues{$Lon_x}
							
						Else 
							
							$Txt_groupName:=""
							
						End if 
						
						APPEND TO LIST:C376($Lst_groups; $Txt_groupName; <>vLast_Group_UID; $Lst_units; False:C215)
						SET LIST ITEM PARAMETER:C986($Lst_groups; <>vLast_Group_UID; "_type"; "group")
						
						APPEND TO ARRAY:C911($tLon_id; <>vLast_Group_UID)
						APPEND TO ARRAY:C911($tTxt_resname; $Txt_groupName)
						APPEND TO ARRAY:C911($tTxt_source; "")
						APPEND TO ARRAY:C911($tTxt_target; "")
						
						$Lon_attributeNumber:=0
						
						For ($Lon_j; 1; Size of array:C274($tTxt_group_attributeNames); 1)
							
							$Lon_x:=Find in array:C230(<>tTxt_group_Attribute_Names; $tTxt_group_attributeNames{$Lon_j})
							
							If ($Lon_x=-1)
								
								If (Size of array:C274(<>tTxt_group_Attribute_Names)<31)
									
									APPEND TO ARRAY:C911(<>tTxt_group_Attribute_Names; $tTxt_group_attributeNames{$Lon_j})
									$Lon_x:=Size of array:C274(<>tTxt_group_Attribute_Names)
									
								Else 
									
									$Lon_x:=0
									
								End if 
							End if 
							
							$Lon_attributeNumber:=$Lon_attributeNumber ?+ $Lon_x
							SET LIST ITEM PARAMETER:C986($Lst_groups; <>vLast_Group_UID; $tTxt_group_attributeNames{$Lon_j}; $tTxt_group_attributeValues{$Lon_j})
							
							If ($tTxt_group_attributeNames{$Lon_j}="id")
								
								SET LIST ITEM PARAMETER:C986($Lst_groups; <>vLast_Group_UID; Additional text:K28:7; $tTxt_group_attributeValues{$Lon_j})
								
							End if 
						End for 
						
						SET LIST ITEM PARAMETER:C986($Lst_groups; <>vLast_Group_UID; "_attributes.index"; $Lon_attributeNumber)
						SET LIST ITEM PROPERTIES:C386($Lst_groups; <>vLast_Group_UID; False:C215; Bold:K14:2; 0; 0x00878988)
						SET LIST ITEM ICON:C950($Lst_groups; <>vLast_Group_UID; $Pic_collapsed)
						
					End if 
				End for 
			End if 
			
			DOM CLOSE XML:C722($Dom_root)
			
		End if 
	End if 
	
	$Ptr_Search_id:=OBJECT Get pointer:C1124(Object named:K67:5; "search.list.id")
	$Ptr_Search_resname:=OBJECT Get pointer:C1124(Object named:K67:5; "search.list.resname")
	$Ptr_Search_source:=OBJECT Get pointer:C1124(Object named:K67:5; "search.list.source")
	$Ptr_Search_target:=OBJECT Get pointer:C1124(Object named:K67:5; "search.list.target")
	
	COPY ARRAY:C226($tLon_id; $Ptr_Search_id->)
	COPY ARRAY:C226($tTxt_resname; $Ptr_Search_resname->)
	COPY ARRAY:C226($tTxt_source; $Ptr_Search_source->)
	COPY ARRAY:C226($tTxt_target; $Ptr_Search_target->)
	
	$Lon_count:=Size of array:C274($tLon_id)
	$Ptr_Search_order:=OBJECT Get pointer:C1124(Object named:K67:5; "search.list.order")
	ARRAY LONGINT:C221($Ptr_Search_order->; $Lon_count)
	For ($Lon_i; 1; $Lon_count; 1)
		
		$Ptr_Search_order->{$Lon_i}:=$Lon_i
		
	End for 
	
	(OBJECT Get pointer:C1124(Object named:K67:5; "count.group"))->:=Size of array:C274($tDom_groups)
	(OBJECT Get pointer:C1124(Object named:K67:5; "count.unit"))->:=$Lon_unitCount
	
	$0:=$Lst_groups
	
End if 