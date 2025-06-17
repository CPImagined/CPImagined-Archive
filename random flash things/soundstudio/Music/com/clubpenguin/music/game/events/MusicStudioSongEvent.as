//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.events
{
    import flash.events.Event;
    import __AS3__.vec.Vector;
    import com.clubpenguin.music.game.model.vo.SongDetailsVO;

    public class MusicStudioSongEvent extends Event 
    {

        public static const SET_SONG_NAME:String = "MusicStudioSongEvent_SET_SONG_NAME";
        public static const SONG_NAME_UPDATE_SUCCESS:String = "MusicStudioSongEvent_SONG_NAME_UPDATE_SUCCESS";
        public static const SONG_NAME_UPDATE_FAIL:String = "MusicStudioSongEvent_SONG_NAME_UPDATE_FAIL";
        public static const SAVE_SONG_SUCCESS:String = "MusicStudioSongEvent_SAVE_SONG_SUCCESS";
        public static const SAVE_SONG_FAIL:String = "MusicStudioSongEvent_SAVE_SONG_FAIL";
        public static const GET_SHARED_SONGS:String = "MusicStudioSongEvent_GET_SHARED_SONGS";
        public static const SHARED_SONGS_UPDATED:String = "MusicStudioSongEvent_SHARED_SONGS_UPDATED";
        public static const PREVIEW_SONG:String = "MusicStudioSongEvent_PREVIEW_SONG";
        public static const PREVIEW_STOP_SONG:String = "MusicStudioSongEvent_PREVIEW_STOP_SONG";
        public static const PLAY_SONG:String = "MusicStudioSongEvent_PLAY_SONG";
        public static const STOP_SONG:String = "MusicStudioSongEvent_STOP_SONG";
        public static const LIKE_SONG:String = "MusicStudioSongEvent_LIKE_SONG";
        public static const PREVIEW_SONG_PLAYBACK_UPDATED:String = "MusicStudioSongEvent_PREVIEW_SONG_PLAYBACK_UPDATED";
        public static const SONG_PLAYBACK_UPDATED:String = "MusicStudioSongEvent_SONG_PLAYBACK_UPDATED";
        public static const LIKES_UPDATED:String = "MusicStudioSongEvent_LIKES_UPDATED";

        public var songDetails:Vector.<SongDetailsVO>;

        public function MusicStudioSongEvent(_arg_1:String, songDetails:Vector.<SongDetailsVO>=null)
        {
            super(_arg_1, true, true);
            this.songDetails = songDetails;
        }

        override public function clone():Event
        {
            return (new MusicStudioSongEvent(type, this.songDetails));
        }


    }
}//package com.clubpenguin.music.game.events
