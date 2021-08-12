//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : EDITOR_MODIFIED
// Database: 4DPop XLIFF
// ID[09427A2ACD94448EB9B06DAD15620DEA]
// Created #5-6-2013 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Mark current file as modified
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($Boo_enterable)
C_LONGINT:C283($Lon_icon; $Lon_parameters; $Lon_parentRef; $Lon_styles)
C_PICTURE:C286($Pic_buffer)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
SET LIST ITEM PARAMETER:C986(<>Lst_files; *; "modified"; True:C214)

GET LIST ITEM ICON:C951(<>Lst_strings; *; $Pic_buffer)
GET LIST ITEM PROPERTIES:C631(<>Lst_strings; *; $Boo_enterable; $Lon_styles; $Lon_icon)

SET LIST ITEM PROPERTIES:C386(<>Lst_strings; *; False:C215; $Lon_styles; 0; Foreground color:K23:1)
SET LIST ITEM ICON:C950(<>Lst_strings; *; $Pic_buffer)

$Lon_parentRef:=List item parent:C633(<>Lst_strings; *)

If ($Lon_parentRef#0)
	
	GET LIST ITEM ICON:C951(<>Lst_strings; $Lon_parentRef; $Pic_buffer)
	SET LIST ITEM PROPERTIES:C386(<>Lst_strings; $Lon_parentRef; False:C215; Bold:K14:2; 0; Foreground color:K23:1)
	SET LIST ITEM ICON:C950(<>Lst_strings; $Lon_parentRef; $Pic_buffer)
	
End if 

ENABLE MENU ITEM:C149(1; 3)
ENABLE MENU ITEM:C149(1; 4)

// ----------------------------------------------------
// End