//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.events
{
    import flash.events.Event;

    public class MusicStudioSongListItemEvent extends Event 
    {

        public static const PLAY_BUTTON_CLICKED:String = "MusicStudioSongListItemEvent_PLAY_SONG";
        public static const STOP_BUTTON_CLICKED:String = "MusicStudioSongListItemEvent_STOP_SONG";
        public static const LIKE_BUTTON_CLICKED:String = "MusicStudioSongListItemEvent_LIKE_SONG";

        public var payload:Object;

        public function MusicStudioSongListItemEvent(_arg_1:String, payload:Object=null)
        {
            super(_arg_1, true, true);
            this.payload = payload;
        }

        override public function clone():Event
        {
            return (new MusicStudioSongListItemEvent(type, this.payload));
        }


    }
}//package com.clubpenguin.music.game.view.events
