
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.services.ServerCookieService
    {
        var _airtowerListeners, _airtower, _shell, _cookies;
        function ServerCookieService () {
            init();
        }
        function init() {
            _airtowerListeners = {};
            if (_airtower != null) {
                removeAirtowerListeners();
            }
            _airtower = _global.getCurrentAirtower();
            _shell = _global.getCurrentShell();
            _cookies = {};
        }
        function registerCookieVO(_arg_3, _arg_2) {
            if (_cookies[_arg_3] != null) {
                return(false);
            }
            _cookies[_arg_3] = _arg_2;
            if (_airtowerListeners[_arg_2.getReceiveCommandName()] != true) {
                _airtowerListeners[_arg_2.getReceiveCommandName()] = true;
                _airtower.addListener(_arg_2.getReceiveCommandName(), com.clubpenguin.util.Delegate.create(this, onServerCookieReceived, _arg_3), this);
            }
            return(true);
        }
        function getCookieVO(_arg_2) {
            return(_cookies[_arg_2]);
        }
        function requestCookieFromServer(_arg_3) {
            var _local_2 = getCookieVO(_arg_3);
            if (_local_2 != null) {
                _airtower.send(_airtower.PLAY_EXT, (_local_2.getCookieHandlerName() + "#") + _local_2.getReceiveCommandName(), [], "str", _shell.getCurrentServerRoomId());
            }
        }
        function sendCookieToServer(_arg_3) {
            var _local_2 = getCookieVO(_arg_3);
            if (_local_2 != null) {
                _airtower.send(_airtower.PLAY_EXT, (_local_2.getCookieHandlerName() + "#") + _local_2.getSendCommandName(), [_local_2.serialize()], "str", _shell.getCurrentServerRoomId());
            }
        }
        function onServerCookieReceived(_arg_5, _arg_6) {
            var _local_4 = _arg_5[0];
            var _local_3 = _arg_5[1];
            var _local_2 = _cookies[_arg_6];
            if (_local_2 != null) {
                _local_2.deserialize(_local_3);
            }
        }
        function removeAirtowerListeners() {
            for (var _local_2 in _airtowerListeners) {
                _airtower.removeListener(_local_2, onServerCookieReceived);
            }
        }
    }
