//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.event
{
    import flash.events.Event;

    public class FrameRateEvent extends Event 
    {

        public static const FPS_UPDATE:String = "FPSUpdate";
        public static const AVG_FPS_UPDATE:String = "avgFPSUpdate";

        public var fps:Number;

        public function FrameRateEvent(_arg_1:String, fps:Number, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
            this.fps = fps;
        }

    }
}//package com.clubpenguin.lib.event
