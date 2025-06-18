//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.beancounters.BagLauncher
    {
        static var __instance;
        var __oneUpToggle, __invincibleShieldPowerUpToggle, __bagCounter, __anvilOut, __flowerOut, __fishOut, __airborne, __maxAirborne, __gc, __mainTimeline, bagList, bagCircularList, __whichBag;
        function BagLauncher (gc) {
            __instance = this;
        }
        static function get getInstance() {
            if (__instance == undefined) {
                __instance = new com.clubpenguin.games.beancounters.BagLauncher();
            }
            return(__instance);
        }
        function get bagActivity() {
            return(__bagActivity);
        }
        function set bagActivity(param) {
            __bagActivity = param;
            //return(bagActivity);
        }
        function get oneUpToggle() {
            return(__oneUpToggle);
        }
        function set oneUpToggle(param) {
            __oneUpToggle = param;
            //return(oneUpToggle);
        }
        function get invincibleShieldPowerUpToggle() {
            return(__invincibleShieldPowerUpToggle);
        }
        function set invincibleShieldPowerUpToggle(param) {
            __invincibleShieldPowerUpToggle = param;
            //return(invincibleShieldPowerUpToggle);
        }
        function get invincibleShieldPowerUpCounter() {
            return(__invincibleShieldPowerUpCounter);
        }
        function set invincibleShieldPowerUpCounter(param) {
            __invincibleShieldPowerUpCounter = param;
            //return(invincibleShieldPowerUpCounter);
        }
        function get invincibleShieldPowerUpMax() {
            return(__invincibleShieldPowerUpMax);
        }
        function set invincibleShieldPowerUpMax(param) {
            __invincibleShieldPowerUpMax = param;
            //return(invincibleShieldPowerUpMax);
        }
        function get fishCounter() {
            return(__fishCounter);
        }
        function set fishCounter(param) {
            __fishCounter = param;
            //return(fishCounter);
        }
        function get bagCounter() {
            return(__bagCounter);
        }
        function set bagCounter(param) {
            __bagCounter = param;
            //return(bagCounter);
        }
        function get fishMax() {
            return(__fishMax);
        }
        function set fishMax(param) {
            __fishMax = param;
            //return(fishMax);
        }
        function get anvilOut() {
            return(__anvilOut);
        }
        function set anvilOut(param) {
            __anvilOut = param;
            //return(anvilOut);
        }
        function get flowerOut() {
            return(__flowerOut);
        }
        function set flowerOut(param) {
            __flowerOut = param;
            //return(flowerOut);
        }
        function get fishOut() {
            return(__fishOut);
        }
        function set fishOut(param) {
            __fishOut = param;
            //return(fishOut);
        }
        function get airborne() {
            return(__airborne);
        }
        function set airborne(param) {
            __airborne = param;
            //return(airborne);
        }
        function get maxAirborne() {
            return(__maxAirborne);
        }
        function set maxAirborne(param) {
            __maxAirborne = param;
            //return(maxAirborne);
        }
        function init(gc) {
            var _local_6;
            var _local_3;
            __gc = gc;
            __mainTimeline = __gc.mainTimeline;
            com.clubpenguin.games.beancounters.FlyingObjectController.getInstance.init(__gc);
            bagList = new Array();
            bagCircularList = new Array();
            var _local_2 = 0;
            while (_local_2 < 20) {
                _local_3 = "bagInstance" + _local_2;
                if (gc.gameMode == 1) {
                    var _local_4 = __mainTimeline.flyingBagsLayer["bag" + (_local_2 % 4)];
                    _local_4.duplicateMovieClip(_local_3, _local_2 + 100);
                } else {
                    var _local_4 = __mainTimeline.flyingBagsLayer["candybag" + (_local_2 % 4)];
                    _local_4.duplicateMovieClip(_local_3, _local_2 + 100);
                }
                __mainTimeline.flyingBagsLayer[_local_3]._visible = false;
                bagCircularList.push(__mainTimeline.flyingBagsLayer[_local_3]);
                _local_2++;
            }
            bagCircularList = shuffleArray(bagCircularList);
        }
        function update() {
            var _local_3 = Math.round(Math.random() * __bagActivity);
            if (((_local_3 <= 2) and (__gc.penguinClip._currentframe < 7)) and (__mainTimeline.gameOver._visible == false)) {
                if (__airborne < __maxAirborne) {
                    if (__gc.gameMode == 1) {
                        __whichBag = Math.round(Math.random() * 7);
                    } else if (__gc.gameMode == 2) {
                        __whichBag = Math.round(Math.random() * 8);
                    }
                    if (__whichBag <= 3) {
                        var _local_2 = bagCircularList[__bagCount++];
                        if (__bagCount == 20) {
                            __bagCount = 0;
                            bagCircularList = shuffleArray(bagCircularList);
                        }
                        _local_2.swapDepths(__mainTimeline.flyingBagsLayer.getNextHighestDepth());
                        _local_2.GameEngine = __gc;
                        if (__gc.gameMode == 2) {
                            _local_2.colorize();
                        }
                        _local_2._visible = true;
                        _local_2.activate("bag");
                        _local_2.startAnimation();
                        bagList.push(_local_2);
                        __airborne++;
                    }
                    if ((((__whichBag == 4) and (__oneUpToggle == true)) and (__gc.level >= 3)) and ((__gc.level % 2) == 1)) {
                        com.clubpenguin.games.beancounters.FlyingObjectController.getInstance.spawnOneUp(__whichBag, __bagCounter);
                        __oneUpToggle = false;
                        __airborne++;
                    }
                    if (((__whichBag == 5) and (__gc.level >= 2)) and (!__anvilOut)) {
                        com.clubpenguin.games.beancounters.FlyingObjectController.getInstance.spawnAnvil(__gc.gameMode, __whichBag, __bagCounter);
                        __airborne++;
                        __anvilOut = true;
                    }
                    if ((((__whichBag == 6) and (__gc.level >= 3)) and (!__fishOut)) and (__fishCounter <= __fishMax)) {
                        com.clubpenguin.games.beancounters.FlyingObjectController.getInstance.spawnFish(__gc.gameMode, __whichBag, __bagCounter);
                        __airborne++;
                        __fishOut = true;
                        __fishCounter++;
                    }
                    if (((__whichBag == 7) and (__gc.level >= 4)) and (!__flowerOut)) {
                        com.clubpenguin.games.beancounters.FlyingObjectController.getInstance.spawnFlowers(__gc.gameMode, __whichBag, __bagCounter);
                        __airborne++;
                        __flowerOut = true;
                    }
                    if ((((__whichBag == 8) && (invincibleShieldPowerUpToggle)) && (__gc.level > 1)) && (__bagCounter > (__invincibleShieldPowerUpCounter * 50))) {
                        if (__invincibleShieldPowerUpCounter >= __invincibleShieldPowerUpMax) {
                            __invincibleShieldPowerUpToggle = false;
                        } else if (!__gc.isInvincibleShieldOn) {
                            com.clubpenguin.games.beancounters.FlyingObjectController.getInstance.spawnPowerUp(__whichBag, __bagCounter);
                            __airborne++;
                            __invincibleShieldPowerUpCounter++;
                        }
                    }
                    __bagCounter++;
                }
            }
        }
        function shuffleArray(array) {
            var _local_5 = array.length - 1;
            var _local_1 = 0;
            while (_local_1 < _local_5) {
                var _local_3 = Math.round(Math.random() * _local_5);
                var _local_4 = array[_local_1];
                array[_local_1] = array[_local_3];
                array[_local_3] = _local_4;
                _local_1++;
            }
            return(array);
        }
        var __bagIndex = 0;
        var __bagActivity = 10;
        var __fishCounter = 0;
        var __fishMax = 2;
        var __invincibleShieldPowerUpMax = 0;
        var __invincibleShieldPowerUpCounter = 0;
        var __bagCount = 0;
    }
