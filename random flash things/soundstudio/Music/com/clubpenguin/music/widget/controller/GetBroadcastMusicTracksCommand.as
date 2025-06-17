//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.widget.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.services.socket.music.IMusicService;
    import com.clubpenguin.lib.util.Log;

    public class GetBroadcastMusicTracksCommand extends Command 
    {

        [Inject]
        public var musicService:IMusicService;

        public function GetBroadcastMusicTracksCommand()
        {
            Log.debug("");
        }

        override public function execute():void
        {
            Log.debug("");
            this.musicService.requestBroadcastingMusicTracks();
        }


    }
}//package com.clubpenguin.music.widget.controller
