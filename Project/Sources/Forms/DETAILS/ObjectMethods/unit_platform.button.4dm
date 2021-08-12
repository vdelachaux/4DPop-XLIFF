C_BOOLEAN:C305($Boo_modified)
C_LONGINT:C283($Lon_indx)
C_TEXT:C284($kTxt_attribute; $Txt_platform; $Txt_value)

$kTxt_attribute:="d4:includeIf"

$Txt_platform:=Replace string:C233(DETAILS_platform; "mac_win"; "")

GET LIST ITEM PARAMETER:C985(<>Lst_strings; *; $kTxt_attribute; $Txt_value)

$Boo_modified:=($Txt_platform#$Txt_value)

If ($Boo_modified)
	
	SET LIST ITEM PARAMETER:C986(<>Lst_strings; *; $kTxt_attribute; $Txt_platform)
	
	$Lon_indx:=Find in array:C230(<>tTxt_attributeNames; $kTxt_attribute)
	
	If ($Lon_indx<0)
		
		If (Length:C16($Txt_platform)>0)
			
			APPEND TO ARRAY:C911(<>tTxt_attributeNames; $kTxt_attribute)
			APPEND TO ARRAY:C911(<>tTxt_attributeValues; $Txt_platform)
			
			If (Find in array:C230(<>tTxt_xliff_attributeNames; "xmlns:d4")<0)
				
				APPEND TO ARRAY:C911(<>tTxt_xliff_attributeNames; "xmlns:d4")
				APPEND TO ARRAY:C911(<>tTxt_xliff_attributeValues; "http://www.4d.com/d4-ns")
				
			End if 
		End if 
		
	Else 
		
		If (Length:C16($Txt_platform)>0)
			
			<>tTxt_attributeValues{$Lon_indx}:=$Txt_platform
			
		Else 
			
			DELETE FROM ARRAY:C228(<>tTxt_attributeNames; $Lon_indx; 1)
			DELETE FROM ARRAY:C228(<>tTxt_attributeValues; $Lon_indx; 1)
			
		End if 
	End if 
	
	EDITOR_MODIFIED
	
End if 