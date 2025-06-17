//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.services.socket.music.IMusicService;
    import com.clubpenguin.music.game.model.MusicStudioModel;
    import com.clubpenguin.music.game.events.MusicStudioSongEvent;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.model.vo.SongDetailsVO;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class GetSharedSongsCommand extends Command 
    {

        [Inject]
        public var musicService:IMusicService;
        [Inject]
        public var model:MusicStudioModel;
        [Inject]
        public var event:MusicStudioSongEvent;


        override public function execute():void
        {
            Log.debug("");
            this.musicService.getSharedSongSignal.addOnce(this.onSaveResponse);
            this.musicService.requestSharedSongs();
        }

        public function onSaveResponse(response:String):void
        {
            var songsData:Array;
            var i:int;
            var songDataParts:Array;
            var playerId:int;
            var name:String;
            var songId:int;
            var likes:int;
            var details:SongDetailsVO;
            Log.debug(response);
            var songs:Vector.<SongDetailsVO> = new Vector.<SongDetailsVO>();
            if (response.length > 0)
            {
                songsData = response.split(",");
                i = 0;
                while (i < songsData.length)
                {
                    songDataParts = (songsData[i] as String).split("|");
                    playerId = parseInt((songDataParts[0] as String));
                    name = (songDataParts[1] as String);
                    songId = parseInt((songDataParts[2] as String));
                    likes = parseInt((songDataParts[3] as String));
                    details = new SongDetailsVO(NaN);
                    details.setPlayerId(playerId);
                    details.setPlayerName(name);
                    details.setSongId(songId);
                    details.setLikesCount(likes);
                    songs.push(details);
                    i++;
                };
            };
            this.model.setSharedSongs(songs);
        }


    }
}//package com.clubpenguin.music.game.controller
