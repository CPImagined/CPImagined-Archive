//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.services.socket.music.IMusicService;
    import com.clubpenguin.music.mysonglist.model.MySongListModel;
    import com.clubpenguin.lib.util.Log;

    public class DeleteSongCommand extends Command 
    {

        [Inject]
        public var musicService:IMusicService;
        [Inject]
        public var model:MySongListModel;
        [Inject]
        public var songID:String;

        public function DeleteSongCommand()
        {
            Log.debug("");
        }

        override public function execute():void
        {
            Log.debug(this.songID);
            this.musicService.deleteSongSignal.addOnce(this.musicService_DeleteSong_Handler);
            this.musicService.deleteSong(this.songID);
        }

        private function musicService_DeleteSong_Handler(data:String):void
        {
            Log.debug(("1 " + data));
            if (data == "1")
            {
                Log.debug("2");
                this.model.songDeletedResponseSignal.dispatch(this.songID);
            };
        }


    }
}//package com.clubpenguin.music.mysonglist.controller
