//Created by Action Script Viewer - https://www.buraks.com/asv
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
        function sendTrackingEvent(trackingKey, paramsJSONString) {
            _shell.sendTrackingEvent(trackingKey, paramsJSONString);
        }
        function sendToAS3StartAssetLoad(context) {
            currentContext = context;
            _shell.sendToAS3StartAssetLoad(context);
        }
        function sendToAS3EndAssetLoad(context, bytesTotal, path, result) {
        }
        function sendToAS3StartSubContextAssetLoad(context, location) {
            recordStartTime(location);
        }
        function sendToAS3EndSubContextAssetLoad(location, pathName) {
            if (!pathName) {
                pathName = "";
            }
            var _local_3 = fetchElapsedTime(location);
        }
        function sendToAS3LogGameAction(context, action, itemName, payload) {
        }
        function sendTrackLoginError() {
        }
        function sendToAS3LogError(reason, context, message) {
        }
        function sendToAS3LogMovieClipTimeout(reason, context, message) {
        }
        function sendToAS3LogMovieClipLoadError(reason, context, fileURL, errorCode, httpStatus) {
        }
        function sendToAS3LogMovieClipParamError(reason, context, fileURL, caller) {
        }
        function sendWorldSelectedStartLog(world_id) {
            currentContext = "load.world";
            _shell.sendWorldSelectedStartLog(currentContext, world_id);
        }
        function trackUserInfo(transaction_id, isMember, player_id, city, state, country, zip) {
        }
        function trackTestImpression(test, variant, control) {
        }
        function trackStepTimingEvent(context, location, pathName, result) {
        }
        function trackRewardEarned(currency, amount, maintype, subtype, balance, context, options) {
        }
        function trackGameAction(action, context, options) {
        }
        function trackPopup(tracking_code, step) {
        }
        function recordStartTime(location) {
            if (_trackerStartTimes[location] != null) {
            }
            _trackerStartTimes[location] = getTimer();
        }
        function fetchElapsedTime(location) {
            if (_trackerStartTimes[location] == null) {
            }
            var _local_4 = _trackerStartTimes[location];
            var _local_3 = getTimer();
            var _local_5 = _local_3 - _local_4;
            _trackerStartTimes[location] = null;
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
