//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.events
{
    import flash.events.Event;

    public class MusicStudioPromptEvent extends Event 
    {

        public static const VALIDATE_SONG_NAME:String = "MusicStudioPromptEvent_VALIDATE_SONG_NAME";
        public static const SET_SONG_NAME:String = "MusicStudioPromptEvent_SET_SONG_NAME";
        public static const PLAY:String = "MusicStudioPromptEvent_PLAY";
        public static const STOP:String = "MusicStudioPromptEvent_STOP";
        public static const CLOSE:String = "MusicStudioPromptEvent_CLOSE";

        public var payload:Object;

        public function MusicStudioPromptEvent(_arg_1:String, payload:Object=null)
        {
            super(_arg_1, true, true);
            this.payload = payload;
        }

        override public function clone():Event
        {
            return (new MusicStudioPromptEvent(type, this.payload));
        }


    }
}//package com.clubpenguin.music.game.view.events
