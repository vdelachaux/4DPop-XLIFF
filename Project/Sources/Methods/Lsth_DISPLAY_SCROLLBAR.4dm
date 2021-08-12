//%attributes = {"invisible":true}

C_POINTER:C301($1)
GET LIST PROPERTIES:C632($1->; $apparence; $icon; $lineHeight)
OBJECT GET COORDINATES:C663($1->; $Lon_; $Lon_Top; $Lon_; $Lon_Bottom)
OBJECT SET SCROLLBAR:C843($1->; False:C215; ((Count list items:C380($1->)*$lineHeight)>($Lon_Bottom-$Lon_Top)))