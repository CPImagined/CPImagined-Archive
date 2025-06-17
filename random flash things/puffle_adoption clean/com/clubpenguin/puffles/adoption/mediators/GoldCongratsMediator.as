//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.puffles.adoption.view.GoldCongratsView;
    import com.clubpenguin.lib.signals.CloseModuleSignal;
    import com.clubpenguin.puffles.adoption.AdoptionContext;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.puffles.adoption.model.AdoptionModel;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.services.socket.puffles.PuffleCareItemsService;
    import com.clubpenguin.tools.localtext.core.LocalText;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import flash.events.MouseEvent;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class GoldCongratsMediator extends Mediator 
    {

        [Inject]
        public var view:GoldCongratsView;
        [Inject]
        public var closeModule:CloseModuleSignal;
        [Inject]
        public var context:AdoptionContext;
        [Inject]
        public var localizer:ILocalizationManager;
        [Inject]
        public var adoptionModel:AdoptionModel;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var getInventoryService:PuffleCareItemsService;
        private var localText:LocalText;


        override public function onRegister():void
        {
            this.localText = (LocalTextProxy.localText as LocalText);
            this.view.onCompleted.addOnce(this.onComplete);
        }

        private function onComplete():void
        {
            this.setupButtons();
            this.localizeText();
        }

        private function setupButtons():void
        {
            this.view.closeButton.addEventListener(MouseEvent.MOUSE_UP, this.onOkButtonClicked);
            this.view.okButton.addEventListener(MouseEvent.MOUSE_OVER, this.onButtonMouseOver);
            this.view.okButton.addEventListener(MouseEvent.MOUSE_OUT, this.onButtonMouseOut);
            this.view.okButton.addEventListener(MouseEvent.MOUSE_UP, this.onOkButtonClicked);
        }

        private function onCloseClicked(mouseEvent:MouseEvent):void
        {
            this.closeCurrentModule();
        }

        private function closeCurrentModule():void
        {
            this.view.closeButton.removeEventListener(MouseEvent.MOUSE_UP, this.onCloseClicked);
            this.view.okButton.removeEventListener(MouseEvent.MOUSE_OVER, this.onButtonMouseOver);
            this.view.okButton.removeEventListener(MouseEvent.MOUSE_OUT, this.onButtonMouseOut);
            this.view.okButton.removeEventListener(MouseEvent.MOUSE_UP, this.onOkButtonClicked);
            try
            {
                this.closeModule.dispatch(this.context.contextView);
            }
            catch(error:Error)
            {
            };
        }

        private function onOkButtonClicked(mouseEvent:MouseEvent):void
        {
            this.walkPuffle();
        }

        private function walkPuffle():void
        {
            this.getInventoryService.requestInventory();
            this.view.okButton.visible = false;
            var dataObject:Object = new Object();
            dataObject.puffleID = this.adoptionModel.selectedPuffle.id;
            dataObject.showAdoptionAnimation = false;
            var walkMessage:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_WALK_PUFFLE);
            walkMessage.data = dataObject;
            this.bridge.send(walkMessage);
            this.closeCurrentModule();
        }

        private function localizeText():void
        {
            this.localText.setText(this.view.congratsTitle_txt, this.localizer.getLocalizedString("w.puffleadoption.gold.congratulations.title"));
            this.localText.setText(this.view.congratsDescription_txt, this.localizer.getLocalizedString("w.puffleadoption.gold.congratulations.description1"));
            this.localText.setText(this.view.adoptionCertificate_txt, this.localizer.getLocalizedString("w.puffleadoption.gold.congratulations.item1"));
            this.localText.setText(this.view.toy_txt, this.localizer.getLocalizedString("w.puffleadoption.gold.congratulations.item2"));
            this.localText.setText(this.view.okButton_txt, this.localizer.getLocalizedString("w.dialog.button.ok"));
            this.localText.setText(this.view.puffleName_txt, this.adoptionModel.getPuffleName());
        }

        private function onButtonMouseOver(mouseEvent:MouseEvent):void
        {
            mouseEvent.currentTarget.gotoAndStop("over");
        }

        private function onButtonMouseOut(mouseEvent:MouseEvent):void
        {
            mouseEvent.currentTarget.gotoAndStop("up");
        }


    }
}//package com.clubpenguin.puffles.adoption.mediators
