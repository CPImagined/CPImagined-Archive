//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.signal.LoadConfigSignal;
    import com.clubpenguin.main.signal.LoadSwfAddress;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.main.signal.MultiClientCheckSignal;
    import com.clubpenguin.main.signal.LoadLocalizationDataSignal;
    import com.clubpenguin.main.signal.LoadPathsDataSignal;
    import com.clubpenguin.main.signal.LoadWebServicesSignal;
    import com.clubpenguin.main.signal.LoadPuffleCareItemsSignal;
    import com.clubpenguin.main.signal.GetDefaultPufflesSignal;
    import com.clubpenguin.main.signal.InitTrackingSignal;
    import com.clubpenguin.main.signal.LoadNotificationSystemSignal;
    import com.clubpenguin.main.signal.LoadBanningModuleSignal;
    import com.clubpenguin.main.signal.LoadFontLibrarySignal;
    import com.clubpenguin.main.view.MainView;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.services.http.LoadSWFService;

    public class StartupCommand extends SignalCommand 
    {

        [Inject]
        public var _loadConfig:LoadConfigSignal;
        [Inject]
        public var _loadSwfAddress:LoadSwfAddress;
        [Inject]
        public var _mainModel:MainModel;
        [Inject]
        public var _multiClientCheck:MultiClientCheckSignal;
        [Inject]
        public var _loadLocalizationData:LoadLocalizationDataSignal;
        [Inject]
        public var _loadPathsData:LoadPathsDataSignal;
        [Inject]
        public var _loadWebService:LoadWebServicesSignal;
        [Inject]
        public var _loadPuffleCareItems:LoadPuffleCareItemsSignal;
        [Inject]
        public var _getDefaultPuffles:GetDefaultPufflesSignal;
        [Inject]
        public var _initTracking:InitTrackingSignal;
        [Inject]
        public var _loadNotificationService:LoadNotificationSystemSignal;
        [Inject]
        public var _loadBanningModule:LoadBanningModuleSignal;
        [Inject]
        public var _loadFontLibrary:LoadFontLibrarySignal;
        [Inject]
        public var mainView:MainView;


        override public function execute():void
        {
            contextView.addChild(this.mainView);
            var onLoaded:Signal = new Signal();
            onLoaded.addOnce(this.onConfigLoaded);
            this._loadConfig.dispatch(onLoaded);
        }

        private function onConfigLoaded():void
        {
            LoadSWFService.cacheBusterParms = this._mainModel.getBuildParam();
            var onLoaded:Signal = new Signal();
            onLoaded.addOnce(this.onNotificationServiceLoaded);
            this._loadNotificationService.dispatch(onLoaded);
        }

        private function onNotificationServiceLoaded():void
        {
            var onLoaded:Signal = new Signal();
            onLoaded.addOnce(this.onFontLibaryLoaded);
            this._loadFontLibrary.dispatch(onLoaded);
        }

        private function onFontLibaryLoaded():void
        {
            var onLoaded:Signal = new Signal();
            onLoaded.addOnce(this.onWebServicesLoaded);
            this._loadWebService.dispatch(onLoaded);
        }

        private function onWebServicesLoaded():void
        {
            var onLoaded:Signal = new Signal();
            onLoaded.addOnce(this.onLocalizationLoaded);
            this._loadLocalizationData.dispatch(onLoaded);
        }

        private function onLocalizationLoaded():void
        {
            var onLoaded:Signal = new Signal();
            onLoaded.addOnce(this.onBanningModuleLoaded);
            this._loadBanningModule.dispatch(onLoaded);
        }

        private function onBanningModuleLoaded():void
        {
            var onLoaded:Signal = new Signal();
            onLoaded.addOnce(this.onMultiClientCheckComplete);
            this._multiClientCheck.dispatch(onLoaded);
        }

        private function onMultiClientCheckComplete():void
        {
            var onLoaded:Signal = new Signal();
            onLoaded.addOnce(this.onGetDefaultPufflesComplete);
            this._getDefaultPuffles.dispatch(onLoaded);
        }

        private function onGetDefaultPufflesComplete():void
        {
            var onLoaded:Signal = new Signal();
            onLoaded.addOnce(this.onInitTrackingComplete);
            this._initTracking.dispatch(onLoaded);
        }

        private function onInitTrackingComplete():void
        {
            var onLoaded:Signal = new Signal();
            onLoaded.addOnce(this.onPuffleCareItemsLoaded);
            this._loadPuffleCareItems.dispatch(onLoaded);
        }

        private function onPuffleCareItemsLoaded():void
        {
            var onLoaded:Signal = new Signal();
            onLoaded.addOnce(this.onSWFAddressLoaded);
            this._loadSwfAddress.dispatch(onLoaded);
        }

        private function onSWFAddressLoaded():void
        {
        }


    }
}//package com.clubpenguin.main.command
