//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : DETAILS_UPDATE
// Database: 4DPop XLIFF
// ID[2D66F6F2CC9C4B049D9EE4C177348ED3]
// Created #5-6-2013 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_POINTER:C301($1)

C_BOOLEAN:C305($Boo_copy; $Boo_cut; $Boo_paste; $Boo_sort)
C_LONGINT:C283($Lon_parameters; $Lon_type; $Lon_x)
C_POINTER:C301($Ptr_array; $Ptr_object)
C_TEXT:C284($Txt_name; $Txt_type)

If (False:C215)
	C_POINTER:C301(DETAILS_UPDATE; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	If ($Lon_parameters>=1)
		
		$Ptr_object:=$1
		RESOLVE POINTER:C394($Ptr_object; $Txt_name; $Lon_x; $Lon_x)
		
	Else 
		
		$Ptr_object:=OBJECT Get pointer:C1124(Object with focus:K67:3)
		$Txt_name:=OBJECT Get name:C1087(Object with focus:K67:3)
		
	End if 
	
	$Lon_type:=Type:C295($Ptr_object->)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Form event code:C388=On Losing Focus:K2:8)
	
	GET LIST ITEM PARAMETER:C985(<>Lst_strings; *; "_type"; $Txt_type)
	
	If ($Txt_type="unit")
		
		OBJECT SET VISIBLE:C603(*; $Txt_name+".alert"; Length:C16(Self:C308->)=0)
		
	End if 
	
	OBJECT SET VISIBLE:C603(*; $Txt_name+".tip"; Length:C16(Self:C308->)=0)
	
Else 
	
	OBJECT SET VISIBLE:C603(*; $Txt_name+".alert"; False:C215)
	OBJECT SET VISIBLE:C603(*; $Txt_name+".tip"; True:C214)
	
	Case of 
			
			//................................................
		: (Length:C16($Txt_name)=0)
			
			//................................................
		: ($Txt_name="list.unit")
			
			$Boo_copy:=(Selected list items:C379(*; $Txt_name)>0)
			$Boo_sort:=$Boo_copy
			$Boo_paste:=((Pasteboard data size:C400("private.xliff-editor.group")>0)\
				 | (Pasteboard data size:C400("private.xliff-editor.trans-unit")>0))
			
			//................................................
		: ($Txt_name="dump")
			
			$Ptr_array:=OBJECT Get pointer:C1124(Object named:K67:5; $Txt_name)
			$Boo_copy:=(Find in array:C230($Ptr_array->; True:C214)>0)
			
			//................................................
		: (($Lon_type=Is alpha field:K8:1)\
			 | ($Lon_type=Is string var:K8:2)\
			 | ($Lon_type=Is text:K8:3))
			
			$Boo_cut:=True:C214
			$Boo_copy:=True:C214
			$Boo_paste:=(Length:C16(Get text from pasteboard:C524)>0)
			
			//................................................
	End case 
	
	If ($Boo_paste)
		
		ENABLE MENU ITEM:C149(2; 5)
		
	Else 
		
		DISABLE MENU ITEM:C150(2; 5)
		
	End if 
	
	If ($Boo_cut)
		
		ENABLE MENU ITEM:C149(2; 3)
		
	Else 
		
		DISABLE MENU ITEM:C150(2; 3)
		
	End if 
	
	If ($Boo_copy)
		
		ENABLE MENU ITEM:C149(2; 4)
		
	Else 
		
		DISABLE MENU ITEM:C150(2; 4)
		
	End if 
End if 

// ----------------------------------------------------
// End