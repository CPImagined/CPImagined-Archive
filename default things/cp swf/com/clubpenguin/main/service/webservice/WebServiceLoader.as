//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.service.webservice
{
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    import org.osflash.signals.Signal;
    import flash.net.URLLoader;
    import com.clubpenguin.main.vo.WebServiceDataVO;
    import com.clubpenguin.lib.enums.errors.ErrorCodeEnum;
    import com.clubpenguin.lib.enums.resource.CacheTypeEnum;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;
    import com.adobe.serialization.json.JSON;

    public class WebServiceLoader extends EventDispatcher implements IEventDispatcher 
    {

        public var dataLoaded:Signal = new Signal();
        public var dataLoadProgress:Signal = new Signal(uint, uint);
        public var loadError:Signal = new Signal();
        private var urlLoader:URLLoader;
        private var wsdVO:WebServiceDataVO;
        private var path:String;
        private var isRetry:Boolean;


        public function load(webServicePath:String, webServiceType:WebServiceType, buildParam:String=""):void
        {
            this.wsdVO = new WebServiceDataVO();
            this.wsdVO.name = webServiceType.name;
            this.wsdVO.fileName = webServiceType.fileName;
            this.wsdVO.priority = webServiceType.priority;
            this.wsdVO.requiresChunking = webServiceType.requiresChunking;
            this.wsdVO.isCritical = webServiceType.isCritical;
            switch (webServiceType)
            {
                case WebServiceType.CHUNK_MAP:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_CHUNK_MAP_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_CHUNK_MAP_ERROR;
                    break;
                case WebServiceType.LANGUAGE:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_LANGUAGE_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_LANGUAGE_ERROR;
                    break;
                case WebServiceType.PATHS:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_PATHS_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_PATHS_ERROR;
                    break;
                case WebServiceType.ROOMS:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_ROOMS_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_ROOMS_ERROR;
                    break;
                case WebServiceType.MASCOT_MESSAGES:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_MASCOT_MESSAGES_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_MASCOT_MESSAGES_ERROR;
                    break;
                case WebServiceType.GAMES:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_GAMES_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_GAMES_ERROR;
                    break;
                case WebServiceType.STAMPS:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_STAMPS_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_STAMPS_ERROR;
                    break;
                case WebServiceType.FURNITURE:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_FURNITURE_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_FURNITURE_ERROR;
                    break;
                case WebServiceType.ITEMS:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_ITEMS_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_ITEMS_ERROR;
                    break;
                case WebServiceType.PENGUIN_ACTION_FRAMES:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_PENGUIN_ACTION_FRAMES_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_PENGUIN_ACTION_FRAMES_ERROR;
                    break;
                case WebServiceType.MASCOTS:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_MASCOTS_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_MASCOTS_ERROR;
                    break;
                case WebServiceType.IGLOOS:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_IGLOOS_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_IGLOOS_ERROR;
                    break;
                case WebServiceType.PUFFLES:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_PUFFLES_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_PUFFLES_ERROR;
                    break;
                case WebServiceType.PUFFLE_ITEMS:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_PUFFLE_ITEMS_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_PUFFLE_ITEMS_ERROR;
                    break;
                case WebServiceType.TOUR_GUIDE_MESSAGES:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_TOUR_GUIDE_MESSAGES_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_TOUR_GUIDE_MESSAGES_ERROR;
                    break;
                case WebServiceType.JOKES:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_JOKES_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_JOKES_ERROR;
                    break;
                case WebServiceType.FLOORS:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_FLOORS_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_FLOORS_ERROR;
                    break;
                case WebServiceType.SCRIPT_MESSAGES:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_SCRIPT_MESSAGES_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_SCRIPT_MESSAGES_ERROR;
                    break;
                case WebServiceType.PLAYER_COLORS:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_PLAYER_COLORS_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_PLAYER_COLORS_ERROR;
                    break;
                case WebServiceType.NEWSPAPERS:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_NEWSPAPERS_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_NEWSPAPERS_ERROR;
                    break;
                case WebServiceType.POSTCARDS:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_POSTCARDS_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_POSTCARDS_ERROR;
                    break;
                case WebServiceType.GENERAL:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_GENERAL_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_GENERAL_ERROR;
                    break;
                case WebServiceType.SAFE_CHAT_MESSAGES:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_SAFE_CHAT_MESSAGES_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_SAFE_CHAT_MESSAGES_ERROR;
                    break;
                case WebServiceType.POLAROIDS:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_POLAROIDS_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_POLAROIDS_ERROR;
                    break;
                case WebServiceType.STAMPBOOK_COVER:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_STAMPBOOK_COVER_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_STAMPBOOK_COVER_ERROR;
                    break;
                case WebServiceType.ANALYTICS:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_ANALYTICS_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_ANALYTICS_ERROR;
                    break;
                default:
                    this.wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_ERROR;
                    this.wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_ERROR;
            };
            this.path = ((webServicePath + webServiceType.fileName) + CacheTypeEnum.getCacheAsStringByType("config"));
            this.doLoad();
        }

        public function removeEventListeners():void
        {
            this.urlLoader.removeEventListener(Event.COMPLETE, this.onLoad);
            this.urlLoader.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
            this.urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this.urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
        }

        public function getWebServiceData():WebServiceDataVO
        {
            return (this.wsdVO);
        }

        private function doLoad():void
        {
            this.urlLoader = new URLLoader();
            this.urlLoader.addEventListener(Event.COMPLETE, this.onLoad);
            this.urlLoader.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
            this.urlLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this.urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this.urlLoader.load(new URLRequest(this.path));
        }

        private function onLoad(event:Event):void
        {
            this.removeEventListeners();
            try
            {
                this.wsdVO.data = com.adobe.serialization.json.JSON.decode(this.urlLoader.data);
                this.dataLoaded.dispatch(this.wsdVO);
                dispatchEvent(new Event(Event.COMPLETE));
            }
            catch(error:Error)
            {
                if (isRetry)
                {
                    if (wsdVO.isCritical)
                    {
                        onError();
                    }
                    else
                    {
                        dataLoaded.dispatch(wsdVO);
                    };
                }
                else
                {
                    retry();
                };
            };
        }

        private function retry():void
        {
            this.isRetry = true;
            this.doLoad();
        }

        private function onIOError(event:IOErrorEvent):void
        {
            this.removeEventListeners();
            if (this.isRetry)
            {
                this.onError();
            }
            else
            {
                this.retry();
            };
        }

        private function onSecurityError(event:SecurityErrorEvent):void
        {
            this.removeEventListeners();
            this.onError();
        }

        private function onError():void
        {
            this.removeEventListeners();
            this.loadError.dispatch(this.wsdVO.loadError);
        }

        private function onProgress(event:ProgressEvent):void
        {
            this.dataLoadProgress.dispatch(event.bytesLoaded, event.bytesTotal);
        }


    }
}//package com.clubpenguin.main.service.webservice
