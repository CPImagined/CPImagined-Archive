//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.animations.FullStatsAnimation
    {
        var _SHELL, _ENGINE;
        function FullStatsAnimation (shell_mc, engine_mc) {
            _SHELL = shell_mc;
            _ENGINE = engine_mc;
        }
        function playFullStatsAnimation(playerID) {
            var _local_3 = _SHELL.getPlayerObjectById(playerID).attachedPuffle;
            if (_local_3) {
                var _local_4 = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(playerID, _local_3.id, _SHELL, _ENGINE);
                var _local_2 = _SHELL.getPath(ASSET_PATH);
                _local_2 = _local_3.getFormattedAssetURL(_local_2);
                _local_4.playPuffleAnimation(_local_2);
            }
        }
        static var ASSET_PATH = "w.puffle.sprite.fullstats";
    }
