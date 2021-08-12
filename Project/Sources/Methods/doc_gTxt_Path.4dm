//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : doc_gTxt_Path
// Created 03/11/06 by vdl
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_LONGINT:C283($Lon_i; $Lon_Parameters; $Lon_x)
C_TIME:C306($Gmt_)
C_TEXT:C284($kTxt_Separator; $Txt_Buffer; $Txt_Entrypoint; $Txt_file; $Txt_Path; $Txt_Result; $Txt_Volume)

If (False:C215)
	C_TEXT:C284(doc_gTxt_Path; $0)
	C_TEXT:C284(doc_gTxt_Path; $1)
	C_TEXT:C284(doc_gTxt_Path; $2)
	C_TEXT:C284(doc_gTxt_Path; $3)
End if 

$Lon_Parameters:=Count parameters:C259

If ($Lon_Parameters>0)
	$Txt_Entrypoint:=$1
	If ($Lon_Parameters>1)
		$Txt_Path:=$2
		If ($Lon_Parameters>2)
			$Txt_file:=$3
		End if 
	End if 
End if 

$kTxt_Separator:=Get 4D folder:C485[[Length:C16(Get 4D folder:C485)]]

Case of 
		//______________________________________________________
	: ($Txt_Entrypoint="parent.path")
		For ($Lon_i; Length:C16($Txt_Path); 1; -1)
			If ($Txt_Path[[$Lon_i]]=$kTxt_Separator)
				$Txt_Result:=Substring:C12($Txt_Path; 1; $Lon_i)
				$Lon_i:=0
			End if 
		End for 
		//______________________________________________________
	: ($Txt_Entrypoint="create.hierarchy")
		If (Test path name:C476($Txt_Path)=Is a folder:K24:2)
			$Txt_Result:=$Txt_Path
		Else 
			$Txt_Volume:=doc_gTxt_Path("volume.path"; $Txt_Path)
			While (Length:C16($Txt_Path)>0)
				$Lon_x:=Position:C15($kTxt_Separator; $Txt_Path)
				If ($Lon_x#0)
					$Txt_Result:=$Txt_Result+Substring:C12($Txt_Path; 1; $Lon_x)
					$Txt_Path:=Substring:C12($Txt_Path; $Lon_x+1)
				Else 
					$Txt_Result:=$Txt_Result+$Txt_Path
					$Txt_Path:=""
				End if 
				If ($Txt_Result#$Txt_Volume)
					doc_gTxt_Path("create.folder"; $Txt_Result)
				End if 
			End while 
		End if 
		//______________________________________________________
	: ($Txt_Entrypoint="append.file")
		If ($Txt_Path[[Length:C16($Txt_Path)]]#$kTxt_Separator)
			$Txt_Path:=$Txt_Path+$kTxt_Separator
		End if 
		$Txt_Result:=$Txt_Path+$Txt_file
		//______________________________________________________
	: ($Txt_Entrypoint="append.folder")
		If ($Txt_Path[[Length:C16($Txt_Path)]]#$kTxt_Separator)
			$Txt_Path:=$Txt_Path+$kTxt_Separator
		End if 
		$Txt_Result:=$Txt_Path+$Txt_file+$kTxt_Separator
		//______________________________________________________
	: ($Txt_Entrypoint="create.folder")
		If ($Txt_Path[[Length:C16($Txt_Path)]]#$kTxt_Separator)
			$Txt_Path:=$Txt_Path+$kTxt_Separator
		End if 
		If (Test path name:C476($Txt_Path)#Is a folder:K24:2)
			CREATE FOLDER:C475($Txt_Path)
			If (OK=1)
				$Txt_Result:=$Txt_Path
			End if 
		End if 
		//______________________________________________________
	: ($Txt_Entrypoint="validate.path")
		$Txt_Result:=$Txt_Path
		Case of 
				//………………………………………………………………
			: (Test path name:C476($Txt_Result)=Is a folder:K24:2)
				//………………………………………………………………
			: (Test path name:C476($Txt_Result)=Is a document:K24:1)
				//………………………………………………………………
			Else 
				$Txt_Result:=""
				//………………………………………………………………
		End case 
		//______________________________________________________
	: ($Txt_Entrypoint="test.folder")
		If ($Txt_Path[[Length:C16($Txt_Path)]]#$kTxt_Separator)
			$Txt_Path:=$Txt_Path+$kTxt_Separator
		End if 
		$Txt_Path:=$Txt_Path+$Txt_file+$kTxt_Separator
		If (Test path name:C476($Txt_Path)=Is a folder:K24:2)
			$Txt_Result:=$Txt_Path
		End if 
		//______________________________________________________
	: ($Txt_Entrypoint="create.file")
		If (Test path name:C476($Txt_Path)=Is a folder:K24:2)
			$Txt_Result:=$Txt_Path+$Txt_file
			If (Test path name:C476($Txt_Result)#Is a document:K24:1)
				$Gmt_:=Create document:C266($Txt_Result)
				$Txt_Result:=$Txt_Result*Num:C11(OK=1)
				If (OK=1)
					CLOSE DOCUMENT:C267($Gmt_)
				End if 
			End if 
		End if 
		//______________________________________________________
	: ($Txt_Entrypoint="structure@")
		If ($Txt_Entrypoint="@.component@")
			$Txt_Path:=Structure file:C489  //Component target
		Else 
			$Txt_Path:=Structure file:C489(*)  //Database target
		End if 
		Case of 
				//______________________________________________________
			: ($Txt_Entrypoint="@.file")
				//Structure file name
				For ($Lon_i; Length:C16($Txt_Path); 1; -1)
					If ($Txt_Path[[$Lon_i]]=$kTxt_Separator)
						$Txt_Result:=Substring:C12($Txt_Path; $Lon_i+1)
						$Lon_i:=0
					End if 
				End for 
				//______________________________________________________
			: ($Txt_Entrypoint="@.folder")
				//Structure folder path
				For ($Lon_i; Length:C16($Txt_Path); 1; -1)
					If ($Txt_Path[[$Lon_i]]=$kTxt_Separator)
						$Txt_Result:=Substring:C12($Txt_Path; 1; $Lon_i)
						$Lon_i:=0
					End if 
				End for 
				//______________________________________________________
			Else 
				$Txt_Result:=$Txt_Path
				//______________________________________________________
		End case 
		//______________________________________________________
	: ($Txt_Entrypoint="volume.path")
		If (Length:C16($Txt_Path)>0)
			$Lon_x:=Position:C15(":"; $Txt_Path)  //marche sur Mac comme sur PC pour un volume LOCAL. Ex   C:\test\bonjour\   ou Mondisque:MonDossier:MonFichier
			If ($Lon_x>0)
				$Txt_Result:=Substring:C12($Txt_Path; 1; $Lon_x)  //renvoie "disque dur:"  ou C:
				If ($kTxt_Separator="\\")  //on est sur Win
					$Txt_Result:=$Txt_Result+"\\"  //renvoie "C:\ 
				End if 
			Else 
				//volume distant PC ? (vu d'un pc)
				//exemple :     \\serveur\tempo\test\folder\    renverra    \\serveur\tempo\ 
				$Lon_x:=Position:C15("\\\\"; $Txt_Path)  //seulement deux \ 
				If ($Lon_x=1)
					//c'est bien un volume distant PC
					$Txt_Buffer:="••"+Substring:C12($Txt_Path; 3)  //remplace les deux premiers \ par "••"                   ••serveur\tempo\test\ 
					$Lon_x:=Position:C15("\\"; $Txt_Buffer)  //recherche le "\" suivant
					If ($Lon_x>0)
						$Txt_Buffer[[$Lon_x]]:="•"  //remplace le premier \ par une •                  ••serveur•tempo\test\ 
						$Lon_x:=Position:C15("\\"; $Txt_Buffer)  //recherche le "\" suivant
						If ($Lon_x>0)
							$Txt_Result:=Substring:C12($Txt_Path; 1; $Lon_x)
						Else 
							//???
						End if 
					Else 
						//???
					End if 
				Else 
					If ($kTxt_Separator="\\")  //on est sur Win
						$Txt_Result:=$Txt_Path+":\\"  //directement la chaine passée +:\ 
					Else 
						$Txt_Result:=$Txt_Path+":"  //directement la chaine passée +:
					End if 
				End if 
			End if 
		End if 
		//______________________________________________________
	Else 
		TRACE:C157
		//______________________________________________________
End case 

$0:=$Txt_Result
