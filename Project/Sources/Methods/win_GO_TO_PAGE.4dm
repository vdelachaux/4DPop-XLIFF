//%attributes = {"invisible":true}
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_page; $Lon_x)

If (False:C215)
	C_LONGINT:C283(win_GO_TO_PAGE; $1)
End if 

$Lon_page:=FORM Get current page:C276

If ($Lon_page#$1)
	
	ARRAY TEXT:C222($tTxt_objects; 0x0000)
	ARRAY POINTER:C280($tPtr_variables; 0x0000)
	ARRAY LONGINT:C221($tLon_pages; 0x0000)
	
	FORM GET OBJECTS:C898($tTxt_objects; $tPtr_variables; $tLon_pages; *)
	
	$Lon_x:=0
	Repeat 
		
		$Lon_x:=Find in array:C230($tLon_pages; $Lon_page; $Lon_x+1)
		
		If ($Lon_x>0)
			
			OBJECT SET VISIBLE:C603(*; $tTxt_objects{$Lon_x}; False:C215)
			
		End if 
		
	Until ($Lon_x=-1)
	
	OBJECT SET VISIBLE:C603(*; "00.@.Move"; False:C215)
	
	REDRAW WINDOW:C456
	
	FORM GOTO PAGE:C247($1)
	
	SET TIMER:C645(1)
	
End if 