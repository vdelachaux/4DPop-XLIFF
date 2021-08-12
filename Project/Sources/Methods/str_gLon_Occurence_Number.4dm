//%attributes = {"invisible":true}
// ----------------------------------------------------
// Methode : str_gLon_Occurence_Number
// Creee le 22/12/05 par vincent de lachaux
// ----------------------------------------------------
// Description
// Returns the number of the events of $2 in $1
// ----------------------------------------------------
C_LONGINT:C283($0)  //Number of occurences
C_TEXT:C284($1)  //String in which to search
C_TEXT:C284($2)  //String to find

If (False:C215)
	C_LONGINT:C283(str_gLon_Occurence_Number; $0)
	C_TEXT:C284(str_gLon_Occurence_Number; $1)
	C_TEXT:C284(str_gLon_Occurence_Number; $2)
End if 

$0:=(Length:C16($1)-Length:C16(Replace string:C233($1; $2; "")))/Length:C16($2)
