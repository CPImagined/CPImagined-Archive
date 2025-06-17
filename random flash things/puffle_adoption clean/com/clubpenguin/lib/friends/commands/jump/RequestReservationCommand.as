//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands.jump
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.disney.friends.Friend;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.lib.vo.PlayerVO;
    import com.clubpenguin.lib.friends.FriendsSignalBus;
    import com.disney.friends.FriendsService;
    import it.gotoandplay.smartfoxserver.SmartFoxClient;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import it.gotoandplay.smartfoxserver.SFSEvent;

    public class RequestReservationCommand extends SignalCommand 
    {

        public static const HANDLER:String = "a";
        public static const RESERVATION_CMD:String = "res";
        public static const RESERVATION_ZONE:String = "r1";
        public static const WORLD_ZONE:String = "w1";

        [Inject]
        public var targetFriend:Friend;
        [Inject]
        public var reservationKey:String;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var signalBus:SignalBus;
        [Inject]
        public var localPlayer:PlayerVO;
        [Inject]
        public var friendsSignalBus:FriendsSignalBus;
        [Inject]
        public var jumpType:int;
        [Inject]
        public var friendsService:FriendsService;
        private var reservationConnection:SmartFoxClient;
        private var _randomKey:String;
        private var _worldData:Object;


        override public function execute():void
        {
            this.signalBus.worldDataReceived.addOnce(this.onWorldDataRecieved);
            var message:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_REQUEST_WORLD_DATA_BY_ID);
            message.data = {"worldId":this.targetFriend.presence.location.world};
            this.bridge.send(message);
        }

        private function onWorldDataRecieved(worldData:Object):void
        {
            this.reservationConnection = new SmartFoxClient();
            this.reservationConnection.addEventListener(SFSEvent.onConnection, this.onConnected);
            this.reservationConnection.connect(worldData.ip, worldData.port);
            this._worldData = worldData;
        }

        private function onConnected(e:SFSEvent):void
        {
            if (!e.params.success)
            {
            };
            this.reservationConnection.addEventListener(SFSEvent.onLogin, this.onLoginCompleted);
            this.reservationConnection.addEventListener(SFSEvent.onExtensionResponse, this.onExtensionResponseReceived);
            this.reservationConnection.login(RESERVATION_ZONE, this.localPlayer.nickname, this.reservationKey);
        }

        private function onRandomKeyReceived(e:SFSEvent):void
        {
            this.reservationConnection.removeEventListener(SFSEvent.onRandomKey, this.onRandomKeyReceived);
            this._randomKey = e.params.key;
            this.reservationConnection.addEventListener(SFSEvent.onLogin, this.onLoginCompleted);
            this.reservationConnection.addEventListener(SFSEvent.onExtensionResponse, this.onExtensionResponseReceived);
            this.reservationConnection.login(RESERVATION_ZONE, this.localPlayer.nickname, this.reservationKey);
        }

        private function onLoginCompleted(e:SFSEvent):void
        {
            if (!e.params.success)
            {
                this.reservationConnection.disconnect();
            };
        }

        private function onExtensionResponseReceived(e:SFSEvent):void
        {
            var _local_2:String = e.params.type;
            var data:Object = e.params.dataObj;
            var command:String = data._cmd;
            this.reservationConnection.removeEventListener(SFSEvent.onExtensionResponse, this.onExtensionResponseReceived);
            this.reservationConnection.addEventListener(SFSEvent.onExtensionResponse, this.onReservationReceived);
            this.reservationConnection.sendXtMessage(HANDLER, RESERVATION_CMD, [this.localPlayer.player_id, this.targetFriend.presence.id], "str");
        }

        private function onReservationReceived(e:SFSEvent):void
        {
            if (e.params.dataObj[2] == "failed")
            {
                this.friendsService.jumpFailure(this.targetFriend.swid);
            }
            else
            {
                if (this.jumpType == FriendsService.JUMP_TYPE_RESERVATION_AND_JUMP)
                {
                    this.friendsSignalBus.jumpToServer.dispatch(this._worldData, true, this.targetFriend);
                }
                else
                {
                    if (this.jumpType == FriendsService.JUMP_TYPE_RESERVATION)
                    {
                        this.friendsService.reservationReady(this.targetFriend.swid);
                    };
                };
            };
            this.reservationConnection.disconnect();
        }


    }
}//package com.clubpenguin.lib.friends.commands.jump
