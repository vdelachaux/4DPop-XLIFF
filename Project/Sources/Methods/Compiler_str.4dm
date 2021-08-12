//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : Compiler_str
// Created 01/08/07 by vdl
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------

If (False:C215)
	//******************************************************************  
	C_BOOLEAN:C305(str_gBoo_Equal; $0)
	C_TEXT:C284(str_gBoo_Equal; $1)
	C_TEXT:C284(str_gBoo_Equal; $2)
	//******************************************************************  
	C_TEXT:C284(str_Txt_Decode_Text; $0)
	C_TEXT:C284(str_Txt_Decode_Text; $1)
	C_TEXT:C284(str_Txt_Decode_Text; $2)
	//******************************************************************  
	C_TEXT:C284(str_gTxt_Encode_Text; $0)
	C_TEXT:C284(str_gTxt_Encode_Text; $1)
	C_TEXT:C284(str_gTxt_Encode_Text; $2)
	//******************************************************************  
	C_LONGINT:C283(str_gLon_Occurence_Number; $0)
	C_TEXT:C284(str_gLon_Occurence_Number; $1)
	C_TEXT:C284(str_gLon_Occurence_Number; $2)
	//******************************************************************  
End if 

