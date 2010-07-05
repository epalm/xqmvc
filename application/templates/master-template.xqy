xquery version "1.0";
import module namespace xqmvc = "http://scholarsportal.info/xqmvc/core" at "../../system/xqmvc.xqy";
import module namespace processor = "http://scholarsportal.info/xqmvc/system/processor" at "../../system/processor/processor.xqy";

declare variable $data as map:map external;

processor:http-response-content-type('text/html'),

$xqmvc:doctype-xhtml-1.1,

<html>
    <head>
        <title>{ map:get($data, 'browsertitle') }</title>
        <link rel="stylesheet" type="text/css" media="screen" href="{ $xqmvc:resource-dir }/css/style.css"/>
    </head>
    <body>
        <div id="hd">
            <h2>Welcome to XQMVC!</h2>
        </div>
        
        <hr />
        
        <div>{ map:get($data, 'body') }</div>
        
        <hr />
        
        <div id="ft">
            Ontario Council of University Libraries
        </div>
    </body>
</html>