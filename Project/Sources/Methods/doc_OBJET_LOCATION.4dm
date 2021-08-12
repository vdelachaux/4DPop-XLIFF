//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : doc_OBJET_LOCATION
// Created 01/02/07 by Vincent de Lachaux
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_LONGINT:C283($Lon_Bottom; $Lon_dep_H; $Lon_Event; $Lon_Height; $Lon_i; $Lon_Left; $Lon_MaxWidth; $Lon_Platform; $Lon_Position; $Lon_Redim_H)
C_LONGINT:C283($Lon_Right; $Lon_Size; $Lon_Top; $Lon_Width; $Lon_x)
C_TEXT:C284($kTxt_Separator; $Txt_Buffer; $Txt_File; $Txt_FullPath; $Txt_Object; $Txt_Path; $Txt_Volume)
_O_C_STRING:C293(16; $a16_menu)

ARRAY TEXT:C222($tTxt_Volumes; 0)

If (False:C215)
	C_TEXT:C284(doc_OBJET_LOCATION; $1)
	C_TEXT:C284(doc_OBJET_LOCATION; $2)
	C_LONGINT:C283(doc_OBJET_LOCATION; $3)
	C_LONGINT:C283(doc_OBJET_LOCATION; $4)
End if 

$Txt_FullPath:=$1
$Txt_Object:=$2

If (Count parameters:C259>=3)
	
	$Lon_Event:=$3
	
	If (Count parameters:C259>=4)
		
		$Lon_Position:=$4
		
	Else 
		
		$Lon_Position:=Align left:K42:2
		
	End if 
	
Else 
	
	$Lon_Position:=Align left:K42:2
	$Lon_Event:=Form event code:C388
	
End if 

$kTxt_Separator:=System folder:C487[[Length:C16(System folder:C487)]]
$Lon_Size:=Length:C16($Txt_FullPath)

