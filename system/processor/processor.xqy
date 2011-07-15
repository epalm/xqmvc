xquery version "1.0";

module namespace processor = "http://scholarsportal.info/xqmvc/system/processor";

import module namespace xqmvc-conf = "http://scholarsportal.info/xqmvc/config" at "../../application/config/config.xqy";

(:~
: Choose a processor to use
:)

(: eXist-db :)
import module namespace impl = "http://scholarsportal.info/xqmvc/system/processor/impl/exist-db" at "impl/exist-db/impl.xqy";

(: MarkLogic :)
(: import module namespace impl = "http://scholarsportal.info/xqmvc/system/processor/impl/marklogic" at "impl/marklogic/impl.xqy"; :)



declare function processor:execute-module-function($module-namespace as xs:anyURI, $controller-file as xs:anyURI, $function-name as xs:string) as item()* {
    impl:execute-module-function($module-namespace, $controller-file, $function-name)
};

declare function processor:execute($view-file as xs:anyURI, $map as element(map)) {
    impl:execute($view-file, $map)
};

declare function processor:http-response-redirect($location as xs:anyURI) as empty() {
    impl:http-response-redirect($location)
};

declare function processor:http-response-content-type($content-type as xs:string) as empty() {
    impl:http-response-content-type($content-type)
};

declare function processor:response-set-document-type($doctype as xs:string) {
    impl:response-set-document-type($doctype)
};

declare function processor:http-request-param-names() as xs:string*
{
    impl:http-request-param-names()
};

declare function processor:http-request-param($param-name as xs:string, $default-value as xs:string*) as xs:string*
{
    impl:http-request-param($param-name, $default-value)
};

declare function processor:http-request-param($param-name as xs:string) as xs:string*
{
    impl:http-request-param($param-name)
};

declare function processor:http-session-param($param-name as xs:string, $default-value as item()*) as item()*
{
    impl:http-session-param($param-name, $default-value)
};

declare function processor:log($log-message as xs:string) as empty()
{
    impl:log($log-message)
};

declare function processor:architecture() as xs:string
{
    impl:architecture()
};

declare function processor:platform() as xs:string
{
    impl:platform()
};

declare function processor:version() as xs:string
{
    impl:version()
};

declare function processor:store($document-uri as xs:anyURI, $root as node()) as empty()
{
    impl:store($document-uri, $root)
};

declare function processor:delete($document-uri as xs:anyURI) as empty()
{
    impl:delete($document-uri)
};

declare function processor:doc-available($document-uri as xs:anyURI?) as xs:boolean
{
    impl:doc-available($document-uri)
};

declare function processor:doc($document-uri as xs:anyURI?) as node()?
{
    impl:doc($document-uri)
};

declare function processor:directory($uri as xs:anyURI) as document-node()*
{
    impl:directory($uri)
};

declare function processor:random() as xs:integer
{
    impl:random()
};

declare function processor:node-insert-child($node as node(), $child as node()) as empty()
{
    impl:node-insert-child($node, $child)
};

declare function processor:node-replace($current-node as node(), $replacement-node as node()) as empty()
{
    impl:node-replace($current-node, $replacement-node)
};

declare function processor:node-delete($node as node()) as empty()
{
    impl:node-delete($node)
};

declare function processor:format-dateTime-for-human($dateTime as xs:dateTime) as xs:string
{
    impl:format-dateTime-for-human($dateTime)
};

declare function processor:parse-with-fixes($unparsed as xs:string) as node()+ {
    impl:parse-with-fixes($unparsed)
};

declare function processor:get-server-base-uri() as xs:anyURI {
    impl:get-server-base-uri()
};
