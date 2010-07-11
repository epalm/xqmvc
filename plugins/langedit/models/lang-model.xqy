xquery version "1.0";

(:
 : Copyright 2009 Ontario Council of University Libraries
 : 
 : Licensed under the Apache License, Version 2.0 (the "License");
 : you may not use this file except in compliance with the License.
 : You may obtain a copy of the License at
 : 
 :    http://www.apache.org/licenses/LICENSE-2.0
 : 
 : Unless required by applicable law or agreed to in writing, software
 : distributed under the License is distributed on an "AS IS" BASIS,
 : WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 : See the License for the specific language governing permissions and
 : limitations under the License.
 :)
 
(:~
 : A module to retrieve phrases from a database of languages.
 :)
module namespace this = "http://scholarsportal.info/xqmvc/langedit/m/lang";

import module namespace cfg = "http://scholarsportal.info/xqmvc/langedit/config" at "../config/config.xqy";
import module namespace processor = "http://scholarsportal.info/xqmvc/system/processor" at "../../../system/processor/processor.xqy";

declare namespace le = "http://scholarsportal.info/xqmvc/langedit";

(:~
 : Retrieves text from a language file, as an xs:string.
 :
 : If tokens are provided, will substitute tokens into the phrase at proper 
 : locations ([1], [2], etc).  For example, the phrase with key 
 : "search.msg.result" and value "Searched for [1] in [2] seconds" can be 
 : fetched with text("search.msg.result", ("xquery", "1.25")) resulting 
 : in "Searched for xquery in 1.25 seconds".
 :
 : @param $key The text key.
 : @param [$tokens] Tokens to substitute into the phrase.
 : @param [$lang] The lang to use.  If not present, will attempt to use
 :         $SESS-VAR, followed by $DEFAULT-LANG in lang-custom.xqy.
 : @return A text string.
 :)
declare function this:text($key as xs:string, $tokens as xs:string*, $lang as xs:string) as xs:string
{
    let $path := this:path($lang)
    return
        if (fn:not(processor:doc-available($path))) then
            fn:concat('lang file [', $path, '] not found')
        else
            let $value := fn:string(this:value($path, $key))
            let $value := this:sub_var($tokens, $value) return
                if ($value) then $value else fn:concat('[', $key, ']')
};

declare function this:text($key as xs:string, $tokens as xs:string*) as xs:string
{
    let $lang := $cfg:default-lang return
        this:text($key, $tokens, $lang)
};

declare function this:text($key as xs:string)
as xs:string
{
    this:text($key, ())
};

declare function this:path($lang as xs:string) as xs:string
{
    fn:concat($cfg:storage-dir, '/', $cfg:file-prefix, $lang, '.xml')
};

declare function this:value($path as xs:string, $key as xs:string)
as element(le:value)?
{
    processor:doc($path)/le:lang/le:value[@key eq $key]
};

declare function this:html($key as xs:string, $tokens as xs:string*) as element(span)
{
    let $lang := $cfg:default-lang return
        this:html($key, $tokens, $lang)
};

declare function this:html($key as xs:string) as element(span)
{
    this:html($key, ())
};

(:~
 : Retrieves text from a language file, as an element(span).
 :
 : Tokens work the same as this:text(...)
 :
 : The text will be unquote'd, meaning, for example, phrases with 
 : <b>bold</b> tags will be properly displayed in a browser.  YOU MUST ENSURE
 : THAT THE PHRASE CONTAINS VALID XML, IF ANY, otherwise all bets are off.
 :
 : @param $key The text key.
 : @param [$tokens] Tokens to substitute into the phrase.
 : @param [$lang] The lang to use.  If not present, will attempt to use
 :         $SESS-VAR, followed by $DEFAULT-LANG in lang-custom.xqy.
 : @return A string wrapped in (html) span tags.
 : 
 : RFD: 2010-06-02:
 : Modified in response to issue#3 
 :)
declare function this:html($key as xs:string, $tokens as xs:string*, $lang as xs:string) as element(span)
{
    let $path := this:path($lang)
    return
        if (fn:not(processor:doc-available($path))) then
            <span>lang file [{ $path }] not found</span>
        else
            let $value := this:value($path, $key)
            let $value :=
                if ($value) then
                    if (fn:not($value/node())) then
                        $value
                    else
                        let $value := 
                            element { fn:node-name($value) } {
                                $value/@*, processor:parse-with-fixes($value/node())
                            }
                        return
                            if (fn:empty($tokens)) then $value
                            else this:accept($value, $tokens)
                else ()
            return
                <span>{
                    if ($value) then $value
                    else fn:concat('[', $key, ']')
                }</span>
};

(:~
 : @param $x  A node.
 : @param [$tokens] A sequence of Strings ( order matters )
 :
 : Double dispatch recursive functions that Perform a Depth First Search
 : on the given $x node. While doing the DFS, variables that might exist in node's
 : text-children will be replaced with the strings that are specified in the $tokens.
 : 
 : Note1: The variables are numbers [1],[2], etc... implying the order of
 : the strings in the $tokens*.
 : 
 : Note2: The scope of the varaibles are over the whole tree
 : and they can only appear in the $text nodes
 : 
 :)
declare function this:visit($x as node(),$tokens as xs:string*) as node()*
{
   for $z in $x/node() return this:accept($z,$tokens)       
};

declare function this:accept($x as node(),$tokens as xs:string*) as node()*
{
    typeswitch ($x)
        
        case text() return
            text { this:sub_var($tokens, fn:string($x)) }
            
        case element() return
            element { fn:node-name($x)} {$x/@*, this:visit($x,$tokens) }                    
        
        default return
            this:visit($x,$tokens)
};

declare function this:sub_var($tokens as xs:string*, $value)
{
    fn:replace(
        $value,
        fn:concat(
            fn:string-join(
                for $i in 1 to fn:count($tokens) return
                	fn:concat("(.*)(\[", $i, "\])")
            , ""),
            "(.*)"
        ),
        fn:concat(
            fn:string-join(
                for $i in 1 to fn:count($tokens) return
                	fn:concat(
                		if($i gt 1) then(" ") else (""),
                		"$", (($i * 2) - 1),
                		" ",
                		$tokens[$i]
                	)
            , ""),
            " $", (((fn:count($tokens) + 1) * 2) - 1)
        )
    )
};