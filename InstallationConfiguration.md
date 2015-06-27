## Acquire ##

_(requires MarkLogic Server 4.1 EA2 or later)_

Download the latest release from the [Downloads](http://code.google.com/p/xqmvc/downloads/list) page.

## Extract ##

Extract the XQMVC archive anywhere beneath your App Server's root directory.  If the archive was not extracted to the root of the App Server, don't forget to set `$app-root` in `config.xqy` appropriately.  This extraction directory will be referred to as `<approot>`.

## Configure ##

There are several configuration options which must be set appropriately.  They can be found in the `<approot>/application/config/config.xqy` file and are well-commented.  If anything there is unclear, please email xqmvc@googlegroups.com

## URL Rewriting (optional) ##

XQMVC can take advantage of MarkLogic 4.1's URL Rewriter feature, if desired.  In the MarkLogic Server Administration Panel, find your App Server, and set the "url rewriter" field to `/<approot>/system/rewrite.xqy`, where `<approot>` is where you extracted XQMVC.  For example, if you extracted into the root of the App Server, use `/system/rewrite.xqy`.  **Please note** that this should be an absolute path.

Don't forget to set `$url-rewrite` in `config.xqy` to `fn:true()`.

## Permissions ##

The following  Execute Privileges are required:
  * xdmp:eval
  * xdmp:invoke