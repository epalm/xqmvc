Templates reside in the `<approot>/application/templates` directory, and are **main modules** with the following header:

**master-template.xqy**
```
xquery version "1.0-ml";
import module namespace xqmvc = "http://scholarsportal.info/xqmvc/core" at "../../system/xqmvc.xqy";
declare variable $data as map:map external;
```

Templates behave similarly to Views, and are useful for encapsulating visual content in a common shell.  Each Template contains a `$data as map:map` variable containing any data one wishes to pass to that Template.  Individual pieces of data are accessible via `map:get($data, "variable-name")`, each of which have been set by the calling Controller (or Template).  These items (which may themselves be Templates or Views) are embeddable anywhere in the Template.

To invoke a Template from a Controller (or another Template), execute `mvc:template("template-name")`, which points to the file `<approot>/application/templates/template-name.xqy`.  To optionally pass data to a Template, include as a second parameter an even-length sequence of key-value pairs, where the keys are variable names, and the values are data, for example `mvc:template("template-name", ('pagetitle', 'Users', 'user-list-view', mvc:view('user-list-view')))`.

Here's an example which wraps a user list View in a Template with the following call:

**calling code**
```
xqmvc:template('master-template', (
	'browsertitle', 'A Small Example',
	'body', xqmvc:view('user-list', (
		'pagetitle', 'User List'
	))
))
```

**master-template.xqy (continued)**
```
xdmp:set-response-content-type('text/html'),

'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
	"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">',

<html>
	<head>
		<title>{ map:get($data, 'browsertitle') }</title>
		<link rel="stylesheet" type="text/css" media="screen" href="{ $xqmvc:resource-dir }/css/style.css"/>
	</head>
	<body>
		<div id="hd">{ xqmvc:template('header-template') }</div>
		<hr />
		<div>{ map:get($data, 'body') }</div>
		<hr />
		<div id="ft">{ xqmvc:template('footer-template') }</div>
	</body>
</html>
```

Note that a Template is an excellent place to set the response-content-type and DOCTYPE.

Templates may internally call other Templates and Views.  The above example implies the existence of `<approot>/application/templates/header-template.xqy` and `<approot>/application/templates/footer-template.xqy`, which are Templates themselves, which can internally contain more Templates, and so on.  One can easily imagine calling a different "header" Template (which may in turn call a different "menu" Template) depending upon a user being logged in or not.

**What's the difference between Views and Templates?**  There isn't any difference.  Ultimately the same code is used to invoke the requested View or Template.  The two are kept as separate concepts since developers would invariably be writing two different types of views anyways: outer-shell views and inner-content views.  XQMVC explicitly separates these two types in Templates and Views.