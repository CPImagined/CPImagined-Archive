//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.endscreens.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.endscreens.model.MiniGameEndScreensModel;
    import com.clubpenguin.endscreens.view.MiniGameEndScreensView;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import flash.geom.Point;

    public class JoinRoomCommmand extends SignalCommand 
    {

        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var _model:MiniGameEndScreensModel;
        [Inject]
        public var view:MiniGameEndScreensView;


        override public function execute():void
        {
            if (!this._model.isBlackHoleGame)
            {
                this.reloadRoom();
            }
            else
            {
                this.sendJoinRoom(this._model.exitRoom, this._model.exitRoomXpos, this._model.exitRoomYpos);
            };
        }

        public function sendJoinRoom(roomName:String, xPos:int, yPos:int):void
        {
            var bridgeMessageType:String = ((roomName == "igloo") ? AVMBridgeMessage.MSG_TELEPORT_TO_MY_IGLOO : AVMBridgeMessage.MSG_JOIN_ROOM);
            var joinRoomMessage:AVMBridgeMessage = new AVMBridgeMessage(bridgeMessageType);
            joinRoomMessage.data = new Object();
            joinRoomMessage.data.roomName = roomName;
            joinRoomMessage.data.position = new Point(xPos, yPos);
            this.bridge.send(joinRoomMessage);
        }

        public function reloadRoom():void
        {
            var bridgeMessageType:String = AVMBridgeMessage.MSG_RELOAD_ROOM;
            var joinRoomMessage:AVMBridgeMessage = new AVMBridgeMessage(bridgeMessageType);
            joinRoomMessage.data = new Object();
            this.bridge.send(joinRoomMessage);
        }


    }
}//package com.clubpenguin.endscreens.command
