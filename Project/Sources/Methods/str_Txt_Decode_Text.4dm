//%attributes = {"invisible":true}
// ----------------------------------------------------
// Methode : str_Txt_Decode_Text
// Creee le 24/02/06 par vdl
// ----------------------------------------------------
// Description
// Decode le Texte $1 encodé avec l'encodage $2 (UTF-8 si $2 est absent)
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BLOB:C604($Blb_Buffer)
C_TIME:C306($Gmt_Doc)
C_TEXT:C284($Txt_Buffer; $Txt_encoding; $Txt_Node; $Txt_Path; $Txt_Root; $Txt_Target)

$Txt_Target:=$1
If (Count parameters:C259>1)
	$Txt_encoding:=$2
End if 

If (Length:C16($Txt_encoding)=0)
	$Txt_encoding:="UTF-8"
End if 

If (Length:C16($Txt_Target)>0)
	$Txt_Target:=Replace string:C233($Txt_Target; "&"; "&amp;")  //ampersand
	$Txt_Target:=Replace string:C233($Txt_Target; "<"; "&lt;")  //less than
	$Txt_Path:=Temporary folder:C486+"decode.xml"
	If (Test path name:C476($Txt_Path)=Is a document:K24:1)
		DELETE DOCUMENT:C159($Txt_Path)
	End if 
	$Gmt_Doc:=Create document:C266($Txt_Path)
	If (OK=1)
		SAX SET XML DECLARATION:C858($Gmt_Doc; $Txt_encoding; True:C214; False:C215)
		SEND PACKET:C103($Gmt_Doc; "<root><string>")
		SEND PACKET:C103($Gmt_Doc; $Txt_Target)
		SEND PACKET:C103($Gmt_Doc; "</string></root>")
		CLOSE DOCUMENT:C267($Gmt_Doc)
		$Txt_Root:=DOM Parse XML source:C719($Txt_Path; False:C215)
		If (OK=1)
			$Txt_Node:=DOM Find XML element:C864($Txt_Root; "/root/string")
			If (OK=1)
				DOM GET XML ELEMENT VALUE:C731($Txt_Node; $Txt_Buffer)
				If (OK=1)
					$Txt_Buffer:=Replace string:C233($Txt_Buffer; "&amp;"; "&")  //ampersand
					$Txt_Buffer:=Replace string:C233($Txt_Buffer; "&lt;"; "<")  //less than
				End if 
			End if 
		End if 
		DELETE DOCUMENT:C159($Txt_Path)
	End if 
End if 

$0:=$Txt_Buffer
