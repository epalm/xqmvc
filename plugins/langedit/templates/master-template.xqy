xquery version "1.0";

import module namespace xqmvc = "http://scholarsportal.info/xqmvc/core" at "../../../system/xqmvc.xqy";
import module namespace processor = "http://scholarsportal.info/xqmvc/system/processor" at "../../../system/processor/processor.xqy";
import module namespace map = "http://scholarsportal.info/xqmvc/system/map" at "../../../system/map.xqy";

declare variable $data as element(map) external;

processor:http-response-content-type('application/xhtml+xml'),

processor:http-response-set-document-type($xqmvc:doctype-xhtml-1.1),

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <title>LangEdit</title>
        <link rel="stylesheet" type="text/css" media="screen" href="{ $xqmvc:plugin-resource-dir }/css/style.css"/>
    </head>
    <body onload="document.getElementById('focus').focus()">
        <div id="hd">
            <div style="float: left; width: 49%; text-align: left;">
                LangEdit
            </div>
            <div style="float: right; width: 49%; text-align: right;">
                <a href="http://spotdocs.scholarsportal.info/display/MarkLogic/LangEdit">help</a>
            </div>
            <div style="clear: both;">{' '}</div>
        </div>
        
        <hr />
        
        <div class="bd">{ map:get($data, 'body') }</div>
        
        <hr />
        
        <div id="ft">
            Ontario Council of University Libraries
        </div>
    </body>
</html>