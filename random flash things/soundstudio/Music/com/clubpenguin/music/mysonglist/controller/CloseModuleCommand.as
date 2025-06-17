//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.player.IMusicPlayer;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.music.events.MusicModuleEvent;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class CloseModuleCommand extends Command 
    {

        [Inject]
        public var musicPlayer:IMusicPlayer;
        [Inject]
        public var bridge:IAVMBridgeService;


        override public function execute():void
        {
            Log.debug("");
            this.musicPlayer.stop();
            (contextView as BaseModule).getContext().eventDispatcher.dispatchEvent(new MusicModuleEvent(MusicModuleEvent.HIDE_MYSONGLIST));
            Log.debug(" send request to unmute room music");
            this.bridge.send(new AVMBridgeMessage(AVMBridgeMessage.MSG_UNMUTE_ROOM_MUSIC));
        }


    }
}//package com.clubpenguin.music.mysonglist.controller
