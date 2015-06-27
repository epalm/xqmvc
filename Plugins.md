A plugin is a library built upon the XQMVC framework.  Plugins differ from conventional libraries (such as lib-search.xqy (http://xqzone.marklogic.com/svn/lib-search/trunk/release) and date-parser.xqy (http://xqzone.marklogic.com/svn/commons/trunk/dates) which are entirely self-contained library modules with no dependencies) in that they consist of models/controllers/views/templates like a regular XQMVC appplication.

Plugins are located at `<app-root>/plugins/<plugin-name>`, and contain the same folder structure as the `<app-root>/application` directory:

```
<app-root>/plugins/PluginOne/config/...
<app-root>/plugins/PluginOne/controllers/...
<app-root>/plugins/PluginOne/libraries/...
<app-root>/plugins/PluginOne/models/...
<app-root>/plugins/PluginOne/resources/...
<app-root>/plugins/PluginOne/templates/...
<app-root>/plugins/PluginOne/views/...

<app-root>/plugins/PluginTwo/config/...
<app-root>/plugins/PluginTwo/controllers/...
<app-root>/plugins/PluginTwo/libraries/...
<app-root>/plugins/PluginTwo/models/...
<app-root>/plugins/PluginTwo/resources/...
<app-root>/plugins/PluginTwo/templates/...
<app-root>/plugins/PluginTwo/views/...
```

If a plugin has its own interface, it's accessible at, if using URL Rewriting with a .html suffix, http://host.com/approot/plugin/controller/function.html, and if not using URL Rewriting, http://host.com/approot/index.xqy?_p=plugin&_c=controller&_f=function.

The LangEdit internationalization app is implemented as a plugin, and comes bundled with XQMVC.

### Plugin Development ###

Plugins are basically regular XQMVC applications abstracted out into a self-contained XQMVC app in an `<app-root>/plugins/<plugin-name>` subdirectory with slightly different import statements, function calls and variable references:

Controller, View, and Template headers should use the following import statement, which simply includes an extra `../` to account for plugins being nested one directory deeper than the standard application:
```
import module namespace xqmvc = "http://scholarsportal.info/xqmvc/core" at "../../../system/xqmvc.xqy";
```

Prepend `plugin-` to the `xqmvc:view`, `xqmvc:template`, `xqmvc:link`, and `xqmvc:formlink` functions, and make the first parameter an `xs:string` indicating the name of the current plugin.  For example,
```
xqmvc:view("my-view")
```
becomes
```
xqmvc:plugin-view("plugin-name", "my-view")
```

Use `$xqmvc:plugin-resource-dir` and `$xqmvc:plugin-library-dir` to reference the resources and libraries directories within the current plugin.