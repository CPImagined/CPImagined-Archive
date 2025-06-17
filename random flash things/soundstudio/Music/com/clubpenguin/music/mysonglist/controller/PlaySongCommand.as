//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.player.IMusicPlayer;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.resources.song.SongRecorded;

    public class PlaySongCommand extends Command 
    {

        [Inject]
        public var musicPlayer:IMusicPlayer;
        [Inject]
        public var songData:String;
        [Inject]
        public var mainModel:MainModel;

        public function PlaySongCommand()
        {
            Log.debug("");
        }

        override public function execute():void
        {
            Log.debug(this.songData);
            this.musicPlayer.loadSong(new SongRecorded(int(this.songData), this.mainModel.getPlayerID(), true, false));
        }


    }
}//package com.clubpenguin.music.mysonglist.controller
