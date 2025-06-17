//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.puffles.adoption.view.GhostCongratsView;
    import com.clubpenguin.lib.signals.CloseModuleSignal;
    import com.clubpenguin.puffles.adoption.AdoptionContext;
    import com.clubpenguin.puffles.adoption.model.AdoptionModel;
    import com.clubpenguin.services.socket.puffles.PuffleCareItemsService;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.tools.localtext.core.LocalText;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import flash.events.MouseEvent;
    import flash.display.MovieClip;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class GhostCertificateViewMediator extends Mediator 
    {

        private const CHOSEN_TOKEN:String = "w.pufflecare.certificate.thiscertifies";
        private const CERTIFIES_THAT_TOKEN:String = "w.pufflecare.certificate.adoptedby";
        private const LOCATION_TOKEN:String = "w.puffleadoption.congratulations.wherepuffle";
        private const CARE_TOKEN:String = "w.pufflecare.certificate.playcare";
        private const ADOPT_TOKEN:String = "w.pufflecare.certificate.adoptedon";
        private const OK_BUTTON_TEXT:String = "w.pufflecare.care.return.ok";

        [Inject]
        public var view:GhostCongratsView;
        [Inject]
        public var closeModule:CloseModuleSignal;
        [Inject]
        public var context:AdoptionContext;
        [Inject]
        public var adoptionModel:AdoptionModel;
        [Inject]
        public var getInventoryService:PuffleCareItemsService;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var localizer:ILocalizationManager;
        [Inject]
        public var mainModel:MainModel;
        private var _adoptersName:String;
        private var MONTH_STRING:Array = [];
        private var localText:LocalText;


        override public function onRegister():void
        {
            this.localText = (LocalTextProxy.localText as LocalText);
            this.view.onCompleted.addOnce(this.onComplete);
        }

        private function onComplete():void
        {
            this.setupButtons();
            this.setPuffleName();
            this.setUserName();
            this.localizeText();
            this.replaceHeadline();
        }

        private function setupButtons():void
        {
            this.getCloseButton().buttonMode = true;
            this.getCloseButton().addEventListener(MouseEvent.MOUSE_UP, this.onCloseButtonClicked);
            this.view.okButton.buttonMode = true;
            this.view.okButton.mouseChildren = false;
            this.view.okButton.addEventListener(MouseEvent.MOUSE_UP, this.onCloseButtonClicked);
        }

        override public function onRemove():void
        {
            this.getCloseButton().removeEventListener(MouseEvent.MOUSE_UP, this.onCloseButtonClicked);
            this.view.okButton.removeEventListener(MouseEvent.MOUSE_UP, this.onCloseButtonClicked);
        }

        private function onCloseButtonClicked(mouseEvent:MouseEvent):void
        {
            this.closeCurrentModule();
        }

        private function localizeText():void
        {
            var updatedStringWithPuffle:String = this.localizer.getLocalizedString(this.LOCATION_TOKEN, this.adoptionModel.getPuffleName());
            var adoptedByText:String = this.localizer.getLocalizedString(this.CERTIFIES_THAT_TOKEN, this.mainModel.getUsername());
            this.localText.setText(this.view.wasAdopted, adoptedByText);
            this.localText.setText(this.view.certifiesThat_Text, this.localizer.getLocalizedString(this.CHOSEN_TOKEN));
            this.localText.setText(this.view.locationOfPuffleText, updatedStringWithPuffle);
            this.localText.setText(this.view.careOfPuffleText, this.localizer.getLocalizedString(this.CARE_TOKEN));
            this.localText.setText(this.view.okButtonText, this.localizer.getLocalizedString(this.OK_BUTTON_TEXT));
            this.setAdoptionDate();
        }

        private function replaceHeadline():void
        {
            var lang:String = this.mainModel.getLanguage();
            var headlineTitleMC:MovieClip = this.view.ghostAdoptionCertificateTitle;
            headlineTitleMC.gotoAndStop(lang);
        }

        private function setUserName():void
        {
            this._adoptersName = this.adoptionModel.playerVO.nickname;
        }

        private function setPuffleName():void
        {
            this.view.puffleNameTextBox.text = this.adoptionModel.getPuffleName();
        }

        private function setAdoptionDate():void
        {
            var completeText:String;
            var month:String;
            var day:Number;
            var year:Number;
            if (this.adoptionModel.selectedPuffle.adoptionDate)
            {
                this.MONTH_STRING.push(this.localizer.getLocalizedString("January"));
                this.MONTH_STRING.push(this.localizer.getLocalizedString("February"));
                this.MONTH_STRING.push(this.localizer.getLocalizedString("March"));
                this.MONTH_STRING.push(this.localizer.getLocalizedString("April"));
                this.MONTH_STRING.push(this.localizer.getLocalizedString("May"));
                this.MONTH_STRING.push(this.localizer.getLocalizedString("June"));
                this.MONTH_STRING.push(this.localizer.getLocalizedString("July"));
                this.MONTH_STRING.push(this.localizer.getLocalizedString("August"));
                this.MONTH_STRING.push(this.localizer.getLocalizedString("September"));
                this.MONTH_STRING.push(this.localizer.getLocalizedString("October"));
                this.MONTH_STRING.push(this.localizer.getLocalizedString("November"));
                this.MONTH_STRING.push(this.localizer.getLocalizedString("December"));
                month = this.MONTH_STRING[this.adoptionModel.selectedPuffle.adoptionDate.getMonth()];
                day = this.adoptionModel.selectedPuffle.adoptionDate.getDate();
                year = this.adoptionModel.selectedPuffle.adoptionDate.getFullYear();
                completeText = this.localizer.getLocalizedString(this.ADOPT_TOKEN, month, day, year);
            }
            else
            {
                completeText = "";
            };
            this.localText.setText(this.view.dateText, completeText);
        }

        private function walkPuffle():void
        {
            var dataObject:Object = {
                "puffleID":this.adoptionModel.selectedPuffle.id,
                "showAdoptionAnimation":true
            };
            var walkMessage:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_WALK_PUFFLE);
            walkMessage.data = dataObject;
            this.bridge.send(walkMessage);
        }

        private function closeCurrentModule():void
        {
            this.walkPuffle();
            this.getCloseButton().removeEventListener(MouseEvent.MOUSE_UP, this.onCloseButtonClicked);
            try
            {
                this.closeModule.dispatch(this.context.contextView);
            }
            catch(error:Error)
            {
            };
        }

        private function getCloseButton():MovieClip
        {
            return (this.view.closeButton);
        }


    }
}//package com.clubpenguin.puffles.adoption.mediators
