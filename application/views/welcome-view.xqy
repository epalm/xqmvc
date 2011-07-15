xquery version "1.0";
import module namespace xqmvc = "http://scholarsportal.info/xqmvc/core" at "../../system/xqmvc.xqy";

import module namespace processor = "http://scholarsportal.info/xqmvc/system/processor" at "../../system/processor/processor.xqy";
import module namespace map = "http://scholarsportal.info/xqmvc/system/map" at "../../system/map.xqy";

declare variable $data as element(map) external;

<div xmlns="http://www.w3.org/1999/xhtml">
    <p>
        <a href="http://code.google.com/p/xqmvc">
            Website / Documentation
        </a>
    </p>
    <table>
        <tr>
            <td>Time:</td><td>{ processor:format-dateTime-for-human(xs:dateTime(map:get($data, 'time'))) }</td>
        </tr>
        <tr>
            <td>Architecture:</td><td>{ map:get($data, 'arch') }</td>
        </tr>
        <tr>
            <td>Platform:</td><td>{ map:get($data, 'plat') }</td>
        </tr>
        <tr>
            <td>Version:</td><td>{ map:get($data, 'vers') }</td>
        </tr>
    </table>
    <p><a href="{ xqmvc:link('user', 'list') }">User Manager example &#187;</a></p>
    <p><a href="{ xqmvc:plugin-link('langedit', 'editor', 'index') }">LangEdit i18n editor &#187;</a></p>
</div>