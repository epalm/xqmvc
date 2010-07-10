xquery version "1.0-ml";

module namespace impl = "http://scholarsportal.info/xqmvc/system/processor/impl/marklogic";

declare function impl:execute-module-function($module-namespace as xs:anyURI, $controller-file as xs:anyURI, $function-name as xs:string) as item()* {

    let $import-declaration := fn:concat(
        'import module namespace pfx = ',
        '"', $module-namespace,'" at ',
        '"', $controller-file, '";'
    ),
    $function-call := fn:concat('pfx:', $function-name, '()') return

        xdmp:eval(
            fn:concat($import-declaration, $function-call),
            (),
            <options xmlns="xdmp:eval">
                <isolation>different-transaction</isolation>
                <prevent-deadlocks>true</prevent-deadlocks>
            </options>
        )
};

declare function impl:execute($view-file as xs:anyURI, $map as element(map)) {
    xdmp:invoke($view-file, 
        (xs:QName("data"), $map),
        <options xmlns="xdmp:eval">
            <isolation>different-transaction</isolation>
            <prevent-deadlocks>true</prevent-deadlocks>
        </options>
    )
};

declare function impl:http-response-redirect($location as xs:anyURI) as empty()
{
    xdmp:redirect-response($location)
};

declare function impl:http-response-content-type($content-type as xs:string) as empty() {
    xdmp:set-response-content-type($content-type)
};

declare function impl:response-set-document-type($doctype as xs:string) {
    $doctype
};

declare function impl:http-request-param($param-name as xs:string, $default-value as xs:string*) as xs:string*
{
    xdmp:get-request-field($param-name, $default-value)
};

declare function impl:http-request-param-names() as xs:string*
{
    xdmp:get-request-field-names()
};

declare function impl:http-request-param($param-name as xs:string) as xs:string*
{
    xdmp:get-request-field($param-name)
};

declare function impl:log($log-message as xs:string) as empty()
{
    xdmp:log($log-message)
};

declare function impl:architecture() as xs:string
{
    xdmp:architecture();
};

declare function impl:platform() as xs:string
{
    xdmp:platform();
};

declare function impl:version() as xs:string
{
    xdmp:version();
};

declare function impl:store($document-uri as xs:anyURI, $root as node()) as empty()
{
    xdmp:document-insert($document-uri, $root)
};

declare function impl:delete($document-uri as xs:anyURI) as empty()
{
    xdmp:document-delete($document-uri)
};

declare function impl:doc-available($document-uri as xs:string?) as xs:boolean
{
    fn:doc-available($document-uri)
};

declare function impl:doc($document-uri as xs:string?) as node()?
{
    fn:doc($document-uri)
};

declare function impl:directory($uri as xs:string) as document()*
{
    xdmp:directory($uri)
};

declare function impl:random() as xs:integer
{
    xdmp:random()
};

declare function impl:node-insert-child($node as node(), $child as node()) as empty()
{
    xdmp:node-insert-child($node, $child)
};

declare function impl:node-replace($current-node as node(), $replacement-node as node()) as empty()
{
    xdmp:node-replace($current-node, $replacement-node)
};

declare function impl:node-delete($node as node()) as empty()
{
    xdmp:node-delete($node)
};

declare function impl:format-dateTime-for-human($dateTime as xs:dateTime) as xs:string
{
    xdmp:strftime("%a %d %b %Y %I:%M %p", $dateTime)
};    

declare function impl:parse-with-fixes($unparsed as xs:string) as node()+
{
    xdmp:unquote($unparsed, "", "repair-full")
};