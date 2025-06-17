//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.PlayerFoundCommand implements com.clubpenguin.controller.ICommand
    {
        var _credentials, _swfBridge, _bridgeSendMessage;
        function PlayerFoundCommand (credentials, swfBridge, bridgeSendMessage) {
            _credentials = credentials;
            _swfBridge = swfBridge;
            _bridgeSendMessage = bridgeSendMessage;
        }
        function execute() {
            _swfBridge.send(_bridgeSendMessage, {type:PLAYER_FOUND_MSG, credentials:_credentials, timestamp:com.clubpenguin.util.BridgeStats.getTimestamp(), msgId:com.clubpenguin.util.BridgeStats.sendCount++});
        }
        static var PLAYER_FOUND_MSG = "playerFound";
    }
