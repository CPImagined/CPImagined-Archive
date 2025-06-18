//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.service.webservice.WebServiceManagerProxy;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.managers.resource.ResourceManager;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.main.signal.loadingScreen.ShowLoadingScreenSignal;
    import com.clubpenguin.main.signal.loadingScreen.HideLoadingScreenSignal;
    import com.clubpenguin.main.signal.loadingScreen.UpdateLoadingScreenSignal;
    import org.osflash.signals.Signal;
    import com.clubpenguin.managers.localization.LocalizationManager;
    import flash.utils.getTimer;
    import com.clubpenguin.lib.enums.Language;
    import com.clubpenguin.main.service.webservice.WebServiceType;

    public class LoadWebServicesCommand extends SignalCommand 
    {

        [Inject]
        public var webServiceManagerProxy:WebServiceManagerProxy;
        [Inject]
        public var localizer:ILocalizationManager;
        [Inject]
        public var resourceManager:ResourceManager;
        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var tracker:Tracker;
        [Inject]
        public var showLoadingScreenSignal:ShowLoadingScreenSignal;
        [Inject]
        public var hideLoadingScreenSignal:HideLoadingScreenSignal;
        [Inject]
        public var updateLoadingScreenSignal:UpdateLoadingScreenSignal;
        [Inject]
        public var _onLoaded:Signal;
        private var currentLanguage:String;
        private var startTime:int;
        private var localizationManager:LocalizationManager;


        override public function execute():void
        {
            this.localizationManager = LocalizationManager(this.localizer);
            this.localizationManager.setLoadingErrorMessages(this.mainModel.getEnvironmentData().language);
            this.startTime = getTimer();
            this.currentLanguage = this.mainModel.getEnvironmentData().language;
            this.addSignals();
            this.webServiceManagerProxy.load();
            this.showLoadingScreenSignal.dispatch("");
        }

        private function addSignals():void
        {
            this.webServiceManagerProxy.dataLoaded.addOnce(this.onDataLoaded);
            this.webServiceManagerProxy.setLoadMethodAndLoad.add(this.onSetLoadMethodAndLoad);
            this.webServiceManagerProxy.dataLoadProgress.add(this.onDataProgress);
        }

        private function removeSignals():void
        {
            this.webServiceManagerProxy.dataLoaded.removeAll();
            this.webServiceManagerProxy.setLoadMethodAndLoad.removeAll();
            this.webServiceManagerProxy.dataLoaded.removeAll();
        }

        private function onSetLoadMethodAndLoad(loadMethod:String):void
        {
            this.removeSignals();
            this.webServiceManagerProxy.setLoadMethod(loadMethod);
            this.addSignals();
            this.webServiceManagerProxy.load();
        }

        private function onDataLoaded():void
        {
            var item:Object;
            this.webServiceManagerProxy.setLoadMethodAndLoad.removeAll();
            this.webServiceManagerProxy.dataLoadProgress.removeAll();
            injector.mapValue(Language, Language.fromString(this.currentLanguage));
            this.localizationManager.setLocalizationTableFromKeyedArray(this.webServiceManagerProxy.getDataByName(WebServiceType.LANGUAGE.name).data);
            this.mainModel.pathsVO.data = this.webServiceManagerProxy.getDataByName(WebServiceType.PATHS.name).data;
            this.mainModel.generalConfigVO = this.webServiceManagerProxy.getDataByName(WebServiceType.GENERAL.name).data;
            this.mainModel.generalConfigVO = this.webServiceManagerProxy.getDataByName(WebServiceType.GENERAL.name).data;
            this.mainModel.playerColors = this.webServiceManagerProxy.getDataByName(WebServiceType.PLAYER_COLORS.name).data;
            this.resourceManager.setClothingData(this.webServiceManagerProxy.getDataByName(WebServiceType.ITEMS.name).data, this.mainModel.getEnvironmentData(), this.mainModel.pathsVO);
            this.resourceManager.setFurnitureData(this.webServiceManagerProxy.getDataByName(WebServiceType.FURNITURE.name).data, this.mainModel.getEnvironmentData(), this.mainModel.pathsVO);
            for each (item in this.mainModel.pathsVO.data)
            {
                this.localizationManager.setLocalizationTable(item);
            };
            this.hideLoadingScreenSignal.dispatch();
            this._onLoaded.dispatch();
        }

        private function onDataProgress(progress:Number):void
        {
            this.updateLoadingScreenSignal.dispatch(progress);
        }


    }
}//package com.clubpenguin.main.command
