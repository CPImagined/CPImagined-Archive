//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.managers
{
    import flash.display.MovieClip;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.events.Event;

    public class AnimationSequencer 
    {

        public static const EVENT_DONE:String = "animationSequenceManager_done";
        private static const EVENT_LAST_ANIMATION_FRAME:String = "lastAnimationFrame";

        private var inputArray:Array = new Array();
        private var animationQueue:Array;
        private var playheadPosition:int;
        private var currentClip:MovieClip;
        private var baseClip:MovieClip;
        private var delayTimer:Timer;
        private var clipDepth:int;

        public function AnimationSequencer(baseClip:MovieClip)
        {
            this.playheadPosition = 0;
            this.baseClip = baseClip;
        }

        public function buildAnimationQueue():void
        {
            var inputVO:AnimationVO;
            var frequency:Number;
            var sequenceVO:SequenceVO;
            var clipShowChance:Number;
            this.animationQueue = new Array();
            var i:int;
            while (i < this.inputArray.length)
            {
                inputVO = (this.inputArray[i] as AnimationVO);
                frequency = inputVO.frequency;
                sequenceVO = new SequenceVO();
                clipShowChance = Math.random();
                if (clipShowChance < frequency)
                {
                    sequenceVO.clipToAnimate = inputVO.clipToAnimate;
                    sequenceVO.delay = inputVO.delayVariance;
                    this.animationQueue.push(sequenceVO);
                };
                i++;
            };
            this.playCurrentClip();
        }

        public function push(animationVO:AnimationVO):void
        {
            animationVO.clipToAnimate.gotoAndStop(1);
            this.inputArray.push(animationVO);
            if (animationVO.playImmediately)
            {
                this.immediatePlay(animationVO);
            };
        }

        public function resumeAmbient():void
        {
        }

        public function immediatePlay(animationVO:AnimationVO):void
        {
            var sequenceVO:SequenceVO = new SequenceVO();
            sequenceVO.clipToAnimate = animationVO.clipToAnimate;
            this.animationQueue.splice((this.playheadPosition + 1), 0, sequenceVO);
            this.finishCurrentClip();
            this.playNextClip();
        }

        public function startSequence():void
        {
            this.buildAnimationQueue();
        }

        private function finishCurrentClip():void
        {
            this.currentClip.gotoAndStop(1);
            this.currentClip.removeEventListener(EVENT_LAST_ANIMATION_FRAME, this.onCurrentClipDone);
            this.currentClip.addFrameScript((this.currentClip.totalFrames - 1), null);
            this.clipDepth = this.baseClip.getChildIndex(this.currentClip);
            this.baseClip.removeChild(this.currentClip);
            if (this.delayTimer.hasEventListener(TimerEvent.TIMER_COMPLETE))
            {
                this.delayTimer.reset();
                this.delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayTimer);
            };
            this.currentClip = null;
        }

        private function onCurrentClipDone(event:Event):void
        {
            this.finishCurrentClip();
            this.playNextClip();
        }

        private function playNextClip():void
        {
            this.playheadPosition++;
            if (this.playheadPosition < this.animationQueue.length)
            {
                this.playCurrentClip();
            }
            else
            {
                this.playheadPosition = 0;
                this.buildAnimationQueue();
            };
        }

        private function playCurrentClip():void
        {
            var sequenceVO:SequenceVO = (this.animationQueue[this.playheadPosition] as SequenceVO);
            var delayValue:Number = ((Math.random() * sequenceVO.delay) * 1000);
            this.delayTimer = new Timer(delayValue, 1);
            this.currentClip = sequenceVO.clipToAnimate.clip;
            this.currentClip.gotoAndStop(1);
            this.currentClip.addEventListener(EVENT_LAST_ANIMATION_FRAME, this.onCurrentClipDone);
            this.baseClip.addChildAt(this.currentClip, this.clipDepth);
            this.currentClip.addFrameScript((this.currentClip.totalFrames - 1), function ():void
            {
                currentClip.dispatchEvent(new Event(EVENT_LAST_ANIMATION_FRAME));
            });
            this.delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayTimer);
            this.delayTimer.start();
        }

        private function onDelayTimer(event:TimerEvent):void
        {
            this.delayTimer.reset();
            this.delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayTimer);
            this.currentClip.play();
        }

        public function pauseSequence():void
        {
            this.delayTimer.stop();
            this.currentClip.stop();
        }

        public function destroy():void
        {
            this.delayTimer.stop();
            this.currentClip.stop();
            this.delayTimer = null;
            this.currentClip = null;
            this.animationQueue = null;
            this.inputArray = null;
        }

        public function unPauseSequence():void
        {
            this.currentClip.play();
        }


    }
}//package com.clubpenguin.puffles.adoption.managers
