//%attributes = {"invisible":true}
C_LONGINT:C283($i; $n)
C_TEXT:C284($Text)

ARRAY TEXT:C222($_xlifNames; 0)

$n:=8  //nb of strings to send to the About Component

ARRAY TEXT:C222($_xlifNames; $n)

$_xlifNames{1}:="demo_name"
$_xlifNames{2}:="demo_version"
$_xlifNames{3}:="demo_author"
$_xlifNames{4}:="demo_website"
$_xlifNames{5}:="demo_copyright"
$_xlifNames{6}:="demo_tutorialText"
$_xlifNames{7}:="demo_legalText"
$_xlifNames{8}:="demo_copyright"

For ($i; 1; $n)
	$Text:=Get localized string:C991($_xlifNames{$i})
	EXECUTE METHOD:C1007("Demo_SetVariable"; *; $_xlifNames{$i}; $Text)
End for 

$Text:=Get localized string:C991("demo_aboutMenuLib")
SET ABOUT:C316($Text; "Demo_About")

