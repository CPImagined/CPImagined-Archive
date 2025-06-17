//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command.modelsync
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class SyncPlayerDataCommand extends SignalCommand 
    {

        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var playerObjectPayload:Object;


        override public function execute():void
        {
            var message:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_SYNC_PLAYER_DATA);
            message.data = this.playerObjectPayload;
            this.bridge.send(message);
        }


    }
}//package com.clubpenguin.main.command.modelsync
