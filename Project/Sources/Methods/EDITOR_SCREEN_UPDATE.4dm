//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : EDITOR_SCREEN_UPDATE
// ID[53B9155AD8E4456F9CB0E7EE48F2F0BA]
// Created 02/11/06 by vdl
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($Boo_multistyle)
C_LONGINT:C283($Lon_bottom; $Lon_left; $Lon_parameters; $Lon_ref; $Lon_right; $Lon_top)
C_POINTER:C301($Ptr_id; $Ptr_noTranslate; $Ptr_resname; $Ptr_source; $Ptr_target)
C_TEXT:C284($kTxt_id; $kTxt_noTranslate; $kTxt_resname; $kTxt_source; $kTxt_target; $Txt_type)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	$kTxt_resname:="resname_box"
	$kTxt_id:="id_box"
	$kTxt_source:="unit_source_box.resize"
	$kTxt_noTranslate:="unit_translate.move"
	$kTxt_target:="unit_target_box.move.resize"
	
	$Ptr_resname:=OBJECT Get pointer:C1124(Object named:K67:5; $kTxt_resname)
	ASSERT:C1129(Not:C34(Is nil pointer:C315($Ptr_resname)))
	
	$Ptr_id:=OBJECT Get pointer:C1124(Object named:K67:5; $kTxt_id)
	ASSERT:C1129(Not:C34(Is nil pointer:C315($Ptr_id)))
	
	$Ptr_source:=OBJECT Get pointer:C1124(Object named:K67:5; $kTxt_source)
	ASSERT:C1129(Not:C34(Is nil pointer:C315($Ptr_source)))
	
	$Ptr_noTranslate:=OBJECT Get pointer:C1124(Object named:K67:5; $kTxt_noTranslate)
	ASSERT:C1129(Not:C34(Is nil pointer:C315($Ptr_noTranslate)))
	
	$Ptr_target:=OBJECT Get pointer:C1124(Object named:K67:5; $kTxt_target)
	ASSERT:C1129(Not:C34(Is nil pointer:C315($Ptr_target)))
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Selected list items:C379(<>Lst_strings)>0)
	
	OBJECT SET VISIBLE:C603(*; "@label"; True:C214)
	OBJECT SET VISIBLE:C603(*; "@box"; True:C214)
	OBJECT SET VISIBLE:C603(*; "@alert"; False:C215)
	OBJECT SET VISIBLE:C603(*; "@button"; True:C214)
	
	OBJECT SET ENTERABLE:C238(*; $kTxt_resname; True:C214)
	OBJECT SET ENTERABLE:C238(*; $kTxt_id; True:C214)
	
	$Lon_ref:=Selected list items:C379(<>Lst_strings; *)
	
	GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_ref; "_type"; $Txt_type)
	GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_ref; "id"; $Ptr_id->)
	GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_ref; "resname"; $Ptr_resname->)
	
	If ($Txt_type="unit")  //Transunit
		
		OBJECT SET VISIBLE:C603(*; "resname_box.alert"; Length:C16($Ptr_resname->)=0)
		
		OBJECT SET VISIBLE:C603(*; "unit@"; True:C214)
		OBJECT SET VISIBLE:C603(*; "id_box.alert"; Length:C16($Ptr_id->)=0)
		
		OBJECT SET ENTERABLE:C238(*; $kTxt_source; True:C214)
		OBJECT SET ENABLED:C1123(*; $kTxt_noTranslate; True:C214)
		
		GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_ref; "_source"; $Ptr_source->)
		
		If ($Ptr_noTranslate->=1)\
			 | (<>Txt_targetLang=<>Txt_sourceLang)
			
			$Ptr_target->:=$Ptr_source->
			OBJECT SET ENTERABLE:C238(*; $kTxt_target; False:C215)
			
			OBJECT SET VISIBLE:C603(*; "@target@"; False:C215)
			
		Else 
			
			OBJECT SET ENTERABLE:C238(*; $kTxt_target; True:C214)
			GET LIST ITEM PARAMETER:C985(<>Lst_strings; $Lon_ref; "_target"; $Ptr_target->)
			OBJECT SET VISIBLE:C603(*; "@target@"; True:C214)
			
		End if 
		
		$Boo_multistyle:=(Position:C15("<SPAN"; $Ptr_source->)#0)
		
		If ($Boo_multistyle)
			
			(OBJECT Get pointer:C1124(Object named:K67:5; "unit_source_M_box"))->:=$Ptr_source->
			(OBJECT Get pointer:C1124(Object named:K67:5; "unit_target_M_box"))->:=$Ptr_target->
			
			OBJECT GET COORDINATES:C663(*; "unit_source_box.resize"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
			OBJECT MOVE:C664(*; "unit_source_M_box"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom; *)
			
			OBJECT GET COORDINATES:C663(*; "unit_target_box.move.resize"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
			OBJECT MOVE:C664(*; "unit_target_M_box"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom; *)
			
			OBJECT SET VISIBLE:C603(*; "unit_source_M_box"; True:C214)
			OBJECT SET VISIBLE:C603(*; "unit_target_M_box"; $Ptr_noTranslate->=0)
			
			OBJECT SET VISIBLE:C603(*; "unit_source_box.resize"; False:C215)
			OBJECT SET VISIBLE:C603(*; "unit_target_box.move.resize"; False:C215)
			
		Else 
			
			OBJECT SET VISIBLE:C603(*; "unit_source_box.resize"; True:C214)
			OBJECT SET VISIBLE:C603(*; "unit_target_box.move.resize"; $Ptr_noTranslate->=0)
			OBJECT SET VISIBLE:C603(*; "unit_source_M_box"; False:C215)
			OBJECT SET VISIBLE:C603(*; "unit_target_M_box"; False:C215)
			
		End if 
		
	Else 
		
		OBJECT SET VISIBLE:C603(*; "unit@"; False:C215)
		
		OBJECT SET ENTERABLE:C238(*; $kTxt_source; False:C215)
		OBJECT SET ENTERABLE:C238(*; $kTxt_target; False:C215)
		OBJECT SET ENABLED:C1123(*; $kTxt_noTranslate; False:C215)
		
		OBJECT SET VISIBLE:C603(*; "unit_source_M_box"; False:C215)
		OBJECT SET VISIBLE:C603(*; "unit_target_M_box"; False:C215)
		
	End if 
	
	OBJECT SET ENABLED:C1123(*; "toolbar.sort"; True:C214)
	OBJECT SET ENABLED:C1123(*; "key.@"; True:C214)
	
Else 
	
	OBJECT SET VISIBLE:C603(*; "unit@"; False:C215)
	OBJECT SET VISIBLE:C603(*; "@label"; False:C215)
	OBJECT SET VISIBLE:C603(*; "@box"; False:C215)
	OBJECT SET VISIBLE:C603(*; "@alert"; False:C215)
	OBJECT SET VISIBLE:C603(*; "@button"; False:C215)
	
	OBJECT SET ENTERABLE:C238(*; $kTxt_resname; False:C215)
	OBJECT SET ENTERABLE:C238(*; $kTxt_id; False:C215)
	OBJECT SET ENTERABLE:C238(*; $kTxt_source; False:C215)
	OBJECT SET ENABLED:C1123(*; $kTxt_noTranslate; False:C215)
	OBJECT SET ENTERABLE:C238(*; $kTxt_target; False:C215)
	
	OBJECT SET ENABLED:C1123(*; "toolbar.sort"; False:C215)
	OBJECT SET ENABLED:C1123(*; "key.@"; False:C215)
	
End if 

// ----------------------------------------------------
// End