//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var snowballPowerChanged, totalSnowballPointsChanged, heroPrizeChanged, robotPowerChanged, robotTypesCollectedChanged, robotInventoryChanged, villainPrizeChanged, _jsonObject;
        function SuperHeroCookieVO (cookieId) {
            super(cookieId);
            snowballPowerChanged = new org.osflash.signals.Signal(Number);
            totalSnowballPointsChanged = new org.osflash.signals.Signal(Number);
            heroPrizeChanged = new org.osflash.signals.Signal(Number);
            robotPowerChanged = new org.osflash.signals.Signal(Number);
            robotTypesCollectedChanged = new org.osflash.signals.Signal(Array);
            robotInventoryChanged = new org.osflash.signals.Signal(Array);
            villainPrizeChanged = new org.osflash.signals.Signal(Boolean);
        }
        function getCookieHandlerName() {
            return(SUPERHERO_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return(SUPERHERO_RECEIVE_COMMAND_NAME);
        }
        function getReceiveCommandName() {
            return(SUPERHERO_RECEIVE_COMMAND_NAME);
        }
        function get glovePower() {
            if ((_jsonObject.glovePower == null) || (_jsonObject.glovePower < 0)) {
                return(0);
            } else if (_jsonObject.glovePower > 100) {
                return(100);
            } else if (_jsonObject.glovePower > SNOWBALL_POWER_MAX) {
                return(SNOWBALL_POWER_MAX);
            } else {
                return(_jsonObject.glovePower);
            }
        }
        function set glovePower(value) {
            if (((value == null) || (value < 0)) || (value > SNOWBALL_POWER_MAX)) {
                traceSetError("glovePower", String(value));
                return;
            }
            if (value > 100) {
                value = 100;
            }
            _jsonObject.glovePower = value;
            //return(glovePower);
        }
        function get totalSnowballPoints() {
            return((((_jsonObject.gloveTotal == null) || (_jsonObject.gloveTotal < 0)) ? 0 : (_jsonObject.gloveTotal)));
        }
        function set totalSnowballPoints(value) {
            if (value == null) {
                traceSetError("gloveTotal", String(value));
            }
            _jsonObject.gloveTotal = value;
            totalSnowballPointsChanged.dispatch(value);
            //return(totalSnowballPoints);
        }
        function get heroPrize() {
            if (((_jsonObject.heroPrize == null) || (_jsonObject.heroPrize < 0)) || (_jsonObject.heroPrize > 3)) {
                return(0);
            } else {
                return(_jsonObject.heroPrize);
            }
        }
        function set heroPrize(value) {
            if (((value == null) || (value < 0)) || (value > 3)) {
                traceSetError("heroPrize", String(value));
                return;
            }
            _jsonObject.heroPrize = value;
            heroPrizeChanged.dispatch(value);
            //return(heroPrize);
        }
        function get robotPower() {
            if ((_jsonObject.robotPower == null) || (_jsonObject.robotPower < 0)) {
                return(0);
            } else if (_jsonObject.snowballPower > ROBOT_POWER_MAX) {
                return(ROBOT_POWER_MAX);
            } else {
                return(_jsonObject.robotPower);
            }
        }
        function set robotPower(value) {
            if (((value == null) || (value < 0)) || (value > ROBOT_POWER_MAX)) {
                traceSetError("robotPower", String(value));
                return;
            }
            _jsonObject.robotPower = value;
            if ((robotPowerChanged != null) && (value != null)) {
                robotPowerChanged.dispatch(value);
            }
            //return(robotPower);
        }
        function get villainPrize() {
            if (((_jsonObject.villainPrize == null) || (_jsonObject.villainPrize < 0)) || (_jsonObject.villainPrize > 3)) {
                return(0);
            } else {
                return(_jsonObject.villainPrize);
            }
        }
        function set villainPrize(value) {
            if (((value == null) || (value < 0)) || (value > 3)) {
                traceSetError("villainPrize", String(value));
                return;
            }
            _jsonObject.villainPrize = value;
            villainPrizeChanged.dispatch(value);
            //return(villainPrize);
        }
        function get robotTypesCollected() {
            if (((_jsonObject.built == null) || (_jsonObject.built.length == 0)) || (_jsonObject.built.length > NUM_ROBOT_TYPES)) {
                return(new Array[0]());
            } else {
                return(_jsonObject.built);
            }
        }
        function set robotTypesCollected(value) {
            if (((_jsonObject.built == null) || (_jsonObject.built.length == 0)) || (_jsonObject.built.length > NUM_ROBOT_TYPES)) {
                traceSetError("robotTypesCollected", String(value));
                return;
            }
            _jsonObject.built = value;
            robotTypesCollectedChanged.dispatch(value);
            //return(robotTypesCollected);
        }
        function updateRobotInventory(robotsBuiltInGameSession) {
            var _local_3 = robotInventory;
            var _local_4 = _local_3.length;
            var _local_2 = 0;
            while (_local_2 < _local_4) {
                _local_3[_local_2] = _local_3[_local_2] + robotsBuiltInGameSession[_local_2];
                _local_2++;
            }
        }
        function get robotInventory() {
            var _local_3 = new Array();
            if (_jsonObject.inventory == null) {
                trace("SuperHeroCookieVO inventory is null");
                var _local_2 = 0;
                while (_local_2 < TOTAL_NUM_ROBOTS) {
                    _local_3.push(0);
                    _local_2++;
                }
            } else {
                _local_3 = _jsonObject.inventory;
            }
            return(_local_3);
        }
        function set robotInventory(value) {
            if (value == null) {
                traceSetError("inventory", String(value));
                return;
            }
            var _local_2 = 0;
            while (_local_2 < value.length) {
                if ((value[_local_2] == null) || (value[_local_2] < 0)) {
                    traceSetError("inventory", (String(value) + ":") + value[_local_2]);
                    return;
                }
                _local_2++;
            }
            _jsonObject.inventory = value;
            robotInventoryChanged.dispatch(value);
            //return(robotInventory);
        }
        function traceSetError(propertyName, value) {
            trace((("SuperHeroCookieVO - ERROR - " + value) + " is not a valid value for ") + propertyName);
        }
        static var SUPERHERO_COOKIE_HANDLER_NAME = "shp";
        static var SUPERHERO_RECEIVE_COMMAND_NAME = "shppc";
        static var SNOWBALL_POWER_MAX = 999;
        static var ROBOT_POWER_MAX = 100;
        static var NUM_ROBOT_TYPES = 8;
        static var TOTAL_NUM_ROBOTS = 32;
        static var NUM_POWER_GLOVES = 9;
    }
