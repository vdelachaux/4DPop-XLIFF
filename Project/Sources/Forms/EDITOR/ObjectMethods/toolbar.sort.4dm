C_BOOLEAN:C305($Boo_expanded; $Boo_sort)
C_LONGINT:C283($Lon_parentRef; $Lon_ref; $Lst_sub)
C_TEXT:C284($Txt_label)

TRACE:C157

//Get the reference of the list to sort {
GET LIST ITEM:C378(<>Lst_strings; *; $Lon_ref; $Txt_label; $Lst_sub; $Boo_expanded)

$Boo_sort:=(Is a list:C621($Lst_sub))

If (Not:C34($Boo_sort))
	
	$Lon_parentRef:=List item parent:C633(<>Lst_strings; $Lon_ref)
	GET LIST ITEM:C378(<>Lst_strings; List item position:C629(<>Lst_strings; $Lon_parentRef); $Lon_ref; $Txt_label; $Lst_sub; $Boo_expanded)
	
	$Boo_sort:=(Is a list:C621($Lst_sub))
	
End if 
//}

//If any sort the list
If ($Boo_sort)
	
	If (Shift down:C543)
		
		SORT LIST:C391($Lst_sub; <)
		
	Else 
		
		SORT LIST:C391($Lst_sub)
		
	End if 
	
	EDITOR_MODIFIED
	
End if 