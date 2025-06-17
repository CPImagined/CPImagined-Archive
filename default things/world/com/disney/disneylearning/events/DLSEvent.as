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

        public function DLSEvent(_opcode:String, _learnerID:String, _contentObjective:String, _responsePayload:String, _cookieId:int, _bubbles:Boolean=false, _cancelable:Boolean=false)
        {
            super(DLSEvent.DLSEVENT, _bubbles, _cancelable);
            this.opcode = _opcode;
            this.learnerID = _learnerID;
            this.contentObjective = _contentObjective;
            this.responsePayload = _responsePayload;
            this.cookieId = _cookieId;
        }

        override public function clone():Event
        {
            return (new DLSEvent(this.opcode, this.learnerID, this.contentObjective, this.responsePayload, this.cookieId, this.bubbles, this.cancelable));
        }


    }
}//package com.disney.disneylearning.events
