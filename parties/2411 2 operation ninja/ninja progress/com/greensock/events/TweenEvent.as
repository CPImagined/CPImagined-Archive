//Created by Action Script Viewer - https://www.buraks.com/asv
package com.greensock.events
{
    import flash.events.Event;

    public class TweenEvent extends Event 
    {

        public static const VERSION:Number = 1.1;
        public static const START:String = "start";
        public static const UPDATE:String = "change";
        public static const COMPLETE:String = "complete";
        public static const REVERSE_COMPLETE:String = "reverseComplete";
        public static const REPEAT:String = "repeat";
        public static const INIT:String = "init";

        public function TweenEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

        override public function clone():Event
        {
            return (new TweenEvent(this.type, this.bubbles, this.cancelable));
        }


    }
}//package com.greensock.events
