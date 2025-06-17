//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.commands
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.events.MusicModuleEvent;
    import com.clubpenguin.music.mysonglist.MySongList;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.music.MusicModule;

    public class InitializeMySongListCommand extends Command 
    {

        [Inject]
        public var event:MusicModuleEvent;


        override public function execute():void
        {
            var mySongList:MySongList;
            Log.debug("");
            mySongList = new MySongList((contextView as BaseModule));
            mySongList.name = MusicModule.SONG_LIST_INSTANCE_NAME;
            mySongList.injector = injector.createChild();
            injector.injectInto(mySongList);
            mySongList.setInitData((this.event.payload as String));
            mySongList.init();
            contextView.addChild(mySongList);
        }


    }
}//package com.clubpenguin.music.commands
