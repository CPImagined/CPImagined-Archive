//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress
{
    import flash.events.Event;

    public class ScrollBarEvent extends Event 
    {

        public static const MOVE_EVENT:String = "move_event";

        private var _percentChange:Number;

        public function ScrollBarEvent(_arg_1:Number)
        {
            this._percentChange = _arg_1;
            super(MOVE_EVENT);
        }

        public function get percentChange():Number
        {
            return (this._percentChange);
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress
