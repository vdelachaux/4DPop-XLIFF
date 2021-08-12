//%attributes = {}
//SVG_ABOUT

//$x:=12+"alpha"
//ALERT($x)

//SET UPDATE FOLDER("toto")

//alert(Current process)

C_TEXT:C284($Txt_path)
C_OBJECT:C1216($Obj_buffer)

$Txt_path:=Get localized document path:C1105("xml.xlf")

$Obj_buffer:=xliff_toJSON($Txt_path)

If (Not:C34(OB Is empty:C1297($Obj_buffer)))
	
	CLEAR VARIABLE:C89($Obj_buffer)
	
End if 

//  //RESTART 4D
//OPEN DATA FILE(Data file)