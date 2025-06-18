//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.events
{
    import flash.events.Event;

    public class NinjaModuleEvent extends Event 
    {

        public static const SERVICE_REQUEST:String = "serviceRequest";
        public static const SERVICE_RESPONSE:String = "serviceResponse";
        public static const GOTO_REDEMPTION:String = "gotoRedemption";
        public static const PLAY_VIDEO:String = "playVideo";
        public static const BUY_POWERCARDS:String = "buyPowercards";

        public var messageType:String;
        public var payload:Object;

        public function NinjaModuleEvent(_arg_1:String, messageType:String, payload:Object=null)
        {
            super(_arg_1);
            this.messageType = messageType;
            this.payload = payload;
        }

        override public function clone():Event
        {
            return (new NinjaModuleEvent(this.type, this.messageType, this.payload));
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.events
