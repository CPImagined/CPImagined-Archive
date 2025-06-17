//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.events
{
    import flash.events.Event;
    import com.clubpenguin.music.game.model.vo.SongNameValidationVO;

    public class MusicStudioSongNameEvent extends Event 
    {

        public static const VALIDATE_SONG_NAME:String = "MusicStudioSongNameEvent_VALIDATE_SONG_NAME";
        public static const SONG_NAME_VALIDATION_RESULT:String = "MusicStudioSongNameEvent_SONG_NAME_VALIDATION_RESULT";

        public var songNameValidationVO:SongNameValidationVO;

        public function MusicStudioSongNameEvent(_arg_1:String, vo:SongNameValidationVO)
        {
            super(_arg_1, true, true);
            this.songNameValidationVO = vo;
        }

        override public function clone():Event
        {
            return (new MusicStudioSongNameEvent(type, this.songNameValidationVO));
        }


    }
}//package com.clubpenguin.music.game.events
