C_LONGINT:C283($Lon_item)

$Lon_item:=Selected list items:C379(<>Lst_strings)

SELECT LIST ITEMS BY POSITION:C381(<>Lst_strings; \
Choose:C955($Lon_item=1; Count list items:C380(<>Lst_strings); $Lon_item-1))

DETAILS_LOAD

CALL SUBFORM CONTAINER:C1086(-1)