//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.MusicModule;
    import com.clubpenguin.music.game.MusicStudioModule;
    import com.clubpenguin.music.game.events.MusicStudioEvent;

    public class CreateNewTrackCommand extends Command 
    {


        override public function execute():void
        {
            Log.debug("");
            var module:MusicStudioModule = (contextView.getChildByName(MusicModule.MUSIC_STUDIO_INSTANCE_NAME) as MusicStudioModule);
            if (!module)
            {
                return;
            };
            module.getContext().eventDispatcher.dispatchEvent(new MusicStudioEvent(MusicStudioEvent.PLAY_GAME));
        }


    }
}//package com.clubpenguin.music.mysonglist.controller
