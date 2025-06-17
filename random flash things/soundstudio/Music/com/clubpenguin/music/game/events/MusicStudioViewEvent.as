//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.events
{
    import flash.events.Event;

    public class MusicStudioViewEvent extends Event 
    {

        public static const SHOW_GAME_VIEW:String = "MusicStudioViewEvent_SHOW_GAME_VIEW";
        public static const SHOW_START_SCREEN_VIEW:String = "MusicStudioViewEvent_SHOW_START_SCREEN_VIEW";
        public static const SHOW_INSTRUCTIONS_VIEW:String = "MusicStudioViewEvent_SHOW_INSTRUCTIONS_VIEW";
        public static const HIDE_INSTRUCTIONS_VIEW:String = "MusicStudioViewEvent_HIDE_INSTRUCTIONS_VIEW";
        public static const SHOW_SAVED_TRACKS_VIEW:String = "MusicStudioViewEvent_SHOW_SAVED_TRACKS_VIEW";
        public static const CLOSE_GAME:String = "MusicStudioViewEvent_CLOSE_GAME";
        public static const SHOW_SAVE_PROMPT:String = "MusicStudioViewEvent_SHOW_SAVE_PROMPT";
        public static const SHOW_DELETE_PROMPT:String = "MusicStudioViewEvent_SHOW_DELETE_PROMPT";
        public static const CLOSE_SAVE_PROMPT:String = "MusicStudioViewEvent_CLOSE_SAVE_PROMPT";
        public static const CLOSE_DELETE_PROMPT:String = "MusicStudioViewEvent_CLOSE_DELETE_PROMPT";

        public var payload:Object;

        public function MusicStudioViewEvent(_arg_1:String, payload:Object=null)
        {
            super(_arg_1, true, true);
            this.payload = payload;
        }

        override public function clone():Event
        {
            return (new MusicStudioViewEvent(type, this.payload));
        }


    }
}//package com.clubpenguin.music.game.events
