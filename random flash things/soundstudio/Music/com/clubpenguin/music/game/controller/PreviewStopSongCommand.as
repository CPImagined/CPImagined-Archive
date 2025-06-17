//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.player.IMusicPlayer;
    import com.clubpenguin.music.game.events.MusicStudioSongEvent;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.util.Log;

    public class PreviewStopSongCommand extends Command 
    {

        [Inject]
        public var musicPlayer:IMusicPlayer;
        [Inject]
        public var event:MusicStudioSongEvent;
        [Inject]
        public var mainModel:MainModel;


        override public function execute():void
        {
            Log.debug("");
            this.musicPlayer.stop();
            this.event.songDetails[0].playing = false;
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.PREVIEW_SONG_PLAYBACK_UPDATED, this.event.songDetails));
        }


    }
}//package com.clubpenguin.music.game.controller
