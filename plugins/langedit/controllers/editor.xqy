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

module namespace xqmvc-controller = "http://scholarsportal.info/xqmvc/controller";
import module namespace xqmvc = "http://scholarsportal.info/xqmvc/core" at "../../../system/xqmvc.xqy";
import module namespace processor = "http://scholarsportal.info/xqmvc/system/processor" at "../../../system/processor/processor.xqy";

import module namespace cfg = "http://scholarsportal.info/xqmvc/langedit/config" at "../config/config.xqy";
import module namespace lang = "http://scholarsportal.info/xqmvc/langedit/m/lang" at "../models/lang-model.xqy";
import module namespace editor = "http://scholarsportal.info/xqmvc/langedit/m/editor" at "../models/editor-model.xqy";

declare function xqmvc-controller:index()
{
    let $lang := processor:http-request-param('lang', '')
    let $filter := processor:http-request-param('filter', '')
    let $path := lang:path($lang)
    return
        xqmvc:plugin-template($cfg:plugin-name, 'master-template', (
            'body',
                
                if (fn:not($lang)) then
                    xqmvc-controller:_not-specified()
                
                else if (fn:not(processor:doc-available($path))) then
                    xqmvc-controller:_not-found($lang)
                
                else
                    xqmvc:plugin-view($cfg:plugin-name, 'main-view', (
                        'lang', $lang,
                        'filter', $filter,
                        'path', $path
                    ))
        ))
};

declare function xqmvc-controller:_not-specified()
{
    xqmvc:plugin-view($cfg:plugin-name, 'error-lang-not-specified-view')
};

declare function xqmvc-controller:_not-found($lang as xs:string?)
{
    xqmvc:plugin-view($cfg:plugin-name, 'error-lang-not-found-view', (
        'lang', $lang
    ))
};

declare function xqmvc-controller:lang-create()
{
    let $lang := processor:http-request-param('lang')
    return (
        editor:lang-create($lang),
        xqmvc:redirect(xqmvc:plugin-link($cfg:plugin-name, 'editor', 'index', 
            ('lang', $lang)))
    )
};

declare function xqmvc-controller:lang-delete()
{
    let $lang := processor:http-request-param('lang')
    return (
        editor:lang-delete($lang),
        xqmvc:redirect(xqmvc:plugin-link($cfg:plugin-name, 'editor', 'index'))
    )
};

declare function xqmvc-controller:value-save-all()
{
    let $lang := processor:http-request-param('lang')
    let $filter := processor:http-request-param('filter')
    return (
    
        for $field in processor:http-request-param-names()
        return
            if (fn:starts-with($field, '__key__')) then
                let $id := fn:substring-after($field, '__key__')
                let $key := processor:http-request-param($field)
                let $text := processor:http-request-param(fn:concat('__text__', $id))
                return
                    editor:value-update($lang, $id, $key, $text)
            else ()
        ,
        xqmvc:redirect(xqmvc:plugin-link($cfg:plugin-name, 'editor', 'index',
            ('lang', $lang, 'filter', $filter)))
    )
};

declare function xqmvc-controller:value-create()
{
    let $lang := processor:http-request-param('lang')
    let $filter := processor:http-request-param('filter')
    let $key := processor:http-request-param('key')
    return (
        editor:value-create($key),
        xqmvc:redirect(xqmvc:plugin-link($cfg:plugin-name, 'editor', 'index', 
            ('lang', $lang, 'filter', $filter)))
    )
};

declare function xqmvc-controller:value-delete()
{
    let $lang := processor:http-request-param('lang')
    let $id := processor:http-request-param('id')
    return (
        editor:value-delete($id),
        xqmvc:redirect(xqmvc:plugin-link($cfg:plugin-name, 'editor', 'index',
            ('lang', $lang)))
    )
};