//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.beancounters.FlyingObjectController
    {
        static var __instance;
        var __gc, __mainTimeline;
        function FlyingObjectController () {
            __instance = this;
        }
        static function get getInstance() {
            if (__instance == undefined) {
                __instance = new com.clubpenguin.games.beancounters.FlyingObjectController();
            }
            return(__instance);
        }
        function init(gc) {
            __gc = gc;
            __mainTimeline = __gc.mainTimeline;
        }
        function spawnBag(gameMode, whichBag, bagCounter) {
            var _local_3 = "bagInstance" + bagCounter;
            var _local_4;
            var _local_2;
            if (gameMode == 1) {
                _local_4 = __mainTimeline["bag" + whichBag];
            } else if (gameMode == 2) {
                _local_4 = __mainTimeline["candybag" + whichBag];
            }
            _local_4.duplicateMovieClip(_local_3, bagCounter);
            _local_2 = __mainTimeline[_local_3];
            _local_2.GameEngine = __gc;
            _local_2.activate("bag");
            _local_2.startAnimation();
            return(_local_2);
        }
        function spawnAnvil(gameMode, whichBag, bagCounter) {
            var _local_2 = "anvil" + bagCounter;
            if (gameMode == 1) {
                __mainTimeline.hazard0.duplicateMovieClip(_local_2, bagCounter);
            } else if (gameMode == 2) {
                __mainTimeline.candyHazard0.duplicateMovieClip(_local_2, bagCounter);
            }
            var _local_4;
            _local_4 = __mainTimeline[_local_2];
            _local_4.activate("hazard");
        }
        function spawnFish(gameMode, whichBag, bagCounter) {
            var _local_2 = "fish" + bagCounter;
            if (gameMode == 1) {
                __mainTimeline.hazard1.duplicateMovieClip(_local_2, bagCounter);
            } else if (gameMode == 2) {
                __mainTimeline.candyHazard1.duplicateMovieClip(_local_2, bagCounter);
            }
            var _local_4;
            _local_4 = __mainTimeline[_local_2];
            _local_4.activate("hazard");
        }
        function spawnFlowers(gameMode, whichBag, bagCounter) {
            var _local_2 = "flower" + bagCounter;
            if (gameMode == 1) {
                __mainTimeline.hazard2.duplicateMovieClip(_local_2, bagCounter);
            } else if (gameMode == 2) {
                __mainTimeline.candyHazard2.duplicateMovieClip(_local_2, bagCounter);
            }
            var _local_3;
            _local_3 = __mainTimeline[_local_2];
            _local_3.activate("hazard");
        }
        function spawnOneUp(whichBag, bagCounter) {
            var _local_2 = "oneup" + bagCounter;
            __mainTimeline.oneup.duplicateMovieClip(_local_2, bagCounter);
            var _local_3;
            _local_3 = __mainTimeline[_local_2];
            _local_3.activate("oneup");
        }
        function spawnPowerUp(whichBag, bagCounter) {
            var _local_2 = "invincibleShieldPowerUp" + bagCounter;
            __mainTimeline.invincibleShieldPowerUp.duplicateMovieClip(_local_2, bagCounter);
            var _local_3;
            _local_3 = __mainTimeline[_local_2];
            _local_3.activate("invincibleShieldPowerUp");
        }
    }
