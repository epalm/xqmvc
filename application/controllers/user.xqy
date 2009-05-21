xquery version "1.0-ml";
module namespace xqmvc-controller = "http://scholarsportal.info/xqmvc/controller";
import module namespace xqmvc = "http://scholarsportal.info/xqmvc/core" at "../../system/xqmvc.xqy";

import module namespace user = "http://user.manager.com" at "../models/user-model.xqy";

declare function index()
as item()*
{
	list()
};

declare function list()
as item()*
{
	if (fn:not(user:db-exists())) then
		_request-db-creation()
	else
		xqmvc:template('master-template', (
			'browsertitle', 'User Manager',
			'body', xqmvc:view('user-list-view')
		))
};

declare function view()
as item()*
{
	if (fn:not(user:db-exists())) then
		_request-db-creation()
	else
		let $id := xdmp:get-request-field("id")
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

declare function db-create()
{
	user:db-create(),
	xqmvc:redirect(xqmvc:link("user", "list"))
};

declare function create()
as item()*
{
	let $email := xdmp:get-request-field("email")
	let $first-name := xdmp:get-request-field("first-name")
	let $last-name := xdmp:get-request-field("last-name")
	let $work := user:create($email, $first-name, $last-name)
	return xqmvc:redirect(xqmvc:link("user", "list"))
};

declare function save()
as item()*
{
	let $id := xdmp:get-request-field("id")
	let $email := xdmp:get-request-field("email")
	let $first-name := xdmp:get-request-field("first-name")
	let $last-name := xdmp:get-request-field("last-name")
	let $work := user:save($id, $email, $first-name, $last-name)
	return xqmvc:redirect(xqmvc:link("user", "list"))
};

declare function delete()
as item()*
{
	let $id := xdmp:get-request-field("id")
	let $work := user:delete($id)
	return xqmvc:redirect(xqmvc:link("user", "list"))
};

declare function _request-db-creation()
{
	xqmvc:template('master-template', (
		'body', xqmvc:view('error-db-not-found', (
			'db', $user:db
		))
	))
};