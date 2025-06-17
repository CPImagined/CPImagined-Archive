//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.newspaper.events
{
    import flash.events.Event;
    import com.clubpenguin.newspaper.models.vo.ContentActionVO;
    import com.disney.disneylearning.managers.DLSManager;
    import com.disney.disneylearning.OpcodeJournal;

    public class ContentButtonEvent extends Event 
    {

        public static const CLICKED:String = "contentButtonClicked";
        private static const TOPTIPS:String = "topTips";
        private static const FEATURESTORY:String = "featureStory";
        private static const JOKESANDRIDDLES:String = "jokesAndRiddles";
        private static const UPCOMINGEVENTS:String = "upcomingEvents";
        private static const SUBMITYOURCONTENT:String = "submitYourContent";
        private static const SUBMITCONTENTFORM:String = "submitYourContentForm";
        private static const RIDDLEANSWERS:String = "riddlesAnswers";
        private static const CONTINUEONNEXTPAGE:String = "askAuntArcticContinued";

        private var _contentActionVO:ContentActionVO;

        public function ContentButtonEvent(_arg_1:String, _arg_2:ContentActionVO)
        {
            this._contentActionVO = _arg_2;
            super(_arg_1, true, false);
        }

        private function buttonNavigationCheck(_arg_1:String):void
        {
            switch (_arg_1)
            {
                case TOPTIPS:
                    DLSManager.instance.pushOpcode(OpcodeJournal.SELECTEDSTATUS, OpcodeJournal.NEWSPAPERTOCTOPTIPS, this.dlsmcallback, "0", null);
                    return;
                case FEATURESTORY:
                    DLSManager.instance.pushOpcode(OpcodeJournal.SELECTEDSTATUS, OpcodeJournal.NEWSPAPERTOCFEATURESTORY, this.dlsmcallback, "0", null);
                    return;
                case JOKESANDRIDDLES:
                    DLSManager.instance.pushOpcode(OpcodeJournal.SELECTEDSTATUS, OpcodeJournal.NEWSPAPERTOCJOKESANDRIDDLES, this.dlsmcallback, "0", null);
                    return;
                case UPCOMINGEVENTS:
                    DLSManager.instance.pushOpcode(OpcodeJournal.SELECTEDSTATUS, OpcodeJournal.NEWSPAPERTOCUPCOMINGEVENTS, this.dlsmcallback, "0", null);
                    return;
                case SUBMITYOURCONTENT:
                    DLSManager.instance.pushOpcode(OpcodeJournal.SELECTEDSTATUS, OpcodeJournal.NEWSPAPERSUBMIT, this.dlsmcallback, "0", null);
                    return;
                case SUBMITCONTENTFORM:
                    DLSManager.instance.pushOpcode(OpcodeJournal.SELECTEDSTATUS, OpcodeJournal.NEWSPAPERSUBMIT, this.dlsmcallback, "0", null);
                    return;
                case RIDDLEANSWERS:
                    DLSManager.instance.pushOpcode(OpcodeJournal.SELECTEDSTATUS, OpcodeJournal.RIDDLEANSWERS, this.dlsmcallback, "0", null);
                    return;
                case CONTINUEONNEXTPAGE:
                    DLSManager.instance.pushOpcode(OpcodeJournal.SELECTEDSTATUS, OpcodeJournal.NEWSPAPERTURNPAGE, this.dlsmcallback, "0", null);
                    return;
                default:
                    trace("New button instance needed");
            };
        }

        private function dlsmcallback(_arg_1:String):void
        {
        }

        public function get contentActionVO():ContentActionVO
        {
            var _local_1:String = this._contentActionVO.getTarget();
            this.buttonNavigationCheck(_local_1);
            return (this._contentActionVO);
        }

        override public function toString():String
        {
            return (("[ContentButtonEvent - " + this._contentActionVO.toString()) + "]");
        }


    }
}//package com.clubpenguin.newspaper.events
