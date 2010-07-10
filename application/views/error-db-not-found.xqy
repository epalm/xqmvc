xquery version "1.0";

import module namespace xqmvc = "http://scholarsportal.info/xqmvc/core" at "../../system/xqmvc.xqy";
import module namespace map = "http://scholarsportal.info/xqmvc/system/map" at "../../system/map.xqy";

declare variable $data as element(map) external;

<div>
    <p>Couldn't find document [{ map:get($data, 'db') }]</p>
    <form action="{ xqmvc:link('user', 'db-create') }" method="post">
        <p>
            <input type="submit" value="Create [{ map:get($data, 'db') }]"/>
        </p>
    </form>
</div>