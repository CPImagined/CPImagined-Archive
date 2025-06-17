//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.widget.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.services.socket.music.IMusicLikesService;
    import com.clubpenguin.music.widget.model.MusicWidgetModel;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.widget.events.MusicWidgetEvent;

    public class CheckCanLikeSongCommand extends Command 
    {

        [Inject]
        public var likesService:IMusicLikesService;
        [Inject]
        public var model:MusicWidgetModel;


        override public function execute():void
        {
            Log.debug("");
            var playerID:int = this.model.currentSharedTrack.playerID;
            var songID:int = this.model.currentSharedTrack.songID;
            this.likesService.checkCanLikeTrack.addOnce(this.onCheckCanLikeTrackReceived);
            this.likesService.requestCanLikeSong(playerID, songID);
            commandMap.detain(this);
        }

        protected function onCheckCanLikeTrackReceived(response:Boolean):void
        {
            Log.debug(("" + response));
            Log.debug(("model.currentSharedTrack " + this.model.currentSharedTrack));
            if (this.model.currentSharedTrack)
            {
                this.model.currentSharedTrack.canLikeSong = response;
                dispatch(new MusicWidgetEvent(MusicWidgetEvent.LIKES_UPDATED));
            };
            this.likesService.checkCanLikeTrack.remove(this.onCheckCanLikeTrackReceived);
            commandMap.release(this);
        }


    }
}//package com.clubpenguin.music.widget.controller
