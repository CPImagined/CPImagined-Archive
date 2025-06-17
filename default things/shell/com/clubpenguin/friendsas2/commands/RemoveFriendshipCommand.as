//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.RemoveFriendshipCommand
    {
        var _swid, _roster, _swfBridge, _bridgeSendMessage, _removeAfterIgnore;
        function RemoveFriendshipCommand (swid, roster, removeAfterIgnore, swfBridge, bridgeSendMessage) {
            _swid = swid;
            _roster = roster;
            _swfBridge = swfBridge;
            _bridgeSendMessage = bridgeSendMessage;
            _removeAfterIgnore = removeAfterIgnore;
        }
        function execute() {
            _swfBridge.send(_bridgeSendMessage, {type:REMOVE_FRIENDSHIP_MSG, swid:_swid, removeAfterIgnore:_removeAfterIgnore, timestamp:com.clubpenguin.util.BridgeStats.getTimestamp(), msgId:com.clubpenguin.util.BridgeStats.sendCount++});
        }
        static var REMOVE_FRIENDSHIP_MSG = "removeFriendship";
    }
