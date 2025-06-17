//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.services.socket.music.IMusicService;
    import com.clubpenguin.music.mysonglist.model.MySongListModel;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.util.Log;

    public class GetSongLikesCommand extends Command 
    {

        [Inject]
        public var musicService:IMusicService;
        [Inject]
        public var model:MySongListModel;
        [Inject]
        public var mainModel:MainModel;
        private var _responseCount:Number = 0;


        override public function execute():void
        {
            Log.debug("");
            this.musicService.songLikesSignal.add(this.musicService_getSongLikes_Handler);
            this.musicService.requestMyLikes();
        }

        private function musicService_getSongLikes_Handler(data:String):void
        {
            Log.debug("");
            this._responseCount++;
            this.model.getLikesResponseSignal.dispatch(((data.split("|")[0] + "|") + data.split("|")[1]));
            if (this._responseCount >= this.model.songVOList.length)
            {
                this.musicService.songLikesSignal.remove(this.musicService_getSongLikes_Handler);
            };
        }


    }
}//package com.clubpenguin.music.mysonglist.controller
