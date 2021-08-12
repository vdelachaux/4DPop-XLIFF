C_BOOLEAN:C305($Boo_expanded; $Boo_new)
C_LONGINT:C283($Lon_item; $Lon_ref; $Lon_sublist)
C_TEXT:C284($Txt_label; $Txt_type)

GET LIST ITEM PARAMETER:C985(<>Lst_strings; *; "_new"; $Boo_new)

If ($Boo_new)
	
	GET LIST ITEM PARAMETER:C985(<>Lst_strings; *; "_type"; $Txt_type)
	SET LIST ITEM PARAMETER:C986(<>Lst_strings; *; "_new"; False:C215)
	
	//EDITOR_NEW ("unit")
	CALL SUBFORM CONTAINER:C1086(-2)
	
Else 
	
	GET LIST ITEM:C378(<>Lst_strings; *; $Lon_ref; $Txt_label; $Lon_sublist; $Boo_expanded)
	
	If (Is a list:C621($Lon_sublist) & Not:C34($Boo_expanded))
		
		SET LIST ITEM:C385(<>Lst_strings; $Lon_ref; $Txt_label; $Lon_ref; $Lon_sublist; True:C214)
		
	End if 
	
	$Lon_item:=Selected list items:C379(<>Lst_strings)
	
	SELECT LIST ITEMS BY POSITION:C381(<>Lst_strings; \
		Choose:C955($Lon_item<Count list items:C380(<>Lst_strings); $Lon_item+1; 1))
	
End if 

DETAILS_LOAD

GOTO OBJECT:C206(*; "resname_box")

CALL SUBFORM CONTAINER:C1086(-1)