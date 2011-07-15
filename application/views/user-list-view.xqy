xquery version "1.0";
import module namespace xqmvc = "http://scholarsportal.info/xqmvc/core" at "../../system/xqmvc.xqy";
import module namespace user = "http://user.manager.com" at "../models/user-model.xqy";
import module namespace processor = "http://scholarsportal.info/xqmvc/system/processor" at "../../system/processor/processor.xqy";
import module namespace map = "http://scholarsportal.info/xqmvc/system/map" at "../../system/map.xqy";

declare variable $data as element(map) external;

<div xmlns="http://www.w3.org/1999/xhtml">
    { xqmvc:view('user-creation-form') }
    <table>
        <tr>
            <th>&#160;</th>
            <th>Email</th>
            <th>First</th>
            <th>Last Name</th>
            <th>Created</th>
        </tr>
        {
            for $user in user:list() order by $user/last-name return
                <tr>
                    <td>
                        <a href="{ xqmvc:link('user', 'view', ('id', $user/@id)) }">view</a>
                        &#160;
                        <a href="{ xqmvc:link('user', 'delete', ('id', $user/@id)) }">delete</a>
                        &#160;
                    </td>
                    <td>{ $user/child::element()[local-name(.) eq 'email']/text() }</td>
                    <td>{ $user/child::element()[local-name(.) eq 'first-name']/text() }</td>
                    <td>{ $user/child::element()[local-name(.) eq 'last-name']/text() }</td>
                    <td>{ processor:format-dateTime-for-human(xs:dateTime($user/child::element()[local-name(.) eq 'created'])) }</td>
                </tr>
        }
    </table>
    <p><a href="{ xqmvc:link('welcome', 'index') }">&#171; back to the Welcome Page</a></p>
</div>