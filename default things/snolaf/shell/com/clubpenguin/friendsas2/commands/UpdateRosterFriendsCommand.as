//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.UpdateRosterFriendsCommand implements com.clubpenguin.controller.ICommand
    {
        var _updatedFriends, _roster, _interface, _airtower, _shell, prevNumBuddies;
        function UpdateRosterFriendsCommand (updatedFriendsJsonStr, roster, currentInterface, airtower, shell) {
            _updatedFriends = decodeBuddiesJson(updatedFriendsJsonStr);
            _roster = roster;
            _interface = currentInterface;
            _airtower = airtower;
            _shell = shell;
        }
        function decodeBuddiesJson(jsonStr) {
            var _local_1;
            try {
                _local_1 = com.clubpenguin.util.JSONParser.parse(jsonStr);
            } catch(ex) {
                _local_1 = [];
            }
            return(_local_1);
        }
        function execute() {
            updateBuddiesFromFriends();
        }
        function updateBuddiesFromFriends() {
            prevNumBuddies = _roster.buddies.length;
            var _local_4 = 0;
            while (_local_4 < _updatedFriends.length) {
                var _local_2 = com.clubpenguin.friendsas2.Friend.fromRaw(_updatedFriends[_local_4]);
                if ((!_local_2.name) || (_local_2.name == "")) {
                } else if ((_local_2.name == null) || (_local_2.name.length == 0)) {
                } else if (!updateBuddy(_local_2)) {
                    var _local_9 = (_local_2.presence.status != OFFLINE_STATUS) && (_local_2.presence.location.world == _roster.worldID);
                    var _local_5 = new com.clubpenguin.friendsas2.buddiesintegration.BuddyVO(Number(_local_2.presence.id), _local_2.swid, _local_2.name, _local_9, _local_2.presence.location.world, _local_2.presence.location.room);
                    _roster.buddies.push(_local_5);
                    var _local_6 = _shell.ENGINE;
                    var _local_3 = _local_6.getPlayerMovieClip(_local_5.player_id);
                    if (_local_3 != undefined) {
                        var _local_7;
                        var _local_8 = _shell.getPlayerObjectById(_local_5.player_id);
                        if (_local_3[String(_local_8.dance_frame)]) {
                            _local_7 = _local_3[String(_local_8.dance_frame)];
                        } else {
                            _local_7 = _local_3.art_mc;
                        }
                        _local_6.setPenguinRingColor(_local_7, true);
                    }
                }
                _local_4++;
            }
            if ((_roster.worldID != "") && (prevNumBuddies != _roster.buddies.length)) {
                (new com.clubpenguin.friendsas2.commands.UpdateRosterPlayerIDsCommand(_roster, _interface, _airtower)).execute();
                _shell.sendRefreshPlayerFriendInfo();
            }
            _roster.updated.dispatch(_roster.buddies.length);
        }
        function updateBuddy(friend) {
            var _local_3 = 0;
            while (_local_3 < _roster.buddies.length) {
                var _local_2 = com.clubpenguin.friendsas2.buddiesintegration.BuddyVO(_roster.buddies[_local_3]);
                if (friend.swid == _local_2.swid) {
                    _local_2.world_id = friend.presence.location.world;
                    _local_2.room_id = friend.presence.location.room;
                    var _local_5 = _local_2.is_online;
                    _local_2.is_online = (friend.presence.status != OFFLINE_STATUS) && (_local_2.world_id == _roster.worldID);
                    if ((!_local_5) && (_local_2.is_online)) {
                        _interface.handleUpdateBuddyList();
                    }
                    return(true);
                }
                _local_3++;
            }
            return(false);
        }
        static var OFFLINE_STATUS = "offline";
    }
