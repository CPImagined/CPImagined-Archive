dynamic class com.clubpenguin.hybrid.HybridMovieClipLoader extends mx.events.EventDispatcher
{
    static var EVENT_ON_LOAD_START: String = "onLoadStart";
    static var EVENT_ON_LOAD_ERROR: String = "onLoadError";
    static var EVENT_ON_LOAD_COMPLETE: String = "onLoadComplete";
    static var EVENT_ON_LOAD_INIT: String = "onLoadInit";
    static var EVENT_ON_LOAD_PROGRESS: String = "onLoadProgress";
    static var EVENT_ON_UNLOAD: String = "onUnload";
    static var INTERVAL_RATE: Number = 40;
    static var TIME_OUT_THRESHOLD: Number = 180000;
    static var MIN_BYTES: Number = 4;
    static var PROGRESS_THROTTLE_INTERVAL: Number = 140;
    var _noByteDataTimeout: Number = 0;
    var _trackerReason: String = "MovieClipLoading";
    var _completeParams = null;
    var cacheVersion = null;
    var _container;
    var _latencyDelegate;
    var _latencyInterval;
    var _loadProgressCheckInterval;
    var _movieClipLoader;
    var _movieClipLoaderListener;
    var _startTime;
    var _timeElapsed;
    var _url;
    var dispatchEvent;
    var isNearlyLoadedShown;
    var lastUpdate;

    function HybridMovieClipLoader(completeParams)
    {
        super();
        this._movieClipLoader = new MovieClipLoader();
        this._movieClipLoaderListener = new Object();
        this._movieClipLoaderListener.onLoadStart = com.clubpenguin.util.Delegate.create(this, this.onMovieClipLoadStart);
        this._movieClipLoaderListener.onLoadComplete = com.clubpenguin.util.Delegate.create(this, this.onMovieClipLoadComplete);
        this._movieClipLoaderListener.onLoadError = com.clubpenguin.util.Delegate.create(this, this.onMovieClipLoadError);
        this._movieClipLoaderListener.onLoadProgress = com.clubpenguin.util.Delegate.create(this, this.onMovieClipLoadProgress);
        this._movieClipLoaderListener.onLoadInit = com.clubpenguin.util.Delegate.create(this, this.onMovieClipLoadInit);
        var __reg3 = this._movieClipLoader.addListener(this._movieClipLoaderListener);
    }

    function setCompleteParams(completeParams)
    {
        this._completeParams = completeParams == undefined ? {} : completeParams;
    }

    function loadClip(url, container, callerName, isCDNCache)
    {
        if (url == undefined || url.indexOf("undefined") >= 0) 
        {
            this.logParamError("LoadError", callerName);
            this.dispatchEvent({target: this._container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, errorCode: "undefined url from " + callerName});
            return;
        }
        if (isCDNCache == undefined || isCDNCache == true) 
        {
            var __reg3 = this.searchURLforCacheVersion(url);
            this._url = url + __reg3;
        }
        else 
        {
            this._url = url;
        }
        this._container = container;
        this._startTime = getTimer();
        this._movieClipLoader.loadClip(this._url, this._container);
        clearInterval(this._loadProgressCheckInterval);
        this._loadProgressCheckInterval = setInterval(this, "checkLoadProgress", com.clubpenguin.hybrid.HybridMovieClipLoader.INTERVAL_RATE);
        this.lastUpdate = getTimer();
    }

    function searchURLforCacheVersion(urlS)
    {
        var __reg2 = urlS.split("v2/", 2);
        if (__reg2 != null && __reg2.length > 1) 
        {
            var __reg3 = __reg2[1].split("/", 2);
            if ((__reg0 = __reg3[0]) === "content") 
            {
                return _global.getCurrentShell()._localLoginServerData.getContentCacheVersion();
            }
            else if (__reg0 === "client") 
            {
                return _global.getCurrentShell()._localLoginServerData.getClientCacheVersion();
            }
            else if (__reg0 === "games") 
            {
                return _global.getCurrentShell()._localLoginServerData.getGameCacheVersion();
            }
            else if (__reg0 === "config") 
            {
                return _global.getCurrentShell()._localLoginServerData.getConfigCacheVersion();
            }
            return "";
        }
        return "";
    }

    function unloadClip(target)
    {
        return this._movieClipLoader.unloadClip(target);
    }

    function checkLoadProgress()
    {
        this._timeElapsed = getTimer() - this._startTime;
        if (this._container.getBytesLoaded() == undefined) 
        {
            clearInterval(this._loadProgressCheckInterval);
            return undefined;
        }
        if (this._container.getBytesTotal() < 0 && this._timeElapsed >= com.clubpenguin.hybrid.HybridMovieClipLoader.TIME_OUT_THRESHOLD) 
        {
            clearInterval(this._loadProgressCheckInterval);
            this.logLoadTimeout("HybridLoader TimedOut");
            this.dispatchEvent({target: this._container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, errorCode: "ERROR: HybridMovieClipLoader timed out loading " + this._url});
            return undefined;
        }
        if (this._container.getBytesLoaded() == this._container.getBytesTotal() && this._container.getBytesTotal() > com.clubpenguin.hybrid.HybridMovieClipLoader.MIN_BYTES) 
        {
            clearInterval(this._loadProgressCheckInterval);
            this.dispatchEvent({target: this._container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_COMPLETE});
            this._latencyDelegate = com.clubpenguin.util.Delegate.create(this, this.onAS2MovieClipReady);
            this._container.onEnterFrame = this._latencyDelegate;
            return;
        }
        this.dispatchEvent({target: this._container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, bytesLoaded: this._container.getBytesLoaded(), bytesTotal: this._container.getBytesTotal()});
    }

    function onAS2MovieClipUnload()
    {
        clearInterval(this._latencyInterval);
        clearInterval(this._loadProgressCheckInterval);
        this.dispatchEvent({target: this._container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_UNLOAD});
    }

    function onAS2MovieClipReady()
    {
        clearInterval(this._latencyInterval);
        clearInterval(this._loadProgressCheckInterval);
        this._timeElapsed = getTimer() - this._startTime;
        delete this._container.onEnterFrame;
        this._latencyDelegate = null;
        this.dispatchEvent({target: this._container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT});
    }

    function onMovieClipLoadStart()
    {
        clearInterval(this._latencyInterval);
        clearInterval(this._loadProgressCheckInterval);
        this.dispatchEvent({target: this._container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_START});
    }

    function onMovieClipLoadComplete(target, httpStatus)
    {
        clearInterval(this._latencyInterval);
        clearInterval(this._loadProgressCheckInterval);
        this.dispatchEvent({target: target, loader: this, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_COMPLETE});
    }

    function onMovieClipLoadInit(target)
    {
        clearInterval(this._latencyInterval);
        clearInterval(this._loadProgressCheckInterval);
        this._movieClipLoader.removeListener(this._movieClipLoaderListener);
        this.dispatchEvent({target: this._container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, completeParams: this._completeParams, url: this._url});
    }

    function onMovieClipLoadProgress(target, bytesLoaded, bytesTotal)
    {
        clearInterval(this._latencyInterval);
        clearInterval(this._loadProgressCheckInterval);
        if (bytesTotal > 0) 
        {
            if (bytesLoaded / bytesTotal >= 0.95 && !this.isNearlyLoadedShown) 
            {
                this.isNearlyLoadedShown = true;
                this.dispatchEvent({target: this._container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, bytesLoaded: bytesLoaded, bytesTotal: bytesTotal});
                this.lastUpdate = getTimer();
                return;
            }
            if (getTimer() - this.lastUpdate >= com.clubpenguin.hybrid.HybridMovieClipLoader.PROGRESS_THROTTLE_INTERVAL) 
            {
                this.dispatchEvent({target: this._container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, bytesLoaded: bytesLoaded, bytesTotal: bytesTotal});
                this.lastUpdate = getTimer();
            }
        }
    }

    function onMovieClipLoadError(target, errorCode, httpStatus)
    {
        clearInterval(this._latencyInterval);
        clearInterval(this._loadProgressCheckInterval);
        this.logLoadError("LoadError", errorCode, httpStatus);
        this.dispatchEvent({target: this._container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, errorCode: errorCode, httpStatus: httpStatus});
    }

    function logLoadError(_context, _errorCode, _httpStatus)
    {
    }

    function logLoadTimeout(_context)
    {
    }

    function logParamError(_context, _caller)
    {
    }

}
