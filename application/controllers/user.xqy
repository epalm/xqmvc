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
import module namespace xqmvc = "http://scholarsportal.info/xqmvc/core" at "../../system/xqmvc.xqy";
import module namespace processor = "http://scholarsportal.info/xqmvc/system/processor" at "../../system/processor/processor.xqy";

import module namespace user = "http://user.manager.com" at "../models/user-model.xqy";

declare function xqmvc-controller:index() as item()*
{
    xqmvc-controller:list()
};

declare function xqmvc-controller:list() as item()*
{
    if (fn:not(user:db-exists())) then
        xqmvc-controller:_request-db-creation()
    else
        xqmvc:template('master-template', (
            'browsertitle', 'User Manager',
            'body', xqmvc:view('user-list-view')
        ))
};

declare function xqmvc-controller:view() as item()*
{
    if (fn:not(user:db-exists())) then
        xqmvc-controller:_request-db-creation()
    else
        let $id := processor:http-request-param("id")
        return
            if (fn:not(user:exists($id))) then
                xqmvc:redirect(xqmvc:link('user', 'list'))
            else
                let $user := user:get($id)
                return 
                    xqmvc:template('master-template', (
                        'browsertitle', fn:concat('User Manager - ', 
                            $user/first-name/text(), ' ', 
                            $user/last-name/text()),
                        'body', xqmvc:view('user-edit-view', (
                            'user', $user
                        ))
                    ))
};

declare function xqmvc-controller:db-create()
{
    user:db-create(),
    xqmvc:redirect(xqmvc:link("user", "list"))
};

declare function xqmvc-controller:create() as item()*
{
    let $email := processor:http-request-param("email")
    let $first-name := processor:http-request-param("first-name")
    let $last-name := processor:http-request-param("last-name")
    let $work := user:create($email, $first-name, $last-name)
        return xqmvc:redirect(xqmvc:link("user", "list"))
};

declare function xqmvc-controller:save() as item()*
{
    let $id := processor:http-request-param("id")
    let $email := processor:http-request-param("email")
    let $first-name := processor:http-request-param("first-name")
    let $last-name := processor:http-request-param("last-name")
    let $work := user:save($id, $email, $first-name, $last-name)
        return xqmvc:redirect(xqmvc:link("user", "list"))
};

declare function xqmvc-controller:delete() as item()*
{
    let $id := processor:http-request-param("id")
    let $work := user:delete($id)
        return xqmvc:redirect(xqmvc:link("user", "list"))
};

declare function xqmvc-controller:_request-db-creation()
{
    xqmvc:template('master-template', (
        'body', xqmvc:view('error-db-not-found', (
            'db', $user:db
        ))
    ))
};