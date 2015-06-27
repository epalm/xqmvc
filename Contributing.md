Code contributions to the framework are very much appreciated!

## Coding Conventions ##

So we're all on the same page...

  * Spaces, not tabs.
  * UNIX line endings (LF), not Dos/Windows line endings (CRLF).
  * Respect the 80-character-per-line limit.  XQuery prologue statements are exempt from this convention.
  * Make an attempt to follow the XQuery Style Conventions posted at http://xqdoc.org/xquery-style.html

## Submitting Patches ##

Before receiving commit-level access to the repository, please submit changes as patches.  Here's the procedure to submit a patch:

  1. Check out the _latest_ trunk (http://code.google.com/p/xqmvc/source/checkout).
  1. Make some changes.
  1. Run `svn diff > patch.diff` (or use your favourite SVN client, if you don't use the commandline) to generate the patch.
  1. Attach the patch to an issue (http://code.google.com/p/xqmvc/issues/list), creating a new issue if one doesn't exist.

## Committing Changes ##

If you have commit-level access to the repository...

  * Don't commit empty log messages.
  * **Don't** commit empty log messages.
  * Refer to an issue number, if your changes pertain to one: `i13`
  * Refer to a mailing list message number, if your changes pertain to one: `m34`