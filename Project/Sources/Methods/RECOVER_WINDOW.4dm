//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : RECOVER_WINDOW
// Created 22/05/08 by vdl
// ----------------------------------------------------
// Description
// Try to execute the 4DPop's method to place the window in the screen if
// necessary when a second screen is not present for example...
// ----------------------------------------------------
C_TEXT:C284($Txt_errorMethod)

$Txt_errorMethod:=Method called on error:C704
ON ERR CALL:C155("NO_ERROR")
EXECUTE METHOD:C1007("4DPop_RECOVER_WINDOW")
ON ERR CALL:C155($Txt_errorMethod)
