//%attributes = {"invisible":true}
//  // ----------------------------------------------------
//  // Method : XLIFF_EDITOR_Lon_Objects_Method
//  // Created 19/02/07 by vdl
//  // ----------------------------------------------------
//  // Modified by Vincent de Lachaux (11/07/08)
//  // Add the ":ID,Index" drop asked by René Ricard
//  // http://forums.4d.fr/Post/FR/2030266/1/2048167#2048167
//  // ----------------------------------------------------

TRACE:C157

//C_ENTIER($0)
//C_POINTEUR($1)
//C_ENTIER LONG($2)
//
//C_BLOB($Blb_Buffer)
//C_BOOLEEN($Boo_Expanded;$Boo_Form;$Boo_Maj;$Boo_Sort)
//C_ENTIER LONG($Lon_;$Lon_Bottom;$Lon_Color;$Lon_Destination;$Lon_Destination_Reference;$Lon_Direction;$Lon_End_i;$Lon_Event;$Lon_i;$Lon_Icon)
//C_ENTIER LONG($Lon_Offset;$Lon_Page;$Lon_Parent;$Lon_Process;$Lon_Reference;$Lon_Source;$Lon_Source_Reference;$Lon_Start;$Lon_Style;$Lon_Sublist)
//C_ENTIER LONG($Lon_Top;$Lon_Window;$Lon_x;$Lon_y)
//C_IMAGE($Pic_Buffer)
//C_POINTEUR($Ptr_Object;$Ptr_Source)
//C_TEXTE($Txt_Action;$Txt_Attributes;$Txt_Buffer;$Txt_Character;$Txt_Element;$Txt_Group;$Txt_ResName;$Txt_Source;$Txt_Target;$Txt_Tempo;$Txt_Value)
//C_ALPHA(16;$a16_menu)
//
//TABLEAU ENTIER LONG($tLon_Find;0)
//
//Si (Faux)
//C_ENTIER(XLIFF_EDITOR_Lon_Objects_Method ;$0)
//C_POINTEUR(XLIFF_EDITOR_Lon_Objects_Method ;$1)
//C_ENTIER LONG(XLIFF_EDITOR_Lon_Objects_Method ;$2)
//Fin de si 
//
//Si (Nombre de parametres>=1)
//$Ptr_Object:=$1
//Si (Nombre de parametres>=2)
//$Txt_Buffer:=$Ptr_Object->
//$Lon_Event:=$2
//Sinon 
//$Txt_Buffer:=Lire texte edite
//$Lon_Event:=Evenement formulaire
//Fin de si 
//Sinon 
//$Ptr_Object:=Self
//Si (Nil($Ptr_Object))
//$Ptr_Object:=Objet focus
//Fin de si 
//$Txt_Buffer:=Lire texte edite
//$Lon_Event:=Evenement formulaire
//Fin de si 
//
//Au cas ou 
//  //______________________________________________________
//: ($Lon_Event=Sur gain focus)
//EDITOR_Boo_handler ("update";$Ptr_Object)
//  //______________________________________________________
//: ($Lon_Event=Sur perte focus)
//EDITOR_Boo_handler ("update";$Ptr_Object)
//
//
//
//  //______________________________________________________
//  //: ($Ptr_Object=(-><>bNoTranslate))
//  //Au cas ou 
//  //  //.....................................................    
//  //: ($Lon_Event=Sur clic)
//  //  //Get the selected item reference
//  //INFORMATION ELEMENT(<>Lst_strings;*;$Lon_Reference;$Txt_Element)
//  //  //Get translate attribute position
//  //$Lon_x:=Chercher dans tableau(<>tTxt_attributeNames;"translate")
//  //Si (<>bNoTranslate=0)  // translate="yes"
//  //Si ($Lon_x>0)
//  //  //Remove the attribute
//  //SUPPRIMER DANS TABLEAU(<>tTxt_attributeNames;$Lon_x;1)
//  //SUPPRIMER DANS TABLEAU(<>tTxt_attributeValues;$Lon_x;1)
//  //Fin de si 
//  //LIRE PARAMETRE ELEMENT(<>Lst_strings;$Lon_Reference;"_target";<>Txt_Target)
//  //OBJET FIXER SAISISSABLE(<>Txt_Target;Vrai)
//  //OBJET FIXER VISIBLE(*;"@target@";Vrai)
//  //Si (<>Txt_Target="")
//  //<>Txt_Target:=<>Txt_Source
//  //FIXER PARAMETRE ELEMENT(<>Lst_strings;$Lon_Reference;"_target";<>Txt_Target)
//  //Fin de si 
//  //Sinon   // translate="no"
//  //Si ($Lon_x>0)
//  //<>tTxt_attributeValues{$Lon_x}:="no"
//  //Sinon 
//  //AJOUTER A TABLEAU(<>tTxt_attributeNames;"translate")
//  //AJOUTER A TABLEAU(<>tTxt_attributeValues;"no")
//  //Fin de si 
//  //<>Txt_Target:=""
//  //OBJET FIXER SAISISSABLE(<>Txt_Target;Faux)
//  //OBJET FIXER VISIBLE(*;"@target@";Faux)
//  //Fin de si 
//  //  //Keep the attributes
//  //XLIFF_EDITOR_Boo_handler ("keep_attributes";-><>Lst_strings;->$Lon_Reference)
//  //  //Mark the file as modified
//  //XLIFF_EDITOR_MODIFIED
//  //  //.....................................................    
//  //Fin de cas 
//  //______________________________________________________
//  //: ($Ptr_Object=(-><>bSort))
//  //  //Get the reference of the list to sort 
//  //  //{
//  //INFORMATION ELEMENT(<>Lst_strings;*;$Lon_Reference;$Txt_Label;$Lon_Sublist;$Boo_Expanded)
//  //$Boo_Sort:=(Liste existante($Lon_Sublist))
//  //Si (Non($Boo_Sort))
//  //$Lon_Parent:=Element parent(<>Lst_strings;$Lon_Reference)
//  //INFORMATION ELEMENT(<>Lst_strings;Position element liste(<>Lst_strings;$Lon_Parent);$Lon_Reference;$Txt_Label;$Lon_Sublist;$Boo_Expanded)
//  //$Boo_Sort:=(Liste existante($Lon_Sublist))
//  //Fin de si 
//  //  //}
//  //  //If any sort the list
//  //Si ($Boo_Sort)
//  //Si (Majuscule enfoncee)
//  //TRIER LISTE($Lon_Sublist;<)
//  //Sinon 
//  //TRIER LISTE($Lon_Sublist)
//  //Fin de si 
//  //XLIFF_EDITOR_MODIFIED
//  //Fin de si 
//  //  //}
//
//  //______________________________________________________
//Fin de cas 
