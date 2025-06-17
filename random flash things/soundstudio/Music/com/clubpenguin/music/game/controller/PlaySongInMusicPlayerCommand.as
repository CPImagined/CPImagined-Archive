//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.player.IMusicPlayer;
    import com.clubpenguin.music.game.events.MusicStudioSongEvent;
    import com.clubpenguin.main.model.MainModel;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.music.game.model.vo.SongDetailsVO;
    import com.clubpenguin.lib.util.Log;
    import flash.events.IEventDispatcher;
    import com.clubpenguin.music.player.MusicPlayer;
    import com.clubpenguin.music.resources.song.SongRecorded;
    import flash.events.Event;

    public class PlaySongInMusicPlayerCommand extends Command 
    {

        [Inject]
        public var musicPlayer:IMusicPlayer;
        [Inject]
        public var event:MusicStudioSongEvent;
        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var tracker:Tracker;
        private var _details:SongDetailsVO;


        override public function execute():void
        {
            this._details = (this.event.songDetails[0] as SongDetailsVO);
            Log.debug((this._details + ""));
            this.musicPlayer.stop();
            (this.musicPlayer as IEventDispatcher).addEventListener(MusicPlayer.EVENT_LOAD_COMPLETE, this.onSongLoaded);
            (this.musicPlayer as IEventDispatcher).addEventListener(MusicPlayer.EVENT_SONG_COMPLETE, this.onSongComplete);
            (this.musicPlayer as IEventDispatcher).addEventListener(MusicPlayer.EVENT_SONG_STOP, this.onSongStop);
            this.musicPlayer.loadSong(new SongRecorded(this._details.songId, this._details.playerId, true, false));
            commandMap.detain(this);
        }

        private function onSongLoaded(e:Event):void
        {
            this.tracker.trackGameAction("soundstudio", "game_listen", false, null, false, {"message":this._details.playerId.toString()});
            this.event.songDetails[0].playing = true;
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.SONG_PLAYBACK_UPDATED, this.event.songDetails));
        }

        private function onSongStop(e:Event):void
        {
            Log.debug("");
            this.removeMusicPlayerLiseners();
            this.event.songDetails[0].playing = false;
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.SONG_PLAYBACK_UPDATED, this.event.songDetails));
        }

        private function removeMusicPlayerLiseners():void
        {
            Log.debug("");
            if ((this.musicPlayer as IEventDispatcher).hasEventListener(MusicPlayer.EVENT_SONG_STOP))
            {
                (this.musicPlayer as IEventDispatcher).removeEventListener(MusicPlayer.EVENT_LOAD_COMPLETE, this.onSongLoaded);
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
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.SONG_PLAYBACK_UPDATED, this.event.songDetails));
        }


    }
}//package com.clubpenguin.music.game.controller
