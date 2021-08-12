//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : xliff_Txt_Language
// Created 02/02/07 by vdl
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_BOOLEAN:C305($Boo_More)
C_LONGINT:C283($Lon_i; $Lon_Language; $Lon_Languages; $Lon_Machine; $Lon_Platform)
C_LONGINT:C283($Lon_System; $Lon_x)
C_TEXT:C284($Txt_EntryPoint; $Txt_Path; $Txt_Result)

If (False:C215)
	C_TEXT:C284(xliff_Txt_Language; $0)
	C_TEXT:C284(xliff_Txt_Language; $1)
	C_TEXT:C284(xliff_Txt_Language; $2)
	C_TEXT:C284(xliff_Txt_Language; $3)
End if 

$Lon_Languages:=9  //managed languages

If (True:C214)
	
	ARRAY TEXT:C222($tTxt_Managed_Languages; $Lon_Languages)
	$tTxt_Managed_Languages{1}:="English"
	$tTxt_Managed_Languages{2}:="French"
	$tTxt_Managed_Languages{3}:="German"
	$tTxt_Managed_Languages{4}:="Italian"
	$tTxt_Managed_Languages{5}:="Japanese"
	$tTxt_Managed_Languages{6}:="Spanish"
	$tTxt_Managed_Languages{7}:="Chinese"
	$tTxt_Managed_Languages{8}:="Russian"
	$tTxt_Managed_Languages{9}:="Swedish"
	
	ARRAY TEXT:C222($tTxt_Codes; $Lon_Languages)
	$tTxt_Codes{1}:="en"
	$tTxt_Codes{2}:="fr"
	$tTxt_Codes{3}:="de"
	$tTxt_Codes{4}:="it"
	$tTxt_Codes{5}:="ja"
	$tTxt_Codes{6}:="es"
	$tTxt_Codes{7}:="zh"
	$tTxt_Codes{8}:="ru"
	$tTxt_Codes{9}:="sv"
	
	ARRAY TEXT:C222($tTxt_xliff_Codes; $Lon_Languages)
	$tTxt_xliff_Codes{1}:="en-US"
	$tTxt_xliff_Codes{2}:="fr"
	$tTxt_xliff_Codes{3}:="de"
	$tTxt_xliff_Codes{4}:="it"
	$tTxt_xliff_Codes{5}:="ja"
	$tTxt_xliff_Codes{6}:="es"
	$tTxt_xliff_Codes{7}:="zh"
	$tTxt_xliff_Codes{8}:="ru"
	$tTxt_xliff_Codes{9}:="sv"
	
	ARRAY TEXT:C222($tTxt_Folder_Names; $Lon_Languages)
	$tTxt_Folder_Names{1}:="English"
	$tTxt_Folder_Names{2}:="French"
	$tTxt_Folder_Names{3}:="German"
	$tTxt_Folder_Names{4}:="Italian"
	$tTxt_Folder_Names{5}:="Japanese"
	$tTxt_Folder_Names{6}:="Spanish"
	$tTxt_Folder_Names{7}:="Chinese"
	$tTxt_Folder_Names{8}:="Russian"
	$tTxt_Folder_Names{9}:="Swedish"
	
	ARRAY TEXT:C222($tTxt_System_Languages; 56)
	$tTxt_System_Languages{1}:="Arabic"
	$tTxt_System_Languages{2}:="Bulgarian"
	$tTxt_System_Languages{3}:="Catalan"
	$tTxt_System_Languages{4}:="Chinese"
	$tTxt_System_Languages{5}:="Czech"
	$tTxt_System_Languages{6}:="Danish"
	$tTxt_System_Languages{7}:="German"
	$tTxt_System_Languages{8}:="Greek"
	$tTxt_System_Languages{9}:="English"
	$tTxt_System_Languages{10}:="Spanish"
	$tTxt_System_Languages{11}:="Finnish"
	$tTxt_System_Languages{12}:="French"
	$tTxt_System_Languages{13}:="Hebrew"
	$tTxt_System_Languages{14}:="Hungarian"
	$tTxt_System_Languages{15}:="Icelandic"
	$tTxt_System_Languages{16}:="Italian"
	$tTxt_System_Languages{17}:="Japanese"
	$tTxt_System_Languages{18}:="Korean"
	$tTxt_System_Languages{19}:="Dutch"
	$tTxt_System_Languages{20}:="Norwegian"
	$tTxt_System_Languages{21}:="Polish"
	$tTxt_System_Languages{22}:="Portuguese"
	$tTxt_System_Languages{24}:="Romanian"
	$tTxt_System_Languages{25}:="Russian"
	$tTxt_System_Languages{26}:="Croatian"
	$tTxt_System_Languages{26}:="Serbian"
	$tTxt_System_Languages{27}:="Slovak"
	$tTxt_System_Languages{28}:="Albanian"
	$tTxt_System_Languages{29}:="Swedish"
	$tTxt_System_Languages{30}:="Thai"
	$tTxt_System_Languages{31}:="Turkish"
	$tTxt_System_Languages{33}:="Indonesian"
	$tTxt_System_Languages{34}:="Ukrainian"
	$tTxt_System_Languages{35}:="Belarusian"
	$tTxt_System_Languages{36}:="Slovenian"
	$tTxt_System_Languages{37}:="Estonian"
	$tTxt_System_Languages{38}:="Latvian"
	$tTxt_System_Languages{39}:="Lithuanian"
	$tTxt_System_Languages{41}:="Farsi"
	$tTxt_System_Languages{42}:="Vietnamese"
	$tTxt_System_Languages{45}:="Basque"
	$tTxt_System_Languages{54}:="Afrikaans"
	$tTxt_System_Languages{56}:="Faeroese"
	
	ARRAY TEXT:C222($tTxt_System_Codes; $Lon_Languages)
	$tTxt_System_Codes{1}:="9"  //English
	$tTxt_System_Codes{2}:="12"  //French
	$tTxt_System_Codes{3}:="7"  //German
	$tTxt_System_Codes{4}:="16"  //Italian
	$tTxt_System_Codes{5}:="17"  //Japanese
	$tTxt_System_Codes{6}:="10"  //Spanish
	$tTxt_System_Codes{7}:="4"  //Chinese
	$tTxt_System_Codes{8}:="25"  //Russian
	$tTxt_System_Codes{9}:="29"  //Swedish
	
