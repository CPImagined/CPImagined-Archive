//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.disneylearning.events
{
    import flash.events.Event;

    public class DLSEvent extends Event 
    {

        public static const DLSEVENT:String = "COM.DISNEY.DISNEYLEARNING.EVENT";

        public var opcode:String;
        public var contentObjective:String;
        public var learnerID:String;
        public var responsePayload:String;
        public var cookieId:int;

        public function DLSEvent(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:int, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(DLSEvent.DLSEVENT, _arg_6, _arg_7);
            this.opcode = _arg_1;
            this.learnerID = _arg_2;
            this.contentObjective = _arg_3;
            this.responsePayload = _arg_4;
            this.cookieId = _arg_5;
        }

        override public function clone():Event
        {
            return (new DLSEvent(this.opcode, this.learnerID, this.contentObjective, this.responsePayload, this.cookieId, this.bubbles, this.cancelable));
        }


    }
}//package com.disney.disneylearning.events
