class com.clubpenguin.util.TrackerAS2
{
    var _shell, currentContext;
    static var singletonInstance;
    function TrackerAS2()
    {
        if (!_shell && _global.getCurrentShell())
        {
            _shell = _global.getCurrentShell();
            
        } // end if
        currentContext = "load.login";
    } // End of the function
    static function getInstance()
    {
        if (!com.clubpenguin.util.TrackerAS2.singletonInstance)
        {
            singletonInstance = new com.clubpenguin.util.TrackerAS2();
        } // end if
        return (com.clubpenguin.util.TrackerAS2.singletonInstance);
    } // End of the function
    function startTracker()
    {
        _shell.startTracker();
    } // End of the function
    function sendTrackingEvent(trackingKey, paramsJSONString)
    {
        _shell.sendTrackingEvent(trackingKey, paramsJSONString);
    } // End of the function
    function sendToAS3StartAssetLoad(context)
    {
        currentContext = context;
        _shell.sendToAS3StartAssetLoad(context);
    } // End of the function
    function sendToAS3EndAssetLoad(context, bytesTotal, path, result)
    {
    } // End of the function
    function sendToAS3StartSubContextAssetLoad(context, location)
    {
        this.recordStartTime(location);
    } // End of the function
    function sendToAS3EndSubContextAssetLoad(location, pathName)
    {
        if (!pathName)
        {
            pathName = "";
        } // end if
        var _loc3 = this.fetchElapsedTime(location);
        location = location;
    } // End of the function
    function sendToAS3LogGameAction(context, action, itemName, payload)
    {
    } // End of the function
    function sendTrackLoginError()
    {
    } // End of the function
    function sendToAS3LogError(reason, context, message)
    {
    } // End of the function
    function sendToAS3LogMovieClipTimeout(reason, context, message)
    {
    } // End of the function
    function sendToAS3LogMovieClipLoadError(reason, context, fileURL, errorCode, httpStatus)
    {
    } // End of the function
    function sendToAS3LogMovieClipParamError(reason, context, fileURL, caller)
    {
    } // End of the function
    function sendWorldSelectedStartLog(world_id)
    {
        currentContext = "load.world";
        _shell.sendWorldSelectedStartLog(currentContext, world_id);
    } // End of the function
    function trackUserInfo(transaction_id, isMember, player_id, city, state, country, zip)
    {
    } // End of the function
    function trackTestImpression(test, variant, control)
    {
    } // End of the function
    function trackStepTimingEvent(context, location, pathName, result)
    {
    } // End of the function
    function trackRewardEarned(currency, amount, maintype, subtype, balance, context, options)
    {
    } // End of the function
    function trackGameAction(action, context, options)
    {
    } // End of the function
    function trackPopup(tracking_code, step)
    {
    } // End of the function
    function recordStartTime(location)
    {
        if (_trackerStartTimes[location] != null)
        {
        } // end if
        _trackerStartTimes[location] = getTimer();
    } // End of the function
    function fetchElapsedTime(location)
    {
        if (_trackerStartTimes[location] == null)
        {
        } // end if
        var _loc4 = _trackerStartTimes[location];
        var _loc3 = getTimer();
        var _loc5 = _loc3 - _loc4;
        _trackerStartTimes[location] = null;
        return (_loc5);
    } // End of the function
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
} // End of Class
