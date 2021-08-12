//%attributes = {"invisible":true,"executedOnServer":true}
// ----------------------------------------------------
// Method : env_UPDATE_RESOURCES
// Created 28/05/08 by vdl
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
// Note
// This method is executed on server
// ----------------------------------------------------
var $1 : Blob
var $2 : Blob

If (False:C215)
	C_BLOB:C604(env_UPDATE_RESOURCES; $1)
	C_BLOB:C604(env_UPDATE_RESOURCES; $2)
End if 

var $pathname : Text
var $i; $mode; $offset : Integer
var $data; $x : Blob

If (Count parameters:C259>0)
	
	For ($i; 1; Count parameters:C259; 1)
		
		$offset:=0
		
		If ($i=1)
			
			COPY BLOB:C558($1; $data; 0; 0; BLOB size:C605($1))
			
		Else 
			
			COPY BLOB:C558($2; $data; 0; 0; BLOB size:C605($1))
			
		End if 
		
		BLOB PROPERTIES:C536($data; $mode)
		
		If ($mode#Is not compressed:K22:11)
			
			EXPAND BLOB:C535($data)
			
		End if 
		
		BLOB TO VARIABLE:C533($data; $pathname; $offset)
		BLOB TO VARIABLE:C533($data; $x; $offset)
		SET BLOB SIZE:C606($data; 0)
		
		If (OK=1)
			
			$pathname:=Replace string:C233($pathname; "/"; Folder separator:K24:12)
			$pathname:=Get 4D folder:C485(Database folder:K5:14; *)+$pathname
			
			If (Test path name:C476($pathname)=Is a document:K24:1)
				
				DELETE DOCUMENT:C159($pathname)
				
			Else 
				
			End if 
			
			If (OK=1)
				
				BLOB TO DOCUMENT:C526($pathname; $x)
				
			End if 
		End if 
	End for 
	
	NOTIFY RESOURCES FOLDER MODIFICATION:C1052
	
End if 