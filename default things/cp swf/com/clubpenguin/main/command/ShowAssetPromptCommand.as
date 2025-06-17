//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.vo.AssetPromptVO;
    import com.clubpenguin.lib.services.notifications.INotificationService;
    import com.clubpenguin.main.mediator.dialogs.AssetPromptMediator;
    import com.clubpenguin.managers.AssetManager;
    import com.clubpenguin.main.signal.SignalBus;
    import org.osflash.signals.Signal;
    import com.clubpenguin.managers.vo.AssetVO;
    import flash.display.DisplayObject;

    public class ShowAssetPromptCommand extends SignalCommand 
    {

        [Inject]
        public var assetPromptVO:AssetPromptVO;
        [Inject]
        public var notificationService:INotificationService;
        [Inject]
        public var assetPromptMediator:AssetPromptMediator;
        [Inject]
        public var assetManager:AssetManager;
        [Inject]
        public var signalBus:SignalBus;


        override public function execute():void
        {
            this.notificationService.stop();
            this.loadAsset();
        }

        private function loadAsset():void
        {
            if (!this.assetPromptVO.hideLoadingDialog)
            {
                Signal(this.signalBus.showLoadingDialog).dispatch();
            };
            this.assetManager.assetLoaded.addOnce(this.onAssetPromptLoaded);
            this.assetManager.loadAsset(this.assetPromptVO);
        }

        private function onAssetPromptLoaded(assetVO:AssetVO):void
        {
            if (!this.assetPromptVO.hideLoadingDialog)
            {
                Signal(this.signalBus.hideLoadingDialog).dispatch();
            };
            this.showAssetPrompt(assetVO.content);
        }

        private function showAssetPrompt(displayObject:DisplayObject):void
        {
            this.assetPromptVO.object = displayObject;
            this.assetPromptMediator.init(this.assetPromptVO, this.notificationService);
        }


    }
}//package com.clubpenguin.main.command
