//Created by Action Script Viewer - https://www.buraks.com/asv
package org.swiftsuspenders
{
    import flash.utils.Proxy;
    import flash.utils.getQualifiedClassName;
    import flash.utils.getDefinitionByName;
    import org.swiftsuspenders.*;

    internal function getConstructor(value:Object):Class
    {
        var fqcn:String;
        if (((((value is Proxy) || (value is Number)) || (value is XML)) || (value is XMLList)))
        {
            fqcn = getQualifiedClassName(value);
            return (Class(getDefinitionByName(fqcn)));
        };
        return (value.constructor);
    }

}//package org.swiftsuspenders
