//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : EDITOR_SEARCH
// Database: 4DPop XLIFF
// ID[5FFE0BAB23484984B6C976DF2651F6EF]
// Created #16-5-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_parameters; $Lon_Reference; $Lon_start; $Lon_x)
C_POINTER:C301($Ptr_id; $Ptr_resname; $Ptr_source; $Ptr_target)
C_TEXT:C284($Txt_query)

If (False:C215)
	C_LONGINT:C283(EDITOR_SEARCH; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	$Ptr_id:=OBJECT Get pointer:C1124(Object named:K67:5; "search.list.id")
	ASSERT:C1129(Not:C34(Is nil pointer:C315($Ptr_id)))
	
	$Ptr_resname:=OBJECT Get pointer:C1124(Object named:K67:5; "search.list.resname")
	ASSERT:C1129(Not:C34(Is nil pointer:C315($Ptr_resname)))
	
	$Ptr_source:=OBJECT Get pointer:C1124(Object named:K67:5; "search.list.source")
	ASSERT:C1129(Not:C34(Is nil pointer:C315($Ptr_source)))
	
	$Ptr_target:=OBJECT Get pointer:C1124(Object named:K67:5; "search.list.target")
	ASSERT:C1129(Not:C34(Is nil pointer:C315($Ptr_target)))
	
	//$Boo_previous:=Shift down
	//$Ptr_order:=OBJECT Get pointer(Object named;"search.list.order")
	//ASSERT(Not(Nil($Ptr_order)))
	
	
	If (Count parameters:C259>=1)
		
		$Lon_start:=$1
		
	Else 
		
		$Lon_start:=$Ptr_resname->
		
		//If ($Boo_previous)
		
		//LISTBOX SORT COLUMNS(*;"search.list";5;<)
		
		//Else 
		
		//LISTBOX SORT COLUMNS(*;"search.list";5;>)
		
		//End if 
		
		//$Lon_count:=LISTBOX Get number of rows(*;"search.list")
		
		//If ($Boo_previous)
		
		//$Lon_start:=
		
		//$Lon_start:=$Lon_start+1
		
		//If ($Lon_start>Size of array($Ptr_id->))
		
		//$Lon_start:=0
		
		//End if 
		
		//Else 
		
		If ($Lon_start>0)
			
			Repeat 
				
				If ($Ptr_id->{$Lon_start}<0)
					
					$Lon_start:=$Lon_start+1
					
					If ($Lon_start>Size of array:C274($Ptr_id->))
						
						$Lon_start:=0
						
					End if 
				End if 
			Until ($Lon_start>=0)
			
		End if 
		
	End if 
	//End if 
	
	$Txt_query:=<>tTxt_Search{0}
	$Lon_x:=Position:C15(":"; $Txt_query)
	
	If ($Lon_x>0)
		
		$Txt_query:=Delete string:C232($Txt_query; 1; $Lon_x)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: (<>tTxt_Search{0}="source:@")
		
		$Lon_x:=Find in array:C230($Ptr_source->; "@"+$Txt_query+"@"; $Lon_start+1)
		
		//______________________________________________________
	: (<>tTxt_Search{0}="target:@")
		
		$Lon_x:=Find in array:C230($Ptr_target->; "@"+$Txt_query+"@"; $Lon_start+1)
		
		//______________________________________________________
	: (<>tTxt_Search{0}="id:@")
		
		$Lon_x:=Find in array:C230($Ptr_id->; $Txt_query)
		
		//______________________________________________________
	Else 
		
		//If ($Boo_previous)
		//$Lon_selected:=Find in array($Ptr_search->;True)
		//  //For ($Lon_i;$Lon_selected-1;1;-1)
		//  //If ($Lon_i>0)
		//  //If ($Ptr_resname->{$Lon_i}=("@"+$Txt_query+"@"))
		//  //$Lon_x:=$Lon_i
		//  //$Lon_i:=0
		//  //End if
		//  //End if
		//  //End for
		//COPY ARRAY($Ptr_resname->;$tTxt_buffer)
		//COPY ARRAY($Ptr_id->;$tLon_reference)
		//$Ptr_id:=->$tLon_reference
		//$Lon_count:=Size of array($tTxt_buffer)
		//ARRAY LONGINT($tLon_order;$Lon_count)
		//For ($Lon_i;1;$Lon_count;1)
		//$tLon_order{$Lon_i}:=$Lon_i
		//End for
		//SORT ARRAY($tLon_order;$tTxt_buffer;$tLon_reference;<)
		//$Lon_start:=Find in array($tLon_order;$Lon_selected)
		//$Lon_x:=Find in array($tTxt_buffer;"@"+$Txt_query+"@";$Lon_start+1)
		//Else
		$Lon_x:=Find in array:C230($Ptr_resname->; "@"+$Txt_query+"@"; $Lon_start+1)
		
		//End if 
		
		//______________________________________________________
End case 

//http://forums.4d.fr/Post/FR/16198779/0/0/
//$Lon_Reference:=Choose($Lon_x>0;$Ptr_id->{$Lon_x};0)
If ($Lon_x>0)
	
	$Lon_Reference:=$Ptr_id->{$Lon_x}
	
End if 

LISTBOX SELECT ROW:C912(*; "search.list"; Choose:C955($Lon_x>0; $Lon_x; 0); lk replace selection:K53:1)

If ($Lon_Reference#0)
	
	SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_strings; $Lon_Reference)
	OBJECT SET SCROLL POSITION:C906(<>Lst_strings; List item position:C629(<>Lst_strings; $Lon_Reference))
	
	form_timerEvent(2; -1)
	
	GOTO OBJECT:C206(<>Lst_strings)
	
Else 
	
	BEEP:C151
	
End if 

$Lon_x:=Find in array:C230(<>tTxt_Search; <>tTxt_Search{0})

If ($Lon_x=-1)
	
	APPEND TO ARRAY:C911(<>tTxt_Search; <>tTxt_Search{0})
	
End if 
// ----------------------------------------------------
// End