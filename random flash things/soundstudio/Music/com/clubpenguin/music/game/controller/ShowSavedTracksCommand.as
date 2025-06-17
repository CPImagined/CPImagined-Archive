//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.music.events.MusicModuleEvent;

    public class ShowSavedTracksCommand extends Command 
    {


        override public function execute():void
        {
            Log.debug("");
            (contextView as BaseModule).getContext().eventDispatcher.dispatchEvent(new MusicModuleEvent(MusicModuleEvent.SHOW_MYSONGLIST));
        }


    }
}//package com.clubpenguin.music.game.controller
