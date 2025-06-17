//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.DisconnectFromFriendsCommand implements com.clubpenguin.controller.ICommand
    {
        var _shell, _swfBridge, _bridgeSendMessage;
        function DisconnectFromFriendsCommand (swfBridge, bridgeSendMessage, shell) {
            _shell = shell;
            _swfBridge = swfBridge;
            _bridgeSendMessage = bridgeSendMessage;
        }
        function execute() {
            _swfBridge.send(_bridgeSendMessage, {type:DISCONNECT_BRIDGE_MSG, timestamp:com.clubpenguin.util.BridgeStats.getTimestamp(), msgId:com.clubpenguin.util.BridgeStats.sendCount++});
        }
        static var DISCONNECT_BRIDGE_MSG = "disconnectFromFriends";
    }
