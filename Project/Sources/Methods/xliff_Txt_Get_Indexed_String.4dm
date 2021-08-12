//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Method : xliff_Txt_Get_Indexed_String
// Created 20/01/06 by Vincent de Lachaux
// Modified 26/01/06 by Vincent de Lachaux
// - FileName is now an optional parameter. In this case, search is made in all xliff files.
// ----------------------------------------------------
// Description
// xlif version of Get indexed string (resID; strID{; resFile}) -> String
// ----------------------------------------------------
// Syntax
// xliff_Txt_Get_Indexed_String (resID; strID{; FileName}) -> String
// ----------------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)

C_LONGINT:C283($Lon_i; $Lon_Parameters)
C_TEXT:C284($Txt_Buffer; $Txt_Group_ID; $Txt_ID; $Txt_Index; $Txt_Method; $Txt_Path; $Txt_Unit_ID; $Txt_Value)
C_TEXT:C284($a16_Group; $a16_Root; $a16_Source; $a16_Unit)

ARRAY TEXT:C222($tTxt_Documents; 0)

If (False:C215)
	C_TEXT:C284(xliff_Txt_Get_Indexed_String; $0)
	C_LONGINT:C283(xliff_Txt_Get_Indexed_String; $1)
	C_LONGINT:C283(xliff_Txt_Get_Indexed_String; $2)
	C_TEXT:C284(xliff_Txt_Get_Indexed_String; $3)
End if 

$Lon_Parameters:=Count parameters:C259
$Txt_Group_ID:=String:C10($1)
$Txt_Unit_ID:=String:C10($2)

If ($Lon_Parameters>2)
	
	$Txt_Path:=xliff_Txt_Localized_Path($3)
	
Else 
	
	$Txt_Path:=xliff_Txt_Localized_Path
	
	If (Length:C16($Txt_Path)>0)
		
		DOCUMENT LIST:C474($Txt_Path; $tTxt_Documents)
		
		For ($Lon_i; 1; Size of array:C274($tTxt_Documents); 1)
			
			If ($tTxt_Documents{$Lon_i}="@.xlf")
				
				$Txt_Value:=xliff_Txt_Get_Indexed_String($1; $2; $tTxt_Documents{$Lon_i})
				
				If (Length:C16($Txt_Value)>0)
					
					$Lon_i:=Size of array:C274($tTxt_Documents)+1
					
				End if 
			End if 
		End for 
	End if 
End if 

If (Length:C16($Txt_Path)>0)\
 & ($Lon_Parameters>2)
	
	$Txt_Method:=Method called on error:C704
	ON ERR CALL:C155("NO_ERROR")
	$a16_Root:=DOM Parse XML source:C719($Txt_Path; False:C215)
	
	If (OK=1)
		
		//Get the first groupe
		$a16_Group:=DOM Find XML element:C864($a16_Root; "/xliff/file/body/group")
		
		If (OK=1)
			
			Repeat 
				
				//Get the group ID
				DOM GET XML ATTRIBUTE BY NAME:C728($a16_Group; "id"; $Txt_ID)
				
				If ($Txt_ID=$Txt_Group_ID)
					
					//Find : Get the first Unit
					$a16_Unit:=DOM Get first child XML element:C723($a16_Group)
					
					If (OK=1)
						
						Repeat 
							
							//Get the Unit ID
							DOM GET XML ATTRIBUTE BY NAME:C728($a16_Unit; "id"; $Txt_Index)
							
							If ($Txt_Index#$Txt_Unit_ID)
								
								//See next one
								$a16_Unit:=DOM Get next sibling XML element:C724($a16_Unit)
								
							End if 
						Until ($Txt_Index=$Txt_Unit_ID)\
							 | (OK=0)
						
						If (OK=1)
							
							//Get the target
							$a16_Source:=DOM Get first child XML element:C723($a16_Unit)
							
							//Is the string translatable ? …
							DOM GET XML ATTRIBUTE BY NAME:C728($a16_Unit; "translate"; $Txt_Buffer)
							
							If ($Txt_Buffer="no")
								
								//… no : Get the source string
								DOM GET XML ELEMENT VALUE:C731($a16_Source; $Txt_Value)
								
							Else 
								
								//… yes : Get the target string
								$a16_Source:=DOM Get next sibling XML element:C724($a16_Source)
								DOM GET XML ELEMENT VALUE:C731($a16_Source; $Txt_Value)
								
							End if 
						End if 
					End if 
					
				Else 
					
					//See next one
					$a16_Group:=DOM Get next sibling XML element:C724($a16_Group)
					
				End if 
			Until ($Txt_ID=$Txt_Group_ID)\
				 | (OK=0)
		End if 
		
		DOM CLOSE XML:C722($a16_Root)
		
	End if 
	
	ON ERR CALL:C155($Txt_Method)
	
End if 

$0:=$Txt_Value