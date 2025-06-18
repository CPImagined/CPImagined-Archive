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
        function setCompleteParams(completeParams) {
            _completeParams = ((completeParams != undefined) ? (completeParams) : ({}));
        }
        function loadClip(url, container, callerName, isCDNCache) {
            if ((url == undefined) || (url.indexOf("undefined") >= 0)) {
                logParamError("LoadError", callerName);
                dispatchEvent({target:_container, type:EVENT_ON_LOAD_ERROR, errorCode:"undefined url from " + callerName});
            } else {
                if ((isCDNCache == undefined) || (isCDNCache == true)) {
                    var _local_3 = searchURLforCacheVersion(url);
                    _url = url + _local_3;
                } else {
                    _url = url;
                }
                _container = container;
                _startTime = getTimer();
                _movieClipLoader.loadClip(_url, _container);
                clearInterval(_loadProgressCheckInterval);
                _loadProgressCheckInterval = setInterval(this, "checkLoadProgress", INTERVAL_RATE);
                lastUpdate = getTimer();
            }
        }
        function searchURLforCacheVersion(urlS) {
            var _local_2 = urlS.split("v2/", 2);
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
        function unloadClip(target) {
            return(_movieClipLoader.unloadClip(target));
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
        function onMovieClipLoadComplete(target, httpStatus) {
            clearInterval(_latencyInterval);
            clearInterval(_loadProgressCheckInterval);
            dispatchEvent({target:target, loader:this, type:EVENT_ON_LOAD_COMPLETE});
        }
        function onMovieClipLoadInit(target) {
            clearInterval(_latencyInterval);
            clearInterval(_loadProgressCheckInterval);
            _movieClipLoader.removeListener(_movieClipLoaderListener);
            dispatchEvent({target:_container, type:EVENT_ON_LOAD_INIT, completeParams:_completeParams, url:_url});
        }
        function onMovieClipLoadProgress(target, bytesLoaded, bytesTotal) {
            clearInterval(_latencyInterval);
            clearInterval(_loadProgressCheckInterval);
            if (bytesTotal > 0) {
                if (((bytesLoaded / bytesTotal) >= 0.95) && (!isNearlyLoadedShown)) {
                    isNearlyLoadedShown = true;
                    dispatchEvent({target:_container, type:EVENT_ON_LOAD_PROGRESS, bytesLoaded:bytesLoaded, bytesTotal:bytesTotal});
                    lastUpdate = getTimer();
                } else if ((getTimer() - lastUpdate) >= PROGRESS_THROTTLE_INTERVAL) {
                    dispatchEvent({target:_container, type:EVENT_ON_LOAD_PROGRESS, bytesLoaded:bytesLoaded, bytesTotal:bytesTotal});
                    lastUpdate = getTimer();
                }
            }
        }
        function onMovieClipLoadError(target, errorCode, httpStatus) {
            clearInterval(_latencyInterval);
            clearInterval(_loadProgressCheckInterval);
            logLoadError("LoadError", errorCode, httpStatus);
            dispatchEvent({target:_container, type:EVENT_ON_LOAD_ERROR, errorCode:errorCode, httpStatus:httpStatus});
        }
        function logLoadError(_context, _errorCode, _httpStatus) {
        }
        function logLoadTimeout(_context) {
        }
        function logParamError(_context, _caller) {
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
