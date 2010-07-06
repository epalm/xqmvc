xquery version "1.0";

module namespace impl = "http://scholarsportal.info/xqmvc/system/processor/impl/exist-db";

declare namespace datetime = "http://exist-db.org/xquery/datetime";
declare namespace request = "http://exist-db.org/xquery/request";
declare namespace response = "http://exist-db.org/xquery/response";
declare namespace system = "http://exist-db.org/xquery/system";
declare namespace util = "http://exist-db.org/xquery/util";

declare variable $impl:log-level as xs:string := "info";
declare variable $impl:db-data-root := "/db";



declare function impl:execute-module-function($module-namespace as xs:anyURI, $controller-file as xs:anyURI, $function-name as xs:string) as item()* {
    
    let $import-declaration := fn:concat(
        'import module namespace pfx = ',
        '"', $module-namespace,'" at ',
        '"', $controller-file, '";'
    ),
    $function-call := fn:concat('pfx:', $function-name, '()') return

        util:eval(
            fn:concat($import-declaration, $function-call)
        )
};

declare function impl:execute($view-file as xs:anyURI, $map as element(map)) {

    (: requires eXist 1.4.1+ :)
    
    util:eval($view-file, 
        (xs:QName("data"), sequence-to-map($pairs))
    )
};

declare function impl:http-response-redirect($location as xs:anyURI) as empty()
{
    response:redirect-to($location)
};

declare function impl:http-response-content-type($content-type as xs:string) as empty() {
    util:declare-option("exist:serialize", fn:concat("media-type=", $content-type))
};

declare function impl:response-set-document-type($doctype as xs:string) {
    util:declare-option("exist:serialize", fn:concat("doctype-public=", tokenize($doctype, '"')[2], " doctype-private=", tokenize($doctype, '"')[4]))
};

declare function impl:http-request-param-names() as xs:string*
{
    request:get-parameter-names()
};

declare function impl:http-request-param($param-name as xs:string, $default-value as xs:string*) as xs:string*
{
    xdmp:get-request-field($param-name, $default-value)
};

declare function impl:http-request-param($param-name as xs:string) as xs:string*
{
    impl:http-request-param($param-name, ())
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
    let $db-document-uri := impl:_uri_to_db_uri($document-uri) return
        let $stored-uri := xmldb:store(impl:_collection-path-from-uri($db-document-uri), impl:_resource-path-from-uri($uri), root) return
            ()
};

declare function impl:delete($document-uri as xs:anyURI) as empty()
{
    let $db-document-uri := impl:_uri_to_db_uri($document-uri) return
        xmldb:remove(impl:_collection-path-from-uri($db-document-uri), impl:_resource-path-from-uri($uri))
};

declare function impl:doc-available($document-uri as xs:string?) as xs:boolean
{
    fn:doc-available(impl:_uri_to_db_uri($document-uri))
};

declare function impl:doc($document-uri as xs:string?) as node()?
{
    fn:doc(impl:_uri_to_db_uri($document-uri))
};

declare function impl:directory($uri as xs:string) as document()*
{
    collection(impl:_uri_to_db_uri($uri))
};

declare function impl:random() as xs:integer
{
    util:random()
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



declare function impl:_uri_to_db_uri($document-uri as xs:anyURI) as xs:anyURI {
    
    let $db-document-uri := if(fn:not(fn:starts-with($document-uri, $impl:db-data-root))) then
    (
        if(fn:starts-with($document-uri, "/")then
        (
            fn:concat($impl:db-data-root, $document-uri)
        )
        else
        (
           fn:concat($impl:db-data-root, "/", $document-uri)
        )
    ) else($document-uri) return
        $db-document-uri
};

declare function impl:_collection-path-from-uri($uri as xs:string) as xs:string
{
    replace($uri, "(.*)/.*", "$1")
};

declare function impl:_resource-path-from-uri($uri as xs:string) as xs:string
{
    replace($uri, ".*/", "")
};