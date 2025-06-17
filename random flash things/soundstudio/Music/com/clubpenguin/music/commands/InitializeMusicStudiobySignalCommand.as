//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.commands
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.game.MusicStudioModule;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.module.BaseModule;

    public class InitializeMusicStudiobySignalCommand extends Command 
    {


        override public function execute():void
        {
            var module:MusicStudioModule;
            Log.debug("");
            module = new MusicStudioModule((contextView as BaseModule));
            module.name = "musicStudio";
            module.injector = injector;
            module.init();
            contextView.addChild(module);
        }


    }
}//package com.clubpenguin.music.commands
