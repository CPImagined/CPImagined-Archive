//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.services.socket.music.IMusicService;
    import com.clubpenguin.music.mysonglist.model.MySongListModel;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.mysonglist.model.SongDataVO;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class GetSongDataCommand extends Command 
    {

        [Inject]
        public var musicService:IMusicService;
        [Inject]
        public var model:MySongListModel;
        [Inject]
        public var mainModel:MainModel;

        public function GetSongDataCommand()
        {
            Log.debug("");
        }

        override public function execute():void
        {
            Log.debug("");
            this.musicService.mySongsSignal.add(this.musicService_getSongList_Handler);
            this.musicService.requestMySongs();
            commandMap.detain(this);
        }

        private function musicService_getSongList_Handler(data:String):void
        {
            var songData:String;
            var songDataSplit:Array;
            Log.debug(data);
            this.musicService.mySongsSignal.remove(this.musicService_getSongList_Handler);
            commandMap.release(this);
            var songDataList:Array = data.split(",");
            if (((data == "") || (data == null)))
            {
                songDataList = new Array();
            };
            var songDataVOs:Vector.<SongDataVO> = new Vector.<SongDataVO>();
            for each (songData in songDataList)
            {
                songDataSplit = songData.split("|");
                Log.debug((("Sharing: " + songDataSplit[2]) as String));
                songDataVOs.push(new SongDataVO(songDataSplit[1], songDataSplit[0], songDataSplit[2], songDataSplit[3]));
            };
            this.model.isMember = this.mainModel.myPlayerVO.is_member;
            this.model.setSongVOs(songDataVOs);
        }


    }
}//package com.clubpenguin.music.mysonglist.controller
