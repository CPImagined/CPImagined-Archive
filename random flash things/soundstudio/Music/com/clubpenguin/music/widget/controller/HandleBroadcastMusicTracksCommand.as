//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.widget.controller
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.services.socket.music.IMusicService;
    import com.clubpenguin.music.widget.model.MusicWidgetModel;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.widget.model.SharedTrackDataVO;
    import com.clubpenguin.music.widget.events.MusicWidgetEvent;

    public class HandleBroadcastMusicTracksCommand extends SignalCommand 
    {

        [Inject]
        public var musicService:IMusicService;
        [Inject]
        public var model:MusicWidgetModel;
        [Inject]
        public var data:Array;

        public function HandleBroadcastMusicTracksCommand()
        {
            Log.debug("");
        }

        override public function execute():void
        {
            Log.debug("");
            this.musicService_getBroadcastMusicTracks_Handler();
        }

        private function musicService_getBroadcastMusicTracks_Handler():void
        {
            var songData:String;
            var i:int;
            var trackDataSplit:Array;
            var currentTrackPlayerID:int;
            var currentTrackPlayerNickname:String;
            var currentTrackPlayerSwid:String;
            var currentTrackSongID:int;
            var currentTrackLikes:int;
            var sharedTrackDataVO:SharedTrackDataVO;
            Log.debug(String(this.data));
            if (this.data.length < 3)
            {
                return;
            };
            this.model.numberOfSharedTracks = this.data[0];
            this.data.shift();
            this.model.myQueuePosition = this.data[0];
            this.data.shift();
            if (this.data[0] == null)
            {
                return;
            };
            var musicTracksDataList:Array = this.data[0].split(",");
            Log.debug(("musicTracksDataList " + musicTracksDataList));
            var songDataList:Array = new Array();
            for each (songData in musicTracksDataList)
            {
                trackDataSplit = songData.split("|");
                songDataList.push(trackDataSplit);
            };
            Log.debug(("songDataList " + songDataList));
            this.model.resetSharedTracksQueue();
            i = 0;
            while (i < songDataList.length)
            {
                currentTrackPlayerID = songDataList[i][0];
                currentTrackPlayerNickname = songDataList[i][1];
                currentTrackPlayerSwid = songDataList[i][2];
                currentTrackSongID = songDataList[i][3];
                currentTrackLikes = songDataList[i][4];
                if (((songDataList[i][0] == undefined) || (songDataList[i][1] == undefined)))
                {
                }
                else
                {
                    sharedTrackDataVO = new SharedTrackDataVO(currentTrackPlayerID, currentTrackPlayerNickname, currentTrackPlayerSwid, currentTrackSongID, currentTrackLikes);
                    this.model.addToSharedTracksQueue(sharedTrackDataVO);
                };
                i++;
            };
            Log.debug("Dispatch Music Widget Event.UPDATE");
            dispatch(new MusicWidgetEvent(MusicWidgetEvent.UPDATE));
            if (this.model.currentSharedTrack)
            {
                Log.debug("Dispatch Music Widget Event.PLAY");
                eventDispatcher.dispatchEvent(new MusicWidgetEvent(MusicWidgetEvent.PLAY));
                commandMap.execute(CheckCanLikeSongCommand);
            };
        }


    }
}//package com.clubpenguin.music.widget.controller
