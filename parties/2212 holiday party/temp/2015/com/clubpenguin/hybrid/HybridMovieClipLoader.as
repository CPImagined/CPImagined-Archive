class com.clubpenguin.hybrid.HybridMovieClipLoader extends mx.events.EventDispatcher
{
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
   function HybridMovieClipLoader(completeParams)
   {
      super();
      this._movieClipLoader = new MovieClipLoader();
      this._movieClipLoaderListener = new Object();
      this._movieClipLoaderListener.onLoadStart = com.clubpenguin.util.Delegate.create(this,this.onMovieClipLoadStart);
      this._movieClipLoaderListener.onLoadComplete = com.clubpenguin.util.Delegate.create(this,this.onMovieClipLoadComplete);
      this._movieClipLoaderListener.onLoadError = com.clubpenguin.util.Delegate.create(this,this.onMovieClipLoadError);
      this._movieClipLoaderListener.onLoadProgress = com.clubpenguin.util.Delegate.create(this,this.onMovieClipLoadProgress);
      this._movieClipLoaderListener.onLoadInit = com.clubpenguin.util.Delegate.create(this,this.onMovieClipLoadInit);
      var _loc3_ = this._movieClipLoader.addListener(this._movieClipLoaderListener);
   }
   function setCompleteParams(completeParams)
   {
      this._completeParams = completeParams == undefined ? {} : completeParams;
   }
   function loadClip(url, container, callerName, isCDNCache)
   {
      if(url == undefined || url.indexOf("undefined") >= 0)
      {
         this.logParamError("LoadError",callerName);
         this.dispatchEvent({target:this._container,type:com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR,errorCode:"undefined url from " + callerName});
      }
      else
      {
         if(isCDNCache == undefined || isCDNCache == true)
         {
            var _loc3_ = this.searchURLforCacheVersion(url);
            this._url = url + _loc3_;
         }
         else
         {
            this._url = url;
         }
         this._container = container;
         this._startTime = getTimer();
         this._movieClipLoader.loadClip(this._url,this._container);
         clearInterval(this._loadProgressCheckInterval);
         this._loadProgressCheckInterval = setInterval(this,"checkLoadProgress",com.clubpenguin.hybrid.HybridMovieClipLoader.INTERVAL_RATE);
         this.lastUpdate = getTimer();
      }
   }
   function searchURLforCacheVersion(urlS)
   {
      var _loc2_ = urlS.split("v2/",2);
      if(_loc2_ != null && _loc2_.length > 1)
      {
         var _loc3_ = _loc2_[1].split("/",2);
         switch(_loc3_[0])
         {
            case "content":
               return _global.getCurrentShell()._localLoginServerData.getContentCacheVersion();
            case "client":
               return _global.getCurrentShell()._localLoginServerData.getClientCacheVersion();
            case "games":
               return _global.getCurrentShell()._localLoginServerData.getGameCacheVersion();
            case "config":
               return _global.getCurrentShell()._localLoginServerData.getConfigCacheVersion();
            default:
               return "";
         }
      }
      else
      {
         return "";
      }
   }
   function unloadClip(target)
   {
      return this._movieClipLoader.unloadClip(target);
   }
   function checkLoadProgress()
   {
      this._timeElapsed = getTimer() - this._startTime;
      if(this._container.getBytesLoaded() == undefined)
      {
         clearInterval(this._loadProgressCheckInterval);
         return undefined;
      }
      if(this._container.getBytesTotal() < 0 && this._timeElapsed >= com.clubpenguin.hybrid.HybridMovieClipLoader.TIME_OUT_THRESHOLD)
      {
         clearInterval(this._loadProgressCheckInterval);
         this.logLoadTimeout("HybridLoader TimedOut");
         this.dispatchEvent({target:this._container,type:com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR,errorCode:"ERROR: HybridMovieClipLoader timed out loading " + this._url});
         return undefined;
      }
      if(this._container.getBytesLoaded() == this._container.getBytesTotal() && this._container.getBytesTotal() > com.clubpenguin.hybrid.HybridMovieClipLoader.MIN_BYTES)
      {
         clearInterval(this._loadProgressCheckInterval);
         this.dispatchEvent({target:this._container,type:com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_COMPLETE});
         this._latencyDelegate = com.clubpenguin.util.Delegate.create(this,this.onAS2MovieClipReady);
         this._container.onEnterFrame = this._latencyDelegate;
      }
      else
      {
         this.dispatchEvent({target:this._container,type:com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS,bytesLoaded:this._container.getBytesLoaded(),bytesTotal:this._container.getBytesTotal()});
      }
   }
   function onAS2MovieClipUnload()
   {
      clearInterval(this._latencyInterval);
      clearInterval(this._loadProgressCheckInterval);
      this.dispatchEvent({target:this._container,type:com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_UNLOAD});
   }
   function onAS2MovieClipReady()
   {
      clearInterval(this._latencyInterval);
      clearInterval(this._loadProgressCheckInterval);
      this._timeElapsed = getTimer() - this._startTime;
      delete this._container.onEnterFrame;
      this._latencyDelegate = null;
      this.dispatchEvent({target:this._container,type:com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT});
   }
   function onMovieClipLoadStart()
   {
      clearInterval(this._latencyInterval);
      clearInterval(this._loadProgressCheckInterval);
      this.dispatchEvent({target:this._container,type:com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_START});
   }
   function onMovieClipLoadComplete(target, httpStatus)
   {
      clearInterval(this._latencyInterval);
      clearInterval(this._loadProgressCheckInterval);
      this.dispatchEvent({target:target,loader:this,type:com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_COMPLETE});
   }
   function onMovieClipLoadInit(target)
   {
      clearInterval(this._latencyInterval);
      clearInterval(this._loadProgressCheckInterval);
      this._movieClipLoader.removeListener(this._movieClipLoaderListener);
      this.dispatchEvent({target:this._container,type:com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT,completeParams:this._completeParams,url:this._url});
   }
   function onMovieClipLoadProgress(target, bytesLoaded, bytesTotal)
   {
      clearInterval(this._latencyInterval);
      clearInterval(this._loadProgressCheckInterval);
      if(bytesTotal > 0)
      {
         if(bytesLoaded / bytesTotal >= 0.95 && !this.isNearlyLoadedShown)
         {
            this.isNearlyLoadedShown = true;
            this.dispatchEvent({target:this._container,type:com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS,bytesLoaded:bytesLoaded,bytesTotal:bytesTotal});
            this.lastUpdate = getTimer();
         }
         else if(getTimer() - this.lastUpdate >= com.clubpenguin.hybrid.HybridMovieClipLoader.PROGRESS_THROTTLE_INTERVAL)
         {
            this.dispatchEvent({target:this._container,type:com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS,bytesLoaded:bytesLoaded,bytesTotal:bytesTotal});
            this.lastUpdate = getTimer();
         }
      }
   }
   function onMovieClipLoadError(target, errorCode, httpStatus)
   {
      clearInterval(this._latencyInterval);
      clearInterval(this._loadProgressCheckInterval);
      this.logLoadError("LoadError",errorCode,httpStatus);
      this.dispatchEvent({target:this._container,type:com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR,errorCode:errorCode,httpStatus:httpStatus});
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
