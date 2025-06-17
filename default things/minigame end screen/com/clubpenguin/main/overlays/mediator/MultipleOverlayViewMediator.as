//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.overlays.mediator
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.main.overlays.view.MultipleOverlayView;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.lib.services.socket.IConnection;
    import org.robotlegs.core.IInjector;
    import com.clubpenguin.main.model.ModuleModel;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import flash.display.Sprite;
    import com.clubpenguin.main.overlays.view.OverlayView;
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import flash.display.DisplayObject;
    import com.clubpenguin.main.view.dialogs.LoadingDialogView;
    import com.clubpenguin.main.overlays.vo.LoadingOverlayVO;
    import com.clubpenguin.main.overlays.vo.OverlayVO;
    import flash.display.MovieClip;
    import flash.display.Loader;
    import com.clubpenguin.main.overlays.vo.MembershipOverlayVO;
    import com.clubpenguin.main.overlays.vo.MembershipFAQOverlayVO;
    import com.clubpenguin.main.overlays.vo.ModuleOverlayVO;
    import com.clubpenguin.lib.module.INotificationModule;
    import flash.events.MouseEvent;
    import com.clubpenguin.lib.module.ModuleFilenamesEnum;

    public class MultipleOverlayViewMediator extends Mediator 
    {

        [Inject]
        public var view:MultipleOverlayView;
        [Inject]
        public var signalBus:SignalBus;
        [Inject]
        public var _model:MainModel;
        [Inject]
        public var localizationManager:ILocalizationManager;
        [Inject]
        public var _connection:IConnection;
        [Inject]
        public var injector:IInjector;
        [Inject]
        public var moduleModel:ModuleModel;
        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var tracker:Tracker;
        private var _swfBridge:IAVMBridgeService;
        private var overlays:Array = [];


        override public function onRegister():void
        {
            this._swfBridge = this._model.getAVMBridge();
            this.signalBus.showLoadingDialog.add(this.onShowLoading);
            this.signalBus.hideLoadingDialog.add(this.onHideLoading);
            this.signalBus.showOverlay.add(this.onShowOverlayRequested);
            this.signalBus.showMembershipPrompt.add(this.onShowMembershipPrompt);
            this.signalBus.showMembershipPufflePrompt.add(this.onShowMembershipPufflePrompt);
            this.signalBus.showMembershipFAQ.add(this.onShowMembershipFAQ);
            this.signalBus.closeView.add(this.onCloseOverlayClicked);
            this.signalBus.cleanupClient.add(this.onClearAllOverlays);
            var worldLayer:Sprite = new Sprite();
            worldLayer.name = "world";
            this.view.addChild(worldLayer);
            var notificationLayer:Sprite = new Sprite();
            notificationLayer.name = "notifications";
            this.view.addChild(notificationLayer);
        }

        private function onCloseOverlayClicked(displayObject:DisplayObject):void
        {
            var bridge:IAVMBridgeService;
            var overlayView:OverlayView;
            if ((displayObject is BaseModule))
            {
                bridge = this._model.getAVMBridge();
                if (bridge.isConnected())
                {
                    this._model.getAVMBridge().send(new AVMBridgeMessage(AVMBridgeMessage.MSG_MODULE_CLOSED));
                };
                this.moduleModel.removeModule(BaseModule(displayObject));
            };
            var i:int;
            while (i < this.overlays.length)
            {
                overlayView = OverlayView(this.overlays[i]);
                if (overlayView.contains(displayObject))
                {
                    this.removeOverlayByView(overlayView);
                    break;
                };
                i++;
            };
        }

        private function onShowLoading():void
        {
            var loadingDialog:LoadingDialogView = new LoadingDialogView();
            loadingDialog.x = ((760 - loadingDialog.width) * 0.5);
            loadingDialog.y = ((435 - loadingDialog.height) * 0.5);
            var loadingOverlay:LoadingOverlayVO = new LoadingOverlayVO(loadingDialog);
            this.mainModel.loadingOverlayVO = loadingOverlay;
            this.showOverlay(loadingOverlay);
        }

        private function onHideLoading():void
        {
            this.removeOverlayByID(LoadingOverlayVO.LOADING_OVERLAY_ID);
        }

        private function onShowOverlayRequested(overlayVO:OverlayVO):void
        {
            this.showOverlay(overlayVO);
        }

        private function onShowMembershipPrompt(overlayVO:MembershipOverlayVO):void
        {
            var overlayView:OverlayView = this.showOverlay(overlayVO);
            if (overlayView == null)
            {
                return;
            };
            var mediator:MembershipPromptMediator = new MembershipPromptMediator();
            this.injector.injectInto(mediator);
            mediator.setDependencies(MovieClip(Loader(overlayVO.object).content), overlayView, this.signalBus.closeView, overlayVO.dataObject);
        }

        private function onShowMembershipPufflePrompt(overlayVO:MembershipOverlayVO):void
        {
            var overlayView:OverlayView = this.showOverlay(overlayVO);
            if (overlayView == null)
            {
                return;
            };
            var mediator:MembershipPufflePromptMediator = new MembershipPufflePromptMediator();
            this.injector.injectInto(mediator);
            mediator.setDependencies(MovieClip(Loader(overlayVO.object).content), overlayView, this.signalBus.closeView, overlayVO.dataObject);
        }

        private function onShowMembershipFAQ(overlayVO:MembershipFAQOverlayVO):void
        {
            var overlayView:OverlayView = this.showOverlay(overlayVO);
            if (overlayView == null)
            {
                return;
            };
            var mediator:MembershipFAQMediator = new MembershipFAQMediator();
            this.injector.injectInto(mediator);
            mediator.setDependencies(this._model, MovieClip(Loader(overlayVO.object).content), overlayView, this.signalBus.closeView, overlayVO.dataObject);
        }

        public function showOverlay(overlayVO:OverlayVO):OverlayView
        {
            if (!overlayVO)
            {
                return (null);
            };
            return (this.addNewOverlayView(overlayVO));
        }

        private function addNewOverlayView(overlayVO:OverlayVO):OverlayView
        {
            var moduleOverlayVO:ModuleOverlayVO;
            var notifcationModule:INotificationModule;
            if (!overlayVO)
            {
                return (null);
            };
            var overlayView:OverlayView = new OverlayView(overlayVO.object, overlayVO.modalBackgroundEnabled);
            if (((overlayVO.layer == null) || (this.view.getChildByName(overlayVO.layer) == null)))
            {
                overlayVO.layer = "world";
            };
            var layer:Sprite = Sprite(this.view.getChildByName(overlayVO.layer));
            if (layer.getChildByName(overlayVO.id))
            {
                return (null);
            };
            var addedOverlayView:OverlayView = OverlayView(layer.addChild(overlayView));
            addedOverlayView.name = overlayVO.id;
            if (overlayVO.disableMouse)
            {
                overlayView.mouseChildren = false;
                overlayView.mouseEnabled = false;
            };
            if (overlayVO.id)
            {
                overlayView.name = String(overlayVO.id);
            };
            this.overlays.push(overlayView);
            overlayView.vo = overlayVO;
            if (overlayVO.connectClose)
            {
                try
                {
                    overlayVO.object["close_btn"].addEventListener(MouseEvent.MOUSE_UP, this.onCloseBtnClicked);
                }
                catch(error:Error)
                {
                };
            };
            if ((overlayView.vo is ModuleOverlayVO))
            {
                moduleOverlayVO = ModuleOverlayVO(overlayView.vo);
                if (((moduleOverlayVO.moduleVO.blockPuffleNotifications) && (this.moduleModel.isModuleOpen(ModuleFilenamesEnum.NOTIFICATIONS))))
                {
                    notifcationModule = INotificationModule(this.moduleModel.getModuleWithKey(ModuleFilenamesEnum.NOTIFICATIONS));
                    notifcationModule.getNotificationService().stop();
                };
            };
            return (overlayView);
        }

        public function onCloseBtnClicked(e:MouseEvent):void
        {
            this.signalBus.closeView.dispatch(e.target);
        }

        public function removeOverlayByView(overlayView:OverlayView):Boolean
        {
            var i:int;
            var moduleOverlayVO:ModuleOverlayVO;
            var notifcationModule:INotificationModule;
            if (this.view.contains(overlayView))
            {
                Sprite(this.view.getChildByName(overlayView.vo.layer)).removeChild(overlayView);
                if (mediatorMap.hasMediatorForView(overlayView))
                {
                    mediatorMap.removeMediatorByView(overlayView);
                };
                i = 0;
                while (i < this.overlays.length)
                {
                    if (this.overlays[i] == overlayView)
                    {
                        this.overlays.splice(i, 1);
                    };
                    i++;
                };
                overlayView.close();
                if ((overlayView.vo is ModuleOverlayVO))
                {
                    moduleOverlayVO = ModuleOverlayVO(overlayView.vo);
                    if (((moduleOverlayVO.moduleVO.blockPuffleNotifications) && (this.moduleModel.isModuleOpen(ModuleFilenamesEnum.NOTIFICATIONS))))
                    {
                        notifcationModule = INotificationModule(this.moduleModel.getModuleWithKey(ModuleFilenamesEnum.NOTIFICATIONS));
                        notifcationModule.getNotificationService().start();
                    };
                };
                return (true);
            };
            throw (new Error("MultipleOverlayViewMediator -> ERROR! Someone tried to remove an overlay that wasn't being shown."));
        }

        public function removeOverlayByID(ID:String):void
        {
            var overlayView:OverlayView;
            for each (overlayView in this.overlays)
            {
                if (overlayView.name == ID)
                {
                    this.removeOverlayByView(overlayView);
                };
            };
        }

        private function onClearAllOverlays():void
        {
            var overlay:OverlayView;
            var i:int;
            while (i < this.overlays.length)
            {
                overlay = this.overlays[i];
                if (this.view.contains(overlay))
                {
                    if (overlay.isBaseModule())
                    {
                        overlay.close();
                    };
                    Sprite(this.view.getChildByName(overlay.vo.layer)).removeChild(overlay);
                };
                this.overlays[i] = null;
                overlay = null;
                i++;
            };
            this.overlays = new Array();
        }


    }
}//package com.clubpenguin.main.overlays.mediator
