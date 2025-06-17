//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.service.webservice
{
    import com.clubpenguin.main.signal.LoadWebServiceFatalErrorSignal;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.main.signal.LoadLogoSignal;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.main.vo.WebServiceDataVO;
    import org.osflash.signals.Signal;

    public class WebServiceManagerProxy 
    {

        public static var ZIP_LOAD:String = "zip";
        public static var INDIVIDUAL_LOAD:String = "individual";

        [Inject]
        public var fatalError:LoadWebServiceFatalErrorSignal;
        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var localizationManager:ILocalizationManager;
        [Inject]
        public var tracker:Tracker;
        [Inject]
        public var loadLogoSignal:LoadLogoSignal;
        public var _webServiceManager:IWebServiceManager;
        public var loadMethod:String;

        public function WebServiceManagerProxy():void
        {
        }

        public function setLoadMethod(loadMethod:String):void
        {
            this.loadMethod = loadMethod;
            if (loadMethod == WebServiceManagerProxy.ZIP_LOAD)
            {
                this._webServiceManager = new WebServiceZipManager();
            }
            else
            {
                this._webServiceManager = new WebServiceManager();
            };
            this._webServiceManager.bridge = this.bridge;
            this._webServiceManager.fatalError = this.fatalError;
            this._webServiceManager.localizationManager = this.localizationManager;
            this._webServiceManager.mainModel = this.mainModel;
            this._webServiceManager.tracker = this.tracker;
        }

        public function load():void
        {
            this._webServiceManager.load();
        }

        public function sendDataAcrossBridge():void
        {
            Log.debug("\tWebServiceManagerProxy.sendDataAcrossBridge()");
            this._webServiceManager.sendDataAcrossBridge();
            this.dataSent.addOnce(this.onDataSent);
            this.loadLogoSignal.dispatch();
        }

        public function getDataByName(name:String, remove:Boolean=false):WebServiceDataVO
        {
            return (this._webServiceManager.getDataByName(name, remove));
        }

        private function onDataSent():void
        {
            Log.debug("\tWebServiceManagerProxy.onDataSent()");
            this.loadLogoSignal.dispatch();
        }

        public function get dataLoaded():Signal
        {
            return (this._webServiceManager.dataLoaded);
        }

        public function get dataLoadProgress():Signal
        {
            return (this._webServiceManager.dataLoadProgress);
        }

        public function get dataSent():Signal
        {
            return (this._webServiceManager.dataSent);
        }

        public function get setLoadMethodAndLoad():Signal
        {
            return (this._webServiceManager.setLoadMethodAndLoad);
        }


    }
}//package com.clubpenguin.main.service.webservice
