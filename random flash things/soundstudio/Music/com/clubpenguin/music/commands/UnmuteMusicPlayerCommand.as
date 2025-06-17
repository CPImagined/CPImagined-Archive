//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.commands
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.player.IMusicPlayer;
    import com.clubpenguin.lib.util.Log;

    public class UnmuteMusicPlayerCommand extends Command 
    {

        [Inject]
        public var musicPlayer:IMusicPlayer;


        override public function execute():void
        {
            Log.debug("");
            this.musicPlayer.unmute();
        }


    }
}//package com.clubpenguin.music.commands
