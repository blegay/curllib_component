//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}

  //C_TEXT($0;$vt_languageStr)
  //C_LONGINT($1;$vl_language)
  //C_TEXT($2;$va_inLanguage)  // ("fr", "en")
  //  //_o_C_ALPHA(2;$2;$va_inLanguage)  // ("fr", "en")

  //  // NOTE : maybe the data should be stored in metadata files (xml)...

  //$vt_languageStr:=""

  //C_LONGINT($vl_nbParam)
  //$vl_nbParam:=Count parameters
  //If ($vl_nbParam>0)
  //$vl_language:=$1

  //If ($vl_language#0)

  //Case of 
  //: ($vl_nbParam=1)
  //$va_inLanguage:=""
  //Else 
  //  //: ($vl_nbParam=2)
  //$va_inLanguage:=$2
  //End case 

  //Case of 
  //: (Length($va_inLanguage)=0)

  //Case of 
  //: ($vl_language=7)
  //$vt_languageStr:="Deutsch"

  //: ($vl_language=9)
  //$vt_languageStr:="English"

  //: ($vl_language=10)
  //$vt_languageStr:="Español"

  //: ($vl_language=12)
  //$vt_languageStr:="Français"

  //: ($vl_language=22)
  //$vt_languageStr:="Português"

  //Else 
  //$vt_languageStr:=ENV__langageName ($vl_language;"en")
  //End case 

  //: ($va_inLanguage="en")  // language names in english
  //Case of 
  //: ($vl_language=1)
  //$vt_languageStr:="Arabic"
  //: ($vl_language=2)
  //$vt_languageStr:="Bulgarian"
  //: ($vl_language=3)
  //$vt_languageStr:="Catalan"
  //: ($vl_language=4)
  //$vt_languageStr:="Chinese"
  //: ($vl_language=5)
  //$vt_languageStr:="Czech"
  //: ($vl_language=6)
  //$vt_languageStr:="Danish"
  //: ($vl_language=7)
  //$vt_languageStr:="German"
  //: ($vl_language=8)
  //$vt_languageStr:="Greek"
  //: ($vl_language=9)
  //$vt_languageStr:="English"
  //: ($vl_language=10)
  //$vt_languageStr:="Spanish"
  //: ($vl_language=11)
  //$vt_languageStr:="Finnish"
  //: ($vl_language=12)
  //$vt_languageStr:="French"
  //: ($vl_language=13)
  //$vt_languageStr:="Hebrew"
  //: ($vl_language=14)
  //$vt_languageStr:="Hungarian"
  //: ($vl_language=15)
  //$vt_languageStr:="Icelandic"
  //: ($vl_language=16)
  //$vt_languageStr:="Italian"
  //: ($vl_language=17)
  //$vt_languageStr:="Japanese"
  //: ($vl_language=18)
  //$vt_languageStr:="Korean"
  //: ($vl_language=19)
  //$vt_languageStr:="Dutch"
  //: ($vl_language=20)
  //$vt_languageStr:="Norwegian"
  //: ($vl_language=21)
  //$vt_languageStr:="Polish"
  //: ($vl_language=22)
  //$vt_languageStr:="Portuguese"
  //: ($vl_language=24)
  //$vt_languageStr:="Romanian"
  //: ($vl_language=25)
  //$vt_languageStr:="Russian"
  //: ($vl_language=26)
  //$vt_languageStr:="Croatian"
  //: ($vl_language=26)
  //$vt_languageStr:="Serbian"
  //: ($vl_language=27)
  //$vt_languageStr:="Slovak"
  //: ($vl_language=28)
  //$vt_languageStr:="Albanian"
  //: ($vl_language=29)
  //$vt_languageStr:="Swedish"
  //: ($vl_language=30)
  //$vt_languageStr:="Thai"
  //: ($vl_language=31)
  //$vt_languageStr:="Turkish"
  //: ($vl_language=33)
  //$vt_languageStr:="Indonesian"
  //: ($vl_language=34)
  //$vt_languageStr:="Ukrainian"
  //: ($vl_language=35)
  //$vt_languageStr:="Belarusian"
  //: ($vl_language=36)
  //$vt_languageStr:="Slovenian"
  //: ($vl_language=37)
  //$vt_languageStr:="Estonian"
  //: ($vl_language=38)
  //$vt_languageStr:="Latvian"
  //: ($vl_language=39)
  //$vt_languageStr:="Lithuanian"
  //: ($vl_language=41)
  //$vt_languageStr:="Farsi"
  //: ($vl_language=42)
  //$vt_languageStr:="Vietnamese"
  //: ($vl_language=45)
  //$vt_languageStr:="Basque"
  //: ($vl_language=54)
  //$vt_languageStr:="Afrikaans"
  //: ($vl_language=56)
  //$vt_languageStr:="Faeroese"

  //Else 
  //$vt_languageStr:="??? "+String($vl_language)
  //End case 

  //: ($va_inLanguage="fr")  // language names in french
  //Case of 
  //: ($vl_language=1)
  //$vt_languageStr:="Arabe"
  //: ($vl_language=2)
  //$vt_languageStr:="Bulgare"
  //: ($vl_language=3)
  //$vt_languageStr:="Catalan"
  //: ($vl_language=4)
  //$vt_languageStr:="Chinois"
  //: ($vl_language=5)
  //$vt_languageStr:="Tcheque"
  //: ($vl_language=6)
  //$vt_languageStr:="Danois"
  //: ($vl_language=7)
  //$vt_languageStr:="Allemand"
  //: ($vl_language=8)
  //$vt_languageStr:="Grec"
  //: ($vl_language=9)
  //$vt_languageStr:="Anglais"
  //: ($vl_language=10)
  //$vt_languageStr:="Espagnol"
  //: ($vl_language=11)
  //$vt_languageStr:="Finlandais"
  //: ($vl_language=12)
  //$vt_languageStr:="Français"
  //: ($vl_language=13)
  //$vt_languageStr:="Hébreu"
  //: ($vl_language=14)
  //$vt_languageStr:="Hongrois"
  //: ($vl_language=15)
  //$vt_languageStr:="Islandais"
  //: ($vl_language=16)
  //$vt_languageStr:="Italien"
  //: ($vl_language=17)
  //$vt_languageStr:="Japonais"
  //: ($vl_language=18)
  //$vt_languageStr:="Coréen"
  //: ($vl_language=19)
  //$vt_languageStr:="Néerlandais"
  //: ($vl_language=20)
  //$vt_languageStr:="Norvégien"
  //: ($vl_language=21)
  //$vt_languageStr:="Polonais"
  //: ($vl_language=22)
  //$vt_languageStr:="Portugais"
  //: ($vl_language=24)
  //$vt_languageStr:="Roumain"
  //: ($vl_language=25)
  //$vt_languageStr:="Russe"
  //: ($vl_language=26)
  //$vt_languageStr:="Croate"
  //: ($vl_language=26)
  //$vt_languageStr:="Serbe"
  //: ($vl_language=27)
  //$vt_languageStr:="Slovaque"
  //: ($vl_language=28)
  //$vt_languageStr:="Albanais"
  //: ($vl_language=29)
  //$vt_languageStr:="Suédois"
  //: ($vl_language=30)
  //$vt_languageStr:="Thailandais"
  //: ($vl_language=31)
  //$vt_languageStr:="Turc"
  //: ($vl_language=33)
  //$vt_languageStr:="Indonésien"
  //: ($vl_language=34)
  //$vt_languageStr:="Ukrainien"
  //: ($vl_language=35)
  //$vt_languageStr:="Bélarusse"
  //: ($vl_language=36)
  //$vt_languageStr:="Slovène"
  //: ($vl_language=37)
  //$vt_languageStr:="Estonien"
  //: ($vl_language=38)
  //$vt_languageStr:="Letton"
  //: ($vl_language=39)
  //$vt_languageStr:="Lithuanien"
  //: ($vl_language=41)
  //$vt_languageStr:="Farsi"
  //: ($vl_language=42)
  //$vt_languageStr:="Vietnamien"
  //: ($vl_language=45)
  //$vt_languageStr:="Basque"
  //: ($vl_language=54)
  //$vt_languageStr:="Afrikaans"
  //: ($vl_language=56)
  //$vt_languageStr:="Féroïen"

  //Else 
  //$vt_languageStr:="??? "+String($vl_language)
  //End case 

  //: ($va_inLanguage="de")  // language names in german
  //Case of 
  //: ($vl_language=1)
  //$vt_languageStr:="Arabisch"
  //: ($vl_language=2)
  //$vt_languageStr:="Bulgarisch"
  //: ($vl_language=3)
  //$vt_languageStr:="Catalan"
  //: ($vl_language=4)
  //$vt_languageStr:="Chinesisch"
  //: ($vl_language=5)
  //$vt_languageStr:="Tschechisch"
  //: ($vl_language=6)
  //$vt_languageStr:="Dänisch"
  //: ($vl_language=7)
  //$vt_languageStr:="Deutsch"
  //: ($vl_language=8)
  //$vt_languageStr:="Griechisch"
  //: ($vl_language=9)
  //$vt_languageStr:="Englisch"
  //: ($vl_language=10)
  //$vt_languageStr:="Spanisch"
  //: ($vl_language=11)
  //$vt_languageStr:="Finnisch"
  //: ($vl_language=12)
  //$vt_languageStr:="Französisch"
  //: ($vl_language=13)
  //$vt_languageStr:="Hebräisch"
  //: ($vl_language=14)
  //$vt_languageStr:="Ungarisch"
  //: ($vl_language=15)
  //$vt_languageStr:="Isländisch"
  //: ($vl_language=16)
  //$vt_languageStr:="Italienisch"
  //: ($vl_language=17)
  //$vt_languageStr:="Japanisch"
  //: ($vl_language=18)
  //$vt_languageStr:="Koreanisch"
  //: ($vl_language=19)
  //$vt_languageStr:="Holländisch"
  //: ($vl_language=20)
  //$vt_languageStr:="Norwegisch"
  //: ($vl_language=21)
  //$vt_languageStr:="Polnisch"
  //: ($vl_language=22)
  //$vt_languageStr:="Portugiesisch"
  //: ($vl_language=24)
  //$vt_languageStr:="Rumänisch"
  //: ($vl_language=25)
  //$vt_languageStr:="Russisch"
  //: ($vl_language=26)
  //$vt_languageStr:="Kroatisch"
  //: ($vl_language=26)
  //$vt_languageStr:="Serbisch"
  //: ($vl_language=27)
  //$vt_languageStr:="Slovakisch"
  //: ($vl_language=28)
  //$vt_languageStr:="Albanisch"
  //: ($vl_language=29)
  //$vt_languageStr:="Schwedisch"
  //: ($vl_language=30)
  //$vt_languageStr:="Thailändisch"
  //: ($vl_language=31)
  //$vt_languageStr:="Türkisch"
  //: ($vl_language=33)
  //$vt_languageStr:="Indonesisch"
  //: ($vl_language=34)
  //$vt_languageStr:="Ukrainisch"
  //: ($vl_language=35)
  //$vt_languageStr:="Weißrussisch"
  //: ($vl_language=36)
  //$vt_languageStr:="Slowenisch"
  //: ($vl_language=37)
  //$vt_languageStr:="Estländisch"
  //: ($vl_language=38)
  //$vt_languageStr:="Lettisch"
  //: ($vl_language=39)
  //$vt_languageStr:="Lithauisch"
  //: ($vl_language=41)
  //$vt_languageStr:="Farsi (Persisch)"
  //: ($vl_language=42)
  //$vt_languageStr:="Vietnamesisch"
  //: ($vl_language=45)
  //$vt_languageStr:="Baskisch"
  //: ($vl_language=54)
  //$vt_languageStr:="Afrikaans"
  //: ($vl_language=56)
  //$vt_languageStr:="Färöisch"
  //Else 
  //$vt_languageStr:="??? "+String($vl_language)
  //End case 

  //: ($va_inLanguage="sp")  // language names in spanish
  //Case of 
  //: ($vl_language=1)
  //$vt_languageStr:="Árabe"
  //: ($vl_language=2)
  //$vt_languageStr:="Búlgaro"
  //: ($vl_language=3)
  //$vt_languageStr:="Catalán"
  //: ($vl_language=4)
  //$vt_languageStr:="Chino"
  //: ($vl_language=5)
  //$vt_languageStr:="Checo"
  //: ($vl_language=6)
  //$vt_languageStr:="Danés"
  //: ($vl_language=7)
  //$vt_languageStr:="Alemán"
  //: ($vl_language=8)
  //$vt_languageStr:="Griego"
  //: ($vl_language=9)
  //$vt_languageStr:="Inglés"
  //: ($vl_language=10)
  //$vt_languageStr:="Español"
  //: ($vl_language=11)
  //$vt_languageStr:="Finlandés"
  //: ($vl_language=12)
  //$vt_languageStr:="Francés"
  //: ($vl_language=13)
  //$vt_languageStr:="Hebreo"
  //: ($vl_language=14)
  //$vt_languageStr:="Húngaro"
  //: ($vl_language=15)
  //$vt_languageStr:="Islandés"
  //: ($vl_language=16)
  //$vt_languageStr:="Italiano"
  //: ($vl_language=17)
  //$vt_languageStr:="Japonés"
  //: ($vl_language=18)
  //$vt_languageStr:="Coreano"
  //: ($vl_language=19)
  //$vt_languageStr:="Holandés"
  //: ($vl_language=20)
  //$vt_languageStr:="Noruego"
  //: ($vl_language=21)
  //$vt_languageStr:="Polonia"
  //: ($vl_language=22)
  //$vt_languageStr:="Portugués"
  //: ($vl_language=24)
  //$vt_languageStr:="Rumano"
  //: ($vl_language=25)
  //$vt_languageStr:="Ruso"
  //: ($vl_language=26)
  //$vt_languageStr:="Croata"
  //: ($vl_language=26)
  //$vt_languageStr:="Serbio"
  //: ($vl_language=27)
  //$vt_languageStr:="Esloveno"
  //: ($vl_language=28)
  //$vt_languageStr:="Albanés"
  //: ($vl_language=29)
  //$vt_languageStr:="Suizo"
  //: ($vl_language=30)
  //$vt_languageStr:="Tailandés"
  //: ($vl_language=31)
  //$vt_languageStr:="Turco"
  //: ($vl_language=33)
  //$vt_languageStr:="Indonesio"
  //: ($vl_language=34)
  //$vt_languageStr:="Ucraniano"
  //: ($vl_language=35)
  //$vt_languageStr:="Bielarruso"
  //: ($vl_language=36)
  //$vt_languageStr:="Esloveno"
  //: ($vl_language=37)
  //$vt_languageStr:="Estonio"
  //: ($vl_language=38)
  //$vt_languageStr:="Latvio"
  //: ($vl_language=39)
  //$vt_languageStr:="Lituania"
  //: ($vl_language=41)
  //$vt_languageStr:="Farsi"
  //: ($vl_language=42)
  //$vt_languageStr:="Vietnamés"
  //: ($vl_language=45)
  //$vt_languageStr:="Vasco"
  //: ($vl_language=54)
  //$vt_languageStr:="Africano"
  //: ($vl_language=56)
  //$vt_languageStr:="Feroés"
  //Else 
  //$vt_languageStr:="??? "+String($vl_language)
  //End case 

  //: ($va_inLanguage="po")  // language names in portuguese
  //Case of 
  //: ($vl_language=1)
  //$vt_languageStr:="Árabe"
  //: ($vl_language=2)
  //$vt_languageStr:="Búlgaro"
  //: ($vl_language=3)
  //$vt_languageStr:="Catalão"
  //: ($vl_language=4)
  //$vt_languageStr:="Chinês"
  //: ($vl_language=5)
  //$vt_languageStr:="Checo"
  //: ($vl_language=6)
  //$vt_languageStr:="Danes"
  //: ($vl_language=7)
  //$vt_languageStr:="Alemão"
  //: ($vl_language=8)
  //$vt_languageStr:="Grego"
  //: ($vl_language=9)
  //$vt_languageStr:="Inglês"
  //: ($vl_language=10)
  //$vt_languageStr:="Espanhol"
  //: ($vl_language=11)
  //$vt_languageStr:="Finlandês"
  //: ($vl_language=12)
  //$vt_languageStr:="Francês"
  //: ($vl_language=13)
  //$vt_languageStr:="Hebraico"
  //: ($vl_language=14)
  //$vt_languageStr:="Húngaro"
  //: ($vl_language=15)
  //$vt_languageStr:="Islandês"
  //: ($vl_language=16)
  //$vt_languageStr:="Italiano"
  //: ($vl_language=17)
  //$vt_languageStr:="Japonês"
  //: ($vl_language=18)
  //$vt_languageStr:="Coreano"
  //: ($vl_language=19)
  //$vt_languageStr:="Holandês"
  //: ($vl_language=20)
  //$vt_languageStr:="Norueguês"
  //: ($vl_language=21)
  //$vt_languageStr:="Polonês"
  //: ($vl_language=22)
  //$vt_languageStr:="Português"
  //: ($vl_language=24)
  //$vt_languageStr:="Romano"
  //: ($vl_language=25)
  //$vt_languageStr:="Russo"
  //: ($vl_language=26)
  //$vt_languageStr:="Croata"
  //: ($vl_language=26)
  //$vt_languageStr:="Sérvio"
  //: ($vl_language=27)
  //$vt_languageStr:="Esloveno"
  //: ($vl_language=28)
  //$vt_languageStr:="Albanês"
  //: ($vl_language=29)
  //$vt_languageStr:="Suíço"
  //: ($vl_language=30)
  //$vt_languageStr:="Tailandês"
  //: ($vl_language=31)
  //$vt_languageStr:="Turco"
  //: ($vl_language=33)
  //$vt_languageStr:="Indonésio"
  //: ($vl_language=34)
  //$vt_languageStr:="Ucraniano"
  //: ($vl_language=35)
  //$vt_languageStr:="Bielorruso"
  //: ($vl_language=36)
  //$vt_languageStr:="Esloveno"
  //: ($vl_language=37)
  //$vt_languageStr:="Estoniano"
  //: ($vl_language=38)
  //$vt_languageStr:="Letão"
  //: ($vl_language=39)
  //$vt_languageStr:="Lituano"
  //: ($vl_language=41)
  //$vt_languageStr:="Persa"
  //: ($vl_language=42)
  //$vt_languageStr:="Vietnamita"
  //: ($vl_language=45)
  //$vt_languageStr:="Basco"
  //: ($vl_language=54)
  //$vt_languageStr:="Africano"
  //: ($vl_language=56)
  //$vt_languageStr:="Feróica"
  //Else 
  //$vt_languageStr:="??? "+String($vl_language)
  //End case 

  //Else 
  //$vt_languageStr:=ENV__langageName ($vl_language;"en")
  //End case 

  //End if 

  //End if 
  //$0:=$vt_languageStr