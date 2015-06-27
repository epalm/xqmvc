XQMVC requires two pieces of information to load/execute a page:
  1. The name of the Controller to load.
  1. The name of the (zero-arg) function to execute (within that Controller).

This information is extracted from the querystring fields **`_c`** (for Controller) and **`_f`** (for function).  For example, the url http://host.com/index.xqy?_c=welcome&_f=index will load the `welcome` Controller (located at `<approot>/application/controllers/welcome.xqy`) and execute it's `index()` function.

If using URL Rewriting (see the InstallationConfiguration to set this up), XQMVC will "hide" these two querystring fields in the URL path.  The above example would look like http://host.com/welcome/index.html (far nicer on the eyes).  Additional querystring fields may still be appended, for example http://host.com/user/delete.html?id=3 (which is equivalent to http://host.com/index.xqy?_c=user&_f=delete&id=3).

**Please note** the querystring field names **`_c`** and **`_f`** are configurable via the `<approot>/application/config/config.xqy` file.  Your application **MAY NOT** use these querystring field names in its links and forms.  The following link, for example, will result in an error (assuming the default querystring field names **`_c`** and **`_f`** are used): http://host.com/welcome/index.html?_f=hello (which is equivalent to http://host.com/index.xqy?_c=welcome&_f=index.html?_f=hello), since there are two `_f` values.