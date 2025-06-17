//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.managers.AssetManager;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.main.MainContext;
    import com.clubpenguin.main.overlays.vo.MembershipFAQOverlayVO;
    import org.osflash.signals.Signal;
    import com.clubpenguin.main.overlays.vo.OverlayVO;
    import com.clubpenguin.managers.vo.AssetVO;
    import flash.display.DisplayObject;

    public class LoadMembershipFAQCommand extends SignalCommand 
    {

        [Inject]
        public var assetManager:AssetManager;
        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var signalBus:SignalBus;
        [Inject]
        public var context:MainContext;
        [Inject]
        public var filePath:String;
        [Inject]
        public var data:Object;
        private var overlayVO:MembershipFAQOverlayVO = new MembershipFAQOverlayVO();


        override public function execute():void
        {
            this.overlayVO.url = this.filePath;
            this.loadPrompt(this.overlayVO);
        }

        private function loadPrompt(overlayVO:OverlayVO):void
        {
            if (!overlayVO.hideLoadingDialog)
            {
                Signal(this.signalBus.showLoadingDialog).dispatch();
            };
            this.assetManager.assetLoaded.addOnce(this.onOverlayLoaded);
            this.assetManager.loadAsset(overlayVO);
        }

        private function onOverlayLoaded(assetVO:AssetVO):void
        {
            if (!this.overlayVO.hideLoadingDialog)
            {
                Signal(this.signalBus.hideLoadingDialog).dispatch();
            };
            this.showOverlay(assetVO.content);
        }

        private function showOverlay(displayObject:DisplayObject):void
        {
            this.overlayVO.object = displayObject;
            this.overlayVO.dataObject = this.data;
            Signal(this.signalBus.showMembershipFAQ).dispatch(this.overlayVO);
            this.overlayVO = null;
        }


    }
}//package com.clubpenguin.main.command
