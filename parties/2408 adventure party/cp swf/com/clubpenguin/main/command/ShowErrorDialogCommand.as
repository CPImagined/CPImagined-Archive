//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.vo.ErrorVO;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.lib.services.notifications.INotificationService;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.main.view.ErrorDialogView;
    import com.clubpenguin.main.view.EmbeddedAssets;
    import com.clubpenguin.main.overlays.vo.ErrorOverlayVO;
    import org.osflash.signals.Signal;

    public class ShowErrorDialogCommand extends SignalCommand 
    {

        [Inject]
        public var errorVO:ErrorVO;
        [Inject]
        public var signalBus:SignalBus;
        [Inject]
        public var notificationService:INotificationService;
        [Inject]
        public var tracker:Tracker;
        private var view:ErrorDialogView;


        override public function execute():void
        {
            injector.mapValue(ErrorVO, this.errorVO);
            this.view = new ErrorDialogView(EmbeddedAssets.ErrorDialogAssets);
            this.view.onCompleted.addOnce(this.onViewComplete);
            this.notificationService.stop();
        }

        private function onViewComplete():void
        {
            var errorOverlayVO:ErrorOverlayVO = new ErrorOverlayVO(this.view, this.errorVO);
            Signal(this.signalBus.showOverlay).dispatch(errorOverlayVO);
        }


    }
}//package com.clubpenguin.main.command
