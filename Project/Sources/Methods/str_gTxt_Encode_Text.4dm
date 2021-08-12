//%attributes = {"invisible":true}
// ----------------------------------------------------
// Méthode : str_gTxt_Encode_Text
// Créée le 24/02/06 par vdl
// ----------------------------------------------------
// Description
// Encode le Texte $1 avec l'encodage $2 (UTF-8 si $2 n'est pas présent)
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($0)

C_TEXT:C284($Txt_encoding; $Txt_Target; $Txt_Path; $Txt_Buffer)
C_BLOB:C604($Blb_Buffer)
C_TIME:C306($Gmt_Doc)

$Txt_Target:=$1
If (Count parameters:C259>1)
	$Txt_encoding:=$2
End if 

If (Length:C16($Txt_encoding)=0)
	$Txt_encoding:="UTF-8"
End if 

If (Length:C16($Txt_Target)>0)
	$Txt_Path:=Temporary folder:C486+"encode.xml"
	If (Test path name:C476($Txt_Path)=Is a document:K24:1)
		DELETE DOCUMENT:C159($Txt_Path)
	End if 
	$Gmt_Doc:=Create document:C266($Txt_Path)
	If (OK=1)
		SAX SET XML DECLARATION:C858($Gmt_Doc; $Txt_encoding; True:C214; False:C215)
		SAX OPEN XML ELEMENT:C853($Gmt_Doc; "root")
		SAX ADD XML ELEMENT VALUE:C855($Gmt_Doc; $Txt_Target)
		SAX CLOSE XML ELEMENT:C854($Gmt_Doc)
		CLOSE DOCUMENT:C267($Gmt_Doc)
		DOCUMENT TO BLOB:C525($Txt_Path; $Blb_Buffer)
		If (OK=1)
			$Txt_Buffer:=BLOB to text:C555($Blb_Buffer; Mac text without length:K22:10)
			SET BLOB SIZE:C606($Blb_Buffer; 0)
			$Txt_Buffer:=Substring:C12($Txt_Buffer; Position:C15("<root>"; $Txt_Buffer)+6)
			$Txt_Buffer:=Substring:C12($Txt_Buffer; 1; Position:C15("</root>"; $Txt_Buffer)-1)
		End if 
		DELETE DOCUMENT:C159($Txt_Path)
	End if 
End if 

$0:=$Txt_Buffer