End if 

If (Count parameters:C259>=1)
	
	$Txt_EntryPoint:=$1
	
End if 

Case of 
		//______________________________________________________
	: (Count parameters:C259>=2)
		
		$Txt_Path:=$2
		
		If (Count parameters:C259>=3)
			
			$Lon_x:=Find in array:C230($tTxt_Codes; Substring:C12($3; 1; 2))
			
		Else 
			
			$Lon_x:=Find in array:C230($tTxt_Codes; Get database localization:C1009)
			
		End if 
		
		$Boo_More:=True:C214
		
		//______________________________________________________
	: ($Txt_EntryPoint="Component.@")
		
		$Lon_x:=Abs:C99(Find in array:C230($tTxt_Codes; Get database localization:C1009))
		
		If ($Txt_EntryPoint="@.Folder.Path@")
			
			$Txt_Path:=Get 4D folder:C485(Current resources folder:K5:16)
			
		End if 
		
		$Boo_More:=True:C214
		
		//______________________________________________________
	: ($Txt_EntryPoint="Database.@")
		
		$Lon_x:=Abs:C99(Find in array:C230($tTxt_Codes; Get database localization:C1009))
		
		If ($Txt_EntryPoint="@.Folder.Path@")
			
			$Txt_Path:=Get 4D folder:C485(Current resources folder:K5:16; *)
			
		End if 
		
		$Boo_More:=True:C214
		
		//______________________________________________________
	: ($Txt_EntryPoint="Application.@")
		
		Case of 
				//.....................................................
			: (Command name:C538(41)="ALERT")
				
				$Lon_x:=1  //INTL-US
				
				//.....................................................
			Else 
				
				$Lon_x:=2  //FR
				
				//.....................................................
		End case 
		
		If ($Txt_EntryPoint="@.Folder.Path@")
			
			$Txt_Path:=Application file:C491
			
			_O_PLATFORM PROPERTIES:C365($Lon_Platform)
			If ($Lon_Platform=Windows:K25:3)  //...\4D VF\Resources
				
				For ($Lon_i; Length:C16($Txt_Path); 1; -1)
					
					If ($Txt_Path[[$Lon_i]]=Folder separator:K24:12)
						
						$Txt_Path:=Substring:C12($Txt_Path; 1; $Lon_i)
						
						$Lon_i:=0
						
					End if 
					
				End for 
				
				$Txt_Path:=$Txt_Path+"Resources"+Folder separator:K24:12
				
			Else   //~:4D Developer.app:Contents:Resources: 
				
				$Txt_Path:=$Txt_Path+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Resources"+Folder separator:K24:12
				
			End if 
		End if 
		
		$Boo_More:=True:C214
		
		//______________________________________________________
	: ($Txt_EntryPoint="System.@")
		
		_O_PLATFORM PROPERTIES:C365($Lon_Platform; $Lon_System; $Lon_Machine; $Lon_Language)
		$Lon_x:=Abs:C99(Find in array:C230($tTxt_System_Codes; String:C10($Lon_Language)))
		
		If ($Txt_EntryPoint="@.Folder.Path@")
			
			$Txt_Path:=Get 4D folder:C485(Current resources folder:K5:16; *)
			
		End if 
		
		$Boo_More:=True:C214
		
		//______________________________________________________
	: ($Txt_EntryPoint="CodeFromLanguage")
		
		$Lon_x:=Find in array:C230($tTxt_Managed_Languages; $2)
		
		If ($Lon_x>0)
			
			$Txt_Result:=$tTxt_Codes{$Lon_x}
			
		End if 
		
		//______________________________________________________
	: ($Txt_EntryPoint="FolderFromCode")
		
		$Lon_x:=Find in array:C230($tTxt_Codes; Substring:C12($2; 1; 2))
		
		If ($Lon_x>0)
			
			$Txt_Result:=$tTxt_Folder_Names{$Lon_x}
			
		End if 
		
		//______________________________________________________
