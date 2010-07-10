xquery version "1.0";

import module namespace xqmvc = "http://scholarsportal.info/xqmvc/core" at "../../system/xqmvc.xqy";
import module namespace map = "http://scholarsportal.info/xqmvc/system/map" at "../../system/map.xqy";

declare variable $data as element(map) external;

<form action="{ xqmvc:link('user', 'create') }" method="post">
    <div>
        Email: <input type="text" name="email" value=""/>
        First Name: <input type="text" name="first-name" value=""/>
        Last Name: <input type="text" name="last-name" value=""/>
        <input type="submit" value="Create"/>
    </div>
</form>