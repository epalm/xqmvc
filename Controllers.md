Controllers reside in the `<approot>/application/controllers` directory, and are **library modules** with the following header:

**user.xqy**
```
xquery version "1.0-ml";
module namespace xqmvc-controller = "http://scholarsportal.info/xqmvc/controller";
import module namespace xqmvc = "http://scholarsportal.info/xqmvc/core" at "../../system/xqmvc.xqy";
```

Following this header are zero-parameter executable functions which are mapped to by URLs.  Most of these functions fall into one of two categories.
  * The first simply gathers data of interest (perhaps from a Model), and renders a View (or a Template containing zero or more Views).
  * The second performs work which changes some data, and then redirects to another Controller/function (typically of the first category).

Controllers should be as thin as possible.  They exist only to receive input from the user, validate it, perhaps have the Model do some work, and select the next View.  Controllers are the glue between your data (Models) and your presentation of that data (Views).

Here are a couple of example controller functions:

**user.xqy (continued)**
```
import module namespace user = "http://mynamespace" at "../models/user-model.xqy";

declare function list()
as item()*
{
	let $users := user:list() (: retrieve users from model :)
	return
		xqmvc:view('user-list', (
			'pagetitle', 'User List',
			'users', $users
		))
};

declare function delete()
as item()*
{
	let $id := xdmp:get-request-field("id")
	let $work := user:delete($id)
	return xqmvc:redirect(xqmvc:link("user", "list"))
};

(: more functions here... :)
```

Note the call to `xqmvc:view` in the `list()` function above.  This passes data to a View via even-length sequence of key-value pairs.  See the FunctionReference page for more details.

Ultimately, XQMVC is mapping URLs to functions, which can be dangerous if not controlled.  If you wish for a function to remain hidden from the outside world, prefix it with an underscore.  These "helper" functions will still be accessible within the XQuery library module, and can take parameters.  For example:

**user.xqy (continued)**
```
declare function _helper($param)
{
	"this function is NOT available at http://example.com/user/_helper.html"
};
```