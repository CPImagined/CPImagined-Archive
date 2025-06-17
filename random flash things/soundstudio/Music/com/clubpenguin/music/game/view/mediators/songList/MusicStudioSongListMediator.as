//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.mediators.songList
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.music.game.view.interfaces.IMusicStudioSongList;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.events.MusicStudioSongEvent;
    import com.clubpenguin.music.game.view.events.MusicStudioSongListEvent;
    import com.clubpenguin.music.game.model.vo.SongDetailsVO;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class MusicStudioSongListMediator extends Mediator 
    {


        public function get view():IMusicStudioSongList
        {
            return (viewComponent as IMusicStudioSongList);
        }

        override public function onRegister():void
        {
            Log.debug("");
            addContextListener(MusicStudioSongEvent.SHARED_SONGS_UPDATED, this.onSharedSongsUpdated);
            addContextListener(MusicStudioSongEvent.SONG_PLAYBACK_UPDATED, this.onSongPlaybackUpdated);
            addContextListener(MusicStudioSongEvent.LIKES_UPDATED, this.onSongLikesUpdated);
            addViewListener(MusicStudioSongListEvent.PLAY_SONG, this.playSongRequest);
            addViewListener(MusicStudioSongListEvent.STOP_SONG, this.stopSongRequest);
            addViewListener(MusicStudioSongListEvent.LIKE_SONG, this.likeSongRequest);
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.GET_SHARED_SONGS));
        }

        private function playSongRequest(e:MusicStudioSongListEvent):void
        {
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.PLAY_SONG, this.wrapPayload(e.payload)));
        }

        private function stopSongRequest(e:MusicStudioSongListEvent):void
        {
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.STOP_SONG, this.wrapPayload(e.payload)));
        }

        private function likeSongRequest(e:MusicStudioSongListEvent):void
        {
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.LIKE_SONG, this.wrapPayload(e.payload)));
        }

        private function wrapPayload(payload:Object):Vector.<SongDetailsVO>
        {
            var vector:Vector.<SongDetailsVO> = new Vector.<SongDetailsVO>();
            vector.push((payload as SongDetailsVO));
            return (vector);
        }

        private function onSongPlaybackUpdated(e:MusicStudioSongEvent):void
        {
            this.view.songPlayBackUpdate(e.songDetails);
        }

        private function onSongLikesUpdated(e:MusicStudioSongEvent):void
        {
            this.view.updateSongLikes(e.songDetails);
        }

        private function onSharedSongsUpdated(e:MusicStudioSongEvent):void
        {
            this.view.updateSharedSongs(e.songDetails);
        }


    }
}//package com.clubpenguin.music.game.view.mediators.songList
