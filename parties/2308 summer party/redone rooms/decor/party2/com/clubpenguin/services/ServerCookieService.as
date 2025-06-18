//Created by Action Script Viewer - https://www.buraks.com/asv
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
        function registerCookieVO(cookieId, cookieVO) {
            if (_cookies[cookieId] != null) {
                return(false);
            }
            _cookies[cookieId] = cookieVO;
            if (_airtowerListeners[cookieVO.getReceiveCommandName()] != true) {
                _airtowerListeners[cookieVO.getReceiveCommandName()] = true;
                _airtower.addListener(cookieVO.getReceiveCommandName(), com.clubpenguin.util.Delegate.create(this, onServerCookieReceived), this);
            }
            return(true);
        }
        function getCookieVO(cookieId) {
            return(_cookies[cookieId]);
        }
        function requestCookieFromServer(cookieId) {
            var _local_2 = getCookieVO(cookieId);
            if (_local_2 != null) {
                _airtower.send(_airtower.PLAY_EXT, (_local_2.getCookieHandlerName() + "#") + _local_2.getReceiveCommandName(), [cookieId], "str", _shell.getCurrentServerRoomId());
            }
        }
        function sendCookieToServer(cookieId) {
            var _local_2 = getCookieVO(cookieId);
            if (_local_2 != null) {
                _airtower.send(_airtower.PLAY_EXT, (_local_2.getCookieHandlerName() + "#") + _local_2.getSendCommandName(), [cookieId, _local_2.serialize()], "str", _shell.getCurrentServerRoomId());
            }
        }
        function onServerCookieReceived(data) {
            var _local_6 = data[0];
            var _local_3 = data[1];
            var _local_4 = data[2];
            var _local_2 = _cookies[_local_3];
            if (_local_2 != null) {
                _local_2.deserialize(_local_4);
            }
        }
        function removeAirtowerListeners() {
            for (var _local_2 in _airtowerListeners) {
                _airtower.removeListener(_local_2, onServerCookieReceived);
            }
        }
    }
