
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.util.TrackerAS2
    {
        static var singletonInstance;
        var _shell, currentContext;
        function TrackerAS2 () {
            if ((!_shell) && (_global.getCurrentShell())) {
                _shell = _global.getCurrentShell();
            }
            currentContext = "load.login";
        }
        static function getInstance() {
            if (!singletonInstance) {
                singletonInstance = new com.clubpenguin.util.TrackerAS2();
            }
            return(singletonInstance);
        }
        function startTracker() {
            _shell.startTracker();
        }
        function sendTrackingEvent(_arg_3, _arg_2) {
            _shell.sendTrackingEvent(_arg_3, _arg_2);
        }
        function sendToAS3StartAssetLoad(_arg_2) {
            currentContext = _arg_2;
            _shell.sendToAS3StartAssetLoad(_arg_2);
        }
        function sendToAS3EndAssetLoad(_arg_2, _arg_3, _arg_5, _arg_4) {
            _shell.sendToAS3EndAssetLoad(_arg_2, _arg_3, _arg_5, _arg_4);
        }
        function sendToAS3StartSubContextAssetLoad(_arg_3, _arg_2) {
            recordStartTime(_arg_2);
            _shell.sendToAS3StartSubContextAssetLoad(_arg_3, _arg_2);
        }
        function sendToAS3EndSubContextAssetLoad(_arg_2, _arg_4) {
            if (!_arg_4) {
                _arg_4 = "";
            }
            var _local_3 = fetchElapsedTime(_arg_2);
            _shell.sendToAS3EndSubContextAssetLoad(_arg_2, _arg_4, _local_3);
        }
        function sendToAS3LogGameAction(_arg_2, _arg_3, _arg_5, _arg_4) {
            _shell.sendToAS3LogGameAction(_arg_2, _arg_3, _arg_5, _arg_4);
        }
        function sendTrackLoginError() {
            _shell.sendTrackLoginError();
        }
        function sendToAS3LogError(_arg_3, _arg_4, _arg_2) {
            _shell.sendToAS3LogError(_arg_3, _arg_4, _arg_2);
        }
        function sendToAS3LogMovieClipTimeout(_arg_3, _arg_4, _arg_2) {
            _shell.sendToAS3LogMovieClipTimeout(_arg_3, _arg_4, _arg_2);
        }
        function sendToAS3LogMovieClipLoadError(_arg_4, _arg_5, _arg_2, _arg_6, _arg_3) {
            _shell.sendToAS3LogMovieClipLoadError(_arg_4, _arg_5, _arg_2, _arg_6, _arg_3);
        }
        function sendToAS3LogMovieClipParamError(_arg_3, _arg_5, _arg_2, _arg_4) {
            _shell.sendToAS3LogMovieClipParamError(_arg_3, _arg_5, _arg_2, _arg_4);
        }
        function sendWorldSelectedStartLog(_arg_2) {
            currentContext = "load.world";
            _shell.sendWorldSelectedStartLog(currentContext, _arg_2);
        }
        function trackUserInfo(_arg_9, _arg_3, _arg_4, _arg_7, _arg_8, _arg_5, _arg_6) {
            var _local_2 = {};
            _local_2.type = USER_INFO;
            _local_2.transaction_id = _arg_9;
            _local_2.isMember = _arg_3;
            _local_2.player_id = _arg_4;
            _local_2.city = _arg_7;
            _local_2.state = _arg_8;
            _local_2.country = _arg_5;
            _local_2.zip = _arg_6;
            _shell.sendPlaydomTracking(_local_2);
        }
        function trackTestImpression(_arg_4, _arg_3, _arg_5) {
            var _local_2 = {};
            _local_2.type = TEST_IMPRESSION;
            _local_2.test = _arg_4;
            _local_2.variant = _arg_3;
            _local_2.control = _arg_5;
            _shell.sendPlaydomTracking(_local_2);
        }
        function trackStepTimingEvent(_arg_5, _arg_4, _arg_6, _arg_3) {
            var _local_2 = {};
            _local_2.type = STEP_TIMING;
            _local_2.context = _arg_5;
            _local_2.location = _arg_4;
            _local_2.path_name = _arg_6;
            _local_2.result = _arg_3;
            _shell.sendPlaydomTracking(_local_2);
        }
        function trackRewardEarned(_arg_5, _arg_3, _arg_4, _arg_6, _arg_8, _arg_7, _arg_9) {
            if (_arg_3 == 0) {
                _arg_3 = -1;
            }
            var _local_2 = {};
            _local_2.type = MONEY;
            _local_2.amount = _arg_3;
            _local_2.currency = _arg_5;
            _local_2.maintype = _arg_4;
            _local_2.subtype = _arg_6;
            _local_2.balance = _arg_8;
            _local_2.context = _arg_7;
            _local_2.options = _arg_9;
            _shell.sendPlaydomTracking(_local_2);
        }
        function trackGameAction(_arg_4, _arg_3, _arg_5) {
            var _local_2 = {};
            _local_2.type = GAME_ACTION;
            _local_2.action = _arg_4;
            _local_2.context = _arg_3;
            _local_2.options = _arg_5;
            _shell.sendPlaydomTracking(_local_2);
        }
        function trackPopup(_arg_3, _arg_4) {
            var _local_2 = {};
            _local_2.type = POPUP;
            _local_2.tracking_code = _arg_3;
            _local_2.step = _arg_4;
            _shell.sendPlaydomTracking(_local_2);
        }
        function recordStartTime(_arg_2) {
            if (_trackerStartTimes[_arg_2] != null) {
            }
            _trackerStartTimes[_arg_2] = getTimer();
        }
        function fetchElapsedTime(_arg_2) {
            if (_trackerStartTimes[_arg_2] == null) {
            }
            var _local_4 = _trackerStartTimes[_arg_2];
            var _local_3 = getTimer();
            var _local_5 = _local_3 - _local_4;
            _trackerStartTimes[_arg_2] = null;
            return(_local_5);
        }
        static var ERROR = 0;
        static var GAME_ACTION = 1;
        static var PAGEVIEW = 2;
        static var POPUP = 3;
        static var LEVEL_UP = 4;
        static var MONEY = 5;
        static var STEP_TIMING = 6;
        static var USER_STAT_CHANGE = 7;
        static var SEND_MONEY = 8;
        static var SEND_SOCIAL_ACTION = 9;
        static var PERFORMANCE = 10;
        static var SYSTEM = 11;
        static var TEST_IMPRESSION = 12;
        static var USER_INFO = 13;
        static var CURRENCY_COINS = "coins";
        static var CURRENCY_MEDALS = "medals";
        static var CURRENCY_STAMPS = "stamps";
        static var CURRENCY_ITEMS = "items";
        var _trackerStartTimes = [];
    }
