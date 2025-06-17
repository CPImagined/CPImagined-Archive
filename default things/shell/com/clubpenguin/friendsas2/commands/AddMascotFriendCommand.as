//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.AddMascotFriendCommand implements com.clubpenguin.controller.ICommand
    {
        var _id, _bridgeSendMessage, _swfBridge;
        function AddMascotFriendCommand (id, bridgeSendMessage, swfBridge) {
            _id = id;
            _bridgeSendMessage = bridgeSendMessage;
            _swfBridge = swfBridge;
        }
        function execute() {
            if (_id != undefined) {
                _swfBridge.send(_bridgeSendMessage, {type:SEND_ADD_MASCOT_FRIEND_MSG, id:_id, timestamp:com.clubpenguin.util.BridgeStats.getTimestamp(), msgId:com.clubpenguin.util.BridgeStats.sendCount++});
            }
        }
        static var SEND_ADD_MASCOT_FRIEND_MSG = "addMascotFriend";
    }
