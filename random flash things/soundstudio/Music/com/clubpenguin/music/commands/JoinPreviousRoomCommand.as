//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.music.game.model.MusicStudioModel;
    import com.clubpenguin.main.signal.loadingScreen.ShowLoadingScreenSignal;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class JoinPreviousRoomCommand extends SignalCommand 
    {

        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var model:MusicStudioModel;
        [Inject]
        public var showLoadingScreen:ShowLoadingScreenSignal;


        override public function execute():void
        {
            this.showLoadingScreen.dispatch("");
            var joinRoomMessage:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_JOIN_ROOM);
            joinRoomMessage.data = new Object();
            this.bridge.send(joinRoomMessage);
        }


    }
}//package com.clubpenguin.music.commands
