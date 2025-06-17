//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.model
{
    import flash.events.EventDispatcher;
    import com.clubpenguin.lib.model.IMetricsModel;
    import com.clubpenguin.lib.model.ICounters;
    import flash.display.MovieClip;
    import flash.utils.Timer;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.utils.getTimer;
    import com.clubpenguin.lib.event.FrameRateEvent;
    import com.clubpenguin.lib.vo.metrics.BridgeMetricVO;
    import flash.system.System;

    public class MetricsModel extends EventDispatcher implements IMetricsModel 
    {

        private static var MEGABYTE:Number = 0x100000;
        private static var AVERAGE_FPS_TICK:int = 5000;
        private static var FPS_THRESHOLD:int = 10;

        private var _counters:ICounters;
        private var bridgeTimes:Array;
        private var timerMC:MovieClip;
        private var fpsTimer:Timer;
        private var fpsArray:Array;
        private var frameCount:int = 0;
        private var currentFPS:Number = 0;
        private var avgFPS:Number = 0;
        private var prevTime:int;

        public function MetricsModel(timerMC:MovieClip)
        {
            this._counters = new MetricsCounters();
            this.clearAllMetrics();
            this.timerMC = timerMC;
            this.fpsTimer = new Timer(AVERAGE_FPS_TICK);
        }

        public function startTimers():void
        {
            this.fpsArray = new Array();
            this.currentFPS = 0;
            this.frameCount = 0;
            this.timerMC.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this.fpsTimer.addEventListener(TimerEvent.TIMER, this.onFpsTimer);
            this.fpsTimer.reset();
            this.fpsTimer.start();
        }

        public function stopTimers():void
        {
            this.timerMC.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this.fpsTimer.removeEventListener(TimerEvent.TIMER, this.onFpsTimer);
            this.fpsTimer.stop();
        }

        private function onEnterFrame(event:Event):void
        {
            var currentTime:int = getTimer();
            this.frameCount++;
            if ((currentTime - 1000) > this.prevTime)
            {
                this.prevTime = currentTime;
                this.currentFPS = this.frameCount;
                this.fpsArray.push(this.currentFPS);
                this.frameCount = 0;
                dispatchEvent(new FrameRateEvent(FrameRateEvent.FPS_UPDATE, this.currentFPS));
            };
        }

        private function onFpsTimer(event:TimerEvent):void
        {
            var sumFPS:Number = 0;
            var i:uint;
            while (i < this.fpsArray.length)
            {
                sumFPS = (sumFPS + this.fpsArray[i]);
                i++;
            };
            this.avgFPS = (sumFPS / (i + 1));
            this.fpsArray = new Array();
            dispatchEvent(new FrameRateEvent(FrameRateEvent.AVG_FPS_UPDATE, this.avgFPS));
        }

        public function get counters():ICounters
        {
            return (this._counters);
        }

        public function getAverageBridgeLag():int
        {
            var i:Number;
            var totalLag:int;
            if (this.bridgeTimes.length > 0)
            {
                i = 0;
                while (i < this.bridgeTimes.length)
                {
                    totalLag = (totalLag + this.bridgeTimes[i].lag);
                    i++;
                };
                return (Math.ceil((totalLag / this.bridgeTimes.length)));
            };
            return (0);
        }

        public function getMaxBridgeLag():int
        {
            var sortedBridgeTimes:Array;
            if (this.bridgeTimes.length > 0)
            {
                sortedBridgeTimes = this.bridgeTimes.sortOn("lag", (Array.DESCENDING | Array.NUMERIC));
                return (sortedBridgeTimes[0].lag);
            };
            return (0);
        }

        public function recordBridgeTime(msgId:int, msgType:String, sentTS:int, receivedTS:int):void
        {
            this.bridgeTimes.push(new BridgeMetricVO(msgId, msgType, sentTS, receivedTS, (receivedTS - sentTS)));
        }

        public function clearAllMetrics():void
        {
            this.counters.resetAllCounters();
            this.resetBridgeTimes();
        }

        private function resetBridgeTimes():void
        {
            this.bridgeTimes = new Array();
        }

        public function getMemUsageMB():Number
        {
            return (System.totalMemoryNumber / MEGABYTE);
        }

        public function getCurrentFPS():Number
        {
            return (this.currentFPS);
        }

        public function getAvgFPS():Number
        {
            return (this.avgFPS);
        }


    }
}//package com.clubpenguin.main.model
