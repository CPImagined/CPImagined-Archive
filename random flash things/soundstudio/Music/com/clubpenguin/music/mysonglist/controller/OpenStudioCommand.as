//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.mysonglist.model.MySongListModel;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.mysonglist.MySongList;

    public class OpenStudioCommand extends Command 
    {

        [Inject]
        public var model:MySongListModel;
        [Inject]
        public var tracker:Tracker;
        [Inject]
        public var bridge:IAVMBridgeService;


        override public function execute():void
        {
            var joinRoomMessage:AVMBridgeMessage;
            Log.debug("");
            commandMap.execute(CloseModuleCommand);
            if (this.model.initData == MySongList.INIT_CLUB)
            {
                Log.debug("Showing studio from club.");
                this.tracker.trackGameAction("soundstudio_open", "dance_club", false, null, false, null);
                joinRoomMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_JOIN_ROOM);
                joinRoomMessage.data = new Object();
                joinRoomMessage.data.roomName = "soundroom";
                this.bridge.send(joinRoomMessage);
            };
        }


    }
}//package com.clubpenguin.music.mysonglist.controller
