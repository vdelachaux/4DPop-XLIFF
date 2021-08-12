//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : mnu_RELEASE_MENU
// Created 21/07/06 by vdl
// ----------------------------------------------------
// Description
// Clears the menu $1 from memory  and all menu attached
//----------------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($Lon_i)
C_TEXT:C284($Mnu_main)

ARRAY TEXT:C222($tMnu_ref; 0)
ARRAY TEXT:C222($tTxt_labels; 0)

If (False:C215)
	C_TEXT:C284(mnu_RELEASE_MENU; $1)
End if 

$Mnu_main:=$1

If (Length:C16($Mnu_main)>0)
	
	GET MENU ITEMS:C977($Mnu_main; $tTxt_labels; $tMnu_ref)
	
	For ($Lon_i; 1; Size of array:C274($tMnu_ref); 1)
		
		If (Length:C16($tMnu_ref{$Lon_i})>0)
			
			mnu_RELEASE_MENU($tMnu_ref{$Lon_i})  //<======== RECURSIVE
			
		End if 
		
	End for 
	
	RELEASE MENU:C978($Mnu_main)
	
End if 
