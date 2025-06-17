//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.commands
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.MusicModule;
    import com.clubpenguin.music.game.MusicStudioModule;

    public class HideMusicStudioCommand extends Command 
    {


        override public function execute():void
        {
            Log.debug("");
            var module:MusicStudioModule = (contextView.getChildByName(MusicModule.MUSIC_STUDIO_INSTANCE_NAME) as MusicStudioModule);
            if (module)
            {
                module.destroy();
                contextView.removeChild(module);
            };
        }


    }
}//package com.clubpenguin.music.commands
