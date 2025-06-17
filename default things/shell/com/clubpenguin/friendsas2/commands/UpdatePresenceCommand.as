//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.UpdatePresenceCommand implements com.clubpenguin.controller.ICommand
    {
        var _worldID, _roomID, _presence, _swfBridge, _bridgeSendMessage;
        function UpdatePresenceCommand (worldID, roomID, presence, swfBridge, bridgeSendMessage) {
            _worldID = worldID;
            _roomID = roomID;
            _presence = presence;
            _swfBridge = swfBridge;
            _bridgeSendMessage = bridgeSendMessage;
        }
        function execute() {
            var _local_2 = new com.clubpenguin.friendsas2.Location("", String(_roomID), String(_worldID));
            _presence.location = _local_2;
            _swfBridge.send(_bridgeSendMessage, {type:UPDATE_PRESENCE_BRIDGE_MSG, presence:_presence, timestamp:com.clubpenguin.util.BridgeStats.getTimestamp(), msgId:com.clubpenguin.util.BridgeStats.sendCount++});
        }
        static var UPDATE_PRESENCE_BRIDGE_MSG = "updatePresence";
    }
