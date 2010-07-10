xquery version "1.0";

import module namespace xqmvc = "http://scholarsportal.info/xqmvc/core" at "../../../system/xqmvc.xqy";
import module namespace map = "http://scholarsportal.info/xqmvc/system/map" at "../../../system/map.xqy";
import module namespace cfg = "http://scholarsportal.info/xqmvc/langedit/config" at "../config/config.xqy";
import module namespace editor = "http://scholarsportal.info/xqmvc/langedit/m/editor" at "../models/editor-model.xqy";

declare variable $data as element(map) external;

<div xmlns="http://www.w3.org/1999/xhtml">{
    for $lang in editor:lang-list()
    return (
        <a href="{ xqmvc:plugin-link($cfg:plugin-name, 'editor', 'index', ('lang', $lang)) }">{
            if ($lang eq map:get($data, 'current')) then attribute class { 'selected' } else (),
            $lang
        }</a>
        , '&#160;'
    )
}&#160;</div>