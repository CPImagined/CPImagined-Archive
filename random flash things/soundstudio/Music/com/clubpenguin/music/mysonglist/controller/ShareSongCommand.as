//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.services.socket.music.IMusicService;
    import com.clubpenguin.music.mysonglist.model.MySongListModel;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.lib.util.Log;

    public class ShareSongCommand extends Command 
    {

        [Inject]
        public var musicService:IMusicService;
        [Inject]
        public var model:MySongListModel;
        [Inject]
        public var songData:String;
        [Inject]
        public var tracker:Tracker;
        private var _songID:String;
        private var _sharedFlag:String;

        public function ShareSongCommand()
        {
            Log.debug("");
        }

        override public function execute():void
        {
            Log.debug(this.songData);
            this._songID = this.songData.split("|")[0];
            this._sharedFlag = this.songData.split("|")[1];
            this.musicService.shareSongSignal.addOnce(this.musicService_ShareSong_Handler);
            this.musicService.shareSong(this._songID, this._sharedFlag);
        }

        private function musicService_ShareSong_Handler(data:String):void
        {
            if (data == "1")
            {
                this.tracker.trackGameAction("soundstudio", "game_share", false, null, false, null);
                this.model.songSharedResponseSignal.dispatch(((this._songID + "|") + this._sharedFlag));
            };
        }


    }
}//package com.clubpenguin.music.mysonglist.controller
