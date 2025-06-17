//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.vo.PromptVO;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.lib.services.notifications.INotificationService;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.main.view.PromptView;
    import com.clubpenguin.main.view.EmbeddedAssets;
    import com.clubpenguin.main.overlays.vo.PromptOverlayVO;
    import org.osflash.signals.Signal;

    public class ShowPromptCommand extends SignalCommand 
    {

        [Inject]
        public var promptVO:PromptVO;
        [Inject]
        public var signalBus:SignalBus;
        [Inject]
        public var notificationService:INotificationService;
        [Inject]
        public var model:MainModel;
        private var view:PromptView;


        override public function execute():void
        {
            injector.mapValue(PromptVO, this.promptVO);
            this.view = new PromptView(EmbeddedAssets.PromptAssets);
            this.view.onCompleted.addOnce(this.onViewComplete);
            this.model.activePrompt = this.view;
            this.notificationService.stop();
        }

        private function onViewComplete():void
        {
            var promptOverlayVO:PromptOverlayVO = new PromptOverlayVO(this.view, this.promptVO);
            Signal(this.signalBus.showOverlay).dispatch(promptOverlayVO);
        }


    }
}//package com.clubpenguin.main.command
