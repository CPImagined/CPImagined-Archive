//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.muppets.vo.MuppetsPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var _jsonObject;
        function MuppetsPartyCookieVO (cookieId) {
            super(cookieId);
        }
        function getCookieHandlerName() {
            return(MUPPETS_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return("ERROR-NO-COOKIE-SEND-COMMAND");
        }
        function getReceiveCommandName() {
            return(MUPPETS_RECEIVE_COMMAND_NAME);
        }
        function get muppets() {
            if (_jsonObject.muppets == undefined) {
                return(new Object());
            }
            return(_jsonObject.muppets);
        }
        function get login() {
            if (_jsonObject.login == undefined) {
                return(0);
            }
            return(_jsonObject.login);
        }
        function getMessageViewedByMuppetId(muppetId) {
            var _local_2 = muppets[String(muppetId)].mv;
            if (_local_2 == undefined) {
                return([0, 0]);
            }
            return(_local_2);
        }
        function isMuppetMessageViewed(muppetId, messageIndex) {
            var _local_2 = getMessageViewedByMuppetId(muppetId);
            return(_local_2[messageIndex] == 1);
        }
        function setMessageViewed(muppetId, messageIndex) {
            if ((muppetId < 0) && (muppetId > 7)) {
                return(undefined);
            }
            if (isMuppetMessageViewed(muppetId, messageIndex)) {
                return(undefined);
            }
            _jsonObject[String(muppetId)].mv[messageIndex] = 1;
            var _local_4 = _global.getCurrentAirtower();
            _local_4.send(_local_4.PLAY_EXT, (MUPPETS_COOKIE_HANDLER_NAME + "#") + "mmsgviewed", [muppetId, messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function traceSetError(propertyName, value) {
            trace((("MuppetsPartyCookieVO - ERROR - " + value) + " is not a valid value for ") + propertyName);
        }
        static var MUPPETS_COOKIE_HANDLER_NAME = "muppets";
        static var MUPPETS_RECEIVE_COMMAND_NAME = "partycookie";
    }
