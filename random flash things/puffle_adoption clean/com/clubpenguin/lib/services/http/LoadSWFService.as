//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.services.http
{
    import org.robotlegs.mvcs.Actor;
    import org.osflash.signals.Signal;
    import flash.display.Loader;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.net.URLRequest;
    import com.clubpenguin.lib.enums.resource.CacheTypeEnum;
    import flash.events.SecurityErrorEvent;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.display.DisplayObject;

    public class LoadSWFService extends Actor 
    {

        public static var cacheBusterParms:String = "";
        private static var $_uid:int = -1;

        private var __uid:int;
        public var responseReceived:Signal = new Signal(LoadSWFResponse);
        public var requestFailed:Signal = new Signal(LoadSWFResponse);
        public var progressReceived:Signal = new Signal(uint, uint);
        public var response:LoadSWFResponse;
        protected var loader:Loader;
        private var __appDomain:ApplicationDomain;
        private var __context:LoaderContext;
        private var _url:String;
        private var _request:URLRequest;
        private var _props:Object = null;
        private var _useCacheBusting:Boolean = true;

        public function LoadSWFService(url:String="")
        {
            this.__uid = ++$_uid;
            this.url = url;
            this.__appDomain = ApplicationDomain.currentDomain;
        }

        public function set url(value:String):void
        {
            this._url = value;
        }

        public function get url():String
        {
            return (this._url);
        }

        public function set props(props:Object):void
        {
            this._props = props;
        }

        public function set useCacheBusting(value:Boolean):void
        {
            this._useCacheBusting = value;
        }

        public function get useCacheBusting():Boolean
        {
            return (this._useCacheBusting);
        }

        public function set applicationDomain(_appDomain:ApplicationDomain):void
        {
            this.__appDomain = _appDomain;
        }

        public function get applicationDomain():ApplicationDomain
        {
            return (this.__appDomain);
        }

        public function set context(_context:LoaderContext):void
        {
            this.__context = _context;
        }

        public function send(_appDomain:ApplicationDomain=null, isCDNCache:Boolean=true):void
        {
            var splitURL:Array;
            var cacheType:Array;
            var updatedURL:String;
            if (((this._useCacheBusting) && (isCDNCache)))
            {
                splitURL = this._url.split("v2/", 2);
                if (((!(splitURL == null)) && (splitURL.length > 1)))
                {
                    cacheType = String(splitURL[1]).split("/", 2);
                    updatedURL = (this._url + CacheTypeEnum.getCacheAsStringByType(String(cacheType[0])));
                    this._request = new URLRequest(updatedURL);
                }
                else
                {
                    this._request = new URLRequest((this._url + cacheBusterParms));
                };
            }
            else
            {
                this._request = new URLRequest(this._url);
            };
            this.response = new LoadSWFResponse();
            this.response.id = this._url;
            this.response.service = this;
            var appDomain:ApplicationDomain = new ApplicationDomain(((_appDomain != null) ? _appDomain : this.__appDomain));
            var loaderContext:LoaderContext = ((this.__context == null) ? new LoaderContext(false, appDomain) : this.__context);
            this.loader = new Loader();
            this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this.loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.onHTTPStatus);
            this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete);
            this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
            this.loader.contentLoaderInfo.addEventListener(Event.UNLOAD, this.onUnload);
            this.loader.load(this._request, loaderContext);
        }

        protected function onProgress(event:ProgressEvent):void
        {
            this.progressReceived.dispatch(event.bytesLoaded, event.bytesTotal);
        }

        protected function onUnload(event:Event):void
        {
        }

        protected function onComplete(event:Event):void
        {
            this.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this.loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, this.onHTTPStatus);
            this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onComplete);
            this.loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
            this.loader.contentLoaderInfo.removeEventListener(Event.UNLOAD, this.onUnload);
            if (this.response.success)
            {
                this.response.data = (this.loader as DisplayObject);
                this.response.bytesTotal = this.loader.contentLoaderInfo.bytesTotal;
                if (this._props)
                {
                    this.response.props = this._props;
                };
                this.processResponse(this.response);
                this.responseReceived.dispatch(this.response);
            }
            else
            {
                this.requestFailed.dispatch(this.response);
            };
        }

        protected function processResponse(response:LoadSWFResponse):void
        {
        }

        protected function onHTTPStatus(event:HTTPStatusEvent):void
        {
            this.response.status = event.status;
            switch (event.status)
            {
                case 0:
                    this.response.success = true;
                    break;
                case 200:
                    this.response.success = true;
                    break;
                default:
                    this.response.errorMessage = ("HTTP Error " + event.status.toString());
            };
        }

        protected function onSecurityError(event:SecurityErrorEvent):void
        {
            this.response.errorMessage = event.text;
            this.requestFailed.dispatch(this.response);
        }

        protected function onIOError(event:IOErrorEvent):void
        {
            this.response.errorMessage = event.text;
            this.requestFailed.dispatch(this.response);
        }


    }
}//package com.clubpenguin.lib.services.http
