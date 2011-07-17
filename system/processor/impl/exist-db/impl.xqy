xquery version "1.0";

module namespace impl = "http://scholarsportal.info/xqmvc/system/processor/impl/exist-db";

import module namespace xqmvc-conf = "http://scholarsportal.info/xqmvc/config" at "../../../../application/config/config.xqy";

import module namespace datetime = "http://exist-db.org/xquery/datetime";
import module namespace request = "http://exist-db.org/xquery/request";
import module namespace response = "http://exist-db.org/xquery/response";
import module namespace session = "http://exist-db.org/xquery/session";
import module namespace system = "http://exist-db.org/xquery/system";
import module namespace util = "http://exist-db.org/xquery/util";
import module namespace xmldb = "http://exist-db.org/xquery/xmldb";

declare variable $impl:log-level as xs:string := "info";

declare function impl:execute-module-function($module-namespace as xs:anyURI, $controller-file as xs:anyURI, $function-name as xs:string) as item()* {
    
    (:
    let $import-declaration := fn:concat(
        'import module namespace pfx = ',
        '"', $module-namespace,'" at ',
        '"', $controller-file, '";'
    ),
    $function-call := fn:concat('pfx:', $function-name, '()') return

        util:eval(
            fn:concat($import-declaration, $function-call)
        )
    :)
        
         let $template := util:import-module($module-namespace, "pfx",
            xs:anyURI(fn:concat("xmldb:exist://", $controller-file))) return
    
        (: TODO experiment with changing false() to true() below for caching :)
    
       util:eval(fn:concat('pfx:', $function-name, '()'), false())
};

declare function impl:execute($view-file as xs:anyURI, $map as element(map)) {

    (: requires eXist 1.4.1+ :)
    
    (: TODO experiment with changing false() to true() below for caching :)
    
    util:eval($view-file,
        false(),
        (xs:QName("data"), $map)
    )
};

declare function impl:http-response-redirect($location as xs:anyURI) as empty()
{
    response:redirect-to($location)
};

declare function impl:http-response-content-type($content-type as xs:string) as empty() {
    if(util:get-option("exist:serialize"))then
        util:declare-option("exist:serialize", fn:concat(util:get-option("exist:serialize"), " ", "method=xhtml omit-xml-declaration=no media-type=", $content-type))
    else
        util:declare-option("exist:serialize", fn:concat("method=xhtml omit-xml-declaration=no media-type=", $content-type))
};

declare function impl:response-set-document-type($doctype as xs:string) {

    (: TODO need to fix how serialization options are set :)
    let $doctype-public := replace(tokenize($doctype, '"')[2], " ", "&#160;"),
    $doctype-system := tokenize($doctype, '"')[4] return
    
    if(util:get-option("exist:serialize"))then
        util:declare-option("exist:serialize", fn:concat(util:get-option("exist:serialize"), " ", "method=xhtml omit-xml-declaration=no media-type=text/html doctype-public=", $doctype-public, " doctype-system=", $doctype-system))
    else
        util:declare-option("exist:serialize", fn:concat("method=xhtml omit-xml-declaration=no media-type=text/html doctype-public=", $doctype-public, " doctype-system=", $doctype-system))
};

declare function impl:http-request-param-names() as xs:string*
{
    request:get-parameter-names()
};

declare function impl:http-request-param($param-name as xs:string, $default-value as xs:string*) as xs:string*
{
    request:get-parameter($param-name, $default-value)
};

declare function impl:http-request-param($param-name as xs:string) as xs:string*
{
    request:get-parameter($param-name, ())
};

declare function impl:http-session-param($param-name as xs:string, $default-value as item()*) as item()*
{
    let $session-param := session:get-attribute($param-name) return
        if(empty($session-param))then
            $default-value
        else
            $session-param
};

declare function impl:log($log-message as xs:string) as empty()
{
    util:log($impl:log-level, $log-message)
};

declare function impl:architecture() as xs:string
{
    "Java"
};

declare function impl:platform() as xs:string
{
    "eXist-db"
};

declare function impl:version() as xs:string
{
    system:get-version()
};

declare function impl:store($document-uri as xs:anyURI, $root as node()) as empty()
{
    let $db-document-uri := impl:_uri_to_db_uri($document-uri),
    $db-collection-uri := impl:_collection-path-from-uri($db-document-uri) return
        
        let $null := impl:_create-collection-path($db-collection-uri) return
            let $stored-uri := xmldb:store($db-collection-uri, impl:_resource-path-from-uri($db-document-uri), $root) return
                ()
};

(: creates the collection path if it doesnt exist :)
declare function impl:_create-collection-path($path as xs:string) {
	let $segments := tokenize($path, "/") return
		for $i in 3 to count($segments)
		let $parent-collection := fn:concat("/", string-join($segments[position() = (2 to $i - 1)], "/"))
		let $collection-name := $segments[$i] return
            if(xmldb:collection-available(fn:concat($parent-collection, "/", $collection-name)))then
                ()
            else
                xmldb:create-collection($parent-collection, $collection-name)
};

declare function impl:delete($document-uri as xs:anyURI) as empty()
{
    let $db-document-uri := impl:_uri_to_db_uri($document-uri) return
        xmldb:remove(impl:_collection-path-from-uri($db-document-uri), impl:_resource-path-from-uri($db-document-uri))
};

declare function impl:doc-available($document-uri as xs:anyURI?) as xs:boolean
{
    fn:doc-available(impl:_uri_to_db_uri($document-uri))
};

declare function impl:doc($document-uri as xs:anyURI?) as node()?
{
    fn:doc(impl:_uri_to_db_uri($document-uri))
};

declare function impl:directory($uri as xs:anyURI) as document-node()*
{
    fn:collection(impl:_uri_to_db_uri($uri))
};

declare function impl:random() as xs:unsignedLong
{
    util:random-ulong()
};

declare function impl:node-insert-child($node as node(), $child as node()) as empty()
{
    update insert $child into $node
};

declare function impl:node-replace($current-node as node(), $replacement-node as node()) as empty()
{
    update replace $current-node with $replacement-node
};

declare function impl:node-delete($node as node()) as empty()
{
    update delete $node
};

declare function impl:format-dateTime-for-human($dateTime as xs:dateTime) as xs:string
{
    datetime:format-dateTime($dateTime, "E d MMM yyyy hh:mm a")
};

declare function impl:parse-with-fixes($unparsed as xs:string) as node()+
{
    util:parse-html($unparsed)
};

declare function impl:_uri_to_db_uri($document-uri as xs:anyURI) as xs:string {
    
    let $db-document-uri :=
        if(fn:not(fn:starts-with($document-uri, $xqmvc-conf:app-root))) then
            if(fn:starts-with($document-uri, "/"))then
                fn:concat($xqmvc-conf:app-root, $document-uri)
            else
                fn:concat($xqmvc-conf:app-root, "/", $document-uri)
        else
            $document-uri
            
    return
        $db-document-uri
};

declare function impl:_collection-path-from-uri($uri as xs:anyURI) as xs:string
{
    replace($uri, "(.*)/.*", "$1")
};

declare function impl:_resource-path-from-uri($uri as xs:anyURI) as xs:string
{
    replace($uri, ".*/", "")
};

declare function impl:get-server-base-uri() as xs:anyURI {
    xs:anyURI(substring-before(request:get-uri(), "/db/"))
};