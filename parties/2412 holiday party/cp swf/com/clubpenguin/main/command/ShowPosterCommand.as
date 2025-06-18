//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.managers.AssetManager;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.main.overlays.vo.OverlayVO;
    import org.osflash.signals.Signal;
    import flash.events.MouseEvent;
    import com.clubpenguin.managers.vo.AssetVO;
    import flash.display.DisplayObject;

    public class ShowPosterCommand extends SignalCommand 
    {

        [Inject]
        public var assetManager:AssetManager;
        [Inject]
        public var environmentVO:EnvironmentDataVO;
        [Inject]
        public var signalBus:SignalBus;
        [Inject]
        public var filePath:String;
        private var posterOverlayVO:OverlayVO;


        override public function execute():void
        {
            this.posterOverlayVO = new OverlayVO();
            this.posterOverlayVO.isAbsoluteURL = true;
            this.posterOverlayVO.url = this.filePath;
            this.posterOverlayVO.id = "posterOverlay";
            this.posterOverlayVO.connectClose = true;
            this.loadPoster(this.posterOverlayVO);
        }

        private function loadPoster(overlayVO:OverlayVO):void
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
            if (!this.posterOverlayVO.hideLoadingDialog)
            {
                Signal(this.signalBus.hideLoadingDialog).dispatch();
            };
            assetVO.content["content"]["close_btn"].addEventListener(MouseEvent.MOUSE_UP, this.onPosterClick);
            this.showOverlay(assetVO.content);
        }

        private function onPosterClick(e:MouseEvent):void
        {
            this.signalBus.closeView.dispatch(e.target);
        }

        private function showOverlay(displayObject:DisplayObject):void
        {
            this.posterOverlayVO.object = displayObject;
            Signal(this.signalBus.showOverlay).dispatch(this.posterOverlayVO);
            this.posterOverlayVO = null;
        }


    }
}//package com.clubpenguin.main.command
