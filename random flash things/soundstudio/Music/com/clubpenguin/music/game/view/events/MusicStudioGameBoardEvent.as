//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.events
{
    import flash.events.Event;

    public class MusicStudioGameBoardEvent extends Event 
    {

        public static const TRIGGER_SOUND:String = "MusicStudioGameBoardEvent_TRIGGER_SOUND";
        public static const SOUND_BUTTON_CLICKED:String = "MusicStudioGameBoardEvent_SOUND_BUTTON_CLICKED";
        public static const RECORDING_REQUEST_START:String = "MusicStudioGameBoardEvent_RECORDING_REQUEST_START";
        public static const RECORDING_REQUEST_STOP:String = "MusicStudioGameBoardEvent_RECORDING_REQUEST_STOP";
        public static const GENRE_BUTTON_CLICKED:String = "MusicStudioGameBoardEvent_GENRE_BUTTON_CLICKED";
        public static const GENRE_SELECTED:String = "MusicStudioGameBoardEvent_GENRE_SELECTED";
        public static var CAN_RECORD_QUESTION:String = "MusicStudioGameBoardEvent_CAN_RECORD_QUESTION";
        public static var RECORD_CANCEL:String = "MusicStudioGameBoardEvent_RECORD_CANCEL";

        public var payload:Object;

        public function MusicStudioGameBoardEvent(_arg_1:String, payload:Object=null)
        {
            super(_arg_1, true, true);
            this.payload = payload;
        }

        override public function clone():Event
        {
            return (new MusicStudioGameBoardEvent(type, this.payload));
        }


    }
}//package com.clubpenguin.music.game.view.events
