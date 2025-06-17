//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.events
{
    import flash.events.Event;

    public class MusicStudioInstructionsEvent extends Event 
    {

        public static const CLOSE:String = "MusicStudioInstructionsEvent_CLOSE";
        public static const BACK:String = "MusicStudioInstructionsEvent_BACK";
        public static const NEXT:String = "MusicStudioInstructionsEvent_NEXT";
        public static const PLAY:String = "MusicStudioInstructionsEvent_PLAY";

        public var payload:Object;

        public function MusicStudioInstructionsEvent(_arg_1:String, payload:Object=null)
        {
            super(_arg_1, true, true);
            this.payload = payload;
        }

        override public function clone():Event
        {
            return (new MusicStudioInstructionsEvent(type, this.payload));
        }


    }
}//package com.clubpenguin.music.game.view.events
