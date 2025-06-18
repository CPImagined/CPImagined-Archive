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
                _airtower.addListener(cookieVO.getReceiveCommandName(), com.clubpenguin.util.Delegate.create(this, onServerCookieReceived, cookieId), this);
            }
            return(true);
        }
        function getCookieVO(cookieId) {
            return(_cookies[cookieId]);
        }
        function requestCookieFromServer(cookieId) {
            var cookie = getCookieVO(cookieId);
            if (cookie != null) {
                _airtower.send(_airtower.PLAY_EXT, (cookie.getCookieHandlerName() + "#") + cookie.getReceiveCommandName(), [], "str", _shell.getCurrentServerRoomId());
            }
        }
        function sendCookieToServer(cookieId) {
            var cookie = getCookieVO(cookieId);
            if (cookie != null) {
                _airtower.send(_airtower.PLAY_EXT, (cookie.getCookieHandlerName() + "#") + cookie.getSendCommandName(), [cookie.serialize()], "str", _shell.getCurrentServerRoomId());
            }
        }
        function onServerCookieReceived(data, cookieId) {
            var smart_room_id = data[0];
            var cookieData = data[1];
            var cookie = _cookies[cookieId];
            if (cookie != null) {
                cookie.deserialize(cookieData);
            }
        }
        function removeAirtowerListeners() {
            for (var key in _airtowerListeners) {
                _airtower.removeListener(key, onServerCookieReceived);
            }
        }
    }
