//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : form_timerEvent
// ID[5724745EDCF043DEB2C729D447591FB6]
// Created 22/03/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Get/set set generic timer event object
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($Lon_parameters)
C_POINTER:C301($Ptr_timerEvent)

If (False:C215)
	C_LONGINT:C283(form_timerEvent; $0)
	C_LONGINT:C283(form_timerEvent; $1)
	C_LONGINT:C283(form_timerEvent; $2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	$Ptr_timerEvent:=OBJECT Get pointer:C1124(Object named:K67:5; "_timerEvent")
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If ($Lon_parameters=0)
	
	//return the current value & clear
	
	$0:=$Ptr_timerEvent->
	
	CLEAR VARIABLE:C89($Ptr_timerEvent->)
	
Else 
	
	//set the current value 
	If (Not:C34(Is nil pointer:C315($Ptr_timerEvent)))
		
		$Ptr_timerEvent->:=$1
		
	End if 
	
	If ($1#0) & ($Lon_parameters>=2)
		
		//start the timer
		SET TIMER:C645($2)
		
	End if 
End if 

// ----------------------------------------------------
// End