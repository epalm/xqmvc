Models reside in the `<approot>/application/models` directory, do the "real work" of your application, and have no requirement other than being valid XQuery **library modules**.  Such modules should ideally encapsulate groups of related functions.  For example, a user-model.xqy may include `list() as element(users)`, `create($name as xs:string)`, `delete($id as xs:integer)` and `exists($id as xs:integer) as xs:boolean` functions, while an auth-model.xqy may include `login($name as xs:string, $pass as xs:string) as xs:boolean`, `logout()` and `logged-in() as xs:boolean` functions.

Here is an example Model:

**user-model.xqy**
```
xquery version "1.0-ml";
module namespace myns = "http://mynamespace";

declare function list() as element(users)
{
	(: this data would normally come from the underlying database :)
	<users>
		<user>
			<id>1</id>
			<name>John Smith</name>
			<email>john@smith.com</email>
		</user>
		<user>
			<id>2</id>
			<name>Jane Smith</name>
			<email>jane@smith.com</email>
		</user>
	</users>
};

declare function delete($id) as xs:boolean
{
	(: this function would normally issue an update-query :)
	fn:true()
};

(: more functions here... :)
```