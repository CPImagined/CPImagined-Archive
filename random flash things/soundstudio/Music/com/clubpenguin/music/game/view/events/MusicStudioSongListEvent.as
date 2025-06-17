//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.events
{
    import flash.events.Event;

    public class MusicStudioSongListEvent extends Event 
    {

        public static const GET_SHARED_SONGS:String = "MusicStudioSongListEvent_GET_SHARED_SONGS";
        public static const UPDATE_SHARED_SONGS:String = "MusicStudioSongListEvent_UPDATE_SHARED_SONGS";
        public static const PLAY_SONG:String = "MusicStudioSongListEvent_PLAY_SONG";
        public static const STOP_SONG:String = "MusicStudioSongListEvent_STOP_SONG";
        public static const LIKE_SONG:String = "MusicStudioSongListEvent_LIKE_SONG";
        public static const UPDATE_LIKES:String = "MusicStudioSongListEvent_UPDATE_LIKES";

        public var payload:Object;

        public function MusicStudioSongListEvent(_arg_1:String, payload:Object=null)
        {
            super(_arg_1, true, true);
            this.payload = payload;
        }

        override public function clone():Event
        {
            return (new MusicStudioSongListEvent(type, this.payload));
        }


    }
}//package com.clubpenguin.music.game.view.events
