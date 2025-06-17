//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.FriendshipRemovedCommand implements com.clubpenguin.controller.ICommand
    {
        var _swid, _roster, _shell;
        function FriendshipRemovedCommand (swid, roster, shell) {
            _swid = swid;
            _roster = roster;
            _shell = shell;
        }
        function execute() {
            var _local_4 = -1;
            var _local_2 = 0;
            while (_local_2 < _roster.buddies.length) {
                var _local_3 = com.clubpenguin.friendsas2.buddiesintegration.BuddyVO(_roster.buddies[_local_2]);
                if (_local_3.swid == _swid) {
                    _local_4 = Number(_local_3.player_id);
                }
                _local_2++;
            }
            if (_local_4 != -1) {
                _shell.handleRemoveBuddyPlayer(["", _local_4]);
                var _local_6 = _shell.ENGINE;
                var _local_5 = _local_6.getPlayerMovieClip(_local_4);
                if (_local_5 != undefined) {
                    var _local_7;
                    var _local_8 = _shell.getPlayerObjectById(_local_4);
                    if (_local_5[String(_local_8.dance_frame)]) {
                        _local_7 = _local_5[String(_local_8.dance_frame)];
                    } else {
                        _local_7 = _local_5.art_mc;
                    }
                    _local_6.setPenguinRingColor(_local_7, false);
                }
            }
        }
    }
