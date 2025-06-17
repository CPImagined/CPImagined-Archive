//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.game.events.MusicStudioEvent;
    import com.clubpenguin.music.game.model.MusicStudioModel;
    import com.clubpenguin.music.player.IMusicPlayer;
    import com.clubpenguin.lib.util.Log;

    public class PlaySoundsCommand extends Command 
    {

        [Inject]
        public var event:MusicStudioEvent;
        [Inject]
        public var model:MusicStudioModel;
        [Inject]
        public var musicPlayer:IMusicPlayer;


        override public function execute():void
        {
            this.playSounds();
        }

        private function playSounds():void
        {
            Log.debug("");
            Log.debug((this.event.payload as String));
            this.musicPlayer.appendStatus((this.event.payload as String));
        }


    }
}//package com.clubpenguin.music.game.controller
