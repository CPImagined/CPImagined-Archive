﻿//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.TrackerAS2
    {
        static var singletonInstance;
        var _shell, currentContext;
        function TrackerAS2 () {
            trace("TrackerAS2()");
            if ((!_shell) && (_global.getCurrentShell())) {
                _shell = _global.getCurrentShell();
            } else {
                trace("\tERROR: _shell = " + _shell);
            }
            currentContext = "load.login";
        }
        static function getInstance() {
            trace("\tTrackerAS2.getInstance()");
            if (!singletonInstance) {
                singletonInstance = new com.clubpenguin.util.TrackerAS2();
            }
            return(singletonInstance);
        }
        function startTracker() {
            trace("\tTrackerAS2.startTracker()");
            _shell.startTracker();
        }
        function sendTrackingEvent(trackingKey, paramsJSONString) {
            trace("\tTrackerAS2.sendTrackingEvent()");
            _shell.sendTrackingEvent(trackingKey, paramsJSONString);
        }
        function sendToAS3StartAssetLoad(context) {
            currentContext = context;
            _shell.sendToAS3StartAssetLoad(context);
        }
        function sendToAS3EndAssetLoad(context, bytesTotal, path, result) {
            trace(("\tTrackerAS2.sendToAS3EndAssetLoad(" + context) + ")");
            _shell.sendToAS3EndAssetLoad(context, bytesTotal, path, result);
        }
        function sendToAS3StartSubContextAssetLoad(context, location) {
            recordStartTime(location);
            _shell.sendToAS3StartSubContextAssetLoad(context, location);
        }
        function sendToAS3EndSubContextAssetLoad(location, pathName) {
            trace(("\tTrackerAS2.sendToAS3EndSubContextAssetLoad(" + location) + ")");
            if (!pathName) {
                pathName = "";
            }
            var _local_3 = fetchElapsedTime(location);
            _shell.sendToAS3EndSubContextAssetLoad(location, pathName, _local_3);
        }
        function sendToAS3LogGameAction(context, action, itemName, payload) {
            _shell.sendToAS3LogGameAction(context, action, itemName, payload);
        }
        function sendTrackLoginError() {
            trace("\tTrackerAS2.sendTrackLoginError()");
            _shell.sendTrackLoginError();
        }
        function sendToAS3LogError(reason, context, message) {
            trace("\tTrackerAS2.sendToAS3LogError()");
            _shell.sendToAS3LogError(reason, context, message);
        }
        function sendToAS3LogMovieClipTimeout(reason, context, message) {
            trace("\tTrackerAS2.sendToAS3LogMovieClipTimeout()");
            _shell.sendToAS3LogMovieClipTimeout(reason, context, message);
        }
        function sendToAS3LogMovieClipLoadError(reason, context, fileURL, errorCode, httpStatus) {
            trace("\tTrackerAS2.sendToAS3LogMovieClipLoadError()");
            _shell.sendToAS3LogMovieClipLoadError(reason, context, fileURL, errorCode, httpStatus);
        }
        function sendToAS3LogMovieClipParamError(reason, context, fileURL, caller) {
            trace("\tTrackerAS2.sendToAS3LogMovieClipParamError()");
            _shell.sendToAS3LogMovieClipParamError(reason, context, fileURL, caller);
        }
        function sendWorldSelectedStartLog(world_id) {
            currentContext = "load.world";
            _shell.sendWorldSelectedStartLog(currentContext, world_id);
        }
        function trackUserInfo(transaction_id, isMember, player_id, city, state, country, zip) {
            var _local_2 = {};
            _local_2.type = USER_INFO;
            _local_2.transaction_id = transaction_id;
            _local_2.isMember = isMember;
            _local_2.player_id = player_id;
            _local_2.city = city;
            _local_2.state = state;
            _local_2.country = country;
            _local_2.zip = zip;
            _shell.sendPlaydomTracking(_local_2);
        }
        function trackTestImpression(test, variant, control, isMember) {
            trace("\tTrackerAS2.trackTestImpression()");
            var _local_2 = {};
            _local_2.type = TEST_IMPRESSION;
            _local_2.test = test;
            _local_2.variant = variant;
            _local_2.control = control;
            _local_2.isMember = isMember;
            _shell.sendPlaydomTracking(_local_2);
        }
        function trackStepTimingEvent(context, location, pathName, result) {
            var _local_2 = {};
            _local_2.type = STEP_TIMING;
            _local_2.context = context;
            _local_2.location = location;
            _local_2.path_name = pathName;
            _local_2.result = result;
            _shell.sendPlaydomTracking(_local_2);
        }
        function trackRewardEarned(currency, amount, maintype, subtype, balance, context, options) {
            if (amount == 0) {
                amount = 1;
            }
            var _local_2 = {};
            _local_2.type = MONEY;
            _local_2.amount = amount;
            _local_2.currency = currency;
            _local_2.maintype = maintype;
            _local_2.subtype = subtype;
            _local_2.balance = balance;
            _local_2.context = context;
            _local_2.options = options;
            _shell.sendPlaydomTracking(_local_2);
        }
        function trackGameAction(action, context, options) {
            var _local_2 = {};
            _local_2.type = GAME_ACTION;
            _local_2.action = action;
            _local_2.context = context;
            _local_2.options = options;
            _shell.sendPlaydomTracking(_local_2);
        }
        function trackPopup(tracking_code, step) {
            var _local_2 = {};
            _local_2.type = POPUP;
            _local_2.tracking_code = tracking_code;
            _local_2.step = step;
            _shell.sendPlaydomTracking(_local_2);
        }
        function recordStartTime(location) {
            if (_trackerStartTimes[location] != null) {
                trace(("\t\tERROR: _trackerStartTimes[" + location) + "] already exists");
            }
            _trackerStartTimes[location] = getTimer();
        }
        function fetchElapsedTime(location) {
            if (_trackerStartTimes[location] == null) {
                trace(("\t\tERROR: _trackerStartTimes[" + location) + "] does not exist");
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
