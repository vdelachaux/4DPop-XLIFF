//%attributes = {"invisible":true}

C_LONGINT:C283(xml_last_error)

If (False:C215)
	
	C_TEXT:C284(object_TOUCH; $1)
	
	xml_NO_ERROR
	
	C_TEXT:C284(xml_GET_ATTRIBUTES_ARRAYS; $1)
	C_POINTER:C301(xml_GET_ATTRIBUTES_ARRAYS; $2)
	C_POINTER:C301(xml_GET_ATTRIBUTES_ARRAYS; $3)
	
	C_TEXT:C284(xml_Error_text; $0)
	C_LONGINT:C283(xml_Error_text; $1)
	
	C_LONGINT:C283(xml_Validation; $0)
	C_TEXT:C284(xml_Validation; $1)
	C_TEXT:C284(xml_Validation; $2)
	
End if 