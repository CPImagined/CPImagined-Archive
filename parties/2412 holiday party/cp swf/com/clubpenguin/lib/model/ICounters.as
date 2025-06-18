//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.model
{
    public interface ICounters 
    {

        function registerCounter(_arg_1:String):void;
        function getCount(_arg_1:String):int;
        function incrementCounter(_arg_1:String):void;
        function resetCounter(_arg_1:String):void;
        function resetAllCounters():void;
        function removeCounter(_arg_1:String):void;
        function removeAllCounters():void;

    }
}//package com.clubpenguin.lib.model
