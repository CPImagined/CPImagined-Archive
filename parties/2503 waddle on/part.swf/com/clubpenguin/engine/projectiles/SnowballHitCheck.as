
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.engine.projectiles.SnowballHitCheck implements com.clubpenguin.engine.projectiles.ISnowballHitCheck
    {
        function SnowballHitCheck () {
        }
        function hitCheck(_arg_5) {
            var _local_13 = _global.getCurrentShell();
            var _local_9 = _global.getCurrentEngine();
            var _local_6 = _local_13.getPlayerList();
            var _local_8 = _arg_5.snowballMC;
            var _local_7 = new Array();
            var _local_12;
            var _local_14 = -1;
            if (_local_13.isMyPlayer(_arg_5.player_id)) {
                _local_9.setPlayerAction("wait");
            }
            if (!_local_8._visible) {
                return(undefined);
            }
            for (var _local_11 in _local_6) {
                var _local_2 = _local_6[_local_11];
                var _local_3 = _local_9.getPlayerMovieClip(_local_2.player_id);
                var _local_4 = _local_3.hitTest(_arg_5.__get__x(), _arg_5.__get__y(), true);
                if (_local_4) {
                    _local_7.push(_local_2);
                }
            }
            if (_local_7.length > 0) {
                _local_7.sortOn("y", [Array.NUMERIC | Array.DESCENDING]);
                var _local_10 = _local_7[0];
                var _local_15 = _local_9.getPlayerMovieClip(_local_10.player_id);
                if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isMoving(_local_10.player_id)) {
                    _local_12 = com.clubpenguin.engine.projectiles.SnowballHitStateConstant.BOUNCE;
                } else {
                    _local_14 = _local_10.player_id;
                    _local_12 = com.clubpenguin.engine.projectiles.SnowballHitStateConstant.HIT;
                    _local_8._x = _local_10.x;
                    _local_8._y = _local_10.y;
                    if (_local_8.getDepth() < _local_15.getDepth()) {
                        _local_8.swapDepths(_local_15);
                    }
                }
            } else {
                _local_12 = com.clubpenguin.engine.projectiles.SnowballHitStateConstant.MISS;
            }
            if (_local_8._totalFrames == 4) {
                _local_8.gotoAndStop(_local_12);
            } else {
                _local_8.gotoAndStop(2);
            }
            return(_local_14);
        }
    }
