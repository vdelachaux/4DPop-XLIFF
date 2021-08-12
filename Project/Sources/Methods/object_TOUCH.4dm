//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : object_TOUCH
// Database: 4DPop XLIFF
// ID[4DE424E494A642958CC9D60A202AF1F2]
// Created #4-6-2013 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Generate an event "On bound variable change" if $1
// is a subform
// ----------------------------------------------------
// Declarations
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters)
C_POINTER:C301($Ptr_object)
C_TEXT:C284($Txt_objectName)

If (False:C215)
	C_TEXT:C284(object_TOUCH; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$Txt_objectName:=$1
	
	$Ptr_object:=OBJECT Get pointer:C1124(Object named:K67:5; $Txt_objectName)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Not:C34(Is nil pointer:C315($Ptr_object)))
	
	If (OBJECT Get type:C1300(*; $Txt_objectName)=Object type subform:K79:40)
		
		$Ptr_object->:=$Ptr_object->
		
	End if 
End if 

// ----------------------------------------------------
// End