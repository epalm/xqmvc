## `xqmvc:view($view as xs:string [, $pairs as item()*]) as item()*` ##

Returns the contents of a View file, which is an XQuery **main module** living in the `<approot>/application/views` directory.  Note that the $name parameter **should not** be suffixed with `.xqy`.  Optional 2nd parameter is an even-length sequence of key-value pairs containing data to supply to the View.  The following examples would typically be present in a Controller or Template.

**Ex:**
```
xqmvc:view("footer")
```

**Ex:**
```
xqmvc:view("search-results", (
    "result-count", 64,
    "results", $results,
    "duration", 0.07
))
```

## `xqmvc:template($name as xs:string [, $pairs as item()*]) as item()*` ##

Returns the contents of a Template file, which is an XQuery **main module** living in the `<approot>/application/templates` directory.  Note that the $name parameter **should not** be suffixed with `.xqy`.  Optional 2nd parameter is an even-length sequence of key-value pairs containing data to supply to the Template.  The following examples would typically be present in a Controller or another Template.

**Ex:**
```
xqmvc:template("logged-out-template", (
    "login-form", xqmvc:view("login-form")
))
```

**Ex:**
```
xqmvc:template("logged-in-template", (
    "pagetitle", "Settings",
    "menu", xqmvc:view("logged-in-menu"),
    "settings", xqmvc:view("settings-view")
))
```

**Ex:**
```
xqmvc:template("master-template", (
	"browsertitle", "A Small Example",
	"body", xqmvc:view("user-list", (
		"pagetitle", "User List"
	))
))
```

## `xqmvc:link($controller as xs:string, $function as xs:string [, $pairs as item()*]) as xs:string` ##

Generates a URL string pointing to the specified controller / function, for use in href= and action= attributes of html anchors and forms.  This function should be used exclusively within a webapp when linking to internal pages.  Optionally accepts an even-length sequence of key-value pairs to append as a query string.

**Ex:**
```
xqmvc:link("acontroller", "afunction")
```
With URL Rewriting, will output: `http://host.com/acontroller/afunction.html`
Without URL Rewriting, will output: `http://host.com/index.xqy?_c=acontroller&_f=afunction`

**Ex:**
```
<a href="{xqmvc:link('user', 'delete', ('id', '42', 'debug', 1))}">delete this user</a>
```
With URL Rewriting, will output: `<a href="http://host.com/user/delete.html?id=42&debug=1">delete this user</a>`
Without URL Rewriting, will output: `<a href="http://host.com/index.xqy?_c=user&_f=delete&id=42&debug=1">delete this user</a>`

**Ex:**
```
<form action="{xqmvc:link('user', 'create')}" method="post">
```
With URL Rewriting, will output: `<form action="http://host.com/user/create.html" method="post">`
Without URL Rewriting, will output: `<form action="http://host.com/index.xqy?_c=user&_f=create" method="post">`

## `xqmvc:formlink($controller as xs:string, $function as xs:string) as item()*` ##

For forms with `method="get"`, the standard link function won't work, depending on whether URL Rewriting is on or off.  Simply leave the action attribute off the form element, and make the call to formlink directly after the form opening tag.

**Ex:**
```
<form method="get">
	{ xqmvc:plugin-formlink('user', 'list') }
	<input type="input" name="filter" value="" />
</form>
```
With URL Rewriting, will output:
```
<form action="/user/list.html" method="get">
	<input type="input" name="filter" value="" />
</form>
```
Without URL Rewriting, will output:
```
<form action="?" method="get">
	<input type="hidden" name="_c" value="user"/>
	<input type="hidden" name="_f" value="list"/>
	<input type="input" name="filter" value="" />
</form>
```

## `xqmvc:redirect($location as xs:string)` ##

Redirects the browser to the specified location.  This is typically used in conjunction with `xqmvc:link` in Controller functions which have updated some data, and wish to redirect to another Controller/function.

**Ex:**
```
declare function delete-user()
{
    (: deletion code goes here :)
    let $x := "..."
    return
        (: bounce back to user list :)
        xqmvc:redirect(xqmvc:link("user", "list"))
};
```

**Ex:**
```
xqmvc:redirect("http://external.website.com")
```