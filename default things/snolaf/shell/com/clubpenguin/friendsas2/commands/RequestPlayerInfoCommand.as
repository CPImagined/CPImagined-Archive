//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.RequestPlayerInfoCommand implements com.clubpenguin.controller.ICommand
    {
        var _playerID, _airtower, _callback;
        function RequestPlayerInfoCommand (playerID, airtower, callback) {
            _playerID = playerID;
            _airtower = airtower;
            _callback = callback;
        }
        function execute() {
            _airtower.addListener(_airtower.GET_PLAYER_INFO_BY_ID, onPlayerDataReceived, this);
            _airtower.send(_airtower.PLAY_EXT, (_airtower.PLAYER_HANDLER + "#") + _airtower.GET_PLAYER_INFO_BY_ID, [_playerID], "str", -1);
        }
        function onPlayerDataReceived(data) {
            var _local_2 = data[1];
            _airtower.removeListener(_airtower.GET_PLAYER_INFO_BY_ID, onPlayerDataReceived);
            _callback(_local_2, data[2], data[3]);
        }
        static var ADD_IGNORED_MSG = "addIgnored";
    }
