C_LONGINT:C283($Lon_; $Lon_Bottom; $Lon_i; $Lon_Left; $Lon_Ref)
C_TEXT:C284($Txt_Element; $Txt_Reference)
_O_C_STRING:C293(255; $a16_menu)

$a16_menu:=Create menu:C408
For ($Lon_i; 1; Count list items:C380(<>Lst_files); 1)
	GET LIST ITEM:C378(<>Lst_files; $Lon_i; $Lon_Ref; $Txt_Element)
	APPEND MENU ITEM:C411($a16_menu; $Txt_Element)
	SET MENU ITEM PARAMETER:C1004($a16_menu; $Lon_i; String:C10($Lon_Ref))
End for 
OBJECT GET COORDINATES:C663(Self:C308->; $Lon_Left; $Lon_; $Lon_; $Lon_Bottom)

$Txt_Reference:=Dynamic pop up menu:C1006($a16_menu; ""; $Lon_Left; $Lon_Bottom)
RELEASE MENU:C978($a16_menu)

If ($Txt_Reference#"")
	SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_files; Num:C11($Txt_Reference))
	OBJECT SET VISIBLE:C603(*; "_Spinner"; True:C214)
	form_timerEvent(1; -1)
End if 