xquery version "1.0";
module namespace user = "http://user.manager.com";

import module namespace processor = "http://scholarsportal.info/xqmvc/system/processor" at "../../system/processor/processor.xqy";

declare variable $db := '/users.xml';

declare function db-exists()
{
    processor:doc-available($db) and fn:exists(processor:doc($db)/users)
};

declare function db-create()
{
    if (fn:not(db-exists())) then
        processor:store($db, <users/>)
    else ()
};

declare function list() as element(user)*
{
    processor:doc($db)/users/user
};

declare function create($email as xs:string, $first-name as xs:string, 
    $last-name as xs:string)
{
    if (fn:not(db-exists())) then ()
    else
        let $user :=
            <user id="{ processor:random() }">
                <email edit="yes">{ $email }</email>
                <first-name edit="yes">{ $first-name }</first-name>
                <last-name edit="yes">{ $last-name }</last-name>
                <created>{ fn:current-dateTime() }</created>
            </user>
        return
            processor:node-insert-child(processor:doc($db)/users, $user)
};

declare function get($id as xs:string)
{
    if (fn:not(db-exists())) then ()
    else
        processor:doc($db)/users/user[@id eq $id]
};

declare function exists($id as xs:string)
as xs:boolean
{
    fn:exists(get($id))
};

declare function save($id as xs:string, $email as xs:string, 
    $first-name as xs:string, $last-name as xs:string)
{
    if (fn:not(db-exists())) then ()
    else
        if (fn:not(exists($id))) then ()
        else (
            processor:node-replace(processor:doc($db)/users/user[@id eq $id]/email, <email edit="yes">{ $email }</email>),
            processor:node-replace(processor:doc($db)/users/user[@id eq $id]/first-name, <first-name edit="yes">{ $first-name }</first-name>),
            processor:node-replace(processor:doc($db)/users/user[@id eq $id]/last-name, <last-name edit="yes">{ $last-name }</last-name>)
        )
};

declare function delete($id as xs:string)
{
    if (fn:not(db-exists())) then ()
    else
        if (fn:not(exists($id))) then ()
        else
            processor:node-delete(processor:doc($db)/users/user[@id eq $id])
};