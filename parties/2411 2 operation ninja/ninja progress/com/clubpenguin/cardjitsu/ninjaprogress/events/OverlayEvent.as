//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.events
{
    import flash.events.Event;

    public class OverlayEvent extends Event 
    {

        public static const CLOSE:String = "overlayClose";
        public static const LOGOUT:String = "overlayLogout";

        public function OverlayEvent(_arg_1:String)
        {
            super(_arg_1);
        }

        override public function clone():Event
        {
            return (new OverlayEvent(this.type));
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.events
