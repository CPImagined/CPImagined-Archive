//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.blackout.SnowballHitCheck implements com.clubpenguin.world.rooms2012.common.collision.ISnowballHitCheck
    {
        function SnowballHitCheck () {
        }
        function hitCheck(snowballInfo) {
            var _local_12 = _global.getCurrentShell();
            var _local_10 = _global.getCurrentEngine();
            var _local_6 = _local_12.getPlayerList();
            var _local_9 = snowballInfo.snowballMC;
            var _local_7 = new Array();
            var _local_11;
            var _local_14 = -1;
            if (_local_12.isMyPlayer(snowballInfo.player_id)) {
                _local_10.setPlayerAction("wait");
            }
            if (!_local_9._visible) {
                return(undefined);
            }
            for (var _local_13 in _local_6) {
                var _local_2 = _local_6[_local_13];
                var _local_4 = _local_10.getPlayerMovieClip(_local_2.player_id);
                var _local_3 = _local_4.hitTest(snowballInfo.x, snowballInfo.y, true);
                if (_local_3) {
                    _local_7.push(_local_2);
                }
            }
            if (_local_7.length > 0) {
                _local_7.sortOn("y", [Array.NUMERIC | Array.DESCENDING]);
                var _local_8 = _local_7[0];
                if (com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isMoving(_local_8.player_id)) {
                    _local_11 = com.clubpenguin.world.rooms2012.blackout.Blackout.SNOWBALL_STATE_BOUNCE;
                } else if (_local_8.mascot_id == com.clubpenguin.world.rooms2012.common.MascotEnum.HERBERT_MASCOT_ID) {
                    _local_11 = com.clubpenguin.world.rooms2012.blackout.Blackout.SNOWBALL_STATE_BOUNCE;
                } else {
                    _local_14 = _local_8.player_id;
                    _local_11 = com.clubpenguin.world.rooms2012.blackout.Blackout.SNOWBALL_STATE_HIT;
                    _local_9._x = _local_8.x;
                    _local_9._y = _local_8.y;
                    _local_9.swapDepths(_local_9._parent.getNextHighestDepth());
                }
            } else {
                _local_11 = com.clubpenguin.world.rooms2012.blackout.Blackout.SNOWBALL_STATE_MISS;
            }
            if (_local_9._totalFrames == 4) {
                _local_9.gotoAndStop(_local_11);
            } else {
                _local_9.gotoAndStop(2);
            }
            return(_local_14);
        }
    }
