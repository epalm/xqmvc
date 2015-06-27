## Abstract ##

MVC is a design pattern which promotes organization of code and file structure by separating presentation from domain logic.  While there are dozens of MVC frameworks for languages such as Java, Python, PHP, Ruby, etc, nothing similar exists for developers building complex applications in XQuery.

XQMVC is a new XQuery web application framework which leverages MVC design principles as well as new capabilities made available in MarkLogic Server 4.1 to offer the foundation for a clean and well-organized XQuery-driven website.  Highlights include friendly URLs, nestable templates (allowing visual sections of a site to be encapsulated in reusable XHTML fragments), and a simple but effective i18n engine (to externalize and manage text fragments using a web-based editor).

## MVC Design ##

MVC is a design pattern which encourages separation of user interface from business logic.

Quote from Wikipedia:
> Model-View-Controller (MVC) is an architectural pattern used in software engineering. Successful use of the pattern isolates business logic from user interface considerations, resulting in an application where it is easier to modify either the visual appearance of the application or the underlying business rules without affecting the other. In MVC, the model represents the information (the data) of the application; the view corresponds to elements of the user interface such as text, checkbox items, and so forth; and the controller manages the communication of data and the business rules used to manipulate the data to and from the model.

## Features ##

  * URL Mapping: Using URL Rewriting, site addresses map directly to Controllers and functions.  For example http://host.com/search/results.html maps to and executes the `search` Controller's `results()` function.
  * Templating System: Develop common visual shells to wrap around page content.  Templates can be nested infinitely within other Templates, allowing sections of a site to be encapsulated into reusable xhtml fragments.
  * Plugin System: Develop self-contained XQMVC 'helper applications' which can be abstracted out of your main application and shared with others.  For example, the i18n engine 'LangEdit' is implemented as a plugin.
  * LangEdit Plugin: Use a web-based editor to externalize and manage all text fragments of your site.