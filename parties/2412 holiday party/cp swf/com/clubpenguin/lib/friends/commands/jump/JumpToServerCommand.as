//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands.jump
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.socket.IConnection;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.disney.friends.Friend;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class JumpToServerCommand extends SignalCommand 
    {

        private static const HANDLER:String = "q";
        private static const JUMP_CROSS_SERVER_CMD:String = "jmp";

        [Inject]
        public var connection:IConnection;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var worldData:Object;
        [Inject]
        public var isCrossServer:Boolean;
        [Inject]
        public var friend:Friend;


        override public function execute():void
        {
            var message:AVMBridgeMessage;
            if (this.isCrossServer)
            {
                this.connection.getResponded().add(this.onConnectionResponse);
                this.connection.sendMessage(HANDLER, JUMP_CROSS_SERVER_CMD);
            }
            else
            {
                message = new AVMBridgeMessage(AVMBridgeMessage.MSG_JUMP_TO_PLAYER);
                message.data = {};
                message.data.playerId = this.friend.presence.id;
                this.bridge.send(message);
            };
        }

        private function onConnectionResponse(messageType:String, responseData:Array):void
        {
            var loginKey:String;
            var message:AVMBridgeMessage;
            if (messageType != JUMP_CROSS_SERVER_CMD)
            {
                return;
            };
            this.connection.getResponded().remove(this.onConnectionResponse);
            if (responseData[1] != "failed")
            {
                loginKey = responseData[1];
                message = new AVMBridgeMessage(AVMBridgeMessage.MSG_JUMP_TO_SERVER);
                message.data = {
                    "worldId":this.worldData.id,
                    "loginKey":loginKey,
                    "playerId":this.friend.presence.id
                };
                this.bridge.send(message);
            };
        }


    }
}//package com.clubpenguin.lib.friends.commands.jump
