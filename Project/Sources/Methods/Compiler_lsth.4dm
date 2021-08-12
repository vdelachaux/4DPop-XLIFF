//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : Compiler_lsth
// Created 01/08/07 by vdl
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------

If (False:C215)
	//******************************************************************  
	C_LONGINT:C283(lsth_DELETE_ITEM; $1)
	C_LONGINT:C283(lsth_DELETE_ITEM; $2)
	//******************************************************************  
	C_LONGINT:C283(lsth_Lon_Get_SublistReference; $0)
	C_POINTER:C301(lsth_Lon_Get_SublistReference; $1)
	C_LONGINT:C283(lsth_Lon_Get_SublistReference; $2)
	C_BOOLEAN:C305(lsth_Lon_Get_SublistReference; $3)
	//******************************************************************  
	C_LONGINT:C283(lsth_Lon_CountFirstLevelItems; $0)
	C_POINTER:C301(lsth_Lon_CountFirstLevelItems; $1)
	//******************************************************************  
	C_POINTER:C301(Lsth_DISPLAY_SCROLLBAR; $1)
	//******************************************************************  
End if 