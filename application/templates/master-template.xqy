xquery version "1.0-ml";
import module namespace xqmvc = "http://scholarsportal.info/xqmvc/core" at "../../system/xqmvc.xqy";
declare variable $data as map:map external;

xdmp:set-response-content-type('text/html'),

'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">',

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