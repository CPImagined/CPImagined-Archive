//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.future.FuturePartySnowballHitCheck implements com.clubpenguin.engine.projectiles.ISnowballHitCheck
    {
        function FuturePartySnowballHitCheck () {
        }
        function SnowballHitCheck() {
        }
        function hitCheck(snowballInfo) {
            var _local_3 = _global.getCurrentShell();
            var _local_5 = _global.getCurrentEngine();
            var _local_9 = _local_3.getPlayerList();
            var _local_2 = snowballInfo.snowballMC;
            var _local_6 = new Array();
            var _local_4;
            var _local_7 = -1;
            if (_local_3.isMyPlayer(snowballInfo.player_id)) {
                _local_5.setPlayerAction("wait");
            }
            if (!_local_2._visible) {
                return(undefined);
            }
            _local_4 = com.clubpenguin.engine.projectiles.SnowballHitStateConstant.MISS;
            if (_local_2._totalFrames == 4) {
                _local_2.gotoAndStop(_local_4);
            } else {
                _local_2.gotoAndStop(2);
            }
            return(0);
        }
    }
