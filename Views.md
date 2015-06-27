Views reside in the `<approot>/application/views` directory, and are **main modules** with the following header:

**user-list-view.xqy**
```
xquery version "1.0-ml";
import module namespace xqmvc = "http://scholarsportal.info/xqmvc/core" at "../../system/xqmvc.xqy";
declare variable $data as map:map external;
```

Views represent the presentation of your application.  Each View is typically fragment of xhtml, and should only be invoked via Controller (or Template).  Each View contains a `$data as map:map` variable containing any data one wishes to pass to that View.  Individual pieces of data are accessible via `map:get($data, "variable-name")`, each of which have been set by the calling Controller (or Template).

To invoke a View from a Controller (or Template), execute `mvc:view("view-name")`, which points to the file `<approot>/application/views/view-name.xqy`.  To optionally pass data to a View, include as a second parameter an even-length sequence of key-value pairs, where the keys are variable names, and the values are data, for example `mvc:view("view-name", ('x', 123, 'name', 'Eric'))`.

Continuing the example of a list of users:

**calling code**
```
xqmvc:view('user-list-view', (
	'pagetitle', 'User List'
))
```

**user-list-view.xqy (continued)**
```
import module namespace user = "http://mynamespace" at "../models/user-model.xqy";

<div>
	<h2>{ map:get($data, "pagetitle") }</h2>
	<table border="1">
		<tr>
			<th>username</th>
			<th>email</th>
			<th>action</th>
		</tr>
		{
			for $user in user:list()
			return
				<tr>
					<td>{ $user/name/text() }</td>
					<td>{ $user/email/text() }</td>
					<td><a href="{ xqmvc:link('user', 'delete', ('id', $user/id/text())) }">delete</a></td>
				</tr>
		}
	</table>
</div>
```

Note the call to `xqmvc:link` in the delete anchor above.  This generates a link to an internal Controller/function. See the FunctionReference page for more details.