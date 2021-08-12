//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : str_gBoo_Equal
// Created le 1/12/98 by vdl
// ----------------------------------------------------
// Description
// Comparaison diacritique de 2 chaines de caractères
//
// str_gBoo_Equal ("caractères";"caracteres") is False
// str_gBoo_Equal ("Vincent";"vincent") is False
// ----------------------------------------------------
// Modified by Vincent de Lachaux (11/07/08)
// Plus rapide avec position diacritique de la v11
// ----------------------------------------------------
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

If (False:C215)
	C_BOOLEAN:C305(str_gBoo_Equal; $0)
	C_TEXT:C284(str_gBoo_Equal; $1)
	C_TEXT:C284(str_gBoo_Equal; $2)
End if 

//$Txt_1:=$1
//$Txt_2:=$2
//$Lon_End_i:=Longueur($Txt_1)

//Si ($Lon_End_i=Longueur($Txt_2))

//Tant que ($Lon_End_i%4#0)
//$Txt_1:=$Txt_1+"•"
//$Txt_2:=$Txt_2+"•"
//$Lon_End_i:=Longueur($Txt_1)
//Fin tant que 
//
//Boucle ($Lon_i;1;$Lon_End_i;4)
//$Lon_Offset:=0
//FIXER TAILLE BLOB($Blb_Buffer;0)
//TEXTE VERS BLOB(Sous chaine($Txt_1;$Lon_i;4);$Blb_Buffer;Mac Texte sans longueur ;*)
//$Lon_1:=BLOB vers entier long($Blb_Buffer;Ordre octets Macintosh ;$Lon_Offset)
//
//$Lon_Offset:=0
//FIXER TAILLE BLOB($Blb_Buffer;0)
//TEXTE VERS BLOB(Sous chaine($Txt_2;$Lon_i;4);$Blb_Buffer;Mac Texte sans longueur ;*)
//$Lon_2:=BLOB vers entier long($Blb_Buffer;Ordre octets Macintosh ;$Lon_Offset)
//
//$Boo_OK:=($Lon_1=$Lon_2)
//
//Si (Non($Boo_OK))
//$Lon_i:=$Lon_End_i+1
//Fin de si 
//Fin de boucle 

//Fin de si 

//$0:=$Boo_OK

$0:=((Length:C16($1)=Length:C16($2)) & (Position:C15($1; $2; *)=1))
