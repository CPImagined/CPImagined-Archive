//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.vo.CFCPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var _jsonObject;
        function CFCPartyCookieVO (cookieId) {
            super(cookieId);
        }
        function getCookieHandlerName() {
            return(CFC_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return(CFC_RECEIVE_COMMAND_NAME);
        }
        function getReceiveCommandName() {
            return(CFC_RECEIVE_COMMAND_NAME);
        }
        function set loginMsgViewed(value) {
            if (value == undefined) {
                traceSetError("loginMsgViewed", String(value));
                return;
            }
            _jsonObject.loginMsgViewed = value;
            //return(loginMsgViewed);
        }
        function get loginMsgViewed() {
            if (_jsonObject.loginMsgViewed == undefined) {
                return(false);
            }
            return(_jsonObject.loginMsgViewed);
        }
        function set coinsDonated(value) {
            if (value == undefined) {
                traceSetError("donation", String(value));
                return;
            }
            _jsonObject.coinsDonated = value;
            //return(coinsDonated);
        }
        function get coinsDonated() {
            if ((_jsonObject.coinsDonated == undefined) || (_jsonObject.coinsDonated < 0)) {
                return(0);
            }
            return(_jsonObject.coinsDonated);
        }
        function traceSetError(propertyName, value) {
            trace((("CFCPartyCookieVO - ERROR - " + value) + " is not a valid value for ") + propertyName);
        }
        static var PARTY_COOKIE_ID = "20131201";
        static var CFC_COOKIE_HANDLER_NAME = "christmas";
        static var CFC_RECEIVE_COMMAND_NAME = "christmasc";
    }
