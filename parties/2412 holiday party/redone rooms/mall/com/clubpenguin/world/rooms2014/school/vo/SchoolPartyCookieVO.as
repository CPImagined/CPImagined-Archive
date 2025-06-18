//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.school.vo.SchoolPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var serialize, _jsonObject;
        function SchoolPartyCookieVO (cookieId) {
            super(cookieId);
            trace("SchoolPartyCookieVO()");
        }
        function getCookieHandlerName() {
            return(SCHOOL_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return("ERROR-NO-COOKIE-SEND-COMMAND");
        }
        function getReceiveCommandName() {
            return(SCHOOL_RECEIVE_COMMAND_NAME);
        }
        function get msgViewedArray() {
            trace("SchoolPartyCookieVO.msgViewedArray: " + serialize());
            if (_jsonObject.msgViewedArray == undefined) {
                return([0, 0]);
            }
            return(_jsonObject.msgViewedArray);
        }
        function setMessageViewed(messageIndex) {
            var _local_2 = _global.getCurrentAirtower();
            _local_2.send(_local_2.PLAY_EXT, (SCHOOL_COOKIE_HANDLER_NAME + "#") + com.clubpenguin.world.rooms2014.school.SchoolPartyConstants.MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function get snowflakes() {
            trace("SchoolPartyCookieVO.snowflakes _jsonObject.questItems: " + _jsonObject.questTaskStatus);
            trace("SchoolPartyCookieVO.snowflakes _jsonObjects: " + _jsonObject);
            for (var _local_3 in _jsonObject) {
                var _local_2 = _jsonObject[_local_3];
                trace((("SchoolPartyCookieVO json property : " + _local_3) + " = ") + _local_2);
            }
            if (_jsonObject.questTaskStatus == undefined) {
                return([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
            }
            return(_jsonObject.questTaskStatus);
        }
        function traceSetError(propertyName, value) {
            trace((("FrozenPartyCookieVO - ERROR - " + value) + " is not a valid value for ") + propertyName);
        }
        function areItemsCollected() {
            var _local_2 = 0;
            while (_local_2 < _jsonObject.questTaskStatus.length) {
                if (_jsonObject.questTaskStatus[_local_2] == 0) {
                    return(false);
                }
                _local_2++;
            }
            return(true);
        }
        static var SCHOOL_COOKIE_HANDLER_NAME = "school";
        static var SCHOOL_RECEIVE_COMMAND_NAME = "partycookie";
    }
