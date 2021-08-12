//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : obj_DISPLAY_LOCALIZED_OBJECTS
// Created 28/01/09 by Vincent de Lachaux
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($Lon_bottom; $Lon_height; $Lon_left; $Lon_offset; $Lon_right)
C_LONGINT:C283($Lon_top; $Lon_width)
C_TEXT:C284($Txt_name)

If (False:C215)
	C_TEXT:C284(obj_DISPLAY_LOCALIZED_OBJECTS; $1)
	C_LONGINT:C283(obj_DISPLAY_LOCALIZED_OBJECTS; $2)
End if 

$Txt_name:=$1

OBJECT GET COORDINATES:C663(*; $Txt_name+".reference"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
OBJECT GET BEST SIZE:C717(*; $Txt_name+".reference"; $Lon_width; $Lon_height)

If (Count parameters:C259>=2)
	
	If ($Lon_width<$2)
		
		$Lon_width:=$2
		
	End if 
	
End if 

$Lon_offset:=($Lon_left+$Lon_width)-$Lon_right
OBJECT MOVE:C664(*; $Txt_name+".reference"; 0; 0; $Lon_offset)
OBJECT MOVE:C664(*; $Txt_name+".move.@"; $Lon_offset; 0)
OBJECT MOVE:C664(*; $Txt_name+"@.resize"; 0; 0; -$Lon_offset)

