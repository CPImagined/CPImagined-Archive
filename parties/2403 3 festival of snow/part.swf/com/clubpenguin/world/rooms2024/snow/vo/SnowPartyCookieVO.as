﻿
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.world.rooms2024.snow.vo.SnowPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var _jsonObject;
        function SnowPartyCookieVO() {
            super();
        }
        function getCookieHandlerName() {
            return(com.clubpenguin.world.rooms2024.snow.SnowPartyConstants.TEMPLATED_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return(com.clubpenguin.world.rooms2024.snow.SnowPartyConstants.TEMPLATED_RECEIVE_COMMAND_NAME);
        }
        function getReceiveCommandName() {
            return(com.clubpenguin.world.rooms2024.snow.SnowPartyConstants.TEMPLATED_RECEIVE_COMMAND_NAME);
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
    }