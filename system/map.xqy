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

declare function map:create() as element(map)
{
    <map/>
};

declare function map:put($map as element(map), $key as xs:string, $value as item()*) as element(map)
{
    <map>{
        for $entry in $map/entry[@key ne $key]
        return $entry,
        <entry key="{ $key }">
            <value>{ $value }</value>
        </entry>
    }</map>
};

declare function map:remove($map as element(map), $key as xs:string) as element(map)
{
    <map>{
        for $entry in $map/entry[@key ne $key]
        return $entry
    }</map>
};

declare function map:get($map as element(map), $key as xs:string) as item()*
{
    $map/entry[@key eq $key]/value/node()
};

declare function map:contains-key($map as element(map), $key as xs:string) as xs:boolean
{
    fn:exists($map/entry[@key eq $key])
};

declare function map:keys($map as element(map)) as xs:string*
{
    $map/entry/@key
};

declare function map:size($map as element(map)) as xs:integer
{
    fn:count($map/entry)
};

declare function map:is-empty($map as element(map)) as xs:boolean
{
    map:size($map) eq 0
};

declare function map:sequence-to-map($pairs as item()*) as element(map)
{
    <map>{
        for $i in (1 to fn:count($pairs))[. mod 2 ne 0]
        return
            <entry key="{ $pairs[$i] }">
                <value>{ $pairs[$i + 1] }</value>
            </entry>
    }</map>
};