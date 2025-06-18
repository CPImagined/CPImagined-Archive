//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.teenbeach.vo.TeenBeachPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var _jsonObject;
        function TeenBeachPartyCookieVO (cookieId) {
            super(cookieId);
        }
        function getCookieHandlerName() {
            return(TEENBEACH_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return(TEENBEACH_SEND_COMMAND_NAME);
        }
        function getReceiveCommandName() {
            return(TEENBEACH_RECEIVE_COMMAND_NAME);
        }
        function get isLoginScreenViewed() {
            if (_jsonObject.isLoginScreenViewed == null) {
                return(false);
            }
            return(_jsonObject.isLoginScreenViewed);
        }
        function set isLoginScreenViewed(value) {
            _jsonObject.isLoginScreenViewed = value;
            //return(isLoginScreenViewed);
        }
        function get hasVisitedSurfRoom() {
            if (_jsonObject.hasVisitedSurfRoom == null) {
                return(false);
            }
            return(_jsonObject.hasVisitedSurfRoom);
        }
        function set hasVisitedSurfRoom(value) {
            _jsonObject.hasVisitedSurfRoom = value;
            //return(hasVisitedSurfRoom);
        }
        static var TEENBEACH_COOKIE_HANDLER_NAME = "i";
        static var TEENBEACH_RECEIVE_COMMAND_NAME = "qpc";
        static var TEENBEACH_SEND_COMMAND_NAME = "spd";
    }
