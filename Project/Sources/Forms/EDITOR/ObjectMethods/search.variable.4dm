C_LONGINT:C283($Lon_Event; $Lon_keystroke)

ARRAY LONGINT:C221($tLon_References; 0)

$Lon_Event:=$Lon_Event+(Form event code:C388*Num:C11($Lon_Event=0))

Case of 
		
		//.....................................................
	: ($Lon_Event=On After Edit:K2:43)
		
		//<>Txt_Search:=<>tTxt_Search{0}
		
		//.....................................................
	: ($Lon_Event=On After Keystroke:K2:26)
		
		$Lon_keystroke:=Character code:C91(Keystroke:C390)
		
		Case of 
				
				// Do nothing, but accept the keystroke
				//______________________________________________________
			: ($Lon_keystroke=Up arrow key:K12:18)
				
				<>tTxt_Search:=Choose:C955(<>tTxt_Search>1; \
					<>tTxt_Search-1; \
					Size of array:C274(<>tTxt_Search))
				
				<>tTxt_Search{0}:=<>tTxt_Search{<>tTxt_Search}
				
				//______________________________________________________
			: ($Lon_keystroke=Down arrow key:K12:19)
				
				<>tTxt_Search:=Choose:C955(<>tTxt_Search<Size of array:C274(<>tTxt_Search); \
					<>tTxt_Search+1; \
					Choose:C955(Size of array:C274(<>tTxt_Search)>0; 1; 0))
				
				<>tTxt_Search{0}:=<>tTxt_Search{<>tTxt_Search}
				
				//----------------------------------------
		End case 
		
		//.....................................................
	: ($Lon_Event=On Data Change:K2:15)
		
		Case of 
				
				//______________________________________________________
			: (Length:C16(<>tTxt_Search{0})=0)
				
				//______________________________________________________
			Else 
				
				EDITOR_SEARCH
				
				//______________________________________________________
		End case 
		
		//Lsth_DISPLAY_SCROLLBAR (-><>Lst_strings)
		
		//.....................................................
	: ($Lon_Event=On Load:K2:1)
		
		<>tTxt_Search{0}:=""
		<>tTxt_Search:=0
		
		//.....................................................
End case 