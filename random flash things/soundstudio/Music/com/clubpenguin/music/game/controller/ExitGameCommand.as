//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.game.context.MusicStudioContext;
    import com.clubpenguin.music.game.model.MusicStudioModel;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.events.MusicStudioSongEvent;
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.music.events.MusicModuleEvent;

    public class ExitGameCommand extends Command 
    {

        [Inject]
        public var context:MusicStudioContext;
        [Inject]
        public var model:MusicStudioModel;


        override public function execute():void
        {
            this.context.joinRoomSignal.dispatch();
            Log.debug("");
            this.model.stopSong();
            commandMap.execute(StopSongInMusicPlayerCommand, new MusicStudioSongEvent(MusicStudioSongEvent.STOP_SONG));
            (contextView as BaseModule).getContext().eventDispatcher.dispatchEvent(new MusicModuleEvent(MusicModuleEvent.HIDE_STUDIO));
        }


    }
}//package com.clubpenguin.music.game.controller
