//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.music.game.events.MusicStudioSongEvent;
    import com.clubpenguin.services.socket.music.IMusicLikesService;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.model.vo.SongDetailsVO;

    public class LikeSongCommand extends Command 
    {

        [Inject]
        public var appModel:IAppModel;
        [Inject]
        public var event:MusicStudioSongEvent;
        [Inject]
        public var likesService:IMusicLikesService;


        override public function execute():void
        {
            Log.debug("");
            var songDetails:SongDetailsVO = this.event.songDetails[0];
            var playerId:int = songDetails.playerId;
            var songId:int = songDetails.songId;
            this.likesService.likesCount.addOnce(this.onLikesReceived);
            this.likesService.cannotLikeTrack.addOnce(this.onCannotLikeReceived);
            this.likesService.requestSendLike(playerId, songId);
            commandMap.detain(this);
        }

        protected function onLikesReceived(response:Object):void
        {
            Log.debug(("" + response));
            var count:int = parseInt(response.toString());
            this.event.songDetails[0].setLikesCount(count);
            this.event.songDetails[0].canLikeSong = false;
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.LIKES_UPDATED, this.event.songDetails));
            this.likesService.cannotLikeTrack.remove(this.onCannotLikeReceived);
            commandMap.release(this);
        }

        protected function onCannotLikeReceived():void
        {
            Log.debug("");
            this.event.songDetails[0].canLikeSong = false;
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.LIKES_UPDATED, this.event.songDetails));
            this.likesService.likesCount.remove(this.onLikesReceived);
            commandMap.release(this);
        }


    }
}//package com.clubpenguin.music.game.controller
