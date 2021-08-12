//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Méthode : xlf_Txt_Format
// Créée le 14/11/05 par vdl
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_BOOLEAN:C305($3)

C_BOOLEAN:C305($Boo_xmlCompliant)
C_LONGINT:C283($Lon_Parameters)
C_TEXT:C284($Txt_format; $Txt_in; $Txt_out)

If (False:C215)
	C_TEXT:C284(xliff_Txt_Format; $0)
	C_TEXT:C284(xliff_Txt_Format; $1)
	C_TEXT:C284(xliff_Txt_Format; $2)
	C_BOOLEAN:C305(xliff_Txt_Format; $3)
End if 

$Lon_Parameters:=Count parameters:C259

If ($Lon_Parameters>0)
	
	$Txt_format:=$1  //wanted format
	
	If ($Lon_Parameters>1)
		
		$Txt_in:=$2  //text to format
		
		// Added #15-5-2013 by Vincent de Lachaux
		If ($Lon_Parameters>=3)
			
			$Boo_xmlCompliant:=$3  //encode ampersand, leth than and greater than
			
		End if 
	End if 
End if 

Case of 
		
		//______________________________________________________
	: ($Txt_format="xliff_date")  //Date in [ISO 8601] Format.
		
		//The recommended pattern to use is: CCYY-MM-DDThh:mm:ssZ
		//Where: CCYY is the year (4 digits),
		//MM is the month (2 digits),
		//DD is the day (2 digits),
		//hh is the hours (2 digits),
		//mm is the minutes (2 digits),`
		//ss is the second(2 digits)
		//and Z indicates the time is UTC time.
		
		//C_DATE($Dat)
		//C_HEURE($Gmt)
		//C_TEXTE($Txt_Buffer)
		//$Dat:=Date du jour(*)
		//$Gmt:=Heure courante(*)
		//$Txt_Out:=Chaine(Annee de($Dat))+"-"
		//$Txt_Out:=$Txt_Out+Chaine(Mois de($Dat);"00")+"-"
		//$Txt_Out:=$Txt_Out+Chaine(Jour de($Dat);"00")+"T"
		//$Txt_Out:=$Txt_Out+Chaine($Gmt;1)+"Z"
		
		$Txt_out:=String:C10(Current date:C33; ISO date:K1:8)+"Z"
		
		//______________________________________________________
	: ($Txt_format="xliff_STR#")
		
		$Txt_out:=$Txt_in
		
		//Restaurer les méta caractères
		$Txt_out:=Replace string:C233($Txt_out; Char:C90(Carriage return:K15:38); "\\r")
		$Txt_out:=Replace string:C233($Txt_out; Char:C90(Tab:K15:37); "\\t")
		$Txt_out:=Replace string:C233($Txt_out; Char:C90(Line feed:K15:40); "\\n")
		
		//______________________________________________________
	Else 
		
		$Txt_out:=$Txt_format
		
		//______________________________________________________
End case 

//===========================================
// v12 : La conversion est enfin automatique !!!!
//===========================================
//$Txt_Out:=Remplacer chaine($Txt_Out;"&";"&amp;")  //ampersand
//$Txt_Out:=Remplacer chaine($Txt_Out;"<";"&lt;")  //less than
//$Txt_Out:=Remplacer chaine($Txt_Out;">";"&gt;")  //greater than
//$Txt_Out:=Remplacer chaine($Txt_Out;Caractere(39);"&apos;")  //apostrophe
//$Txt_Out:=Remplacer chaine($Txt_Out;Caractere(Guillemets );"&quot;")  //quotation mark
//===========================================

If ($Boo_xmlCompliant)
	
	$Txt_out:=Replace string:C233($Txt_out; "&"; "&amp;")  //ampersand
	$Txt_out:=Replace string:C233($Txt_out; "<"; "&lt;")  //less than
	$Txt_out:=Replace string:C233($Txt_out; ">"; "&gt;")  //greater than
	
End if 

$0:=$Txt_out  //formatted text