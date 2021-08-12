//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : lsth_DELETE_ITEM
// Created 16/10/06 by vdl
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($Lon_count; $Lon_position; $Lst_main)

If (False:C215)
	C_LONGINT:C283(lsth_DELETE_ITEM; $1)
	C_LONGINT:C283(lsth_DELETE_ITEM; $2)
End if 

$Lst_main:=$1
$Lon_position:=Selected list items:C379($Lst_main)  //keep the current item position

If (Count parameters:C259>1)
	
	DELETE FROM LIST:C624($Lst_main; $2; *)  //given
	
Else 
	
	DELETE FROM LIST:C624($Lst_main; *; *)  //selected
	
End if 

$Lon_count:=Count list items:C380($Lst_main)

If ($Lon_position>$Lon_count)
	
	$Lon_position:=$Lon_count
	
End if 

SELECT LIST ITEMS BY POSITION:C381($Lst_main; $Lon_position)
