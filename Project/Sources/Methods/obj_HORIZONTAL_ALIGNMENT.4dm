//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : obj_HORIZONTAL_ALIGNMENT
// ID[9A3BAC2532834326AA0D4CCCB68276D5]
// Created 19/09/11 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_TEXT:C284(${3})

C_LONGINT:C283($Lon_alignment; $Lon_bottom; $Lon_i; $Lon_j; $Lon_left)
C_LONGINT:C283($Lon_offset; $Lon_parameters; $Lon_reference; $Lon_right; $Lon_top)
C_LONGINT:C283($Lon_width)

If (False:C215)
	C_LONGINT:C283(obj_HORIZONTAL_ALIGNMENT; $1)
	C_LONGINT:C283(obj_HORIZONTAL_ALIGNMENT; $2)
	C_TEXT:C284(obj_HORIZONTAL_ALIGNMENT; ${3})
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=4; "Missing parameter"))
	
	$Lon_alignment:=$1
	$Lon_offset:=$2
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

Case of 
		//______________________________________________________
	: ($Lon_alignment=On the left:K39:2)
		
		For ($Lon_i; 3; $Lon_parameters; 1)
			
			OBJECT GET COORDINATES:C663(*; ${$Lon_i}; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
			
			$Lon_width:=$Lon_right-$Lon_left
			
			For ($Lon_j; $Lon_i+1; $Lon_parameters; 1)
				
				$Lon_reference:=$Lon_right+$Lon_offset
				
				OBJECT GET COORDINATES:C663(*; ${$Lon_j}; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
				
				OBJECT MOVE:C664(*; ${$Lon_j}; $Lon_reference-$Lon_left; 0)
				
			End for 
		End for 
		
		//______________________________________________________
	: ($Lon_alignment=On the right:K39:3)
		
		For ($Lon_i; $Lon_parameters; 3; -1)
			
			OBJECT GET COORDINATES:C663(*; ${$Lon_i}; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
			
			$Lon_width:=$Lon_right-$Lon_left
			
			For ($Lon_j; $Lon_i-1; 3; -1)
				
				$Lon_reference:=$Lon_left-$Lon_offset
				
				OBJECT GET COORDINATES:C663(*; ${$Lon_j}; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
				
				OBJECT MOVE:C664(*; ${$Lon_j}; $Lon_reference-$Lon_right; 0)
				
			End for 
		End for 
		
		//______________________________________________________
	: (False:C215)
		//______________________________________________________
	Else 
		//______________________________________________________
End case 

// ----------------------------------------------------
// End