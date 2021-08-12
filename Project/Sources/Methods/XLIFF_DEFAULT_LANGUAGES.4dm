//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : XLIFF_DEFAULT_LANGUAGES
// Created 09/07/07 by Vincent de Lachaux
// ----------------------------------------------------
// Description
// Retrieve source and target languages
//       - of the database if $3 is not specified
//       - of the $3 resources' folder (path)
// ----------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_TEXT:C284($3)

C_BOOLEAN:C305($Boo_OK)
C_LONGINT:C283($Lon_i; $Lon_j; $Lon_size; $Lon_x)
C_TEXT:C284($Dom_file; $Dom_root; $Txt_folderName; $Txt_path; $Txt_sourceLanguage; $Txt_targetFolderPath; $Txt_targetLanguage; $Txt_value)

ARRAY TEXT:C222($tTxt_documents; 0)
ARRAY TEXT:C222($tTxt_folders; 0)
ARRAY TEXT:C222($tTxt_sources; 0)
ARRAY TEXT:C222($tTxt_targets; 0)
ARRAY TEXT:C222($tTxt_tempo; 0)

If (False:C215)
	C_POINTER:C301(XLIFF_DEFAULT_LANGUAGES; $1)
	C_POINTER:C301(XLIFF_DEFAULT_LANGUAGES; $2)
	C_TEXT:C284(XLIFF_DEFAULT_LANGUAGES; $3)
End if 

If (Count parameters:C259>=3)
	
	$Txt_targetFolderPath:=$3
	
Else 
	
	DOM GET XML ATTRIBUTE BY NAME:C728(<>Dom_object; "target_folder"; $Txt_targetFolderPath)
	
End if 

$Boo_OK:=(Test path name:C476($Txt_targetFolderPath)=Is a folder:K24:2)

If ($Boo_OK)
	
	//Parse the resources folder to find localisation folders
	//Built source-language & target-language arrays with the attributes of the first file
	
	FOLDER LIST:C473($Txt_targetFolderPath; $tTxt_folders)
	
	For ($Lon_i; 1; Size of array:C274($tTxt_folders); 1)
		
		$Txt_folderName:=$tTxt_folders{$Lon_i}
		
		If ($Txt_folderName="@.lproj")  //Localisation folder
			
			$Txt_path:=doc_gTxt_Path("append.folder"; $Txt_targetFolderPath; $Txt_folderName)
			DOCUMENT LIST:C474($Txt_path; $tTxt_documents)
			
			For ($Lon_j; 1; Size of array:C274($tTxt_documents); 1)
				
				If ($tTxt_documents{$Lon_j}="@.xlf")
					
					$Txt_path:=doc_gTxt_Path("append.file"; $Txt_path; $tTxt_documents{$Lon_j})
					$Dom_root:=DOM Parse XML source:C719($Txt_path; False:C215)
					
					If (OK=1)
						
						$Dom_file:=DOM Find XML element:C864($Dom_root; "xliff/file")
						
						If (OK=1)
							
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_file; "source-language"; $Txt_value)
							APPEND TO ARRAY:C911($tTxt_sources; $Txt_value)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_file; "target-language"; $Txt_value)
							APPEND TO ARRAY:C911($tTxt_targets; $Txt_value)
							
						End if 
					End if 
					
					$Lon_j:=MAXLONG:K35:2-1
					
				End if 
			End for 
		End if 
	End for 
	
	$Lon_size:=Size of array:C274($tTxt_sources)
	$Boo_OK:=($Lon_size>0)
	
End if 

If ($Boo_OK)
	
	COPY ARRAY:C226($tTxt_sources; $tTxt_tempo)
	
	For ($Lon_i; 1; $Lon_size; 1)
		
		$tTxt_tempo{$Lon_i}:=Substring:C12($tTxt_tempo{$Lon_i}; 1; 2)
		
	End for 
	
	$Boo_OK:=(Count in array:C907($tTxt_tempo; $tTxt_tempo{1})=$Lon_size)
	
	If ($Boo_OK)  //One source-language (it's normal)
		
		$Txt_sourceLanguage:=$tTxt_sources{1}
		
		//Delete the source-language from target-language array
		
		Repeat 
			
			$Lon_x:=Find in array:C230($tTxt_targets; Substring:C12($Txt_sourceLanguage; 1; 2)+"@")
			
			If ($Lon_x>0)
				
				DELETE FROM ARRAY:C228($tTxt_targets; $Lon_x; 1)
				
			End if 
		Until ($Lon_x=-1)
		
		$Lon_size:=Size of array:C274($tTxt_targets)
		
		Case of 
				
				//.....................................................
			: ($Lon_size=0)  //source-language & target-language are the same
				
				$Txt_targetLanguage:=$Txt_sourceLanguage
				
				//.....................................................
			: ($Lon_size=1)  //Only one: it's the good
				
				$Txt_targetLanguage:=$tTxt_targets{1}
				
				//.....................................................
			Else 
				
				//1] System language
				$Lon_x:=Find in array:C230($tTxt_targets; Substring:C12(xliff_Txt_Language("System.Code.Alpha"); 1; 2)+"@")
				
				If ($Lon_x<0)
					
					//2] 4D language
					$Lon_x:=Find in array:C230($tTxt_targets; Substring:C12(xliff_Txt_Language("Application.Code.Alpha"); 1; 2)+"@")
					
					If ($Lon_x<0)
						
						//3] The first found
						$Lon_x:=1
						
					End if 
				End if 
				
				$Txt_targetLanguage:=$tTxt_targets{$Lon_x}
				
				//.....................................................
		End case 
	End if 
End if 

If (Not:C34($Boo_OK))
	
	$Txt_sourceLanguage:=xliff_Txt_Language("System.Code.Alpha")
	$Txt_targetLanguage:=xliff_Txt_Language("Application.Code.Alpha")
	
End if 

$1->:=$Txt_sourceLanguage
$2->:=$Txt_targetLanguage