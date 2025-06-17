//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.IgnoredUpdatedCommand implements com.clubpenguin.controller.ICommand
    {
        var _ignoredCredentials, _roster, _airtower, _interface, _shell;
        function IgnoredUpdatedCommand (ignoredCredentialsJsonStr, roster, airtower, currentInterface, shell) {
            _ignoredCredentials = decodeCredentialsJson(ignoredCredentialsJsonStr);
            _roster = roster;
            _airtower = airtower;
            _interface = currentInterface;
            _shell = shell;
        }
        function decodeCredentialsJson(jsonStr) {
            var _local_1;
            try {
                _local_1 = com.clubpenguin.util.JSONParser.parse(jsonStr);
            } catch(ex) {
                _local_1 = [];
            }
            return(_local_1);
        }
        function execute() {
            var _local_4 = _roster.ignored.length;
            _roster.ignored.length = 0;
            var _local_3 = 0;
            while (_local_3 < _ignoredCredentials.length) {
                var _local_2 = com.clubpenguin.friendsas2.CredentialsVO.fromRaw(_ignoredCredentials[_local_3]);
                if ((!_local_2.name) || (_local_2.name == "")) {
                } else {
                    _roster.ignored.push(new com.clubpenguin.friendsas2.buddiesintegration.BuddyVO(Number(_local_2.playerId), _local_2.swid, _local_2.name, false, ""));
                }
                _local_3++;
            }
            if (_roster.worldID != "") {
                (new com.clubpenguin.friendsas2.commands.UpdateRosterPlayerIDsCommand(_roster, _interface, _airtower)).execute();
            }
            if (_local_4 != _roster.ignored.length) {
                _shell.sendRefreshPlayerFriendInfo();
            }
        }
    }
