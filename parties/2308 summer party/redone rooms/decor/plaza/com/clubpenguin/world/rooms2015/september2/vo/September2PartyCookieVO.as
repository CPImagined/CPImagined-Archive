//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.september2.vo.September2PartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        static var _airtower;
        var _jsonObject;
        function September2PartyCookieVO (cookieId) {
            super(cookieId);
            _airtower = _global.getCurrentAirtower();
        }
        function getCookieHandlerName() {
            return(SEPTEMBER2_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return(PARTY_RECEIVE_COMMAND_NAME);
        }
        function getReceiveCommandName() {
            return(PARTY_RECEIVE_COMMAND_NAME);
        }
        function get msgViewedArray() {
            if (_jsonObject.msgViewedArray == undefined) {
                return([0]);
            }
            return(_jsonObject.msgViewedArray);
        }
        static function sendRequestPartyCookie() {
            _airtower.send(_airtower.PLAY_EXT, (SEPTEMBER2_COOKIE_HANDLER_NAME + "#") + SEPTEMBER2_COOKIE_HANDLER_NAME, [0], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function sendMessageViewed(messageIndex) {
            if ((messageIndex >= 0) && (messageIndex < msgViewedArray.length)) {
                _airtower.send(_airtower.PLAY_EXT, (SEPTEMBER2_COOKIE_HANDLER_NAME + "#") + MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
            } else {
                traceSetError("sendMessageViewed", messageIndex);
            }
        }
        function traceSetError(propertyName, value) {
        }
        function toString(arr) {
            var _local_1 = 0;
            while (_local_1 < (arr.length - 1)) {
                _local_1++;
            }
        }
        function hasPlayerViewedMessage(messageIndex) {
            return(((msgViewedArray[messageIndex] == 1) ? true : false));
        }
        static var PARTY_COOKIE_ID = "20150902";
        static var SEPTEMBER2_COOKIE_HANDLER_NAME = "anniversary";
        static var PARTY_RECEIVE_COMMAND_NAME = "partycookie";
        static var PARTY_SETTINGS_RESPONSE_NAME = "partyservice";
        static var MESSAGE_VIEWED_COMMAND = "msgviewed";
    }
