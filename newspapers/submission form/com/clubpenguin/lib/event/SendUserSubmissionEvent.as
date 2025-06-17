//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.event
{
    import flash.events.Event;

    public class SendUserSubmissionEvent extends Event 
    {

        public static const USER_SUBMISSION_EVENT:String = "userSubmissionEvent";

        public var submissionText:String;
        public var submissionCategory:String;

        public function SendUserSubmissionEvent(_arg_1:String, _arg_2:String)
        {
            super(USER_SUBMISSION_EVENT, true, true);
            this.submissionText = _arg_1;
            this.submissionCategory = _arg_2;
        }

        override public function clone():Event
        {
            return (new SendUserSubmissionEvent(this.submissionText, this.submissionCategory));
        }

        override public function toString():String
        {
            return ((super.toString() + " ") + submissionText);
        }


    }
}//package com.clubpenguin.lib.event
