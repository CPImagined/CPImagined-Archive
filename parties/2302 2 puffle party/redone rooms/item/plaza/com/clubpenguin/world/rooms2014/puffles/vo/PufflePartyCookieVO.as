//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.puffles.vo.PufflePartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var _jsonObject;
        function PufflePartyCookieVO (cookieId) {
            super(cookieId);
        }
        function getCookieHandlerName() {
            return(PUFFLEPARTY_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return(PUFFLEPARTY_RECEIVE_COMMAND_NAME);
        }
        function getReceiveCommandName() {
            return(PUFFLEPARTY_RECEIVE_COMMAND_NAME);
        }
        function set msgViewedArray(value) {
            if (value == undefined) {
                traceSetError("msgViewedArray", String(value));
                return;
            }
            _jsonObject.msgViewedArray = value;
            //return(msgViewedArray);
        }
        function get msgViewedArray() {
            if (_jsonObject.msgViewedArray == undefined) {
                return([0, 0]);
            }
            return(_jsonObject.msgViewedArray);
        }
        function traceSetError(propertyName, value) {
        }
        static var PARTY_COOKIE_ID = "20140402";
        static var PUFFLEPARTY_COOKIE_HANDLER_NAME = "puffleparty";
        static var PUFFLEPARTY_RECEIVE_COMMAND_NAME = "partycookie";
        static var PUFFLE_TRANSFORM_COMMAND = "pptransform";
    }
