//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.UpdateRosterPlayerIDsCommand implements com.clubpenguin.controller.ICommand
    {
        var _roster, _interface, _airtower, _newBuddySwids, _newBuddies, _newIgnoredSwids, _newIgnored;
        function UpdateRosterPlayerIDsCommand (roster, currentInterface, airtower) {
            _roster = roster;
            _interface = currentInterface;
            _airtower = airtower;
            _newBuddySwids = [];
            _newBuddies = [];
            _newIgnoredSwids = [];
            _newIgnored = [];
        }
        function execute() {
            var _local_2;
            var _local_4 = 0;
            while (_local_4 < _roster.buddies.length) {
                _local_2 = com.clubpenguin.friendsas2.buddiesintegration.BuddyVO(_roster.buddies[_local_4]);
                if ((!_local_2.player_id) && (_local_2.player_id != -1)) {
                    _newBuddySwids.push(_local_2.swid);
                    _newBuddies.push(_local_2);
                    _swidSentCount++;
                }
                _local_4++;
            }
            var _local_3 = 0;
            while (_local_3 < _roster.ignored.length) {
                _local_2 = com.clubpenguin.friendsas2.buddiesintegration.BuddyVO(_roster.ignored[_local_3]);
                if ((!_local_2.player_id) && (_local_2.player_id != -1)) {
                    _newIgnoredSwids.push(_local_2.swid);
                    _newIgnored.push(_local_2);
                    _swidSentCount++;
                }
                _local_3++;
            }
            if ((_newBuddySwids.length != 0) || (_newIgnoredSwids.length != 0)) {
                var _local_5 = "";
                if (_newBuddySwids.length) {
                    _local_5 = _local_5 + _newBuddySwids.join(DELIMITER);
                }
                if (_newIgnoredSwids.length != 0) {
                    if (_local_5 != "") {
                        _local_5 = _local_5 + DELIMITER;
                    }
                    _local_5 = _local_5 + _newIgnoredSwids.join(DELIMITER);
                }
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PLAYER_HANDLER + "#") + _airtower.PBSM_START, [], "str", -1);
                sendMultipleSwidCalls(_newBuddySwids.concat(_newIgnoredSwids));
            } else {
                _interface.handleUpdateBuddyList();
            }
        }
        function sendMultipleSwidCalls(_swids) {
            var _local_4;
            var _local_3 = "";
            _local_4 = _swids.splice(0, Math.min(MAX_SWID_COUNT, _swids.length));
            _local_3 = _local_4.join(DELIMITER);
            _airtower.send(_airtower.PLAY_EXT, (_airtower.PLAYER_HANDLER + "#") + _airtower.GET_PLAYER_IDS_BY_SWIDS, [_local_3], "str", -1);
            if (_swids.length > 0) {
                sendMultipleSwidCalls(_swids);
            } else {
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PLAYER_HANDLER + "#") + _airtower.PBSM_FINISHED, [], "str", -1);
                _airtower.addListener(_airtower.PBSM_START, handlePbsmStarted, this);
                _airtower.addListener(_airtower.PBSM_FINISHED, handlePbsmFinished, this);
            }
        }
        function handlePbsmStarted() {
            _airtower.removeListener(_airtower.PBSM_START, handlePbsmStarted);
            _airtower.addListener(_airtower.GET_PLAYER_IDS_BY_SWIDS, onPlayerIDsReceived, this);
        }
        function onPlayerIDsReceived(data) {
            var _local_3 = String(data[1]).split(DELIMITER);
            var _local_2;
            while (_iIndex < _newBuddies.length) {
                _local_2 = com.clubpenguin.friendsas2.buddiesintegration.BuddyVO(_newBuddies[_iIndex]);
                _local_2.player_id = _local_3[_idIndex];
                _idIndex++;
                _iIndex++;
            }
            while (_jIndex < _newIgnored.length) {
                _local_2 = com.clubpenguin.friendsas2.buddiesintegration.BuddyVO(_newIgnored[_jIndex]);
                _local_2.player_id = _local_3[_idIndex];
                _idIndex++;
                _jIndex++;
            }
        }
        function handlePbsmFinished() {
            _interface.handleUpdateBuddyList();
            _airtower.removeListener(_airtower.PBSM_FINISHED, handlePbsmFinished);
            _airtower.removeListener(_airtower.GET_PLAYER_IDS_BY_SWIDS, onPlayerIDsReceived);
            _idIndex = 0;
            _jIndex = 0;
            _iIndex = 0;
        }
        static var DELIMITER = "|";
        static var MAX_SWID_COUNT = 90;
        var _swidSentCount = 0;
        var _swidArrayCount = 0;
        var _idIndex = 0;
        var _iIndex = 0;
        var _jIndex = 0;
    }
