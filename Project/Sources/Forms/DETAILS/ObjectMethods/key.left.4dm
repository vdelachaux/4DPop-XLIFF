C_BOOLEAN:C305($Boo_expanded)
C_LONGINT:C283($Lon_ref; $Lon_sublist)
C_TEXT:C284($Txt_label)

GET LIST ITEM:C378(<>Lst_strings; *; $Lon_ref; $Txt_label; $Lon_sublist; $Boo_expanded)

If (Is a list:C621($Lon_sublist) & $Boo_expanded)
	
	SET LIST ITEM:C385(<>Lst_strings; $Lon_ref; $Txt_label; $Lon_ref; $Lon_sublist; False:C215)
	
End if 