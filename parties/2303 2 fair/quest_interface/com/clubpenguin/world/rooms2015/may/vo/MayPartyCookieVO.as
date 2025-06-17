//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.may.vo.MayPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        static var _airtower;
        var _jsonObject;
        function MayPartyCookieVO (cookieId) {
            super(cookieId);
            trace("MayPartyCookieVO - cookieId : " + cookieId);
            _airtower = _global.getCurrentAirtower();
        }
        function getCookieHandlerName() {
            return(MAY_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return(MAY_RECEIVE_COMMAND_NAME);
        }
        function getReceiveCommandName() {
            return(MAY_RECEIVE_COMMAND_NAME);
        }
        function set msgViewedArray(value) {
            trace("MAY PARTY COOKIE - SET MESSAGES VIEWED : " + value);
            if (value == undefined) {
                traceSetError("msgViewedArray", String(value));
                return;
            }
            _jsonObject.msgViewedArray = value;
            //return(msgViewedArray);
        }
        function get msgViewedArray() {
            return(_jsonObject.msgViewedArray);
        }
        function set tickets(value) {
            if (value == undefined) {
                traceSetError("tickets", String(value));
                return;
            }
            _jsonObject.tickets = value;
            //return(tickets);
        }
        function get tickets() {
            if ((_jsonObject.tickets == undefined) || (_jsonObject.tickets < 0)) {
                return(0);
            }
            return(_jsonObject.tickets);
        }
        function set silverTicket(value) {
            if (value == undefined) {
                traceSetError("silverTicket", String(value));
                return;
            }
            _jsonObject.silverTicket = value;
            //return(silverTicket);
        }
        function get silverTicket() {
            if (_jsonObject.silverTicket == undefined) {
                return(0);
            }
            return(_jsonObject.silverTicket);
        }
        function set spinDayIndex(value) {
            if (value == undefined) {
                traceSetError("spinDayIndex", String(value));
                return;
            }
            _jsonObject.spinDayIndex = value;
            //return(spinDayIndex);
        }
        function get spinDayIndex() {
            if (_jsonObject.spinDayIndex == undefined) {
                return(0);
            }
            return(_jsonObject.spinDayIndex);
        }
        function traceSetError(propertyName, value) {
            trace((("MayPartyCookieVO - ERROR - " + value) + " is not a valid value for ") + propertyName);
        }
        static function sendRequestPartyCookie() {
            _airtower.send(_airtower.PLAY_EXT, (MAY_COOKIE_HANDLER_NAME + "#") + MAY_COOKIE_HANDLER_NAME, [0], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function setMessageViewed(messageIndex) {
            trace("MAY PARTY COOKIE SERVER COMMAND - setMessageViewed : " + messageIndex);
            _airtower.send(_airtower.PLAY_EXT, (MAY_COOKIE_HANDLER_NAME + "#") + MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        static var PARTY_COOKIE_ID = "20150501";
        static var MAY_COOKIE_HANDLER_NAME = "fair";
        static var MAY_RECEIVE_COMMAND_NAME = "partycookie";
        static var MAYRECEIVE_COMMAND_NAME = "partycookie";
        static var PARTY_SETTINGS_RESPONSE_NAME = "partyservice";
        static var MESSAGE_VIEWED_COMMAND = "msgviewed";
    }
