//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.AddIgnoredCommand implements com.clubpenguin.controller.ICommand
    {
        var _playerID, _airtower, _swfBridge, _bridgeSendMessage, _engine, _swid;
        function AddIgnoredCommand (playerID, airtower, swfBridge, bridgeSendMessage, swid, engine) {
            _playerID = playerID;
            _airtower = airtower;
            _swfBridge = swfBridge;
            _bridgeSendMessage = bridgeSendMessage;
            _engine = engine;
            _swid = swid;
        }
        function execute() {
            _engine.hideIgnoredPenguin(_playerID, true);
            if (_swid == undefined) {
                _airtower.addListener(_airtower.GET_PLAYER_INFO_BY_ID, onPlayerDataReceived, this);
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PLAYER_HANDLER + "#") + _airtower.GET_PLAYER_INFO_BY_ID, [_playerID], "str", -1);
            } else {
                _swfBridge.send(_bridgeSendMessage, {type:ADD_IGNORED_MSG, swid:_swid, timestamp:com.clubpenguin.util.BridgeStats.getTimestamp(), msgId:com.clubpenguin.util.BridgeStats.sendCount++});
            }
        }
        function onPlayerDataReceived(data) {
            var _local_2 = data[1];
            if ((_local_2 == undefined) || (_local_2.length == 0)) {
                return(undefined);
            }
            _airtower.removeListener(_airtower.GET_PLAYER_INFO_BY_ID, onPlayerDataReceived);
            _swfBridge.send(_bridgeSendMessage, {type:ADD_IGNORED_MSG, swid:data[1], timestamp:com.clubpenguin.util.BridgeStats.getTimestamp(), msgId:com.clubpenguin.util.BridgeStats.sendCount++});
        }
        static var ADD_IGNORED_MSG = "addIgnored";
    }
