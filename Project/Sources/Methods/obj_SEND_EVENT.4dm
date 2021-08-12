//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : Méthode : obj_SEND_EVENT
// Created 30/04/09 by Vincent de Lachaux
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($1)
C_POINTER:C301(${2})

C_LONGINT:C283($Lon_i; $Lon_parameters)

ARRAY POINTER:C280($tPtr_objectVariable; 0)
ARRAY TEXT:C222($tTxt_objectNames; 0)

If (False:C215)
	C_LONGINT:C283(obj_SEND_EVENT; $1)
	C_POINTER:C301(obj_SEND_EVENT; ${2})
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

// ----------------------------------------------------

If ($Lon_parameters>=2)
	
	For ($Lon_i; 2; $Lon_parameters-1)
		
		${$Lon_i}->:=$1
		
	End for 
	
Else 
	
	FORM GET OBJECTS:C898($tTxt_objectNames; $tPtr_objectVariable)
	
	For ($Lon_i; 1; Size of array:C274($tTxt_objectNames))
		
		If ($tTxt_objectNames{$Lon_i}="@.frame.@")
			
			If (Type:C295($tPtr_objectVariable{$Lon_i}->)=Is longint:K8:6)
				
				$tPtr_objectVariable{$Lon_i}->:=$1
				
			End if 
		End if 
		
	End for 
	
End if 

CALL SUBFORM CONTAINER:C1086(-100)