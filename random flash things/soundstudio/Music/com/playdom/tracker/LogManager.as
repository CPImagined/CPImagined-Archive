//Created by Action Script Viewer - https://www.buraks.com/asv
package com.playdom.tracker
{
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import com.playdom.util.LogProxy;
    import flash.events.Event;

    public class LogManager 
    {

        public var url:String = "";
        [ArrayElementType("String")]
        protected var que:Array;
        protected var myTimer:Timer;
        protected var flushOnInterval:Boolean;

        public function LogManager(url:String, flushOnInterval:Boolean)
        {
            this.url = url;
            this.flushOnInterval = flushOnInterval;
            if (flushOnInterval)
            {
                this.que = new Array();
                this.resetTimer();
            };
        }

        protected function resetTimer():void
        {
            if (this.myTimer)
            {
                if (this.myTimer.running)
                {
                    this.myTimer.stop();
                };
                this.myTimer.removeEventListener(TimerEvent.TIMER, this.handleTimer);
                this.myTimer = null;
            };
            this.myTimer = new Timer(30000, 1);
            this.myTimer.addEventListener(TimerEvent.TIMER, this.handleTimer);
            this.myTimer.start();
        }

        protected function handleTimer(te:TimerEvent):void
        {
            this.flushQue();
        }

        public function log(logString:String, flush:Boolean):void
        {
            if (this.flushOnInterval)
            {
                this.que.push(logString);
                if (flush)
                {
                    this.flushQue();
                };
            }
            else
            {
                this.sendToBI(logString);
            };
        }

        protected function flushQue():void
        {
            var logString:String;
            while (this.que.length > 0)
            {
                logString = this.que.pop();
                this.sendToBI(logString);
            };
            this.resetTimer();
        }

        protected function sendToBI(logString:String):void
        {
            var completeURL:String = (this.url + logString);
            var req:URLRequest = new URLRequest(completeURL);
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(IOErrorEvent.IO_ERROR, this.onAnalysisError);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onAnalysisError);
            LogProxy.log(("LogManager.sendToBI:" + completeURL));
            loader.addEventListener(Event.COMPLETE, this.onAnalysisSuccess);
            loader.load(req);
        }

        protected function onAnalysisError(evt:Event):void
        {
            LogProxy.log(("Tracker.onAnalysisError," + evt.toString()));
        }

        protected function onAnalysisSuccess(evt:Event):void
        {
        }


    }
}//package com.playdom.tracker
