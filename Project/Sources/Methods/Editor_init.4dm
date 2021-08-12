//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : XLIFF_Boo_Editor_Init
// Created 21/03/07 by vdl
// ----------------------------------------------------
// Description
// Module Initialisations
// ----------------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($Boo_ok)
C_LONGINT:C283($Lon_buffer; $Lon_version)
C_TEXT:C284($Txt_buffer; $Txt_buffer_2; $Txt_errorMethod; $Txt_pathCible; $Txt_pathSource)

If (False:C215)
	C_BOOLEAN:C305(Editor_init; $0)
	C_LONGINT:C283(Editor_init; $1)
End if 

$Lon_version:=$1
$Boo_ok:=True:C214

<>Dom_object:=DOM Create XML Ref:C861("object")

//XLIFF version managed
DOM SET XML ATTRIBUTE:C866(<>Dom_object; "default.version"; "1.0")

//Get the DTD folder path: ~/This Component/Resources/DTD/ {
$Txt_buffer:=Get 4D folder:C485(Current resources folder:K5:16)
$Txt_buffer:=doc_gTxt_Path("append.folder"; $Txt_buffer; "DTD")
$Txt_buffer:=doc_gTxt_Path("create.hierarchy"; $Txt_buffer)
DOM SET XML ATTRIBUTE:C866(<>Dom_object; "dtd_folder"; $Txt_buffer)
//}

//Rename General Preferences file {
$Txt_pathSource:=Get 4D folder:C485
$Txt_pathSource:=$Txt_pathSource+"4D XLIFF Editor preference.xml"
If (Test path name:C476($Txt_pathSource)=Is a document:K24:1)
	$Txt_pathCible:=Replace string:C233($Txt_pathSource; "4D XLIFF Editor preference.xml"; "4DPop XLIFF.xml")
	If (Test path name:C476($Txt_pathCible)#Is a document:K24:1)
		MOVE DOCUMENT:C540($Txt_pathSource; $Txt_pathCible)
	End if 
End if 
//}

//Rename Database Preferences file {
$Txt_pathSource:=Get 4D folder:C485(Database folder:K5:14; *)

$Txt_pathSource:=$Txt_pathSource+"Preferences"+Folder separator:K24:12+"4D XLIFF Editor preference.xml"
If (Test path name:C476($Txt_pathSource)=Is a document:K24:1)
	$Txt_pathCible:=Replace string:C233($Txt_pathSource; "4D XLIFF Editor preference.xml"; "4DPop XLIFF.xml")
	If (Test path name:C476($Txt_pathCible)#Is a document:K24:1)
		MOVE DOCUMENT:C540($Txt_pathSource; $Txt_pathCible)
	End if 
End if 
//}

//For test purpose, a component can give the path of the target folder {
$Txt_errorMethod:=Method called on error:C704
ON ERR CALL:C155("NO_ERROR")
EXECUTE METHOD:C1007("Resources_Target_Path"; $Txt_buffer)
ON ERR CALL:C155($Txt_errorMethod)
//}

If (env_Boo_Is_a_Component)
	
	//Component execution
	If (Application type:C494=4D Remote mode:K5:5)
		
		//Open the local cached folder
		$Txt_buffer:=doc_gTxt_Path("append.folder"; Get 4D folder:C485(4D Client database folder:K5:13; *); "Resources")
		
	Else 
		
		//Open host database resources  folder:  ~/Host Database/Ressources/
		//$Txt_buffer:=doc_gTxt_Path("append.folder"; doc_gTxt_Path("structure.folder"); "Resources")
		//$Txt_buffer:=doc_gTxt_Path("create.hierarchy"; $Txt_buffer)
		var $folder : 4D:C1709.Folder
		$folder:=Folder:C1567(fk resources folder:K87:11; *)
		$folder.create()
		$Txt_buffer:=$folder.platformPath
		
	End if 
	
Else 
	
	//Standalone execution
	If (Is compiled mode:C492)
		
		//Standalone editeur
		PREFERENCES("database.target"; ->$Txt_buffer)
		$Txt_buffer:=doc_gTxt_Path("validate.path"; $Txt_buffer)
		
	Else 
		
		//Matrice database
		$Txt_buffer:=Get 4D folder:C485(Current resources folder:K5:16)
		
	End if 
End if 

DOM SET XML ATTRIBUTE:C866(<>Dom_object; "target_folder"; $Txt_buffer)

//Get the preferences {
PREFERENCES("default-values"; ->$Txt_buffer)
DOM SET XML ATTRIBUTE:C866(<>Dom_object; "default_comment"; $Txt_buffer)

//PREFERENCES ("xliff";-><>Txt_XLIFF_Version;-><>Txt_XML_Encoding)
PREFERENCES("xliff"; ->$Txt_buffer; ->$Txt_buffer_2)
DOM SET XML ATTRIBUTE:C866(<>Dom_object\
; "default.version"; $Txt_buffer\
; "default.encoding"; $Txt_buffer_2)

PREFERENCES("database.language"; -><>Txt_sourceLang; -><>Txt_targetLang)

//PREFERENCES ("resname-auto-fill";-><>Txt_CharacterEscaped;-><>Lon_ResnameMaxSize)
PREFERENCES("resname-auto-fill"; ->$Txt_buffer; ->$Lon_buffer)
DOM SET XML ATTRIBUTE:C866(<>Dom_object\
; "ignored_characters"; $Txt_buffer\
; "max_resname_size"; $Lon_buffer)
//}

$0:=$Boo_ok

