LangEdit stores key/value pairs in xml files (such as en.xml, fr.xml, etc), which are stored in the MarkLogic database. The directory in which these files are stored is configurable, see `<app-root>/plugins/langedit/config/config.xqy`.

Keys are restricted to the charactesr A-Z, a-z, 0-9, - (hyphen), `_` (underscore), and . (period).  Periods are used to separate groups of values into a dot-notation hierarchy.  For example, the keys **general.errors.username**, **general.errors.password** and **general.errors.email** are all in the same group: **general.errors**.  Groups will visually separate themselves in the LangEdit editor.

To use the values associated with the keys you've created, first import LangEdit's lang-model.xqy file.  Here is the import statement one would use from within a standard view:

```
import module namespace le = "http://scholarsportal.info/xqmvc/langedit/m/lang" at "../../plugins/langedit/models/lang-model.xqy";
```

Then, use the `le:text(...)` and `le:html(...)` functions to display values (further defined below).

The language values used will depend on the $default-lang variable in the `<app-root>/plugins/langedit/config/config.xqy` file.  Note that this can be set using `xdmp:get-session-field(...)` with a default value.  In that case, your application need only set/change a session variable to pull values from a particular language.

## `le:text( $key as xs:string [, $tokens as xs:string* [, $lang as xs:string] ] ) as xs:string` ##

Given a key, retrieves the corresponding value from a language file, as an xs:string.  If tokens are provided, will substitute tokens into the phrase at specified locations (`[1]`, `[2]`, etc).

**Ex:**
```
(:
 : Assuming there exists a key "site.title" with value "My Site"
 :)
le:text("site.title")
=> "My Site"
```
**Ex:**
```
(:
 : Assuming there exists a key "search.msg.result" with value "Searched for [1]
 : in [2] seconds"
 :)
le:text("search.msg.result", ("xquery", "1.25"))
=> "Searched for xquery in 1.25 seconds"
```

## `le:html( $key as xs:string [, $tokens as xs:string* [, $lang as xs:string] ] ) as element(span)` ##

Given a key, retrieves the corresponding value from a language file, as an element(span).  Tokens work the same as `le:text(...)`.  The value will be `xdmp:unquote`'d, meaning, for example, phrases with `<b>bold</b>` tags will be properly displayed in a browser. **Values must contain valid xml**, if any.

**Ex:**
```
(:
 : Assuming there exists a key "site.title" with value "My Site"
 :)
le:html("site.title")
=> <span>My Site</span>
```
**Ex:**
```
(:
 : Assuming there exists a key "search.msg.result" with value "Searched for
 : <b>[1]</b> in <b>[2]</b> seconds"
 :)
le:html("search.msg.result", ("xquery", "1.25"))
=> <span>Searched for <b>xquery</b> in <b>1.25</b> seconds</span>
```