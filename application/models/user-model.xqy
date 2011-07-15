xquery version "1.0";

module namespace user = "http://user.manager.com";

import module namespace processor = "http://scholarsportal.info/xqmvc/system/processor" at "../../system/processor/processor.xqy";

declare variable $user:db as xs:anyURI := xs:anyURI("/users.xml");

declare function user:db-exists()
{
    processor:doc-available($user:db) and fn:exists(processor:doc($user:db)/users)
};

declare function user:db-create()
{
    if(fn:not(user:db-exists())) then
        processor:store($user:db, <users/>)
    else()
};

declare function user:list() as element(user)*
{
    processor:doc($user:db)/users/user
};

declare function user:create($email as xs:string, $first-name as xs:string, $last-name as xs:string)
{
    if (fn:not(user:db-exists())) then
    ()
    else
        let $user :=
            <user id="{ processor:random() }">
                <email edit="yes">{ $email }</email>
                <first-name edit="yes">{ $first-name }</first-name>
                <last-name edit="yes">{ $last-name }</last-name>
                <created>{ fn:current-dateTime() }</created>
            </user>
        return
            processor:node-insert-child(processor:doc($user:db)/users, $user)
};

declare function user:get($id as xs:string)
{
    if (fn:not(user:db-exists())) then
    ()
    else
        processor:doc($user:db)/users/user[@id eq $id]
};

declare function user:exists($id as xs:string) as xs:boolean
{
    fn:exists(user:get($id))
};

declare function user:save($id as xs:string, $email as xs:string, $first-name as xs:string, $last-name as xs:string)
{
    if (fn:not(user:db-exists())) then
    ()
    else
        if (fn:not(fn:exists($id))) then
        ()
        else
        (
            processor:node-replace(processor:doc($user:db)/users/user[@id eq $id]/email, <email edit="yes">{ $email }</email>),
            processor:node-replace(processor:doc($user:db)/users/user[@id eq $id]/first-name, <first-name edit="yes">{ $first-name }</first-name>),
            processor:node-replace(processor:doc($user:db)/users/user[@id eq $id]/last-name, <last-name edit="yes">{ $last-name }</last-name>)
        )
};

declare function user:delete($id as xs:string)
{
    if (fn:not(user:db-exists())) then
    ()
    else
        if (fn:not(fn:exists($id))) then
        ()
        else
            processor:node-delete(processor:doc($user:db)/users/user[@id eq $id])
};