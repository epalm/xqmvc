xquery version "1.0-ml";

(:~
 : Plugin-level configuration.
 :)
module namespace this = "http://scholarsportal.info/xqmvc/langedit/config";

(:
 : Directory in MarkLogic database to store language files, WITHOUT trailing 
 : slash.
 : 
 : eg: '/lang'
 :
 : CAUTION: Do not change this variable after creating language files/values,
 : unless you're prepared to move/rename existing languages files to a new
 : location in the DB.
 :)
declare variable $storage-dir as xs:string := '/langedit';

(:
 : Optionally prefix language filenames.
 : 
 : eg: 'lang-' means language file 'en' will be store as 'lang-en.xml'.
 :
 : CAUTION: Do not change this variable after creating language files/values,
 : unless you're prepared to move/rename existing languages files to a new
 : location in the DB.
 :)
declare variable $file-prefix as xs:string := '';

(:
 : The default language to fetch phrases from.  Note that xdmp:get-session-field
 : is useful here.
 :
 : eg: 'en'
 : eg: xdmp:get-session-field('lang', 'en')
 :)
declare variable $default-lang as xs:string := 'en';

(:
 : Change the name of this plugin if it conflicts with another XQMVC plugin.
 :)
declare variable $plugin-name as xs:string := 'langedit';