//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : UTL__callbackMethodSourceSet
  //@scope : private
  //@deprecated : no
  //@description : This function sets the method text source code text
  //@parameter[1-IN-methodName-TEXT] : method name
  //@parameter[2-IN-methodSourceCode-TEXT] : methopde code
  //@notes : this will not work in a compiled database
  //  4D adds a first line : //%attributes = {"lang":"fr","invisible":true} comment added and reserved by 4D.
  //  it looks like JSON properties stored in an "attributes" object (good idea)
  //@example : UTL__callbackMethodSourceSet 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 11/11/2012, 11:45:29 - v1.00.00
  //@xdoc-end
  //================================================================================

  //C_TEXT($1;$vt_methodName)  //method name
  //C_TEXT($2;$vt_methodSourceCode)  //method source code

  //$vt_methodSourceCode:=""
  //If (Count parameters>1)
  //$vt_methodName:=$1
  //$vt_methodSourceCode:=$2

  //C_BOOLEAN($vb_isComponent)
  //$vb_isComponent:=ENV_isComponent 
  //If ($vb_isComponent)
  //  //the method is called as a component method, we will retun the host database method list
  //METHOD SET CODE($vt_methodName;$vt_methodSourceCode;*)

  //  //<Modif> Bruno LEGAY (BLE) (28/11/2018)
  //  // The plugin will call the host method/function which will call the component method/function
  //METHOD SET ATTRIBUTE($vt_methodName;Attribute invisible;True;*)
  //  //MÉTHODE FIXER ATTRIBUT($vt_callback;Attribut partagée;Vrai;*)
  //  //<Modif>

  //Else 
  //  //the method is not callled from a component
  //METHOD SET CODE($vt_methodName;$vt_methodSourceCode)

  //  //<Modif> Bruno LEGAY (BLE) (28/11/2018)
  //  // The plugin will call the host method/function which will call the component method/function
  //METHOD SET ATTRIBUTE($vt_methodName;Attribute invisible;True)
  //  //MÉTHODE FIXER ATTRIBUT($vt_callback;Attribut partagée;Vrai)
  //  //<Modif>
  //End if 

  //End if 
  //$0:=$vt_methodSourceCode
