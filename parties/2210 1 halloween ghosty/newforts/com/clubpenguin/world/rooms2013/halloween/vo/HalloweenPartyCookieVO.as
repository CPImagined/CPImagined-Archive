//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.halloween.vo.HalloweenPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var candyPointsChanged, _jsonObject;
        function HalloweenPartyCookieVO (cookieId) {
            super(cookieId);
            candyPointsChanged = new org.osflash.signals.Signal(Number);
        }
        function getCookieHandlerName() {
            return(HALLOWEEN_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return(HALLOWEEN_RECEIVE_COMMAND_NAME);
        }
        function getReceiveCommandName() {
            return(HALLOWEEN_RECEIVE_COMMAND_NAME);
        }
        function get msg() {
            if (_jsonObject.msg == undefined) {
                return([0, 0, 0, 0, 0]);
            }
            return(_jsonObject.msg);
        }
        function set msg(value) {
            if ((value == undefined) || (value < 0)) {
                traceSetError("msg", String(value));
                return;
            }
            _jsonObject.msg = value;
            candyPointsChanged.dispatch(value);
            //return(msg);
        }
        function get candyPoints() {
            if (((_jsonObject.points == null) || (_jsonObject.points == undefined)) || (_jsonObject.points < 0)) {
                return(0);
            }
            return(_jsonObject.points);
        }
        function set candyPoints(value) {
            if ((value == null) || (value < 0)) {
                traceSetError("points", String(value));
                return;
            }
            _jsonObject.points = value;
            candyPointsChanged.dispatch(value);
            //return(candyPoints);
        }
        function get candiesCollected() {
            if ((_jsonObject.found == null) || (_jsonObject.found == undefined)) {
                return([0, 0, 0, 0, 0, 0, 0, 0, 0]);
            }
            return(_jsonObject.found);
        }
        function set candiesCollected(value) {
            if (value == null) {
                traceSetError("found", String(value));
                return;
            }
            _jsonObject.found = value;
            //return(candiesCollected);
        }
        function get inventory() {
            trace("_jsonObject.inventory == null " + _jsonObject.inventory);
            if ((_jsonObject.inventory == null) || (_jsonObject.inventory == undefined)) {
                return([0, 0, 0, 0, 0, 0, 0, 0, 0]);
            }
            return(_jsonObject.inventory);
        }
        function set inventory(value) {
            if (value == null) {
                traceSetError("inventory", String(value));
                return;
            }
            _jsonObject.inventory = value;
            //return(inventory);
        }
        function traceSetError(propertyName, value) {
            trace((("HalloweenPartyVO - ERROR - " + value) + " is not a valid value for ") + propertyName);
        }
        static var PARTY_COOKIE_ID = "20131001";
        static var HALLOWEEN_COOKIE_HANDLER_NAME = "hween";
        static var HALLOWEEN_RECEIVE_COMMAND_NAME = "hweenpc";
    }
