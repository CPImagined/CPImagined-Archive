//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.puffles.adoption.view.GhostAdoptionView;
    import com.clubpenguin.puffles.adoption.AdoptionContext;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.lib.vo.PathsVO;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import com.clubpenguin.puffles.adoption.model.AdoptionModel;
    import com.clubpenguin.lib.signals.CloseModuleSignal;
    import com.clubpenguin.puffles.adoption.signals.AdoptionSignalBus;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.puffles.adoption.view.GhostCongratsView;
    import com.clubpenguin.tools.localtext.core.LocalText;
    import flash.utils.Timer;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;
    import com.clubpenguin.lib.enums.puffle.PuffleSubTypeEnum;
    import com.clubpenguin.lib.enums.puffle.PuffleTypeEnum;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.enums.textrestrict.TextRestrictStringEnum;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.text.TextField;
    import com.clubpenguin.lib.util.StringUtils;
    import flash.events.MouseEvent;
    import com.clubpenguin.puffles.adoption.view.EmbeddedAdoptionAssets;

    public class GhostAdoptionMediator extends Mediator 
    {

        private const TITLE_TOKEN:String = "w.puffleadoption.dialog.costincludes.prompt";
        private const DEFAULT_INPUT_TOKEN:String = "w.puffleadoption.dialog.namepuffle.entername";
        private const ADOPT_BUTTON_TOKEN:String = "w.puffleadoption.selected.stats.adoptbutton";
        private const ERROR_DESCRIPTION_TOKEN:String = "w.app.error.message.nameunavailable";

        [Inject]
        public var view:GhostAdoptionView;
        [Inject]
        public var context:AdoptionContext;
        [Inject]
        public var mainModel:IAppModel;
        [Inject]
        public var pathsVO:PathsVO;
        [Inject]
        public var environmentDataVO:EnvironmentDataVO;
        [Inject]
        public var adoptionModel:AdoptionModel;
        [Inject]
        public var closeModule:CloseModuleSignal;
        [Inject]
        public var adoptionSignalBus:AdoptionSignalBus;
        [Inject]
        public var localization:ILocalizationManager;
        [Inject]
        public var tracker:Tracker;
        private var _puffleCongrats:GhostCongratsView;
        private var localText:LocalText;
        private var _validateTimer:Timer = new Timer(1000);
        private var _namePreApproved:Boolean;
        private var _adoptionButtonTranslation:String;


        override public function onRegister():void
        {
            this.localText = (LocalTextProxy.localText as LocalText);
            this.view.onCompleted.addOnce(this.onComplete);
        }

        private function onComplete():void
        {
            this.setupSelectedPuffle();
            this.setupInputText();
            this.setupButtons();
            this.setupTextFields();
            this.setupServerSignals();
        }

        private function setupSelectedPuffle():void
        {
            var chosenPuffleVO:PuffleVO = new PuffleVO();
            var puffleSubTypeEnum:PuffleSubTypeEnum = PuffleSubTypeEnum.getPuffleSubTypeEnumByID(this.adoptionModel.puffleAdoptionTypeId);
            var puffleTypeEnum:PuffleTypeEnum = PuffleTypeEnum.getPuffleTypeEnumByID(puffleSubTypeEnum.baseTypeId);
            chosenPuffleVO.type = puffleTypeEnum;
            chosenPuffleVO.subType = puffleSubTypeEnum;
            Signal(this.adoptionSignalBus.setChosenPuffle).dispatch(chosenPuffleVO);
        }

        private function setupInputText():void
        {
            this.view.stage.focus = this.view.inputTextField;
            this.view.inputTextField.mouseEnabled = true;
            this.view.inputTextField.restrict = TextRestrictStringEnum.getRestrictStringByLanguage(this.environmentDataVO.language);
            this.view.inputTextField.addEventListener(Event.CHANGE, this.updateInputBackground);
            this._validateTimer.addEventListener(TimerEvent.TIMER, this.checkPuffleNameWithResponse);
        }

        private function updateInputBackground(event:Event):void
        {
            if (TextField(event.target).length > 0)
            {
                this.goToProcessingState();
            }
            else
            {
                this.goToDefaultState();
            };
        }

        private function goToDefaultState():void
        {
            this._namePreApproved = false;
            this.deactivateAdoptButton();
            this.view.inputDefaultText.visible = true;
            this.hideErrorText();
            this.view.inputBackground.gotoAndStop("userTypes");
        }

        private function goToProcessingState():void
        {
            this._namePreApproved = false;
            this.deactivateAdoptButton();
            this.view.inputDefaultText.visible = false;
            this.hideErrorText();
            var inputText:String = StringUtils.toTitleCase(this.view.inputTextField.text);
            this.view.inputTextField.text = inputText;
            this.view.inputBackground.gotoAndStop("loading");
            if (this.adoptionModel.isNameCached(inputText))
            {
                if (this.adoptionModel.isNameValid(inputText))
                {
                    this.goToValidNameState();
                }
                else
                {
                    this.goToInvalidNameState();
                };
            }
            else
            {
                this._validateTimer.reset();
                this._validateTimer.start();
            };
        }

        private function goToValidNameState():void
        {
            this._namePreApproved = true;
            this.activateAdoptButton();
            this.view.inputDefaultText.visible = false;
            this.hideErrorText();
            this.view.inputBackground.gotoAndStop("nameApproved");
        }

        private function goToInvalidNameState():void
        {
            this._namePreApproved = false;
            this.deactivateAdoptButton();
            this.view.inputDefaultText.visible = false;
            this.showErrorText();
            this.view.inputBackground.gotoAndStop("nameRejected");
        }

        private function activateAdoptButton():void
        {
            this.view.adoptButton.gotoAndStop("_up");
            this.view.adoptButton.buttonMode = true;
            this.view.adoptButton.mouseChildren = false;
            this.view.adoptButtonText.text = this._adoptionButtonTranslation;
            this.view.adoptButton.addEventListener(MouseEvent.CLICK, this.onAdoptClicked);
        }

        private function deactivateAdoptButton():void
        {
            this.view.adoptButton.buttonMode = false;
            this.view.adoptButton.gotoAndStop("deactivated");
            this.view.adoptButton.removeEventListener(MouseEvent.CLICK, this.onAdoptClicked);
        }

        private function hideErrorText():void
        {
            this.view.errorField.visible = false;
        }

        private function showErrorText():void
        {
            this.view.errorField.visible = true;
        }

        private function setupButtons():void
        {
            this.view.closeButton.addEventListener(MouseEvent.MOUSE_UP, this.onCloseClicked, false, 0, true);
            this.view.inputBackground.addEventListener(MouseEvent.CLICK, this.onInputBackgroundClicked);
            this.deactivateAdoptButton();
            this.hideErrorText();
        }

        private function onInputBackgroundClicked(event:MouseEvent):void
        {
            this.view.stage.focus = this.view.inputTextField;
        }

        private function setupTextFields():void
        {
            this.view.adoptPuffleText.text = this.localization.getLocalizedString(this.TITLE_TOKEN);
            this.view.inputDefaultText.text = this.localization.getLocalizedString(this.DEFAULT_INPUT_TOKEN);
            this.view.errorFieldText.text = this.localization.getLocalizedString(this.ERROR_DESCRIPTION_TOKEN);
            this._adoptionButtonTranslation = this.localization.getLocalizedString(this.ADOPT_BUTTON_TOKEN);
            this.view.adoptButtonText.text = this._adoptionButtonTranslation;
        }

        private function setupServerSignals():void
        {
            this.adoptionModel.invalidNameSelected.removeAll();
            this.adoptionModel.validNameSelected.removeAll();
            this.adoptionModel.invalidNameSelected.add(this.goToInvalidNameState);
            this.adoptionModel.validNameSelected.add(this.goToValidNameState);
            this.adoptionModel.puffleAdopted.add(this.onPuffleAdopted);
        }

        private function checkPuffleNameWithResponse(event:Event):void
        {
            this._validateTimer.stop();
            this.adoptionModel.setPuffleName(String(this.view.inputTextField.text));
            this.adoptionModel.checkPuffleNameWithResponse();
        }

        private function onCloseClicked(event:MouseEvent):void
        {
            this.adoptionModel.invalidNameSelected.remove(this.goToInvalidNameState);
            this.closeCurrentModule();
        }

        private function closeCurrentModule():void
        {
            try
            {
                this.closeModule.dispatch(this.context.contextView);
            }
            catch(e:Error)
            {
            };
        }

        private function onAdoptClicked(event:MouseEvent):void
        {
            if (this._namePreApproved)
            {
                this.adoptionModel.adoptSelectedPuffle();
            };
        }

        private function onPuffleAdopted():void
        {
            this.adoptionModel.setPuffleName(String(this.view.inputTextField.text));
            this._puffleCongrats = new GhostCongratsView(EmbeddedAdoptionAssets.GhostCongratsAsset);
            this.view.addChild(this._puffleCongrats);
        }

        override public function onRemove():void
        {
            this.view.inputTextField.removeEventListener(Event.CHANGE, this.updateInputBackground);
            this._validateTimer.removeEventListener(TimerEvent.TIMER, this.checkPuffleNameWithResponse);
            this.view.closeButton.removeEventListener(MouseEvent.CLICK, this.onCloseClicked);
            this.view.inputBackground.removeEventListener(MouseEvent.CLICK, this.onInputBackgroundClicked);
            this.view.adoptButton.removeEventListener(MouseEvent.CLICK, this.onAdoptClicked);
            this.adoptionModel.invalidNameSelected.remove(this.goToInvalidNameState);
            this.adoptionModel.validNameSelected.remove(this.goToValidNameState);
            this.adoptionModel.puffleAdopted.remove(this.onPuffleAdopted);
        }


    }
}//package com.clubpenguin.puffles.adoption.mediators
