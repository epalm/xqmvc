xquery version "1.0";

(:
 : Copyright 2009 Ontario Council of University Libraries
 : 
 : Licensed under the Apache License, Version 2.0 (the "License");
 : you may not use this file except in compliance with the License.
 : You may obtain a copy of the License at
 : 
 :    http://www.apache.org/licenses/LICENSE-2.0
 : 
 : Unless required by applicable law or agreed to in writing, software
 : distributed under the License is distributed on an "AS IS" BASIS,
 : WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 : See the License for the specific language governing permissions and
 : limitations under the License.
 :)

(:~
 : Application-level configuration.
 :)
module namespace xqmvc-conf = "http://scholarsportal.info/xqmvc/config";

(:
 : Absolute path of this web application within the App-Server, WITHOUT
 : trailing slash.  If it's in the root of the App Server, LEAVE BLANK.
 : 
 : eg: This web app is in a subdir named 'webapp' of the App-Server: '/webapp'
 : eg: This web app is in the root of the App-Server (leave blank):  ''
 : eg: This web app is in a collection inside the eXist-db database '/db/xqmvc'
 :)
declare variable $xqmvc-conf:app-root as xs:string := '';

(:
 : Enables/disables URL Rewriting.  All this flag truly does is change the 
 : output of the mvc:link function appropriately to reflect this setting.  
 : Please see the documentation for instructions on how to set up URL 
 : Rewriting.
 :)
declare variable $xqmvc-conf:url-rewrite as xs:boolean := fn:false();

(:
 : Enables/disables debug output.  This will affect performance of the
 : application and should be off in production environments.
 :)
declare variable $xqmvc-conf:debug as xs:boolean := fn:false();

(:
 : If URL Rewriting is on, you may optionally allow all your urls to contain a 
 : suffix, such as "http://host.com/webapp/controller/function.html".  Leave 
 : blank for no suffix.
 :)
declare variable $xqmvc-conf:url-suffix as xs:string := '.html';

(:
 : Default controller to load, if none specified.
 :)
declare variable $xqmvc-conf:default-controller as xs:string := 'welcome';

(:
 : Field name to use in the querystring when specifying which Controller to 
 : load.
 :)
declare variable $xqmvc-conf:controller-querystring-field as xs:string := '_c';

(:
 : Field name to use in the querystring when specifying which Function to 
 : execute.
 :)
declare variable $xqmvc-conf:function-querystring-field as xs:string := '_f';

(:
 : Field name to use in the querystring when specifying which Plugin to 
 : use.  If omitted in the querystring, no plugin is used.
 :)
declare variable $xqmvc-conf:plugin-querystring-field as xs:string := '_p';