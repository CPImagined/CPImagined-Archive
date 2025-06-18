dynamic class com.clubpenguin.util.TrackerAS2
{
    static var ERROR: Number = 0;
    static var GAME_ACTION: Number = 1;
    static var PAGEVIEW: Number = 2;
    static var POPUP: Number = 3;
    static var LEVEL_UP: Number = 4;
    static var MONEY: Number = 5;
    static var STEP_TIMING: Number = 6;
    static var USER_STAT_CHANGE: Number = 7;
    static var SEND_MONEY: Number = 8;
    static var SEND_SOCIAL_ACTION: Number = 9;
    static var PERFORMANCE: Number = 10;
    static var SYSTEM: Number = 11;
    static var TEST_IMPRESSION: Number = 12;
    static var USER_INFO: Number = 13;
    static var CURRENCY_COINS: String = "coins";
    static var CURRENCY_MEDALS: String = "medals";
    static var CURRENCY_STAMPS: String = "stamps";
    static var CURRENCY_ITEMS: String = "items";
    var _trackerStartTimes = [];
    var _shell;
    var currentContext;

    function TrackerAS2()
    {
        if (!this._shell && _global.getCurrentShell()) 
        {
            this._shell = _global.getCurrentShell();
        }
        this.currentContext = "load.login";
    }

    static function getInstance()
    {
        if (!com.clubpenguin.util.TrackerAS2.singletonInstance) 
        {
            com.clubpenguin.util.TrackerAS2.singletonInstance = new com.clubpenguin.util.TrackerAS2();
        }
        return com.clubpenguin.util.TrackerAS2.singletonInstance;
    }

    function startTracker()
    {
        this._shell.startTracker();
    }

    function sendTrackingEvent(trackingKey, paramsJSONString)
    {
        this._shell.sendTrackingEvent(trackingKey, paramsJSONString);
    }

    function sendToAS3StartAssetLoad(context)
    {
        this.currentContext = context;
        this._shell.sendToAS3StartAssetLoad(context);
    }

    function sendToAS3EndAssetLoad(context, bytesTotal, path, result)
    {
        this._shell.sendToAS3EndAssetLoad(context, bytesTotal, path, result);
    }

    function sendToAS3StartSubContextAssetLoad(context, location)
    {
        this.recordStartTime(location);
        this._shell.sendToAS3StartSubContextAssetLoad(context, location);
    }

    function sendToAS3EndSubContextAssetLoad(location, pathName)
    {
        if (!pathName) 
        {
            pathName = "";
        }
        var __reg3 = this.fetchElapsedTime(location);
        location = location;
        this._shell.sendToAS3EndSubContextAssetLoad(location, pathName, __reg3);
    }

    function sendToAS3LogGameAction(context, action, itemName, payload)
    {
        this._shell.sendToAS3LogGameAction(context, action, itemName, payload);
    }

    function sendTrackLoginError()
    {
        this._shell.sendTrackLoginError();
    }

    function sendToAS3LogError(reason, context, message)
    {
        this._shell.sendToAS3LogError(reason, context, message);
    }

    function sendToAS3LogMovieClipTimeout(reason, context, message)
    {
        this._shell.sendToAS3LogMovieClipTimeout(reason, context, message);
    }

    function sendToAS3LogMovieClipLoadError(reason, context, fileURL, errorCode, httpStatus)
    {
        this._shell.sendToAS3LogMovieClipLoadError(reason, context, fileURL, errorCode, httpStatus);
    }

    function sendToAS3LogMovieClipParamError(reason, context, fileURL, caller)
    {
        this._shell.sendToAS3LogMovieClipParamError(reason, context, fileURL, caller);
    }

    function sendWorldSelectedStartLog(world_id)
    {
        this.currentContext = "load.world";
        this._shell.sendWorldSelectedStartLog(this.currentContext, world_id);
    }

    function trackUserInfo(transaction_id, isMember, player_id, city, state, country, zip)
    {
        var __reg2 = {};
        __reg2.type = com.clubpenguin.util.TrackerAS2.USER_INFO;
        __reg2.transaction_id = transaction_id;
        __reg2.isMember = isMember;
        __reg2.player_id = player_id;
        __reg2.city = city;
        __reg2.state = state;
        __reg2.country = country;
        __reg2.zip = zip;
        this._shell.sendPlaydomTracking(__reg2);
    }

    function trackTestImpression(test, variant, control)
    {
        var __reg2 = {};
        __reg2.type = com.clubpenguin.util.TrackerAS2.TEST_IMPRESSION;
        __reg2.test = test;
        __reg2.variant = variant;
        __reg2.control = control;
        this._shell.sendPlaydomTracking(__reg2);
    }

    function trackStepTimingEvent(context, location, pathName, result)
    {
        var __reg2 = {};
        __reg2.type = com.clubpenguin.util.TrackerAS2.STEP_TIMING;
        __reg2.context = context;
        __reg2.location = location;
        __reg2.path_name = pathName;
        __reg2.result = result;
        this._shell.sendPlaydomTracking(__reg2);
    }

    function trackRewardEarned(currency, amount, maintype, subtype, balance, context, options)
    {
        if (isNaN(amount)) 
        {
            return undefined;
        }
        if (amount == 0) 
        {
            amount = -1;
        }
        var __reg2 = {};
        __reg2.type = com.clubpenguin.util.TrackerAS2.MONEY;
        __reg2.amount = amount;
        __reg2.currency = currency;
        __reg2.maintype = maintype;
        __reg2.subtype = subtype;
        __reg2.balance = balance;
        __reg2.context = context;
        __reg2.options = options;
        this._shell.sendPlaydomTracking(__reg2);
    }

    function trackGameAction(action, context, options)
    {
        var __reg2 = {};
        __reg2.type = com.clubpenguin.util.TrackerAS2.GAME_ACTION;
        __reg2.action = action;
        __reg2.context = context;
        __reg2.options = options;
        this._shell.sendPlaydomTracking(__reg2);
    }

    function trackPopup(tracking_code, step)
    {
        var __reg2 = {};
        __reg2.type = com.clubpenguin.util.TrackerAS2.POPUP;
        __reg2.tracking_code = tracking_code;
        __reg2.step = step;
        this._shell.sendPlaydomTracking(__reg2);
    }

    function recordStartTime(location)
    {
        this._trackerStartTimes[location] == null;
        this._trackerStartTimes[location] = getTimer();
    }

    function fetchElapsedTime(location)
    {
        this._trackerStartTimes[location] != null;
        var __reg4 = this._trackerStartTimes[location];
        var __reg3 = getTimer();
        var __reg5 = __reg3 - __reg4;
        this._trackerStartTimes[location] = null;
        return __reg5;
    }

}
