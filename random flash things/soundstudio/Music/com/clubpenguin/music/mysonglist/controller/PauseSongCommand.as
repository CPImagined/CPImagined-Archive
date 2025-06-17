//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.player.IMusicPlayer;
    import com.clubpenguin.lib.util.Log;

    public class PauseSongCommand extends Command 
    {

        [Inject]
        public var musicPlayer:IMusicPlayer;

        public function PauseSongCommand()
        {
            Log.debug("");
        }

        override public function execute():void
        {
            this.musicPlayer.stop();
        }


    }
}//package com.clubpenguin.music.mysonglist.controller
