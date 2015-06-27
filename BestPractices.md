## The update-redirect cycle ##

A controller POSTed to by an html form may create, replace, or delete a node in the database (an XQuery **update** transaction) and should end in a redirect, rather than invoking and displaying a view.  If not redirected, and an end user attempts to refresh the page, they'll be prompted to re-POST the form variables, which is typically undesirable.

## Views shouldn't be invoked directly ##

Views should be selected and displayed by Controllers, which are executed based on end-user action.

## Models and Controllers shouldn't contain XHTML ##

To facilitate true separation of UI considerations from business logic, only Views should contain XHTML.

## Controllers and Views shouldn't contain fn:doc(...) calls ##

Only Models should talk to the underlying data, while Controllers and Views talk to the Model, which acts as a buffer.

## Models shouldn't access request variables ##

In order to keep the Model decoupled from the rest of the application, it should not rely on outside variables or values.

## File-naming conventions ##

  * Models: `<name>-model.xqy`, eg: user-model.xqy
  * Controllers: `<name>.xqy`, eg: user.xqy
  * Views: `<name>-view.xqy`, eg: user-list-view.xqy, user-edit-view.xqy
  * Templates: `<name>-template.xqy`}, eg: master-template.xqy, menu-template.xqy