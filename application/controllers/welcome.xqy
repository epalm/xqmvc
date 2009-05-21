xquery version "1.0-ml";
module namespace xqmvc-controller = "http://scholarsportal.info/xqmvc/controller";
import module namespace xqmvc = "http://scholarsportal.info/xqmvc/core" at "../../system/xqmvc.xqy";

declare function index()
as item()*
{
	xqmvc:template('master-template', (
		'browsertitle', 'Welcome to XQMVC!',
		'body', xqmvc:view('welcome-view', (
			'time', fn:current-dateTime(),
			'arch', xdmp:architecture(),
			'plat', xdmp:platform(),
			'vers', xdmp:version()
		))
	))
};