End case 

Case of 
		//……………………………………………………
	: (Not:C34($Boo_More))
		
		//……………………………………………………
	: ($Lon_x=-1)
		
		BEEP:C151
		
		//……………………………………………………
	: ($Txt_EntryPoint="@Language")
		
		$Txt_Result:=$tTxt_Managed_Languages{$Lon_x}
		
		//……………………………………………………
	: ($Txt_EntryPoint="@Code.Alpha")
		
		$Txt_Result:=$tTxt_Codes{$Lon_x}
		
		//……………………………………………………
	: ($Txt_EntryPoint="@Code.Xliff")
		
		$Txt_Result:=$tTxt_xliff_Codes{$Lon_x}
		
		//……………………………………………………
	: ($Txt_EntryPoint="@Code.Numeric")
		
		$Txt_Result:=$tTxt_System_Codes{$Lon_x}
		
		//……………………………………………………
	: ($Txt_EntryPoint="@.Folder.Name")
		
		$Txt_Result:=$tTxt_Folder_Names{$Lon_x}
		
		//……………………………………………………
	: ($Txt_EntryPoint="@Folder.Path@")
		
		$Txt_Result:=$Txt_Path+$tTxt_Folder_Names{$Lon_x}+".lproj"+Folder separator:K24:12
		
		If ($Txt_EntryPoint="@Validated")
			
			If (Test path name:C476($Txt_Result)#Is a folder:K24:2)
				
				$Txt_Result:=$Txt_Path+$tTxt_Codes{$Lon_x}+".lproj"+Folder separator:K24:12
				
				If (Test path name:C476($Txt_Result)#Is a folder:K24:2)
					
					FOLDER LIST:C473($Txt_Path; $tTxt_Folder_Names)
					SORT ARRAY:C229($tTxt_Folder_Names)
					$Lon_x:=Find in array:C230($tTxt_Folder_Names; $tTxt_Codes{$Lon_x}+"@")
					
					If ($lon_x>0)
						
						$Txt_Result:=$Txt_Path+$tTxt_Folder_Names{$Lon_x}+Folder separator:K24:12
						
					End if 
				End if 
			End if 
		End if 
		
		//……………………………………………………
End case 

$0:=$Txt_Result
