//Created by Action Script Viewer - https://www.buraks.com/asv
package com.playdom.tracker
{
    import flash.utils.Timer;
    import com.clubpenguin.lib.event.FrameRateEvent;
    import flash.events.TimerEvent;
    import flash.events.FullScreenEvent;
    import flash.display.Stage;

    use namespace OnlyTracker;

    public class PerformanceDelegate 
    {

        public static const PERF_POLL_CONTEXT:String = "perfpoll";
        public static const PERF_EVENT_CONTEXT:String = "perfevent";
        private static const FPS_THRESHOLD:int = 12;
        private static const EVENT_DELAY_COUNT:int = 60000;
        private static const MINUTES_TO_MILISECONDS_MULTIPLIER:uint = 60000;

        private var tracker:Tracker;
        private var trackInterval:Array = [];
        private var trackerIntervalIndex:int = 0;
        private var totalRepeats:uint = 0;
        private var eventDelayTimer:Timer;
        private var performanceTimer:Timer;
        private var avgFPSArray:Array;
        OnlyTracker var running:Boolean;

        public function PerformanceDelegate(tracker:Tracker)
        {
            this.tracker = tracker;
        }

        OnlyTracker function startPM(trackInterval:Array):void
        {
            this.trackInterval = trackInterval;
            this.totalRepeats = trackInterval.length;
            this.avgFPSArray = new Array();
            this.eventDelayTimer = new Timer(EVENT_DELAY_COUNT, 1);
            this.tracker.metricsModel.addEventListener(FrameRateEvent.AVG_FPS_UPDATE, this.onAvgFPSupdate);
            this.setPerformanceTimer();
            this.performanceTimer.start();
            this.performanceTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onPerformanceTimerComplete);
            this.running = true;
        }

        OnlyTracker function stopPM():void
        {
            this.tracker.metricsModel.removeEventListener(FrameRateEvent.AVG_FPS_UPDATE, this.onAvgFPSupdate);
            this.performanceTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onPerformanceTimerComplete);
            this.performanceTimer.stop();
            this.running = false;
        }

        OnlyTracker function watchDisplayState(stage:Stage):void
        {
            stage.addEventListener(FullScreenEvent.FULL_SCREEN, this.handleScreenChange);
        }

        private function handleScreenChange(event:FullScreenEvent):void
        {
        }

        private function onAvgFPSupdate(event:FrameRateEvent):void
        {
            this.avgFPSArray.push(event.fps);
            if (((Math.floor(event.fps) < FPS_THRESHOLD) && (!(this.eventDelayTimer.running))))
            {
                this.eventDelayTimer.reset();
                this.eventDelayTimer.start();
                this.tracker.trackPerformance(event.fps, PERF_EVENT_CONTEXT);
            };
        }

        private function setPerformanceTimer():void
        {
            if (this.performanceTimer == null)
            {
                this.performanceTimer = new Timer(this.getNextInterval(), 1);
            }
            else
            {
                this.performanceTimer.stop();
                this.performanceTimer.delay = this.getNextInterval();
                this.performanceTimer.reset();
                this.performanceTimer.start();
            };
        }

        private function onPerformanceTimerComplete(event:TimerEvent):void
        {
            var avgFPS:Number = 0;
            var sumFPS:Number = 0;
            var i:uint;
            while (i < this.avgFPSArray.length)
            {
                sumFPS = (sumFPS + this.avgFPSArray[i]);
                i++;
            };
            avgFPS = (sumFPS / (i + 1));
            this.tracker.trackPerformance(avgFPS, PERF_POLL_CONTEXT, this.performanceTimer.delay);
            this.setPerformanceTimer();
        }

        private function getNextInterval():int
        {
            var interval:int;
            if (this.trackerIntervalIndex < this.trackInterval.length)
            {
                interval = (this.trackInterval[this.trackerIntervalIndex] * MINUTES_TO_MILISECONDS_MULTIPLIER);
                this.trackerIntervalIndex++;
            }
            else
            {
                interval = (this.trackInterval[(this.trackInterval.length - 1)] * MINUTES_TO_MILISECONDS_MULTIPLIER);
            };
            return (interval);
        }


    }
}//package com.playdom.tracker
