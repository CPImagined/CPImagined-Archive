//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.events
{
    import flash.events.Event;

    public class StateChangeEvent extends Event 
    {

        public static const CHANGE_STATE:String = "changeState";

        public var state:String;

        public function StateChangeEvent(_arg_1:String, state:String)
        {
            super(_arg_1, true, true);
            this.state = state;
        }

        override public function clone():Event
        {
            return (new StateChangeEvent(this.type, this.state));
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.events
