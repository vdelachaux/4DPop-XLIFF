//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : mnu_Load_menu_from_file
// Created 04/02/09 by Vincent de Lachaux
// ----------------------------------------------------
// Description
// Loads  a menu from an XML definition file
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_TEXT:C284($Dom_menuBar; $Dom_root; $Mnu_menuBar; $Txt_ID; $Txt_path)

If (False:C215)
	C_TEXT:C284(mnu_Load_menu_from_file; $0)
	C_TEXT:C284(mnu_Load_menu_from_file; $1)
	C_TEXT:C284(mnu_Load_menu_from_file; $2)
End if 

//Init {
$Mnu_menuBar:=Create menu:C408

$Txt_ID:=$1

If (Count parameters:C259>=2)
	
	$Txt_path:=$2
	
Else 
	
	$Txt_path:=Get 4D folder:C485(Current resources folder:K5:16)+"menus.xml"
	
End if 
//}

If (Asserted:C1132(Test path name:C476($Txt_path)=Is a document:K24:1))
	
	$Dom_root:=DOM Parse XML source:C719($Txt_path)
	
	If (Asserted:C1132(OK=1))
		
		$Dom_menuBar:=DOM Find XML element by ID:C1010($Dom_root; $Txt_ID)
		
		If (Asserted:C1132(OK=1))
			
			mnu_LOAD_MENU($Mnu_menuBar; $Dom_menuBar)
			
		End if 
		
		DOM CLOSE XML:C722($Dom_root)
		
	End if 
End if 

$0:=$Mnu_menuBar
