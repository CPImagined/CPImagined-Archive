//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.vo.ModuleVO;
    import com.clubpenguin.managers.AssetManager;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.main.MainContext;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.main.model.ModuleModel;
    import com.clubpenguin.main.signal.loadingScreen.ShowLoadingScreenSignal;
    import com.clubpenguin.main.signal.loadingScreen.HideLoadingScreenSignal;
    import com.clubpenguin.main.overlays.vo.ModuleOverlayVO;
    import com.clubpenguin.lib.module.ModuleFilenamesEnum;
    import com.clubpenguin.main.overlays.type.OverlayType;
    import com.clubpenguin.main.overlays.vo.OverlayVO;
    import flash.display.Loader;
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.managers.vo.AssetVO;
    import org.osflash.signals.Signal;

    public class LoadModuleCommand extends SignalCommand 
    {

        [Inject]
        public var moduleVO:ModuleVO;
        [Inject]
        public var assetManager:AssetManager;
        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var signalBus:SignalBus;
        [Inject]
        public var context:MainContext;
        [Inject]
        public var localizationManager:ILocalizationManager;
        [Inject]
        public var moduleModel:ModuleModel;
        [Inject]
        public var showLoadingScreen:ShowLoadingScreenSignal;
        [Inject]
        public var hideLoadingScreen:HideLoadingScreenSignal;
        private var _overlayVO:ModuleOverlayVO = new ModuleOverlayVO();


        override public function execute():void
        {
            var moduleName:String;
            if (this.moduleModel.isModuleOpen(ModuleFilenamesEnum.getValue(this.moduleVO.moduleName)))
            {
                return;
            };
            try
            {
                moduleName = this.moduleVO.moduleName;
                this._overlayVO.type = OverlayType.MODULE;
                this._overlayVO.dataObject = this.moduleVO.moduleData;
                this._overlayVO.id = moduleName;
                this._overlayVO.url = ModuleFilenamesEnum.getValue(moduleName).filename;
                this._overlayVO.modalBackgroundEnabled = this.moduleVO.modalBackgroundEnabled;
                this._overlayVO.hideLoadingDialog = this.moduleVO.hideLoadingDialog;
                this._overlayVO.isExternal = ModuleFilenamesEnum.getValue(moduleName).isExternal;
                this._overlayVO.disableMouse = this.moduleVO.disableMouse;
                this._overlayVO.layer = this.moduleVO.moduleLayer;
                this._overlayVO.persistent = this.moduleVO.persistent;
                this._overlayVO.moduleVO = this.moduleVO;
                this.loadModule(this._overlayVO);
            }
            catch(error:Error)
            {
            };
        }

        private function loadModule(overlayVO:OverlayVO):void
        {
            if (!overlayVO.hideLoadingDialog)
            {
                this.signalBus.showLoadingDialog.dispatch();
            };
            this.assetManager.assetLoaded.add(this.onModuleLoaded);
            this.assetManager.loadAsset(overlayVO);
            this.assetManager.assetFailed.addOnce(this.onModuleFailedToLoad);
            this.assetManager.progressReceived.add(this.onProgressReceived);
        }

        private function onProgressReceived(bytesLoaded:uint, bytesTotal:uint):void
        {
            this.signalBus.updateLoadingDialog.dispatch(((bytesLoaded / bytesTotal) * 100));
        }

        private function onModuleLoaded(assetVO:AssetVO):void
        {
            if (assetVO.id != this._overlayVO.id)
            {
                return;
            };
            this.assetManager.assetLoaded.remove(this.onModuleLoaded);
            this.assetManager.progressReceived.remove(this.onProgressReceived);
            if (!this._overlayVO.hideLoadingDialog)
            {
                this.signalBus.hideLoadingDialog.dispatch();
            };
            var loader:Loader = Loader(assetVO.content);
            var baseModule:BaseModule = BaseModule(loader.content);
            baseModule.injector = this.context.getInjector().createChild(loader.contentLoaderInfo.applicationDomain);
            baseModule.data = this.moduleVO.moduleData;
            baseModule.parentLoader = loader;
            baseModule.init();
            this.showModule(baseModule);
        }

        private function onModuleFailedToLoad():void
        {
            this.assetManager.progressReceived.remove(this.onProgressReceived);
            this.signalBus.hideLoadingDialog.dispatch();
        }

        private function showModule(module:BaseModule):void
        {
            this._overlayVO.object = module;
            var moduleKey:ModuleFilenamesEnum = ModuleFilenamesEnum.getValue(this._overlayVO.id);
            this.moduleModel.addModuleWithKey(module, moduleKey);
            Signal(this.signalBus.showOverlay).dispatch(this._overlayVO);
            Signal(this.signalBus.moduleLoaded).dispatch(module, this.moduleVO);
            this._overlayVO = null;
        }


    }
}//package com.clubpenguin.main.command
