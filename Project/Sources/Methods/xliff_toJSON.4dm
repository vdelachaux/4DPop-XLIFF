//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : xliff_toJSON
// ID[EB6B801E346A4BB08BA1A0256B76F992]
// Created 01/12/11 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Converts a XLIFF file into a JSON object
// The result, extracted from the file $1, will be like this {"resname 1":"string 1","resname 2":"string 2",...,"resname N":"string N",}
// If $2 parameter is given, the extraction is limited to the group whose the resname is equal to $2.
// Note: the string value is the contents of the target element, except if attribute 'translate' is 'no'. In this case, it's the source element value that is returned
// ----------------------------------------------------
// Declarations
C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BLOB:C604($Blb_result; $Blb_source; $Blb_xsl)
C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_buffer; $Txt_groupResname; $Txt_path; $Txt_XSL)

If (False:C215)
	C_OBJECT:C1216(xliff_toJSON; $0)
	C_TEXT:C284(xliff_toJSON; $1)
	C_TEXT:C284(xliff_toJSON; $2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//$Txt_xliffFile:=$1
	
	If (Test path name:C476($1)#Is a document:K24:1)
		
		$Txt_path:=Get localized document path:C1105($1)
		
	Else 
		
		$Txt_path:=$1
		
	End if 
	
	If ($Lon_parameters>=2)
		
		$Txt_groupResname:=$2
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

If (Asserted:C1132(Test path name:C476($Txt_path)=Is a document:K24:1))
	
	$Txt_XSL:=$Txt_XSL+"<?xml version=\"1.0\" encoding=\"utf-8\"?>\r"\
		+"<xsl:stylesheet version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\"\r"\
		+"xmlns:dyn=\"http://exslt.org/dynamic\"\r"\
		+"extension-element-prefixes=\"dyn\">\r"\
		+"<xsl:output method=\"text\" encoding=\"UTF-8\" indent=\"no\" omit-xml-declaration=\"yes\"/>\r"\
		+"<xsl:param name=\"xpath_in\" select=\"'//group/trans-unit'\"/>\r"\
		+"<xsl:template match=\"/\">\r"\
		+"<xsl:text>{\r"\
		+"</xsl:text>\r"\
		+"<xsl:for-each select=\"dyn:evaluate($xpath_in)\">\r"\
		+"<xsl:text>\"</xsl:text>\r"\
		+"<xsl:value-of select=\"@resname\"/>\r"\
		+"<xsl:text>\":\"</xsl:text>\r"\
		+"<xsl:choose>\r"\
		+"<xsl:when test=\"@translate='no'\">\r"\
		+"<xsl:value-of select=\"./source\"/>\r"\
		+"</xsl:when>\r"\
		+"<xsl:otherwise>\r"\
		+"<xsl:value-of select=\"./target\"/>\r"\
		+"</xsl:otherwise>\r"\
		+"</xsl:choose>\r"\
		+"<xsl:text>\",\r"\
		+"</xsl:text>\r"\
		+"</xsl:for-each>\r"\
		+"<xsl:text>}</xsl:text>\r"\
		+"</xsl:template>\r"\
		+"</xsl:stylesheet>\r"
	
	CONVERT FROM TEXT:C1011($Txt_XSL; "UTF-8"; $Blb_xsl)
	
	If (Length:C16($Txt_groupResname)>0)
		
		_O_XSLT SET PARAMETER:C883("xpath_in"; "'//group[@resname=\""+$Txt_groupResname+"\"]/trans-unit'")
		
	End if 
	
	DOCUMENT TO BLOB:C525($Txt_path; $Blb_source)
	
	_O_XSLT APPLY TRANSFORMATION:C882($Blb_source; $Blb_xsl; $Blb_result; True:C214)
	
	If (OK=1)
		
		$Txt_buffer:=Convert to text:C1012($Blb_result; "UTF-8")
		
		//remove the last comma of each arrays
		$Txt_buffer:=Replace string:C233($Txt_buffer; "\",\n}"; "\"\n}")
		
		$0:=JSON Parse:C1218($Txt_buffer)
		
	End if 
End if 

// ----------------------------------------------------
// End