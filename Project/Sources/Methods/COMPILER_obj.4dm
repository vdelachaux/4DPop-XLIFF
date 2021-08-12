//%attributes = {"invisible":true}

If (False:C215)  //Getter
	
	C_LONGINT:C283(obj_Get_bottom; $0)
	C_TEXT:C284(obj_Get_bottom; $1)
	
	C_LONGINT:C283(obj_Get_height; $0)
	C_TEXT:C284(obj_Get_height; $1)
	
	C_LONGINT:C283(obj_Get_left; $0)
	C_TEXT:C284(obj_Get_left; $1)
	
	C_LONGINT:C283(obj_Get_right; $0)
	C_TEXT:C284(obj_Get_right; $1)
	
	C_LONGINT:C283(obj_Get_top; $0)
	C_TEXT:C284(obj_Get_top; $1)
	
	
	C_LONGINT:C283(obj_Get_width; $0)
	C_TEXT:C284(obj_Get_width; $1)
	
End if 

If (False:C215)  //Setter
	
	C_TEXT:C284(obj_SET_BOTTOM; $1)
	C_LONGINT:C283(obj_SET_BOTTOM; $2)
	
	C_TEXT:C284(obj_SET_HEIGHT; $1)
	C_LONGINT:C283(obj_SET_HEIGHT; $2)
	
	C_TEXT:C284(obj_SET_LEFT; $1)
	C_LONGINT:C283(obj_SET_LEFT; $2)
	
	C_TEXT:C284(obj_SET_RIGHT; $1)
	C_LONGINT:C283(obj_SET_RIGHT; $2)
	C_BOOLEAN:C305(obj_SET_RIGHT; $3)
	
	C_TEXT:C284(obj_SET_TOP; $1)
	C_LONGINT:C283(obj_SET_TOP; $2)
	
	C_TEXT:C284(obj_SET_WIDTH; $1)
	C_LONGINT:C283(obj_SET_WIDTH; $2)
	
End if 


If (False:C215)
	
	C_TEXT:C284(Obj_CENTER; $1)
	C_TEXT:C284(Obj_CENTER; $2)
	C_LONGINT:C283(Obj_CENTER; $3)
	
	C_POINTER:C301(obj_Get_pointer; $0)
	C_TEXT:C284(obj_Get_pointer; $1)
	
	C_TEXT:C284(obj_DISPLAY_LOCALIZED_OBJECTS; $1)
	C_LONGINT:C283(obj_DISPLAY_LOCALIZED_OBJECTS; $2)
	
	C_LONGINT:C283(obj_HORIZONTAL_ALIGNMENT; $1)
	C_LONGINT:C283(obj_HORIZONTAL_ALIGNMENT; $2)
	
	C_TEXT:C284(obj_HORIZONTAL_ALIGNMENT; ${3})
	
	C_LONGINT:C283(obj_SEND_EVENT; $1)
	C_POINTER:C301(obj_SEND_EVENT; ${2})
	
	C_BOOLEAN:C305(obj_SET_VISIBLE; $1)
	C_TEXT:C284(obj_SET_VISIBLE; ${2})
	
	C_TEXT:C284(obj_Txt_3DButton_Format; $0)
	C_TEXT:C284(obj_Txt_3DButton_Format; $1)
	C_TEXT:C284(obj_Txt_3DButton_Format; $2)
	
	C_BOOLEAN:C305(object_ENABLE; $1)
	C_TEXT:C284(object_ENABLE; ${2})
	
End if 
