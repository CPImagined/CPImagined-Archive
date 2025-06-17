//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.UpdateRosterWorldCommand implements com.clubpenguin.controller.ICommand
    {
        var _worldID, _roster;
        function UpdateRosterWorldCommand (worldID, roster) {
            _worldID = worldID;
            _roster = roster;
        }
        function execute() {
            _roster.worldID = _worldID;
            var _local_2 = 0;
            while (_local_2 < _roster.buddies.length) {
                var _local_3 = com.clubpenguin.friendsas2.buddiesintegration.BuddyVO(_roster.buddies[_local_2]);
                _local_3.is_online = _local_3.world_id == _worldID;
                _local_2++;
            }
        }
    }
