//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.login.views.ViewManager extends com.clubpenguin.ui.views.AbstractViewManager
    {
        var _shell, _languageAbbreviation, _views, getView, onManualLoginDelegate, addView;
        function ViewManager (mc) {
            super(mc);
            debugTrace("View manager instantiated - mc:" + mc);
        }
        function set shell(target) {
            _shell = target;
            //return(shell);
        }
        function get shell() {
            return(_shell);
        }
        function initialize() {
            if (_shell == null) {
                debugTrace("initialize() - Shell not injected into ViewManager");
            }
            initViews();
            showInitialView();
        }
        function setLanguageAbbreviation(abbr) {
            _languageAbbreviation = abbr;
        }
        function getRedemptionStatus() {
            return(_redemptionActive);
        }
        function setRedemptionStatus(status) {
            _redemptionActive = status;
            _shell.redemptionActive = status;
        }
        function hideAllWindows() {
            for (var _local_2 in _views) {
                _views[_local_2].hide();
            }
        }
        function gotoStart() {
            hideAllWindows();
            _shell.sendSetSwfAddress("start");
            _shell.closeSwfBridge();
        }
        function gotoPlayerSelection() {
            debugTrace("-> gotoPlayerSelection");
            hideAllWindows();
            var _local_2 = com.clubpenguin.login.views.PlayerSelection(getView(com.clubpenguin.login.views.PlayerSelection));
            _local_2.setupPlayerSelection();
            _local_2.setLanguageAbbr(_languageAbbreviation);
            _local_2.show();
        }
        function gotoPlayerLogin(obj) {
            debugTrace("-> gotoPlayerLogin");
            hideAllWindows();
            var _local_2 = com.clubpenguin.login.views.PlayerLogin(getView(com.clubpenguin.login.views.PlayerLogin));
            _local_2.setup(obj);
            _local_2.show();
        }
        function gotoWorldSelection() {
            debugTrace("-> gotoWorldSelection");
            hideAllWindows();
            var _local_2 = com.clubpenguin.login.views.WorldSelection(getView(com.clubpenguin.login.views.WorldSelection));
            _local_2.setupWorldSelection();
            _local_2.show();
        }
        function gotoMoreServers() {
            debugTrace("-> gotoMoreServers");
            hideAllWindows();
            var _local_2 = com.clubpenguin.login.views.MoreServers(getView(com.clubpenguin.login.views.MoreServers));
            _local_2.show();
            if (!moreServersTracked) {
                _shell.trackContent("moreServers");
                moreServersTracked = true;
            }
        }
        function gotoNewPlayer() {
            debugTrace("-> gotoNewPlayer");
            hideAllWindows();
            var _local_2 = com.clubpenguin.login.views.NewPlayer(getView(com.clubpenguin.login.views.NewPlayer));
            _local_2.setup({});
            _local_2.show();
        }
        function gotoCreatePenguin() {
            debugTrace("-> gotoCreatePenguin");
            hideAllWindows();
            _shell.sendSetSwfAddress("create");
            _shell.closeSwfBridge();
        }
        function gotoLogin() {
            hideAllWindows();
            _shell.sendSetSwfAddress("login");
        }
        function isMoreServersActive() {
            var _local_2 = com.clubpenguin.login.views.MoreServers(getView(com.clubpenguin.login.views.MoreServers));
            return(_local_2.isActive());
        }
        function showInitialView(loginShow) {
            var _local_4 = _global.com.clubpenguin.login.LocalData;
            if (_shell._localLoginServerData.autoLogin) {
                onManualLoginDelegate = com.clubpenguin.util.Delegate.create(this, gotoNewPlayer);
                _shell.setManualLoginCallback(onManualLoginDelegate);
                var _local_3 = {};
                _local_3.Username = _shell._localLoginServerData.nau.toLowerCase();
                com.clubpenguin.login.LocalData.setLoginPlayerObjectToSave(_local_3);
                com.clubpenguin.login.LocalData.saveNicknameToCookie(_local_3.Username);
                _shell.doAutoLogin();
            } else {
                _shell.hideLoading();
                if (_local_4.getSavedPlayers().length > 0) {
                    gotoPlayerSelection();
                } else {
                    gotoNewPlayer();
                }
            }
        }
        function initViews() {
            debugTrace("initViews");
            var _local_2;
            _local_2 = addView(com.clubpenguin.login.views.NewPlayer);
            _local_2.setLanguageAbbr(_languageAbbreviation);
            _local_2.setShell(_shell);
            var _local_4 = com.clubpenguin.login.views.NewPlayer(_local_2);
            _local_4._x = NEWPLAYER_X;
            _local_4._y = NEWPLAYER_Y;
            _local_2 = addView(com.clubpenguin.login.views.PlayerSelection);
            _local_2.setLanguageAbbr(_languageAbbreviation);
            _local_2.setShell(_shell);
            _local_2 = addView(com.clubpenguin.login.views.PlayerLogin);
            _local_2.setLanguageAbbr(_languageAbbreviation);
            _local_2.setShell(_shell);
            var _local_3 = com.clubpenguin.login.views.PlayerLogin(_local_2);
            _local_3._x = PLAYERLOGIN_X;
            _local_3._y = PLAYERLOGIN_Y;
            _local_2 = addView(com.clubpenguin.login.views.WorldSelection);
            _local_2.setLanguageAbbr(_languageAbbreviation);
            _local_2.setShell(_shell);
            _local_2 = addView(com.clubpenguin.login.views.MoreServers);
            _local_2.setLanguageAbbr(_languageAbbreviation);
            _local_2.setShell(_shell);
            var _local_5 = com.clubpenguin.login.views.MoreServers(_local_2);
            _local_5._x = MORESERVERS_X;
            _local_5._y = MORESERVERS_Y;
        }
        function getQueryParams(queryString) {
            if (flash.external.ExternalInterface.available == false) {
                return(undefined);
            }
            if (queryString) {
                var _local_7 = {};
                var _local_6 = queryString.split("&");
                var _local_3 = 0;
                var _local_2 = -1;
                while (_local_3 < _local_6.length) {
                    var _local_1 = _local_6[_local_3];
                    _local_2 = _local_1.indexOf("=");
                    if (_local_2 > 0) {
                        var _local_4 = _local_1.substring(0, _local_2);
                        _local_4.toLowerCase();
                        var _local_5 = _local_1.substring(_local_2 + 1);
                        _local_7[_local_4] = _local_5;
                    }
                    _local_3++;
                }
                return(_local_7);
            }
        }
        static function debugTrace(msg) {
            if (_debugTracesActive) {
            }
        }
        static var NEWPLAYER_X = 129;
        static var NEWPLAYER_Y = 90;
        static var PLAYERLOGIN_X = 118;
        static var PLAYERLOGIN_Y = 47;
        static var MORESERVERS_X = 54;
        static var MORESERVERS_Y = 18;
        static var _debugTracesActive = true;
        var _redemptionActive = false;
        var moreServersTracked = false;
        var __propInterval = null;
    }
