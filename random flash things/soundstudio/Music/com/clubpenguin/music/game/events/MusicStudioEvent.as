//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.events
{
    import flash.events.Event;

    public class MusicStudioEvent extends Event 
    {

        public static const PLAY_GAME:String = "MusicStudioEvent_PLAY_GAME";
        public static const EXIT_GAME:String = "MusicStudioEvent_EXIT_GAME";
        public static const SHOW_SAVED_TRACKS:String = "MusicStudioEvent_SHOW_SAVED_TRACKS";
        public static const RECORD_PULSE:String = "MusicStudioEvent_RECORD_PULSE";
        public static const START_RECORDING:String = "MusicStudioEvent_START_RECORDING";
        public static const STOP_RECORDING:String = "MusicStudioEvent_STOP_RECORDING";
        public static const START_RECORDING_SUCCESS:String = "MusicStudioEvent_START_RECORDING_SUCCESS";
        public static const STOP_RECORDING_SUCCESS:String = "MusicStudioEvent_STOP_RECORDING_SUCCESS";
        public static const LOAD_GENRE:String = "MusicStudioEvent_LOAD_GENRE";
        public static const PULSE:String = "MusicStudioEvent_PULSE";
        public static const PLAY_SOUNDS:String = "MusicStudioEvent_PLAY_SOUNDS";
        public static const GENRE_LOADED:String = "MusicStudioEvent_GENRE_LOADED";
        public static const SHOW_START_SCREEN:String = "MusicStudioEvent_SHOW_START_SCREEN";
        public static const SHOW_INSTRUCTIONS:String = "MusicStudioEvent_SHOW_INSTRUCTIONS";
        public static const HIDE_INSTRUCTIONS:String = "MusicStudioEvent_HIDE_INSTRUCTIONS";
        public static const RECORD_PERMISSION_STATUS_UPDATE:String = "MusicStudioEvent_RECORD_PERMISSION_STATUS_UPDATE";
        public static var RECORD_PERMISSION_REQUEST:String = "MusicStudioEvent_RECORD_PERMISSION_REQUEST";

        public var payload:Object;

        public function MusicStudioEvent(_arg_1:String, payload:Object=null)
        {
            super(_arg_1, true, true);
            this.payload = payload;
        }

        override public function clone():Event
        {
            return (new MusicStudioEvent(type, this.payload));
        }


    }
}//package com.clubpenguin.music.game.events
