//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.ToggleFriendsUICommand implements com.clubpenguin.controller.ICommand
    {
        var _swfBridge, _bridgeSendMessage;
        function ToggleFriendsUICommand (swfBridge, bridgeSendMessage) {
            _swfBridge = swfBridge;
            _bridgeSendMessage = bridgeSendMessage;
        }
        function execute() {
            _swfBridge.send(_bridgeSendMessage, {type:TOGGLE_FRIENDS_UI_MSG, timestamp:com.clubpenguin.util.BridgeStats.getTimestamp(), msgId:com.clubpenguin.util.BridgeStats.sendCount++});
        }
        static var TOGGLE_FRIENDS_UI_MSG = "toggleFriendsUI";
    }
