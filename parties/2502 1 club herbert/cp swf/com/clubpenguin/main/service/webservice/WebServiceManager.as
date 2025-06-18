//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.service.webservice
{
    import com.clubpenguin.main.signal.LoadWebServiceFatalErrorSignal;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.playdom.tracker.Tracker;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import com.clubpenguin.main.vo.WebServiceDataVO;
    import com.clubpenguin.main.service.webservice.chunkers.IWebServiceChunker;
    import com.clubpenguin.main.service.webservice.chunkers.WebServiceChunkUtils;
    import com.clubpenguin.main.service.webservice.chunkers.SimpleChunker;
    import com.clubpenguin.main.service.webservice.chunkers.KeyedArrayChunker;
    import com.clubpenguin.main.service.webservice.chunkers.StampsChunker;
    import com.clubpenguin.main.service.webservice.chunkers.MascotMessagesChunker;
    import com.clubpenguin.lib.vo.ErrorVO;
    import com.clubpenguin.lib.enums.errors.ErrorCodeEnum;

    public class WebServiceManager implements IWebServiceManager 
    {

        private var _fatalError:LoadWebServiceFatalErrorSignal;
        private var _mainModel:MainModel;
        private var _bridge:IAVMBridgeService;
        private var _localizationManager:ILocalizationManager;
        private var _tracker:Tracker;
        private var _dataLoaded:Signal = new Signal();
        private var _dataLoadProgress:Signal = new Signal(Number);
        private var _dataSent:Signal = new Signal();
        private var _setLoadMethodAndLoad:Signal = new Signal();
        private var totalWebServices:int;
        private var count:int;
        private var webServiceData:Array;
        private var webServiceLoaders:Array;


        public function load():void
        {
            var webServiceType:WebServiceType;
            var webServiceLoader:WebServiceLoader;
            var envData:EnvironmentDataVO = this.mainModel.getEnvironmentData();
            var webServicePath:String = ((envData.getBaseConfigPath() + envData.language) + envData.web_service);
            var webServiceTypes:Array = WebServiceType.getServiceTypes();
            this.totalWebServices = webServiceTypes.length;
            this.count = 0;
            this.webServiceData = [];
            this.webServiceLoaders = [];
            for each (webServiceType in webServiceTypes)
            {
                webServiceLoader = new WebServiceLoader();
                this.webServiceLoaders.push(webServiceLoader);
                webServiceLoader.dataLoaded.addOnce(this.onDataLoaded);
                webServiceLoader.loadError.addOnce(this.onWebServiceLoadError);
                webServiceLoader.load(webServicePath, webServiceType, this._mainModel._buildParam);
            };
        }

        public function sendDataAcrossBridge():void
        {
            var masterChunkMap:Object;
            var wsdVO:WebServiceDataVO;
            var chunker:IWebServiceChunker;
            var itemCount:Number;
            var isRetryOK:Boolean;
            this.count = 0;
            masterChunkMap = this.getDataByName(WebServiceType.CHUNK_MAP.name).data;
            for each (wsdVO in this.webServiceData)
            {
                itemCount = WebServiceChunkUtils.getItemCount(wsdVO.data);
                try
                {
                    if (wsdVO.data != null)
                    {
                        if (wsdVO.requiresChunking)
                        {
                            if ((((wsdVO.name == WebServiceType.ITEMS.name) || (wsdVO.name == WebServiceType.FURNITURE.name)) || (wsdVO.name == WebServiceType.PUFFLE_ITEMS.name)))
                            {
                                chunker = new SimpleChunker();
                            }
                            else
                            {
                                if (((wsdVO.name == WebServiceType.LANGUAGE.name) || (wsdVO.name == WebServiceType.PENGUIN_ACTION_FRAMES.name)))
                                {
                                    chunker = new KeyedArrayChunker();
                                }
                                else
                                {
                                    if (wsdVO.name == WebServiceType.STAMPS.name)
                                    {
                                        chunker = new StampsChunker();
                                    }
                                    else
                                    {
                                        if (wsdVO.name == WebServiceType.MASCOT_MESSAGES.name)
                                        {
                                            chunker = new MascotMessagesChunker();
                                        }
                                        else
                                        {
                                            throw (new Error((("The web service " + wsdVO.name) + " requires chunking but has not been assigned a chunker")));
                                        };
                                    };
                                };
                            };
                            if (!chunker.sendData(this.bridge, wsdVO, masterChunkMap))
                            {
                                throw (new Error("Chunking Error"));
                            };
                        }
                        else
                        {
                            if (itemCount == 0)
                            {
                                throw (new Error((wsdVO.name + " JSON data is empty!")));
                            };
                            WebServiceAVMBridge.sendData(this.bridge, wsdVO.name, wsdVO.name, wsdVO.data, true);
                        };
                    };
                    this.onDataSent(wsdVO);
                }
                catch(error:Error)
                {
                    if (itemCount > 0)
                    {
                        isRetryOK = retrySend(wsdVO, chunker, masterChunkMap);
                        if (isRetryOK)
                        {
                            onDataSent(wsdVO);
                        }
                        else
                        {
                            sendFatalError(wsdVO.sendError);
                            break;
                        };
                    }
                    else
                    {
                        if (wsdVO.isCritical)
                        {
                            sendFatalError(wsdVO.sendError);
                            break;
                        };
                    };
                };
            };
        }

        private function retrySend(wsdVO:WebServiceDataVO, chunker:IWebServiceChunker, masterChunkMap:Object):Boolean
        {
            try
            {
                if (chunker != null)
                {
                    if (!chunker.sendData(this.bridge, wsdVO, masterChunkMap))
                    {
                        throw (new Error("Chunking Error"));
                    };
                }
                else
                {
                    WebServiceAVMBridge.sendData(this.bridge, wsdVO.name, wsdVO.name, wsdVO.data, true);
                };
            }
            catch(error:Error)
            {
                if (wsdVO.isCritical)
                {
                    return (false);
                };
            };
            return (true);
        }

        public function getDataByName(name:String, remove:Boolean=false):WebServiceDataVO
        {
            var wsdVO:WebServiceDataVO;
            if (this.webServiceData == null)
            {
                return (null);
            };
            for each (wsdVO in this.webServiceData)
            {
                if (wsdVO.name == name)
                {
                    return (wsdVO);
                };
            };
            return (null);
        }

        private function sendFatalError(errorCodeEnum:ErrorCodeEnum):void
        {
            var errorCode:int = errorCodeEnum.getId();
            var errorMessage:String = this.localizationManager.getLocalizedString(errorCodeEnum.errorMessageTag);
            var buttonURL:String = this.localizationManager.getLocalizedString(errorCodeEnum.buttonURLTag);
            var buttonText:String = this.localizationManager.getLocalizedString(errorCodeEnum.buttonTextTag);
            var buttonTarget:String = "_self";
            var errorVO:ErrorVO = new ErrorVO(errorMessage, errorCode, buttonURL, buttonText, buttonTarget);
            this.fatalError.dispatch(errorVO);
        }

        private function onWebServiceLoadError(errorEnum:ErrorCodeEnum):void
        {
            var webServiceLoader:WebServiceLoader;
            for each (webServiceLoader in this.webServiceLoaders)
            {
                webServiceLoader.removeEventListeners();
                webServiceLoader.dataLoaded.removeAll();
                webServiceLoader.loadError.removeAll();
            };
            this.sendFatalError(errorEnum);
        }

        private function onDataLoaded(wsdVO:WebServiceDataVO):void
        {
            this.webServiceData.push(wsdVO);
            this.count++;
            this._dataLoadProgress.dispatch((this.count / this.totalWebServices));
            if (this.count == this.totalWebServices)
            {
                this.webServiceData.sortOn("priority", Array.NUMERIC);
                this.dataLoaded.dispatch();
            };
        }

        private function onDataSent(wsdVO:WebServiceDataVO):void
        {
            this.count++;
            this._dataLoadProgress.dispatch((this.count / this.totalWebServices));
            if (this.count == this.totalWebServices)
            {
                this.dataSent.dispatch();
            };
        }

        public function set fatalError(value:LoadWebServiceFatalErrorSignal):void
        {
            this._fatalError = value;
        }

        public function set mainModel(value:MainModel):void
        {
            this._mainModel = value;
        }

        public function set localizationManager(value:ILocalizationManager):void
        {
            this._localizationManager = value;
        }

        public function set bridge(value:IAVMBridgeService):void
        {
            this._bridge = value;
        }

        public function set tracker(value:Tracker):void
        {
            this._tracker = value;
        }

        public function get fatalError():LoadWebServiceFatalErrorSignal
        {
            return (this._fatalError);
        }

        public function get mainModel():MainModel
        {
            return (this._mainModel);
        }

        public function get localizationManager():ILocalizationManager
        {
            return (this._localizationManager);
        }

        public function get bridge():IAVMBridgeService
        {
            return (this._bridge);
        }

        public function get dataLoaded():Signal
        {
            return (this._dataLoaded);
        }

        public function get dataSent():Signal
        {
            return (this._dataSent);
        }

        public function get setLoadMethodAndLoad():Signal
        {
            return (this._setLoadMethodAndLoad);
        }

        public function get dataLoadProgress():Signal
        {
            return (this._dataLoadProgress);
        }


    }
}//package com.clubpenguin.main.service.webservice
