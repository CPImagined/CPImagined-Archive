//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.game.events.MusicStudioViewEvent;

    public class PlayGameCommand extends Command 
    {


        override public function execute():void
        {
            dispatch(new MusicStudioViewEvent(MusicStudioViewEvent.SHOW_GAME_VIEW));
        }


    }
}//package com.clubpenguin.music.game.controller
