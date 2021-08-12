//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : EDITOR_Autofill
// Database: 4DPop XLIFF
// ID[0A5B1933C9684DDB93177E63169C85B3]
// Created #27-6-2013 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($Boo_capitalize)
C_LONGINT:C283($Lon_buffer; $Lon_i; $Lon_parameters)
C_TEXT:C284($Txt_characterEscaped; $Txt_groupName; $Txt_resname; $Txt_Source; $Txt_stopCaracters)

If (False:C215)
	C_TEXT:C284(EDITOR_Autofill; $0)
	C_TEXT:C284(EDITOR_Autofill; $1)
	C_TEXT:C284(EDITOR_Autofill; $2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$Txt_Source:=$1
	$Txt_groupName:=$2
	
	DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "ignored_characters"; $Txt_characterEscaped)
	$Txt_characterEscaped:=Replace string:C233($Txt_characterEscaped; "\\r"; "\r")
	$Txt_characterEscaped:=Replace string:C233($Txt_characterEscaped; "\\n"; "\n")
	$Txt_characterEscaped:=Replace string:C233($Txt_characterEscaped; "\\t"; "\t")
	$Txt_characterEscaped:=Replace string:C233($Txt_characterEscaped; "\\\""; Char:C90(Double quote:K15:41))
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Length:C16(<>Txt_prefix)=0)
	
	If (Position:C15($Txt_groupName; $Txt_Source)#1)
		
		$Txt_resname:=$Txt_groupName\
			+Choose:C955(Length:C16(<>Txt_prefixSeparator)=0; "_"; <>Txt_prefixSeparator)\
			+$Txt_Source
		
	End if 
	
Else 
	
	If (Position:C15(<>Txt_prefix; $Txt_Source)#1)
		
		$Txt_resname:=<>Txt_prefix+$Txt_Source
		
	End if 
End if 

$Txt_resname:=Lowercase:C14($Txt_resname)

$Boo_capitalize:=True:C214  //The first is capitalized

For ($Lon_i; 1; Length:C16($Txt_resname); 1)
	
	Case of 
			
			//______________________________________________________
		: ($Lon_i>Length:C16($Txt_resname))
			
			//______________________________________________________
		: (Position:C15($Txt_resname[[$Lon_i]]; $Txt_stopCaracters)>0)
			
			$Txt_resname:=Substring:C12($Txt_resname; 1; $Lon_i-1)
			$Lon_i:=MAXLONG:K35:2+1
			
			//______________________________________________________
		: (Position:C15($Txt_resname[[$Lon_i]]; $Txt_characterEscaped)>0)
			
			$Boo_capitalize:=($Boo_capitalize | (($Txt_resname[[$Lon_i]]=" ")))
			$Txt_resname:=Replace string:C233($Txt_resname; $Txt_resname[[$Lon_i]]; ""; 1)
			$Lon_i:=$Lon_i-1
			
			//______________________________________________________
		: ($Boo_capitalize)
			
			$Txt_resname[[$Lon_i]]:=Uppercase:C13($Txt_resname[[$Lon_i]])
			$Boo_capitalize:=False:C215
			
			//______________________________________________________
	End case 
End for 

DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object\
; "max_resname_size"; $Lon_buffer)

If ($Lon_buffer>0)
	
	$Txt_resname:=Substring:C12($Txt_resname; 1; $Lon_buffer)
	
End if 

$0:=$Txt_resname

// ----------------------------------------------------
// End