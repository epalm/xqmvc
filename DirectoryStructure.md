XQMVC's directory structure contains an `application` directory (where the entirety of your application resides), a `system` directory (where the XQMVC framework resides) and an `index.xqy` file.

```
<approot>/application/config/config.xqy
<approot>/application/controllers/...
<approot>/application/libraries/...
<approot>/application/models/...
<approot>/application/resources/...
<approot>/application/templates/...
<approot>/application/views/...

<approot>/plugins/...

<approot>/system/xqmvc.xqy
<approot>/system/rewrite.xqy

<approot>/index.xqy
```

The only required file in the `application` directory is `application/config/config.xqy`, which provides essential configuration cues.

The purpose of the remaining directories are as follows:

**`<approot>/application/controllers`** contain your Controller files (XQuery **library** modules).

**`<approot>/application/libraries`** contain any external libraries you wish to import and use in your Models, Views, Controllers or Templates.  For example, the date-parser (http://xqzone.marklogic.com/svn/commons/trunk/dates) library as part of the MarkLogic XQuery Commons (http://developer.marklogic.com/code).

**`<approot>/application/models`** contain your Model files (XQuery **library** modules).

**`<approot>/application/resources`** contain all "other" external files your web application may need, such as javascript files, cascading stylesheets, and image files.  This directory can be referenced using the `$mvc:resource-dir` variable, for example `<link rel="stylesheet" type="text/css" media="screen" href="{ $mvc:resource-dir }/css/style.css"/>`

**`<approot>/application/templates`** contain your Template files (XQuery **main** modules).

**`<approot>/application/views`** contain your View files (XQuery **main** modules).