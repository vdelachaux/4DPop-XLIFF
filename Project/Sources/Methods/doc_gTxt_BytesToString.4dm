//%attributes = {"invisible":true}
// ----------------------------------------------------
// Méthode : Tool_gTxt_BytesToString
// Créée le 28/09/05 par vdl
// ----------------------------------------------------
// Description
// Retourne une chaine formattée à la bonne unitée à partir d'une taille en octets
// On peut forcer l'unité avec le deuxième paramètre.
// ----------------------------------------------------
C_TEXT:C284($0)
C_REAL:C285($1)  //Nombre d'octets à convertir
C_TEXT:C284($2)  //{Unité à utiliser G | M | K | O} (Automatique)
C_TEXT:C284($3)  //{Chaine utilisée si $1=0} (vide)

C_LONGINT:C283($Lon_Parameters)
C_REAL:C285($Num_Size)
C_TEXT:C284($Txt_DecimalSeparator; $Txt_IntegerFormat; $Txt_Nul; $Txt_RealFormat; $Txt_Requested_Unit; $Txt_Result; $Txt_ThousandSeparator)

$Lon_Parameters:=Count parameters:C259
$Num_Size:=$1
If ($Lon_Parameters>1)
	$Txt_Requested_Unit:=$2
	If ($Lon_Parameters>2)
		$Txt_Nul:=$3
	End if 
End if 

//Format en fonction du système
GET SYSTEM FORMAT:C994(Decimal separator:K60:1; $Txt_DecimalSeparator)
GET SYSTEM FORMAT:C994(Thousand separator:K60:2; $Txt_ThousandSeparator)
$Txt_IntegerFormat:="###"+(($Txt_ThousandSeparator+"###")*10)
$Txt_RealFormat:=$Txt_IntegerFormat+$Txt_DecimalSeparator+"00"

Case of 
		//______________________________________________________
	: ($Num_Size=0)  //Null
		$Txt_Result:=$Txt_Nul
		//______________________________________________________
	: ($Txt_Requested_Unit="G")  //Giga
		$Txt_Result:=String:C10(Round:C94($Num_Size/(2^30); 0); $Txt_IntegerFormat)+Char:C90(32)+Get localized string:C991("Giga")
		//______________________________________________________
	: ($Txt_Requested_Unit="M")  //Mega
		$Txt_Result:=String:C10(Round:C94($Num_Size/(2^20); 0); $Txt_IntegerFormat)+Char:C90(32)+Get localized string:C991("Mega")
		//______________________________________________________
	: ($Txt_Requested_Unit="K")  //Kilo
		$Txt_Result:=String:C10(Round:C94($Num_Size/(2^10); 0); $Txt_IntegerFormat)+Char:C90(32)+Get localized string:C991("Kilo")
		//______________________________________________________
	: ($Txt_Requested_Unit="O")  //Octets
		$Txt_Result:=String:C10($Num_Size; $Txt_IntegerFormat)+Char:C90(32)+Get localized string:C991("Bytes")
		//______________________________________________________
	Else 
		Case of 
				//…………………………
			: ($Num_Size>=(2^60))  //Exa
				$Txt_Result:=String:C10(Round:C94($Num_Size/(2^60); 2); $Txt_RealFormat)+Char:C90(32)+Get localized string:C991("Exa")
				//…………………………
			: ($Num_Size>=(2^50))  //Peta
				$Txt_Result:=String:C10(Round:C94($Num_Size/(2^50); 2); $Txt_RealFormat)+Char:C90(32)+Get localized string:C991("Peta")
				//…………………………
			: ($Num_Size>=(2^40))  //Tera
				$Txt_Result:=String:C10(Round:C94($Num_Size/(2^40); 2); $Txt_RealFormat)+Char:C90(32)+Get localized string:C991("Tera")
				//…………………………
			: ($Num_Size>=(2^30))  //Giga
				$Txt_Result:=String:C10(Round:C94($Num_Size/(2^30); 2); $Txt_RealFormat)+Char:C90(32)+Get localized string:C991("Giga")
				//…………………………
			: ($Num_Size>=(2^20))  //Mega
				$Txt_Result:=String:C10(Round:C94($Num_Size/(2^20); 2); $Txt_RealFormat)+Char:C90(32)+Get localized string:C991("Mega")
				//…………………………
			: ($Num_Size>=(2^10))  //Kilo
				$Txt_Result:=String:C10(Round:C94($Num_Size/(2^10); 2); $Txt_RealFormat)+Char:C90(32)+Get localized string:C991("Kilo")
				//…………………………
			Else   //Octets
				$Txt_Result:=String:C10($Num_Size; $Txt_IntegerFormat)+Char:C90(32)+Get localized string:C991("Bytes")
				//…………………………
		End case 
		//______________________________________________________
End case 

$0:=$Txt_Result
