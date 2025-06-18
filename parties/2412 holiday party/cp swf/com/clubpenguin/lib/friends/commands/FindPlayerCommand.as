//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class FindPlayerCommand extends SignalCommand 
    {

        private static const MSG_FIND_PLAYER:String = "findPlayer";

        [Inject]
        public var name:String;
        [Inject]
        public var bridge:IAVMBridgeService;


        override public function execute():void
        {
            var bridgeMessage:AVMBridgeMessage = new AVMBridgeMessage(MSG_FIND_PLAYER);
            bridgeMessage.data = {"name":this.name};
            this.bridge.send(bridgeMessage);
        }


    }
}//package com.clubpenguin.lib.friends.commands
