//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.RemoveIgnoredCommand implements com.clubpenguin.controller.ICommand
    {
        var _playerID, _roster, _swfBridge, _bridgeSendMessage, _engine;
        function RemoveIgnoredCommand (player_id, roster, swfBridge, bridgeSendMessage, engine) {
            _playerID = "" + player_id;
            _roster = roster;
            _swfBridge = swfBridge;
            _bridgeSendMessage = bridgeSendMessage;
            _engine = engine;
        }
        function execute() {
            var _local_2 = 0;
            while (_local_2 < _roster.ignored.length) {
                var _local_3 = com.clubpenguin.friendsas2.buddiesintegration.BuddyVO(_roster.ignored[_local_2]);
                if (_local_3.player_id == _playerID) {
                    _engine.hideIgnoredPenguin(_playerID, false);
                    _swfBridge.send(_bridgeSendMessage, {type:REMOVE_IGNORED_MSG, swid:_local_3.swid, timestamp:com.clubpenguin.util.BridgeStats.getTimestamp(), msgId:com.clubpenguin.util.BridgeStats.sendCount++});
                }
                _local_2++;
            }
        }
        static var REMOVE_IGNORED_MSG = "removeIgnored";
    }