If ($Lon_Event=On Load:K2:1)
	
	If ($Lon_Size>0)
		
		$Txt_Volume:=Replace string:C233(FILE_GetVolumeName($Txt_FullPath); $kTxt_Separator; "")
		$Txt_File:=Replace string:C233(FILE_GetLastItemFromPath($Txt_FullPath); $kTxt_Separator; "")
		
		If ($Txt_File#$Txt_Volume)
			
			$Txt_Buffer:=Replace string:C233(Get localized string:C991("FileInVolume"); "{file}"; $Txt_File)
			$Txt_Buffer:=Replace string:C233($Txt_Buffer; "{volume}"; $Txt_Volume)
			
		Else 
			
			$Txt_Buffer:="\""+$Txt_File+"\""
			
		End if 
		
		OBJECT SET FORMAT:C236(*; $Txt_Object; ";;;;;;1969;;;;")
		
	Else 
		
		$Txt_Buffer:=" "
		OBJECT SET FORMAT:C236(*; $Txt_Object; ";;;;;;4;;;;")
		
	End if 
	
	OBJECT SET TITLE:C194(*; $Txt_Object; $Txt_Buffer)
	
	OBJECT GET COORDINATES:C663(*; $Txt_Object; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
	$Lon_MaxWidth:=$Lon_Right-$Lon_Left
	OBJECT GET BEST SIZE:C717(*; $Txt_Object; $Lon_Width; $Lon_Height; $Lon_MaxWidth)
	
	If ($Lon_Position#-1)
		
		OBJECT GET COORDINATES:C663(*; $Txt_Object; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
		$Lon_MaxWidth:=$Lon_Right-$Lon_Left
		OBJECT GET BEST SIZE:C717(*; $Txt_Object; $Lon_Width; $Lon_Height; $Lon_MaxWidth)
		
		If ($Lon_Width<$Lon_MaxWidth)
			
			OBJECT GET COORDINATES:C663(*; $Txt_Object; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
			
			Case of 
					
					//______________________________________________________
				: ($Lon_Position=0)\
					 | ($Lon_Position=Align left:K42:2)
					
					$Lon_dep_H:=0
					$Lon_Redim_H:=$Lon_Width-$Lon_MaxWidth
					
					//______________________________________________________
				: ($Lon_Position=Align center:K42:3)
					
					$Lon_dep_H:=(($Lon_MaxWidth-$Lon_Width)\2)-4
					$Lon_Redim_H:=-$Lon_dep_H*2
					
					//______________________________________________________
				: ($Lon_Position=Align right:K42:4)
					
					$Lon_dep_H:=$Lon_MaxWidth-$Lon_Width
					$Lon_Redim_H:=-$Lon_dep_H
					
					//______________________________________________________
				Else 
					
					$Lon_dep_H:=0
					$Lon_Redim_H:=$Lon_Width-$Lon_MaxWidth
					
					//______________________________________________________
			End case 
			
			OBJECT MOVE:C664(*; $Txt_Object; $Lon_dep_H; 0; $Lon_Redim_H; 0)
			
		End if 
	End if 
	
Else 
	
	VOLUME LIST:C471($tTxt_Volumes)
	_O_PLATFORM PROPERTIES:C365($Lon_Platform)
	
	$a16_menu:=Create menu:C408
	
	For ($Lon_i; 1; Length:C16($Txt_FullPath); 1)
		
		If ($Txt_FullPath[[$Lon_i]]=$kTxt_Separator)
			
			If ($Lon_Platform=Windows:K25:3)
				
				APPEND MENU ITEM:C411($a16_menu; $Txt_Buffer)
				
			Else 
				
				INSERT MENU ITEM:C412($a16_menu; 0; $Txt_Buffer)
				
			End if 
			
			$Lon_x:=$Lon_x+1
			SET MENU ITEM PARAMETER:C1004($a16_menu; -1; String:C10($Lon_x))
			$Txt_Path:=Substring:C12($Txt_FullPath; 1; $Lon_i-1)
			
			Case of 
					
					//______________________________________________________
				: (Find in array:C230($tTxt_Volumes; $Txt_Path)>0)
					
					SET MENU ITEM ICON:C984($a16_menu; -1; "#Images/genericHardDrive.png")
					
					//______________________________________________________
				: (Test path name:C476($Txt_Path)=Is a folder:K24:2)
					
					SET MENU ITEM ICON:C984($a16_menu; -1; "#Images/genericFolder.png")
					
					//  `______________________________________________________
					//________________________________________
				: (Test path name:C476($Txt_Path)=Is a document:K24:1)
					
					SET MENU ITEM ICON:C984($a16_menu; -1; "#Images/genericFile.png")
					
					//______________________________________________________
			End case 
			
			$Txt_Path:=Substring:C12($Txt_FullPath; 1; $Lon_i)
			SET MENU ITEM PARAMETER:C1004($a16_menu; -1; $Txt_Path)
			$Txt_Buffer:=""
			
		Else 
			
			$Txt_Buffer:=$Txt_Buffer+$Txt_FullPath[[$Lon_i]]
			
		End if 
	End for 
	
	If (Length:C16($Txt_Buffer)>0)
		
		If ($Lon_Platform=Windows:K25:3)
			
			APPEND MENU ITEM:C411($a16_menu; $Txt_Buffer)
			
		Else 
			
			INSERT MENU ITEM:C412($a16_menu; 0; $Txt_Buffer)
			
		End if 
		
		$Lon_x:=$Lon_x+1
		SET MENU ITEM PARAMETER:C1004($a16_menu; -1; String:C10($Lon_x))
		SET MENU ITEM ICON:C984($a16_menu; -1; "#Images/genericFile.png")
		
	End if 
	
	If (Count menu items:C405($a16_menu)>0)
		
		APPEND MENU ITEM:C411($a16_menu; "-")
		APPEND MENU ITEM:C411($a16_menu; Get localized string:C991("CopyPath"))
		SET MENU ITEM PARAMETER:C1004($a16_menu; -1; "copy")
		$Txt_Path:=Dynamic pop up menu:C1006($a16_menu)
		
		Case of 
				
				//………………………
			: ($Txt_Path="")
				
				//………………………
			: ($Txt_Path="copy")
				
				SET TEXT TO PASTEBOARD:C523($Txt_FullPath)
				
				//………………………
			Else 
				
				SHOW ON DISK:C922($Txt_Path)
				
				//………………………
		End case 
	End if 
	
	RELEASE MENU:C978($a16_menu)
	
End if 