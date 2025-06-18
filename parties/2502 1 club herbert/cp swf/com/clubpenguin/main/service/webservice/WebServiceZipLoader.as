//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.service.webservice
{
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    import org.osflash.signals.Signal;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import nochump.util.zip.ZipFile;
    import nochump.util.zip.ZipEntry;
    import flash.utils.ByteArray;
    import com.clubpenguin.main.vo.WebServiceDataVO;
    import com.clubpenguin.lib.enums.errors.ErrorCodeEnum;
    //import com.adobe.serialization.json.JSON;

    public class WebServiceZipLoader extends EventDispatcher implements IEventDispatcher 
    {

        public var dataLoaded:Signal = new Signal();
        public var loadError:Signal = new Signal();
        public var dataLoadProgress:Signal = new Signal(uint, uint);
        private var urlLoader:URLLoader;
        private var path:String;
        private var isRetry:Boolean;


        public function load(path:String):void
        {
            this.path = path;
            this.doLoad();
        }

        public function removeEventListeners():void
        {
            this.urlLoader.removeEventListener(Event.COMPLETE, this.onLoad);
            this.urlLoader.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
            this.urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this.urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
        }

        private function doLoad():void
        {
            this.urlLoader = new URLLoader();
            this.urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
            this.urlLoader.addEventListener(Event.COMPLETE, this.onLoad);
            this.urlLoader.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
            this.urlLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this.urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this.urlLoader.load(new URLRequest(this.path));
        }

        private function onLoad(event:Event):void
        {
            var webServiceData:Array;
            var zipFile:ZipFile;
            var missingCriticalWebServices:Array;
            var i:int;
            var errorMessage:String;
            var fileName:String;
            var zipFileEntry:ZipEntry;
            var fileData:ByteArray;
            var webServiceType:WebServiceType;
            var wsdVO:WebServiceDataVO;
            this.removeEventListeners();
            try
            {
                webServiceData = [];
                zipFile = new ZipFile(this.urlLoader.data);
                if (zipFile.entries.length < 1)
                {
                    throw (new Error("Web service data not found - file is empty"));
                };
                missingCriticalWebServices = this.checkForCriticalWebServices(zipFile.entries);
                if (missingCriticalWebServices.length > 0)
                {
                    errorMessage = "The following critical web services were not received:\n";
                    for each (fileName in missingCriticalWebServices)
                    {
                        errorMessage = (errorMessage + (("-" + fileName) + "\n"));
                    };
                    throw (new Error(errorMessage));
                };
                i = 0;
                while (i < zipFile.entries.length)
                {
                    zipFileEntry = zipFile.entries[i];
                    fileData = zipFile.getInput(zipFileEntry);
                    webServiceType = WebServiceType.getWebServiceTypeByFileName(zipFileEntry.name);
                    if (webServiceType == null)
                    {
                    }
                    else
                    {
                        wsdVO = this.createWebServiceDataVO(webServiceType, fileData);
                        if (wsdVO.data != null)
                        {
                            webServiceData.push(wsdVO);
                        };
                    };
                    i = (i + 1);
                };
                this.dataLoaded.dispatch(webServiceData);
            }
            catch(error:Error)
            {
                if (isRetry)
                {
                    onError("unzip", error.message);
                }
                else
                {
                    retry();
                };
            };
        }

        private function createWebServiceDataVO(webServiceType:WebServiceType, fileData:ByteArray):WebServiceDataVO
        {
            var wsdVO:WebServiceDataVO;
            wsdVO = new WebServiceDataVO();
            wsdVO.name = webServiceType.name;
            wsdVO.fileName = webServiceType.fileName;
            wsdVO.priority = webServiceType.priority;
            wsdVO.requiresChunking = webServiceType.requiresChunking;
            wsdVO.isCritical = webServiceType.isCritical;
            switch (webServiceType)
            {
                case WebServiceType.CHUNK_MAP:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_CHUNK_MAP_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_CHUNK_MAP_ERROR;
                    break;
                case WebServiceType.LANGUAGE:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_LANGUAGE_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_LANGUAGE_ERROR;
                    break;
                case WebServiceType.PATHS:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_PATHS_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_PATHS_ERROR;
                    break;
                case WebServiceType.ROOMS:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_ROOMS_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_ROOMS_ERROR;
                    break;
                case WebServiceType.MASCOT_MESSAGES:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_MASCOT_MESSAGES_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_MASCOT_MESSAGES_ERROR;
                    break;
                case WebServiceType.GAMES:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_GAMES_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_GAMES_ERROR;
                    break;
                case WebServiceType.STAMPS:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_STAMPS_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_STAMPS_ERROR;
                    break;
                case WebServiceType.FURNITURE:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_FURNITURE_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_FURNITURE_ERROR;
                    break;
                case WebServiceType.ITEMS:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_ITEMS_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_ITEMS_ERROR;
                    break;
                case WebServiceType.PENGUIN_ACTION_FRAMES:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_PENGUIN_ACTION_FRAMES_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_PENGUIN_ACTION_FRAMES_ERROR;
                    break;
                case WebServiceType.MASCOTS:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_MASCOTS_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_MASCOTS_ERROR;
                    break;
                case WebServiceType.IGLOOS:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_IGLOOS_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_IGLOOS_ERROR;
                    break;
                case WebServiceType.PUFFLES:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_PUFFLES_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_PUFFLES_ERROR;
                    break;
                case WebServiceType.PUFFLE_ITEMS:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_PUFFLE_ITEMS_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_PUFFLE_ITEMS_ERROR;
                    break;
                case WebServiceType.TOUR_GUIDE_MESSAGES:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_TOUR_GUIDE_MESSAGES_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_TOUR_GUIDE_MESSAGES_ERROR;
                    break;
                case WebServiceType.JOKES:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_JOKES_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_JOKES_ERROR;
                    break;
                case WebServiceType.FLOORS:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_FLOORS_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_FLOORS_ERROR;
                    break;
                case WebServiceType.SCRIPT_MESSAGES:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_SCRIPT_MESSAGES_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_SCRIPT_MESSAGES_ERROR;
                    break;
                case WebServiceType.PLAYER_COLORS:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_PLAYER_COLORS_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_PLAYER_COLORS_ERROR;
                    break;
                case WebServiceType.NEWSPAPERS:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_NEWSPAPERS_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_NEWSPAPERS_ERROR;
                    break;
                case WebServiceType.POSTCARDS:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_POSTCARDS_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_POSTCARDS_ERROR;
                    break;
                case WebServiceType.GENERAL:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_GENERAL_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_GENERAL_ERROR;
                    break;
                case WebServiceType.SAFE_CHAT_MESSAGES:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_SAFE_CHAT_MESSAGES_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_SAFE_CHAT_MESSAGES_ERROR;
                    break;
                case WebServiceType.POLAROIDS:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_POLAROIDS_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_POLAROIDS_ERROR;
                    break;
                case WebServiceType.STAMPBOOK_COVER:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_STAMPBOOK_COVER_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_STAMPBOOK_COVER_ERROR;
                    break;
                case WebServiceType.ANALYTICS:
                    wsdVO.loadError = ErrorCodeEnum.WEB_SERVICE_LOAD_ANALYTICS_ERROR;
                    wsdVO.sendError = ErrorCodeEnum.WEB_SERVICE_SEND_ANALYTICS_ERROR;
                    break;
            };
            try
            {
                wsdVO.data = JSON.parse(fileData.toString());
            }
            catch(error:Error)
            {
                if (wsdVO.isCritical)
                {
                    onError("parsing", (("Critical web service: " + wsdVO.fileName) + " could not be parsed"));
                }
                else
                {
                    wsdVO.data = null;
                };
            };
            return (wsdVO);
        }

        private function checkForCriticalWebServices(fileList:Array):Array
        {
            var webServiceType:WebServiceType;
            var joinedFileList:String = fileList.join("|");
            var missing:Array = [];
            for each (webServiceType in WebServiceType.getCriticalServiceTypes())
            {
                if (joinedFileList.indexOf(webServiceType.fileName) < 0)
                {
                    missing.push(webServiceType.fileName);
                };
            };
            return (missing);
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
                this.onError("IOError", "Failed to load web services, defaulting to SINGLE LOAD");
            }
            else
            {
                this.retry();
            };
        }

        private function onSecurityError(event:SecurityErrorEvent):void
        {
            this.removeEventListeners();
            this.onError("security", "Failed to load web services, defaulting to SINGLE LOAD");
        }

        private function onError(context:String, message:String):void
        {
            this.removeEventListeners();
            this.loadError.dispatch(context, message);
        }

        private function onProgress(event:ProgressEvent):void
        {
            this.dataLoadProgress.dispatch(event.bytesLoaded, event.bytesTotal);
        }


    }
}//package com.clubpenguin.main.service.webservice
