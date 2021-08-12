//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : FILE_GetVolumeName
// Created 05/02/07 by vdl
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_x)
C_TEXT:C284($kTxt_Separator; $Txt_Buffer; $Txt_Path; $Txt_Volume)

$kTxt_Separator:=System folder:C487[[Length:C16(System folder:C487)]]

If (Count parameters:C259=1)
	
	$Txt_Path:=$1
	
	If (Length:C16($Txt_Path)>0)
		
		
		$Lon_x:=Position:C15(":"; $Txt_Path)  //marche sur Mac comme sur PC pour un volume LOCAL. Ex   C:\test\bonjour\   ou Mondisque:MonDossier:MonFichier
		
		If ($Lon_x>0)
			
			$Txt_Volume:=Substring:C12($Txt_Path; 1; $Lon_x)  //renvoie "disque dur:"  ou C:
			If ($kTxt_Separator="\\")  //on est sur Win
				$Txt_Volume:=$Txt_Volume+"\\"  //renvoie "C:\ 
			End if 
			
		Else 
			
			//volume distant PC ? (vu d'un pc)
			//exemple :     \\srv-4d\tempo\test\roland\    renverra    \\srv-4d\tempo\ 
			$Lon_x:=Position:C15("\\\\"; $Txt_Path)  //seulement deux \ 
			If ($Lon_x=1)
				//c'est bien un volume distant PC
				$Txt_Buffer:="••"+Substring:C12($Txt_Path; 3)  //remplace les deux premiers \ par "••"                   ••srv-4d\tempo\test\ 
				$Lon_x:=Position:C15("\\"; $Txt_Buffer)  //recherche le "\" suivant
				If ($Lon_x>0)
					$Txt_Buffer[[$Lon_x]]:="•"  //remplace le premier \ par une •                  ••srv-4d•tempo\test\ 
					$Lon_x:=Position:C15("\\"; $Txt_Buffer)  //recherche le "\" suivant
					If ($Lon_x>0)
						$Txt_Volume:=Substring:C12($Txt_Path; 1; $Lon_x)
					Else 
						//???
						$Txt_Volume:=""
					End if 
					
				Else 
					//???
					$Txt_Volume:=""
				End if 
				
			Else 
				
				If ($kTxt_Separator="\\")  //on est sur Win
					$Txt_Volume:=$Txt_Path+":\\"  //directement la chaine passée +:\ 
				Else 
					$Txt_Volume:=$Txt_Path+":"  //directement la chaine passée +:
				End if 
				
			End if 
			
		End if 
	End if 
End if 

$0:=$Txt_Volume
