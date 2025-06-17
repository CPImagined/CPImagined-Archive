//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.game.model.MusicStudioModel;
    import com.clubpenguin.music.player.IMusicPlayer;
    import com.clubpenguin.music.game.events.MusicStudioSongEvent;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.util.Log;
    import flash.events.IEventDispatcher;
    import com.clubpenguin.music.player.MusicPlayer;
    import com.clubpenguin.music.resources.song.SongRecorded;
    import flash.events.Event;

    public class PreviewSongCommand extends Command 
    {

        [Inject]
        public var model:MusicStudioModel;
        [Inject]
        public var musicPlayer:IMusicPlayer;
        [Inject]
        public var event:MusicStudioSongEvent;
        [Inject]
        public var mainModel:MainModel;


        override public function execute():void
        {
            var songData:String = (this.model.currentSongDetails.genreId + this.model.currentSongDetails.songData);
            Log.debug(songData);
            (this.musicPlayer as IEventDispatcher).addEventListener(MusicPlayer.EVENT_SONG_COMPLETE, this.onSongComplete);
            (this.musicPlayer as IEventDispatcher).addEventListener(MusicPlayer.EVENT_SONG_STOP, this.onSongStop);
            this.musicPlayer.loadSong(new SongRecorded(0, -1, true, false, false, songData));
            this.event.songDetails[0].playing = true;
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.PREVIEW_SONG_PLAYBACK_UPDATED, this.event.songDetails));
            commandMap.detain(this);
        }

        private function onSongStop(e:Event):void
        {
            Log.debug("");
            this.removeMusicPlayerLiseners();
        }

        private function removeMusicPlayerLiseners():void
        {
            Log.debug("");
            if ((this.musicPlayer as IEventDispatcher).hasEventListener(MusicPlayer.EVENT_SONG_STOP))
            {
                (this.musicPlayer as IEventDispatcher).removeEventListener(MusicPlayer.EVENT_SONG_COMPLETE, this.onSongComplete);
                (this.musicPlayer as IEventDispatcher).removeEventListener(MusicPlayer.EVENT_SONG_STOP, this.onSongStop);
                commandMap.release(this);
            }
            else
            {
                Log.warn("Listeners not found to be removed");
            };
        }

        private function onSongComplete(e:Event):void
        {
            Log.debug("");
            this.removeMusicPlayerLiseners();
            this.event.songDetails[0].playing = false;
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.PREVIEW_SONG_PLAYBACK_UPDATED, this.event.songDetails));
        }


    }
}//package com.clubpenguin.music.game.controller
