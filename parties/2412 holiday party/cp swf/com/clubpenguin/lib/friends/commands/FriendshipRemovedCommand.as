//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class FriendshipRemovedCommand extends SignalCommand 
    {

        private static const MSG_FRIENDSHIP_REMOVED:String = "friendshipRemoved";

        [Inject]
        public var swid:String;
        [Inject]
        public var bridge:IAVMBridgeService;


        override public function execute():void
        {
            var bridgeMessage:AVMBridgeMessage = new AVMBridgeMessage(MSG_FRIENDSHIP_REMOVED);
            bridgeMessage.data = {"swid":this.swid};
            this.bridge.send(bridgeMessage);
        }


    }
}//package com.clubpenguin.lib.friends.commands
