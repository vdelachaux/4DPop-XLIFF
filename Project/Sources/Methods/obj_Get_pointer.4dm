//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : obj_Get_pointer
// Created 02/02/09 by Vincent de Lachaux
// ----------------------------------------------------
// Description
// Returns a pointer to the variable associated 
// with the object whose name was passed in $1
// ----------------------------------------------------
// Declarations
C_POINTER:C301($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters)

If (False:C215)
	C_POINTER:C301(obj_Get_pointer; $0)
	C_TEXT:C284(obj_Get_pointer; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$0:=OBJECT Get pointer:C1124(Object named:K67:5; $1)
	
	If (Asserted:C1132(Not:C34(Is nil pointer:C315($0))))
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
//END