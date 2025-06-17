//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.ConnectToFriendsCommand implements com.clubpenguin.controller.ICommand
    {
        var _swid, _isMascot, _loginDataRaw, _confirmationHash, _swfBridge, _bridgeSendMessage;
        function ConnectToFriendsCommand (swid, isMascot, loginDataRaw, confirmationHash, swfBridge, bridgeSendMessage) {
            _swid = swid;
            _isMascot = isMascot;
            _loginDataRaw = loginDataRaw;
            _confirmationHash = confirmationHash;
            _swfBridge = swfBridge;
            _bridgeSendMessage = bridgeSendMessage;
        }
        function execute() {
            _swfBridge.send(_bridgeSendMessage, {type:CONNECT_BRIDGE_MSG, swid:_swid, isMascot:_isMascot, loginDataRaw:_loginDataRaw, confirmationHash:_confirmationHash, timestamp:com.clubpenguin.util.BridgeStats.getTimestamp(), msgId:com.clubpenguin.util.BridgeStats.sendCount++});
        }
        static var CONNECT_BRIDGE_MSG = "connectToFriends";
    }
