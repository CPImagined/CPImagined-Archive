//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.widget.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.music.events.MusicModuleEvent;
    import com.clubpenguin.music.mysonglist.MySongList;

    public class ShowSongListCommand extends Command 
    {


        override public function execute():void
        {
            (contextView as BaseModule).getContext().eventDispatcher.dispatchEvent(new MusicModuleEvent(MusicModuleEvent.SHOW_MYSONGLIST, MySongList.INIT_CLUB));
        }


    }
}//package com.clubpenguin.music.widget.controller
