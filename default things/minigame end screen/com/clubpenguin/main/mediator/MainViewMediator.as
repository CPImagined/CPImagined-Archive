//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.mediator
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.main.view.MainView;
    import com.playdom.tracker.Tracker;
    import flash.display.DisplayObject;
    import com.clubpenguin.lib.vo.PlayerVO;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.ModuleVO;
    import com.clubpenguin.lib.module.ModuleFilenamesEnum;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;

    public class MainViewMediator extends Mediator 
    {

        private const GAME_OVER:String = "zo";

        [Inject]
        public var model:MainModel;
        [Inject]
        public var signalBus:SignalBus;
        [Inject]
        public var mainView:MainView;
        [Inject]
        public var tracker:Tracker;
        private var _currentState:String = null;
        private var _isModuleLoading:Boolean = false;
        private var _queuedState:String = null;
        private var _currentModule:DisplayObject;
        private var _showRedemption:Boolean = false;
        private var isTrackingActive:Boolean;
        public var playerVO:PlayerVO;


        override public function onRegister():void
        {
            this.signalBus.moduleLoaded.add(this.onModuleLoaded);
            this.model.onStateChanged.add(this.onDeepLinkChanged);
            this.signalBus.onIntroToCP.addOnce(this.onIntroToCP);
            Signal(this.signalBus.getClosePopups()).add(this.closeAS2Content);
            this.signalBus.music.add(this.onMusicModule);
        }

        override public function onRemove():void
        {
            this.signalBus.moduleLoaded.remove(this.onModuleLoaded);
            this.signalBus.moduleLoaded.remove(this.onModuleLoaded);
            this.model.onStateChanged.remove(this.onDeepLinkChanged);
        }

        private function addStampsNotification():void
        {
            var moduleVO:ModuleVO = new ModuleVO();
            moduleVO.moduleName = ModuleFilenamesEnum.STAMPS_NOTIFICATION.key;
            moduleVO.modalBackgroundEnabled = false;
            moduleVO.hideLoadingDialog = true;
            moduleVO.moduleLayer = "notifications";
            this.signalBus.loadModule.dispatch(moduleVO);
        }

        private function onIntroToCP(firstTime:Boolean):void
        {
            var newMessage:AVMBridgeMessage;
            Log.debug((("\tMainViewMediator.onIntroToCP(" + firstTime) + ")"));
            this.mainView.mouseChildren = false;
            var moduleVO:ModuleVO = new ModuleVO();
            moduleVO.moduleName = ModuleFilenamesEnum.INTRO_TO_CLUBPENGUIN.key;
            moduleVO.modalBackgroundEnabled = false;
            moduleVO.hideLoadingDialog = true;
            moduleVO.moduleData = {"firstTime":firstTime};
            this.signalBus.loadModule.dispatch(moduleVO);
            if (firstTime == true)
            {
                newMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_PARTY_SHOW_ICON);
                this.model.getAVMBridge().send(newMessage);
            };
        }

        private function onMusicModule():void
        {
            Log.debug("");
            var moduleVO:ModuleVO = new ModuleVO();
            moduleVO.moduleName = ModuleFilenamesEnum.MUSIC.key;
            moduleVO.modalBackgroundEnabled = false;
            moduleVO.hideLoadingDialog = true;
            this.signalBus.moduleLoaded.remove(this.onModuleLoaded);
            this.signalBus.loadModule.dispatch(moduleVO);
        }

        private function onDeepLinkChanged(state:String):void
        {
            if (this._currentState != null)
            {
                if (this._currentState == state)
                {
                    return;
                };
                this.closeCurrentState();
            };
            if (this._isModuleLoading)
            {
                this._queuedState = state;
                return;
            };
            var oldState:String = this._currentState;
            this._currentState = state;
            this._isModuleLoading = true;
            var moduleVO:ModuleVO = new ModuleVO();
            moduleVO.modalBackgroundEnabled = false;
            moduleVO.hideLoadingDialog = true;
            switch (state)
            {
                case MainModel.START_SCREEN_STATE:
                    moduleVO.moduleName = ModuleFilenamesEnum.START_SCREEN.key;
                    moduleVO.moduleData = null;
                    this.signalBus.loadModule.dispatch(moduleVO);
                    break;
                case MainModel.LOGIN_STATE:
                    moduleVO.moduleName = ModuleFilenamesEnum.WORLD.key;
                    moduleVO.moduleData = null;
                    this._showRedemption = false;
                    this.signalBus.loadModule.dispatch(moduleVO);
                    break;
                case MainModel.CREATE_ACCOUNT_STATE:
                    moduleVO.moduleName = ModuleFilenamesEnum.CREATE_ACCOUNT.key;
                    moduleVO.moduleData = {"location":oldState};
                    this.signalBus.loadModule.dispatch(moduleVO);
                    break;
                case MainModel.REDEMPTION_STATE:
                    moduleVO.moduleName = ModuleFilenamesEnum.WORLD.key;
                    moduleVO.moduleData = null;
                    this._showRedemption = true;
                    this.signalBus.loadModule.dispatch(moduleVO);
                    break;
            };
        }

        private function onModuleLoaded(displayObject:BaseModule, moduleVO:ModuleVO):void
        {
            var nextState:String;
            this._currentModule = displayObject;
            this._isModuleLoading = false;
            if (((this._currentState == MainModel.LOGIN_STATE) || (this._currentState == MainModel.REDEMPTION_STATE)))
            {
                this.model.getAVMBridge().getInitialized().addOnce(this.onWorldInitialized);
            };
            if (this._queuedState != null)
            {
                nextState = this._queuedState;
                this._queuedState = null;
                this.closeCurrentState();
                this.onDeepLinkChanged(nextState);
            };
        }

        private function onWorldInitialized(langFrame:int, environment:String):void
        {
            var newMessage:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_SHOW_LOGIN);
            newMessage.data = {"showRedemption":this._showRedemption};
            this.model.getAVMBridge().send(newMessage);
            var envData:EnvironmentDataVO = this.model.getEnvironmentData();
            envData.localizedLangFrame = langFrame;
            envData.environment = environment;
            this.addStampsNotification();
        }

        private function closeCurrentState():void
        {
            switch (this._currentState)
            {
                case MainModel.START_SCREEN_STATE:
                case MainModel.CREATE_ACCOUNT_STATE:
                    this.signalBus.closeView.dispatch(this._currentModule);
                    this._currentModule = null;
                    break;
                case MainModel.REDEMPTION_STATE:
                case MainModel.LOGIN_STATE:
                    this.signalBus.unloadAs2World.dispatch(new Signal());
                    this.signalBus.cleanupClient.dispatch();
                    this._currentModule = null;
                    break;
            };
        }

        private function closeAS2Content():void
        {
            this.model.getAVMBridge().send(new AVMBridgeMessage(AVMBridgeMessage.MSG_CLOSE_CONTENT));
        }


    }
}//package com.clubpenguin.main.mediator
