xquery version "1.0";

module namespace map = "http://scholarsportal.info/xqmvc/system/map";

(:
 : proposed map structure:
 :
 : <map>
 :   <entry key="one">
 :     <value>1</value>
 :   </entry>
 :   <entry key="two">
 :     <value>2</value>
 :   </entry>
 : </map>
 : 
 : -> ensures keys are strings
 : -> allows values to be item()
 :)

declare function create()
as element(map)
{
    <map/>
};

declare function put($map as element(map), $key as xs:string, $value as item()*)
as element(map)
{
    <map>{
        for $entry in $map/entry[@key ne $key]
        return $entry,
        <entry key="{ $key }">
            <value>{ $value }</value>
        </entry>
    }</map>
};

declare function remove($map as element(map), $key as xs:string)
as element(map)
{
    <map>{
        for $entry in $map/entry[@key ne $key]
        return $entry
    }</map>
};

declare function get($map as element(map), $key as xs:string)
as item()*
{
    $map/entry[@key eq 'two']/value/node()
};

declare function contains-key($map as element(map), $key as xs:string)
as xs:boolean
{
    fn:exists($map/entry[@key eq $key])
};

declare function keys($map as element(map))
as xs:string*
{
    $map/entry/@key
};

declare function size($map as element(map))
as xs:integer
{
    fn:count($map/entry)
};

declare function is-empty($map as element(map))
as xs:boolean
{
    size($map) eq 0
};

declare function sequence-to-map($pairs as item()*)
as element(map)
{
    <map>{
        for $i in (1 to fn:count($pairs))[. mod 2 ne 0]
        return
            <entry key="{ $pairs[$i] }">
                <value>{ $pairs[$i + 1] }</value>
            </entry>
    }</map>
};
