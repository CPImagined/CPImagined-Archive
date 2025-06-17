//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.RequestFriendshipCommand implements com.clubpenguin.controller.ICommand
    {
        var _swid, _airtower, _bridgeSendMessage, _swfBridge;
        function RequestFriendshipCommand (swid, airtower, bridgeSendMessage, swfBridge) {
            _swid = swid;
            _airtower = airtower;
            _bridgeSendMessage = bridgeSendMessage;
            _swfBridge = swfBridge;
        }
        function execute() {
            _swfBridge.send(_bridgeSendMessage, {type:SEND_FRIEND_REQUEST_MSG, swid:_swid, timestamp:com.clubpenguin.util.BridgeStats.getTimestamp(), msgId:com.clubpenguin.util.BridgeStats.sendCount++});
        }
        static var SEND_FRIEND_REQUEST_MSG = "sendFriendRequest";
    }
