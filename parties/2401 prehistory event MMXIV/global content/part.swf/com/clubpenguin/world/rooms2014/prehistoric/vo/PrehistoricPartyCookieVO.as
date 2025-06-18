
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.vo.PrehistoricPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var _jsonObject;
        function PrehistoricPartyCookieVO (_arg_2) {
            super(_arg_2);
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
        function set msg(_arg_2) {
            if (_arg_2 == undefined) {
                traceSetError("msg", String(_arg_2));
                return;
            }
            _jsonObject.msg = _arg_2;
            //return(msg);
        }
        function get msg() {
            if (_jsonObject.msg == undefined) {
                return([0, 0, 0, 0, 0]);
            }
            return(_jsonObject.msg);
        }
        function set trans(_arg_2) {
            if (_arg_2 == undefined) {
                traceSetError("trans", String(_arg_2));
                return;
            }
            _jsonObject.msg = _arg_2;
            //return(trans);
        }
        function get trans() {
            if (_jsonObject.trans == undefined) {
                return([0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
            }
            return(_jsonObject.trans);
        }
        function set puff(_arg_2) {
            if (_arg_2 == undefined) {
                traceSetError("puff", String(_arg_2));
                return;
            }
            _jsonObject.puff = _arg_2;
            //return(puff);
        }
        function get puff() {
            if (_jsonObject.trans == undefined) {
                return([{id:0, cs:0, hs:0}, {id:1, cs:0, hs:0}, {id:2, cs:0, hs:0}, {id:3, cs:0, hs:0}, {id:4, cs:0, hs:0}, {id:5, cs:0, hs:0}]);
            }
            return(_jsonObject.puff);
        }
		
        function get communicatorMsgViewedArray() {
            if (_jsonObject.communicatorMsgArray == undefined) {
                return([0, 0, 0, 0]);
            }
            return(_jsonObject.communicatorMsgArray);
        }
		
        function set quest(_arg_2) {
            if (_arg_2 == undefined) {
                traceSetError("loginMsgViewed", String(_arg_2));
                return;
            }
            _jsonObject.quest = _arg_2;
            //return(loginMsgViewed);
        }
        function get quest() {
            if (_jsonObject.quest == undefined) {
                return([0, 0, 0, 0, 0]);
            }
            return(_jsonObject.quest);
        }
		function hasPlayerCompletedTask(i) {
			return quest[i] == 1;
		}
		
        function traceSetError(_arg_2, _arg_1) {
        }
        static var PARTY_COOKIE_ID = "20220101";
        static var PREHISTORIC_COOKIE_HANDLER_NAME = "prehistoric";
        static var PREHISTORIC_RECEIVE_COMMAND_NAME = "prehistoricc";
    }
