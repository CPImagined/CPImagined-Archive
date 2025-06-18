
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.world.rooms2024.fools.vo.FoolsPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var _jsonObject;
        function FoolsPartyCookieVO() {
            super();
        }
        function getCookieHandlerName() {
            return(com.clubpenguin.world.rooms2024.fools.FoolsPartyConstants.TEMPLATED_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return(com.clubpenguin.world.rooms2024.fools.FoolsPartyConstants.TEMPLATED_RECEIVE_COMMAND_NAME);
        }
        function getReceiveCommandName() {
            return(com.clubpenguin.world.rooms2024.fools.FoolsPartyConstants.TEMPLATED_RECEIVE_COMMAND_NAME);
        }
        function set msg(_arg_2) {
            if (_arg_2 == undefined) {
                return;
            }
            _jsonObject.msg = _arg_2;
        }
        function get msg() {
            if (_jsonObject.msg == undefined) {
                return([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
            }
            return(_jsonObject.msg);
        }
		function set qcmsg(_arg_2) {
            if (_arg_2 == undefined) {
                return;
            }
            _jsonObject.qcmsg = _arg_2;
        }
        function get qcmsg() {
            if (_jsonObject.qcmsg == undefined) {
                return([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
            }
            return(_jsonObject.qcmsg);
        }
        function set trans(_arg_2) {
            if (_arg_2 == undefined) {
                return;
            }
            _jsonObject.trans = _arg_2;
        }
        function get trans() {
            if (_jsonObject.trans == undefined) {
                return([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
            }
            return(_jsonObject.trans);
        }
		function set task(_arg_2) {
            if (_arg_2 == undefined) {
                return;
            }
            _jsonObject.task = _arg_2;
        }
        function get task() {
            if (_jsonObject.task == undefined) {
                return([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
            }
            return(_jsonObject.task);
        }
    }