//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.vo.PrehistoricPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var _jsonObject;
        function PrehistoricPartyCookieVO (cookieId) {
            super(cookieId);
        }
        function getCookieHandlerName() {
            return(PREHISTORIC_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return(PREHISTORIC_RECEIVE_COMMAND_NAME);
        }
        function getReceiveCommandName() {
            return(PREHISTORIC_RECEIVE_COMMAND_NAME);
        }
        function set msg(value) {
            if (value == undefined) {
                traceSetError("msg", String(value));
                return;
            }
            _jsonObject.msg = value;
            //return(msg);
        }
        function get msg() {
            if (_jsonObject.msg == undefined) {
                return([0, 0, 0, 0, 0]);
            }
            return(_jsonObject.msg);
        }
        function set trans(value) {
            if (value == undefined) {
                traceSetError("trans", String(value));
                return;
            }
            _jsonObject.msg = value;
            //return(trans);
        }
        function get trans() {
            if (_jsonObject.trans == undefined) {
                return([0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
            }
            return(_jsonObject.trans);
        }
        function set puff(value) {
            if (value == undefined) {
                traceSetError("puff", String(value));
                return;
            }
            _jsonObject.puff = value;
            //return(puff);
        }
        function get puff() {
            if (_jsonObject.trans == undefined) {
                return([{id:0, cs:0, hs:0}, {id:1, cs:0, hs:0}, {id:2, cs:0, hs:0}, {id:3, cs:0, hs:0}, {id:4, cs:0, hs:0}, {id:5, cs:0, hs:0}]);
            }
            return(_jsonObject.puff);
        }
        function traceSetError(propertyName, value) {
            trace((("PrehistoricPartyCookieVO - ERROR - " + value) + " is not a valid value for ") + propertyName);
        }
        static var PARTY_COOKIE_ID = "20140101";
        static var PREHISTORIC_COOKIE_HANDLER_NAME = "prehistoric";
        static var PREHISTORIC_RECEIVE_COMMAND_NAME = "prehistoricc";
    }
