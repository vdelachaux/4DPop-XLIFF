//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : xml_GET_ATTRIBUTES_ARRAYS
// Database: 4DPop XLIFF
// ID[F6A84FC6493F40129EC8A5567FE1A0AA]
// Created #3-6-2013 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_LONGINT:C283($Lon_count; $Lon_i; $Lon_parameters)
C_POINTER:C301($Ptr_names; $Ptr_values)
C_TEXT:C284($Dom_node; $Txt_buffer)

If (False:C215)
	C_TEXT:C284(xml_GET_ATTRIBUTES_ARRAYS; $1)
	C_POINTER:C301(xml_GET_ATTRIBUTES_ARRAYS; $2)
	C_POINTER:C301(xml_GET_ATTRIBUTES_ARRAYS; $3)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	$Dom_node:=$1
	$Ptr_names:=$2
	
	If ($Lon_parameters>=3)
		
		$Ptr_values:=$3
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

//%W-518.5
$Lon_count:=DOM Count XML attributes:C727($Dom_node)
ARRAY TEXT:C222($Ptr_names->; $Lon_count)

If ($Lon_parameters>=3)
	
	ARRAY TEXT:C222($Ptr_values->; $Lon_count)
	
	For ($Lon_i; 1; $Lon_count; 1)
		
		DOM GET XML ATTRIBUTE BY INDEX:C729($Dom_node; $Lon_i; $Ptr_names->{$Lon_i}; $Ptr_values->{$Lon_i})
		
	End for 
	
Else 
	
	For ($Lon_i; 1; $Lon_count; 1)
		
		DOM GET XML ATTRIBUTE BY INDEX:C729($Dom_node; $Lon_i; $Ptr_names->{$Lon_i}; $Txt_buffer)
		
	End for 
End if 
//%W+518.5

// ----------------------------------------------------
// End