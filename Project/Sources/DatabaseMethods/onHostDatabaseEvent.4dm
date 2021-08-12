// ----------------------------------------------------
// Method :  Host Database Event - (4DPop XLIFF)
// ID[AB9963B3CEDC4C6FAC8E1694CDEE0C44]
// Created #16-5-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_databaseEvent)

// ----------------------------------------------------
// Initialisations
$Lon_databaseEvent:=$1

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_databaseEvent=On before host database startup:K74:3)
		
		//The host database has just been started. The On Startup database method method
		//of the host database has not yet been called.
		//The On Startup database method of the host database is not called while the On
		//Host Database Event database method of the component is running
		
		//______________________________________________________
	: ($Lon_databaseEvent=On after host database startup:K74:4)
		
		//The On Startup database method of the host database just finished running
		
		//______________________________________________________
	: ($Lon_databaseEvent=On before host database exit:K74:5)
		
		//The host database is closing. The On Exit database method of the host database
		//has not yet been called.
		//The On Exit database method of the host database is not called while the On Host
		//Database Event database method of the component is running
		
		//______________________________________________________
	: ($Lon_databaseEvent=On after host database exit:K74:6)
		
		//The On Exit database method of the host database has just finished running
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_databaseEvent)+")")
		
		//______________________________________________________
End case 