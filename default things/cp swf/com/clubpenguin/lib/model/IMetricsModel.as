//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.model
{
    import flash.events.IEventDispatcher;

    public interface IMetricsModel extends IEventDispatcher 
    {

        function get counters():ICounters;
        function startTimers():void;
        function stopTimers():void;
        function getAverageBridgeLag():int;
        function getMaxBridgeLag():int;
        function recordBridgeTime(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int):void;
        function clearAllMetrics():void;
        function getMemUsageMB():Number;
        function getCurrentFPS():Number;
        function getAvgFPS():Number;

    }
}//package com.clubpenguin.lib.model
