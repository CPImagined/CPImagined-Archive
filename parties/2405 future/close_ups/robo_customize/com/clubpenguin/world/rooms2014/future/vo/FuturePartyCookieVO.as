//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.future.vo.FuturePartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var asteroidPointsChanged, _jsonObject;
        function FuturePartyCookieVO (cookieId) {
            super(cookieId);
            trace("FuturePartyCookieVO()");
            asteroidPointsChanged = new org.osflash.signals.Signal(Number);
        }
        function getCookieHandlerName() {
            return(FUTURE_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return("ERROR-NO-COOKIE-SEND-COMMAND");
        }
        function getReceiveCommandName() {
            return(FUTURE_RECEIVE_COMMAND_NAME);
        }
        function get msgViewedArray() {
            if (_jsonObject.msgViewedArray == undefined) {
                return([0, 0, 0]);
            }
            return(_jsonObject.msgViewedArray);
        }
        function setMessageViewed(messageIndex) {
            var _local_2 = _global.getCurrentAirtower();
            _local_2.send(_local_2.PLAY_EXT, (FUTURE_COOKIE_HANDLER_NAME + "#") + "fpmsgviewed", [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function get hasDefeatedProtobot() {
            return(((_jsonObject.defeatProtobot == undefined) ? false : (((_jsonObject.defeatProtobot == 0) ? false : true))));
        }
        function getEquipInfo(equipNumber) {
            trace("getEquipInfo");
            return({});
        }
        function get robos() {
            if (_jsonObject.robos == undefined) {
                return([{id:0, colorId:0}, {id:1, colorId:0}, {id:2, colorId:0}]);
            }
            return(_jsonObject.robos);
        }
        function getRoboPaint(roboId) {
            trace("_jsonObject.robos " + _jsonObject.robos);
            if ((((_jsonObject.robos == undefined) || (_jsonObject.robos[roboId] == undefined)) || (roboId < 0)) || (roboId > 2)) {
                return(2);
            }
            return(_jsonObject.robos[roboId].colorId);
        }
        function addAsteroidPoints(points) {
            _jsonObject.asteroidPoints = _jsonObject.asteroidPoints + points;
            asteroidPointsChanged.dispatch(Number(_jsonObject.asteroidPoints));
            _global.getCurrentParty().BaseParty.pebug("FuturePartyCookieVO.addAsteroidPoints points " + _jsonObject.asteroidPoints);
        }
        function get asteroidPoints() {
            var _local_2 = parseInt(String(_jsonObject.asteroidPoints));
            return((isNaN(_local_2) ? 0 : (_local_2)));
        }
        function traceSetError(propertyName, value) {
            trace((("FuturePartyCookieVO - ERROR - " + value) + " is not a valid value for ") + propertyName);
        }
        static var FUTURE_COOKIE_HANDLER_NAME = "future";
        static var FUTURE_RECEIVE_COMMAND_NAME = "partycookie";
        static var FUTURE_TRANSFORM_COMMAND_NAME = "fptransform";
    }
