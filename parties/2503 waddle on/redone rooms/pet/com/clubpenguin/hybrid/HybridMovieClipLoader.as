//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hybrid.HybridMovieClipLoader extends mx.events.EventDispatcher
    {
        var _movieClipLoader, _movieClipLoaderListener, dispatchEvent, _container, _url, _startTime, _loadProgressCheckInterval, lastUpdate, _timeElapsed, _latencyDelegate, _latencyInterval, isNearlyLoadedShown;
        function HybridMovieClipLoader (completeParams) {
            super();
            _movieClipLoader = new MovieClipLoader();
            _movieClipLoaderListener = new Object();
            _movieClipLoaderListener.onLoadStart = com.clubpenguin.util.Delegate.create(this, onMovieClipLoadStart);
            _movieClipLoaderListener.onLoadComplete = com.clubpenguin.util.Delegate.create(this, onMovieClipLoadComplete);
            _movieClipLoaderListener.onLoadError = com.clubpenguin.util.Delegate.create(this, onMovieClipLoadError);
            _movieClipLoaderListener.onLoadProgress = com.clubpenguin.util.Delegate.create(this, onMovieClipLoadProgress);
            _movieClipLoaderListener.onLoadInit = com.clubpenguin.util.Delegate.create(this, onMovieClipLoadInit);
            var _local_3 = _movieClipLoader.addListener(_movieClipLoaderListener);
        }
        function setCompleteParams(_arg_2) {
            _completeParams = ((_arg_2 != undefined) ? (_arg_2) : ({}));
        }
        function loadClip(_arg_2, _arg_9, _arg_7, _arg_4) {
            if ((_arg_2 == undefined) || (_arg_2.indexOf("undefined") >= 0)) {
                logParamError("LoadError", _arg_7);
                dispatchEvent({target:_container, type:EVENT_ON_LOAD_ERROR, errorCode:"undefined url from " + _arg_7});
            } else {
                if ((_arg_4 == undefined) || (_arg_4 == true)) {
                    var _local_3 = searchURLforCacheVersion(_arg_2);
                    _url = _arg_2 + _local_3;
                } else {
                    _url = _arg_2;
                }
                _container = _arg_9;
                _startTime = getTimer();
                _movieClipLoader.loadClip(_url, _container);
                clearInterval(_loadProgressCheckInterval);
                _loadProgressCheckInterval = setInterval(this, "checkLoadProgress", INTERVAL_RATE);
                lastUpdate = getTimer();
            }
        }
        function searchURLforCacheVersion(_arg_4) {
            var _local_2 = _arg_4.split("v2/", 2);
            if ((_local_2 != null) && (_local_2.length > 1)) {
                var _local_3 = _local_2[1].split("/", 2);
                switch (_local_3[0]) {
                    case "content" : 
                        return(_global.getCurrentShell()._localLoginServerData.getContentCacheVersion());
                    case "client" : 
                        return(_global.getCurrentShell()._localLoginServerData.getClientCacheVersion());
                    case "games" : 
                        return(_global.getCurrentShell()._localLoginServerData.getGameCacheVersion());
                    case "config" : 
                        return(_global.getCurrentShell()._localLoginServerData.getConfigCacheVersion());
                }
                return("");
            }
            return("");
        }
        function unloadClip(_arg_2) {
            return(_movieClipLoader.unloadClip(_arg_2));
        }
        function checkLoadProgress() {
            _timeElapsed = getTimer() - _startTime;
            if (_container.getBytesLoaded() == undefined) {
                clearInterval(_loadProgressCheckInterval);
                return(undefined);
            }
            if ((_container.getBytesTotal() < 0) && (_timeElapsed >= TIME_OUT_THRESHOLD)) {
                clearInterval(_loadProgressCheckInterval);
                logLoadTimeout("HybridLoader TimedOut");
                dispatchEvent({target:_container, type:EVENT_ON_LOAD_ERROR, errorCode:"ERROR: HybridMovieClipLoader timed out loading " + _url});
                return(undefined);
            }
            if ((_container.getBytesLoaded() == _container.getBytesTotal()) && (_container.getBytesTotal() > MIN_BYTES)) {
                clearInterval(_loadProgressCheckInterval);
                dispatchEvent({target:_container, type:EVENT_ON_LOAD_COMPLETE});
                _latencyDelegate = com.clubpenguin.util.Delegate.create(this, onAS2MovieClipReady);
                _container.onEnterFrame = _latencyDelegate;
            } else {
                dispatchEvent({target:_container, type:EVENT_ON_LOAD_PROGRESS, bytesLoaded:_container.getBytesLoaded(), bytesTotal:_container.getBytesTotal()});
            }
        }
        function onAS2MovieClipUnload() {
            clearInterval(_latencyInterval);
            clearInterval(_loadProgressCheckInterval);
            dispatchEvent({target:_container, type:EVENT_ON_UNLOAD});
        }
        function onAS2MovieClipReady() {
            clearInterval(_latencyInterval);
            clearInterval(_loadProgressCheckInterval);
            _timeElapsed = getTimer() - _startTime;
            delete _container.onEnterFrame;
            _latencyDelegate = null;
            dispatchEvent({target:_container, type:EVENT_ON_LOAD_INIT});
        }
        function onMovieClipLoadStart() {
            clearInterval(_latencyInterval);
            clearInterval(_loadProgressCheckInterval);
            dispatchEvent({target:_container, type:EVENT_ON_LOAD_START});
        }
        function onMovieClipLoadComplete(_arg_2, httpStatus) {
            clearInterval(_latencyInterval);
            clearInterval(_loadProgressCheckInterval);
            dispatchEvent({target:_arg_2, loader:this, type:EVENT_ON_LOAD_COMPLETE});
        }
        function onMovieClipLoadInit(_arg_2) {
            clearInterval(_latencyInterval);
            clearInterval(_loadProgressCheckInterval);
            _movieClipLoader.removeListener(_movieClipLoaderListener);
            dispatchEvent({target:_container, type:EVENT_ON_LOAD_INIT, completeParams:_completeParams, url:_url});
        }
        function onMovieClipLoadProgress(_arg_3, _arg_4, _arg_2) {
            clearInterval(_latencyInterval);
            clearInterval(_loadProgressCheckInterval);
            if (_arg_2 > 0) {
                if (((_arg_4 / _arg_2) >= 0.95) && (!isNearlyLoadedShown)) {
                    isNearlyLoadedShown = true;
                    dispatchEvent({target:_container, type:EVENT_ON_LOAD_PROGRESS, bytesLoaded:_arg_4, bytesTotal:_arg_2});
                    lastUpdate = getTimer();
                } else if ((getTimer() - lastUpdate) >= PROGRESS_THROTTLE_INTERVAL) {
                    dispatchEvent({target:_container, type:EVENT_ON_LOAD_PROGRESS, bytesLoaded:_arg_4, bytesTotal:_arg_2});
                    lastUpdate = getTimer();
                }
            }
        }
        function onMovieClipLoadError(_arg_3, _arg_4, _arg_2) {
            clearInterval(_latencyInterval);
            clearInterval(_loadProgressCheckInterval);
            logLoadError("LoadError", _arg_4, _arg_2);
            dispatchEvent({target:_container, type:EVENT_ON_LOAD_ERROR, errorCode:_arg_4, httpStatus:_arg_2});
        }
        function logLoadError(_arg_3, _arg_4, _arg_5) {
            if (_global.getCurrentShell()) {
                com.clubpenguin.util.TrackerAS2.getInstance().sendToAS3LogMovieClipLoadError(_arg_3, _trackerReason, _url, _arg_4, _arg_5);
            }
        }
        function logLoadTimeout(_arg_3) {
            if (_global.getCurrentShell()) {
                com.clubpenguin.util.TrackerAS2.getInstance().sendToAS3LogMovieClipTimeout(_arg_3, _trackerReason, _url);
            }
        }
        function logParamError(_arg_3, _arg_4) {
            if (_global.getCurrentShell()) {
                com.clubpenguin.util.TrackerAS2.getInstance().sendToAS3LogMovieClipParamError(_arg_3, _trackerReason, _url, _arg_4);
            }
        }
        static var EVENT_ON_LOAD_START = "onLoadStart";
        static var EVENT_ON_LOAD_ERROR = "onLoadError";
        static var EVENT_ON_LOAD_COMPLETE = "onLoadComplete";
        static var EVENT_ON_LOAD_INIT = "onLoadInit";
        static var EVENT_ON_LOAD_PROGRESS = "onLoadProgress";
        static var EVENT_ON_UNLOAD = "onUnload";
        static var INTERVAL_RATE = 40;
        static var TIME_OUT_THRESHOLD = 180000;
        static var MIN_BYTES = 4;
        static var PROGRESS_THROTTLE_INTERVAL = 140;
        var _noByteDataTimeout = 0;
        var _trackerReason = "MovieClipLoading";
        var _completeParams = null;
        var cacheVersion = null;
    }
