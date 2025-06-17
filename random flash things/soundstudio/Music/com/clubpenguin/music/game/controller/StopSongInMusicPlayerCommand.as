//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.player.IMusicPlayer;
    import com.clubpenguin.music.game.events.MusicStudioSongEvent;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.music.game.model.vo.SongDetailsVO;
    import com.clubpenguin.lib.util.Log;

    public class StopSongInMusicPlayerCommand extends Command 
    {

        [Inject]
        public var musicPlayer:IMusicPlayer;
        [Inject]
        public var event:MusicStudioSongEvent;
        [Inject]
        public var mainModel:MainModel;


        override public function execute():void
        {
            var details:SongDetailsVO;
            Log.debug("");
            this.musicPlayer.stop();
            if (((this.event.songDetails) && (this.event.songDetails.length > 0)))
            {
                details = this.event.songDetails[0];
                Log.debug((details + ""));
                this.event.songDetails[0].playing = false;
                dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.SONG_PLAYBACK_UPDATED, this.event.songDetails));
            };
        }


    }
}//package com.clubpenguin.music.game.controller
