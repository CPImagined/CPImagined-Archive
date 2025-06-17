//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.puffles.adoption.view.AdoptionDialogView;
    import com.clubpenguin.puffles.adoption.model.AdoptionModel;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.puffles.adoption.signals.AdoptionSignalBus;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import org.osflash.signals.Signal;
    import com.clubpenguin.tools.localtext.core.LocalText;
    import com.clubpenguin.puffles.adoption.view.PuffleCongratsView;
    import flash.utils.Timer;
    import com.clubpenguin.tools.localtext.core.ILocalTextField;
    import flash.display.MovieClip;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import com.clubpenguin.lib.enums.textrestrict.TextRestrictStringEnum;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.events.MouseEvent;
    import com.clubpenguin.lib.util.MovieClipUtil;
    import com.clubpenguin.puffles.adoption.view.EmbeddedAdoptionAssets;
    import flash.text.TextField;
    import com.clubpenguin.lib.util.StringUtils;

    public class AdoptionDialogMediator extends Mediator 
    {

        private static const PUFFLE_ANIM_DISPLAY_DELAY_TIMER_INTERVAL:uint = 4500;

        public const INVALID_NAME:uint = 441;
        private const AMBIENT1_WEIGHT:uint = 5;
        private const AMBIENT2_WEIGHT:uint = 2;
        private const SELECTED_WEIGHT:uint = 2;

        [Inject]
        public var view:AdoptionDialogView;
        [Inject]
        public var adoptionModel:AdoptionModel;
        [Inject]
        public var signalBus:SignalBus;
        [Inject]
        public var localizer:ILocalizationManager;
        [Inject]
        public var adoptionSignalBus:AdoptionSignalBus;
        [Inject]
        public var environmentDataVO:EnvironmentDataVO;
        public var closeDialog:Signal = new Signal();
        private var localText:LocalText;
        private var _puffleCongrats:PuffleCongratsView;
        private var puffleAnimDelayTimer:Timer;
        private var _validateTimer:Timer = new Timer(1000);
        private var _adoptButtonTextField:ILocalTextField;
        private var _namePreApproved:Boolean;
        private var _puffleHolderClip:MovieClip;


        override public function onRegister():void
        {
            this.localText = (LocalTextProxy.localText as LocalText);
            this.view.onCompleted.addOnce(this.onViewComplete);
        }

        private function onViewComplete():void
        {
            this.setupInputText();
            this.setupPuffleAnimationTimer();
            if (this.adoptionModel.isSelectedPuffleMemberOnly)
            {
                this.view.adoptButton.txtAdoptButtonNonMember.visible = false;
                this._adoptButtonTextField = ILocalTextComponent(this.view.adoptButton.txtAdoptButtonMember).localTextField;
            }
            else
            {
                this.view.adoptButton.txtAdoptButtonMember.visible = false;
                this.view.adoptButton.memberBadge.visible = false;
                this._adoptButtonTextField = ILocalTextComponent(this.view.adoptButton.txtAdoptButtonNonMember).localTextField;
            };
            this.goToDefaultState();
            this.localizeText();
            this.setupButtons();
            this.setupSignalListeners();
        }

        private function setupInputText():void
        {
            this.view.stage.focus = this.view.inputText;
            this.view.inputText.mouseEnabled = true;
            this.view.inputText.restrict = TextRestrictStringEnum.getRestrictStringByLanguage(this.environmentDataVO.language);
            this.view.inputText.addEventListener(Event.CHANGE, this.updateInputBackground);
            this._validateTimer.addEventListener(TimerEvent.TIMER, this.checkPuffleNameWithResponse);
        }

        private function setupPuffleAnimationTimer():void
        {
            this.puffleAnimDelayTimer = new Timer(PUFFLE_ANIM_DISPLAY_DELAY_TIMER_INTERVAL, 1);
            this.puffleAnimDelayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onPuffleAnimDelayTimerDone);
            this.displayPuffleAnim();
        }

        private function localizeText():void
        {
            this.localText.setText(this.view.subText, this.localizer.getLocalizedString("w.puffleadoption.dialog.namepuffle.title"));
            this.localText.setText(ILocalTextComponent(this.view.inputBackground.defaultText).localTextField, this.localizer.getLocalizedString("w.puffleadoption.dialog.namepuffle.entername"));
            this.localText.setText(this._adoptButtonTextField, this.localizer.getLocalizedString("w.puffleadoption.buttontext"));
            this.localText.setText(ILocalTextComponent(this.view.inputBackground.errorText).localTextField, this.localizer.getLocalizedString("w.puffleadoption.dialog.namepuffle.nameerror"));
            this.localText.setText(this.view.price, String(this.adoptionModel.selectedPuffle.price));
        }

        private function setupButtons():void
        {
            this.view.closeButton.addEventListener(MouseEvent.CLICK, this.onCloseClicked);
            this.view.inputBackground.addEventListener(MouseEvent.CLICK, this.onInputBackgroundClicked);
        }

        private function setupSignalListeners():void
        {
            this.adoptionModel.invalidNameSelected.removeAll();
            this.adoptionModel.validNameSelected.removeAll();
            this.adoptionModel.invalidNameSelected.add(this.goToInvalidNameState);
            this.adoptionModel.validNameSelected.add(this.goToValidNameState);
            this.adoptionModel.nameSuggestion.add(this.displayNameSuggestion);
            this.adoptionModel.puffleAdopted.add(this.onPuffleAdopted);
        }

        private function onPuffleAnimDelayTimerDone(event:TimerEvent):void
        {
            this.view.puffleHolder.removeChild(MovieClip(this.view.puffleHolder.getChildAt(0)));
            this.displayPuffleAnim();
        }

        private function displayPuffleAnim():void
        {
            var randomIndex:uint = this.getWeightedPuffleAnimationIndex();
            this.view.puffleHolder.addChild(this.view.puffleAnimClips[randomIndex]);
            this._puffleHolderClip = MovieClip(this.view.puffleHolder.getChildAt(0)).clip;
            this._puffleHolderClip.gotoAndPlay(1);
            var labelFrame:int = MovieClipUtil.getFrameNumberByLabel(this._puffleHolderClip, "end");
            if (labelFrame >= 0)
            {
                this._puffleHolderClip.addFrameScript((labelFrame - 2), null);
            };
            this._puffleHolderClip.addFrameScript((this._puffleHolderClip.totalFrames - 1), this.holderFrameScript);
        }

        private function getWeightedPuffleAnimationIndex():uint
        {
            var totalWeight:uint = ((this.AMBIENT1_WEIGHT + this.AMBIENT2_WEIGHT) + this.SELECTED_WEIGHT);
            var random:Number = uint((Math.random() * totalWeight));
            if (random < this.AMBIENT1_WEIGHT)
            {
                return (0);
            };
            if (random < (this.AMBIENT1_WEIGHT + this.AMBIENT2_WEIGHT))
            {
                return (1);
            };
            return (2);
        }

        private function holderFrameScript():void
        {
            this._puffleHolderClip.stop();
            this.puffleAnimDelayTimer.start();
        }

        private function onCloseClicked(mouseEvent:MouseEvent):void
        {
            this.adoptionModel.invalidNameSelected.remove(this.goToInvalidNameState);
            this.closeDialog.dispatch(false);
        }

        private function onAdoptClicked(mouseEvent:MouseEvent):void
        {
            if (this._namePreApproved)
            {
                this.adoptionModel.adoptSelectedPuffle();
            };
        }

        private function onInputBackgroundClicked(mouseEvent:MouseEvent):void
        {
            this.view.stage.focus = this.view.inputText;
        }

        private function onPuffleAdopted():void
        {
            this.adoptionModel.setPuffleName(String(this.view.inputText.text));
            this._puffleCongrats = new PuffleCongratsView(EmbeddedAdoptionAssets.PuffleCongratsAsset);
            this.view.addChild(this._puffleCongrats);
        }

        private function checkPuffleNameWithResponse(event:Event):void
        {
            if (this.doesNameStartWithSpace(String(this.view.inputText.text)))
            {
                this.goToInvalidNameState();
                return;
            };
            this._validateTimer.stop();
            this.adoptionModel.setPuffleName(String(this.view.inputText.text));
            this.adoptionModel.checkPuffleNameWithResponse();
        }

        private function doesNameStartWithSpace(name:String):Boolean
        {
            if (name.charAt(0) == " ")
            {
                return (true);
            };
            return (false);
        }

        private function requestNameSuggestion(event:MouseEvent):void
        {
            this.adoptionModel.requestNameSuggestion();
        }

        private function displayNameSuggestion(suggestion:String):void
        {
            this.view.inputText.text = suggestion;
            this.adoptionModel.setPuffleName(String(this.view.inputText.text));
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
            this.view.inputBackground.defaultText.visible = true;
            this.hideErrorText();
            this.view.inputBackground.gotoAndStop("userTypes");
        }

        private function goToProcessingState():void
        {
            this._namePreApproved = false;
            this.deactivateAdoptButton();
            this.view.inputBackground.defaultText.visible = false;
            this.hideErrorText();
            var inputText:String = StringUtils.toTitleCase(this.view.inputText.text);
            this.view.inputText.text = inputText;
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
            this.view.inputBackground.defaultText.visible = false;
            this.hideErrorText();
            this.view.inputBackground.gotoAndStop("nameApproved");
        }

        private function goToInvalidNameState():void
        {
            this._namePreApproved = false;
            this.deactivateAdoptButton();
            this.view.inputBackground.defaultText.visible = false;
            this.showErrorText();
            this.view.inputBackground.gotoAndStop("nameRejected");
        }

        private function activateAdoptButton():void
        {
            this.view.adoptButton.gotoAndStop("_up");
            this.view.adoptButton.buttonMode = true;
            this.view.adoptButton.mouseChildren = false;
            this._adoptButtonTextField.textField.textColor = 5519376;
            this.view.adoptButton.addEventListener(MouseEvent.CLICK, this.onAdoptClicked);
        }

        private function deactivateAdoptButton():void
        {
            this.view.adoptButton.buttonMode = false;
            this.view.adoptButton.gotoAndStop("deactivated");
            this._adoptButtonTextField.textField.textColor = 0x666666;
            this.view.adoptButton.removeEventListener(MouseEvent.CLICK, this.onAdoptClicked);
        }

        private function hideErrorText():void
        {
            this.view.inputBackground.errorText.visible = false;
            this.view.inputBackground.errorBubble.visible = false;
        }

        private function showErrorText():void
        {
            this.view.inputBackground.errorText.visible = true;
            this.view.inputBackground.errorBubble.visible = true;
        }

        override public function onRemove():void
        {
            var puffleAnimClip:MovieClip = MovieClip(this.view.puffleHolder.getChildAt(0));
            this.view.puffleHolder.removeChild(puffleAnimClip);
            this.view.inputText.removeEventListener(Event.CHANGE, this.updateInputBackground);
            this._validateTimer.removeEventListener(TimerEvent.TIMER, this.checkPuffleNameWithResponse);
            this.puffleAnimDelayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onPuffleAnimDelayTimerDone);
            this.view.closeButton.removeEventListener(MouseEvent.CLICK, this.onCloseClicked);
            this.view.inputBackground.removeEventListener(MouseEvent.CLICK, this.onInputBackgroundClicked);
            this.view.adoptButton.removeEventListener(MouseEvent.CLICK, this.onAdoptClicked);
            this.adoptionModel.invalidNameSelected.remove(this.goToInvalidNameState);
            this.adoptionModel.validNameSelected.remove(this.goToValidNameState);
            this.adoptionModel.nameSuggestion.remove(this.displayNameSuggestion);
            this.adoptionModel.puffleAdopted.remove(this.onPuffleAdopted);
        }


    }
}//package com.clubpenguin.puffles.adoption.mediators
