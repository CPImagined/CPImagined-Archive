//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.commands
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.events.MusicModuleEvent;
    import com.clubpenguin.music.game.MusicStudioModule;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.music.MusicModule;

    public class InitializeMusicStudioCommand extends Command 
    {

        [Inject]
        public var event:MusicModuleEvent;


        override public function execute():void
        {
            var module:MusicStudioModule;
            Log.debug("");
            module = new MusicStudioModule((contextView as BaseModule));
            module.name = MusicModule.MUSIC_STUDIO_INSTANCE_NAME;
            module.injector = injector;
            module.init();
            contextView.addChild(module);
        }


    }
}//package com.clubpenguin.music.commands
