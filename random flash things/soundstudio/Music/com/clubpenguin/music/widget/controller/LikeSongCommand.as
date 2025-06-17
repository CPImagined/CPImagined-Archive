//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.widget.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.services.socket.music.IMusicLikesService;
    import com.clubpenguin.music.widget.model.MusicWidgetModel;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.widget.events.MusicWidgetEvent;

    public class LikeSongCommand extends Command 
    {

        public const BI_CONTEXT_SOUNDSTUDIO:String = "soundstudio";
        public const SONG_LIKED:String = "song_liked";

        [Inject]
        public var appModel:IAppModel;
        [Inject]
        public var likesService:IMusicLikesService;
        [Inject]
        public var model:MusicWidgetModel;
        [Inject]
        public var tracker:Tracker;


        override public function execute():void
        {
            Log.debug("");
            var playerID:int = this.model.currentSharedTrack.playerID;
            var songID:int = this.model.currentSharedTrack.songID;
            this.likesService.cannotLikeTrack.addOnce(this.onCannotLikeReceived);
            this.likesService.requestSendLike(playerID, songID);
            this.tracker.trackGameAction(this.BI_CONTEXT_SOUNDSTUDIO, this.SONG_LIKED, false, null, false, null);
            commandMap.detain(this);
        }

        protected function onCannotLikeReceived():void
        {
            Log.debug("");
            this.model.currentSharedTrack.canLikeSong = false;
            dispatch(new MusicWidgetEvent(MusicWidgetEvent.LIKES_UPDATED));
            commandMap.release(this);
        }


    }
}//package com.clubpenguin.music.widget.controller
