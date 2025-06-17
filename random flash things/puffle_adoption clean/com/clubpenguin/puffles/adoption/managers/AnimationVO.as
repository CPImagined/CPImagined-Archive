//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.managers
{
    import flash.display.MovieClip;

    public class AnimationVO 
    {

        private var _clipToAnimate:MovieClip;
        private var _frequency:Number;
        private var _delayVariance:int;
        private var _loops:Boolean;
        private var _playImmediately:Boolean;

        public function AnimationVO(clipToAnimate:MovieClip, loops:Boolean, playImmediately:Boolean, frequency:Number=0, delayVariance:int=0)
        {
            this.clipToAnimate = clipToAnimate;
            this._loops = loops;
            this._playImmediately = playImmediately;
            this._frequency = frequency;
            this._delayVariance = delayVariance;
        }

        public function set clipToAnimate(clipToAnimate:MovieClip):void
        {
            this._clipToAnimate = clipToAnimate;
        }

        public function get clipToAnimate():MovieClip
        {
            return (this._clipToAnimate);
        }

        public function get frequency():Number
        {
            return (this._frequency);
        }

        public function get delayVariance():int
        {
            return (this._delayVariance);
        }

        public function get loops():Boolean
        {
            return (this._loops);
        }

        public function get playImmediately():Boolean
        {
            return (this._playImmediately);
        }


    }
}//package com.clubpenguin.puffles.adoption.managers
