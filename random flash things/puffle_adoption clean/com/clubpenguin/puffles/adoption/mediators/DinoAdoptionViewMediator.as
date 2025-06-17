//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.puffles.adoption.view.DinoAdoptionView;
    import com.clubpenguin.lib.signals.CloseModuleSignal;
    import com.clubpenguin.puffles.adoption.AdoptionContext;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.puffles.adoption.signals.AdoptionSignalBus;
    import com.clubpenguin.puffles.adoption.model.AdoptionModel;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.puffles.adoption.view.DinoCertificateView;
    import com.clubpenguin.tools.localtext.core.LocalText;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import flash.events.MouseEvent;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.puffles.adoption.model.AdoptionConstants;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;
    import com.clubpenguin.lib.enums.puffle.PuffleSubTypeEnum;
    import com.clubpenguin.lib.enums.puffle.PuffleTypeEnum;
    import flash.events.Event;
    import com.clubpenguin.puffles.adoption.view.EmbeddedAdoptionAssets;

    public class DinoAdoptionViewMediator extends Mediator 
    {

        private const MAX_PUFFLES:uint = 440;
        private const NAME_NOT_ALLOWED:uint = 441;

        [Inject]
        public var view:DinoAdoptionView;
        [Inject]
        public var closeModule:CloseModuleSignal;
        [Inject]
        public var context:AdoptionContext;
        [Inject]
        public var tracker:Tracker;
        [Inject]
        public var adoptionSignalBus:AdoptionSignalBus;
        [Inject]
        public var adoptionModel:AdoptionModel;
        [Inject]
        public var localizer:ILocalizationManager;
        private var _adoptionAttemptInTransit:Boolean = false;
        private var _dinoCertificateView:DinoCertificateView;
        private var localText:LocalText;


        override public function onRegister():void
        {
            this.localText = (LocalTextProxy.localText as LocalText);
            this.view.onCompleted.addOnce(this.onComplete);
        }

        private function onComplete():void
        {
            var dinoFramLabel:String = ("dino_" + String(this.adoptionModel.puffleAdoptionTypeId));
            this.view.getPuffleView.gotoAndStop(dinoFramLabel);
            this.setupButtons();
            this.setupTextFields();
            this.setupServerSignals();
        }

        private function setupButtons():void
        {
            this.view.closeButton.addEventListener(MouseEvent.MOUSE_UP, this.onCloseClicked);
            this.view.adoptButton.addEventListener(MouseEvent.MOUSE_OVER, this.onButtonMouseOver);
            this.view.adoptButton.addEventListener(MouseEvent.MOUSE_OUT, this.onButtonMouseOut);
            this.view.adoptButton.addEventListener(MouseEvent.MOUSE_DOWN, this.onButtonMouseOut);
            this.view.adoptButton.addEventListener(MouseEvent.MOUSE_UP, this.onAdoptClicked);
        }

        private function onCloseClicked(mouseEvent:MouseEvent):void
        {
            (this.adoptionSignalBus.showPuffleSignal as Signal).dispatch(this.adoptionModel.playerVO.player_id);
            this.closeCurrentModule();
        }

        private function closeCurrentModule():void
        {
            Log.info("Closing DinoAdoptionViewMediator.");
            this.cleanup();
            try
            {
                this.closeModule.dispatch(this.context.contextView);
            }
            catch(error:Error)
            {
                Log.error(("[DinoAdoptionViewMediator] " + error.getStackTrace()));
            };
        }

        private function onAdoptClicked(mouseEvent:MouseEvent):void
        {
            var numPuffles:uint;
            if (this._adoptionAttemptInTransit)
            {
                return;
            };
            this._adoptionAttemptInTransit = true;
            var isMember:Boolean = this.adoptionModel.playerVO.is_member;
            numPuffles = this.adoptionModel.playerVO.puffles.getSize();
            var overPuffleLimit:* = (numPuffles >= AdoptionConstants.MEMBER_PUFFLE_LIMIT);
            if (this.view.puffleNameTextBox.text.length == 0)
            {
                this.adoptionModel.invalidNameSelected.dispatch();
                this._adoptionAttemptInTransit = false;
                return;
            };
            if (!overPuffleLimit)
            {
                this.attemptDinoPuffleAdoption();
            }
            else
            {
                (this.adoptionSignalBus.sendError as Signal).dispatch(this.MAX_PUFFLES);
                this._adoptionAttemptInTransit = false;
            };
        }

        final private function attemptDinoPuffleAdoption():void
        {
            var chosenPuffleVO:PuffleVO = new PuffleVO();
            var puffleSubTypeEnum:PuffleSubTypeEnum = PuffleSubTypeEnum.getPuffleSubTypeEnumByID(this.adoptionModel.puffleAdoptionTypeId);
            var puffleTypeEnum:PuffleTypeEnum = PuffleTypeEnum.getPuffleTypeEnumByID(puffleSubTypeEnum.baseTypeId);
            chosenPuffleVO.type = puffleTypeEnum;
            chosenPuffleVO.subType = puffleSubTypeEnum;
            Signal(this.adoptionSignalBus.setChosenPuffle).dispatch(chosenPuffleVO);
            var puffleNameCandidate:String = this.view.puffleNameTextBox.text;
            this.adoptionModel.setPuffleName(puffleNameCandidate);
            this.adoptionModel.checkValidPuffleName();
        }

        private function setupTextFields():void
        {
            var dinoPuffleTypeString:String;
            this.localText.setText(this.view.adoptButtonText, this.localizer.getLocalizedString("w.puffleadoption.rainbow.adopt"));
            this.localText.setText(this.view.chooseNameText, this.localizer.getLocalizedString("w.puffleadoption.rainbow.choose.name"));
            if (((this.adoptionModel.puffleAdoptionTypeId == 1000) || (this.adoptionModel.puffleAdoptionTypeId == 1001)))
            {
                dinoPuffleTypeString = this.localizer.getLocalizedString("w.p2014.prehistoric.dialogue.adoptionText.trex");
            }
            else
            {
                if (((this.adoptionModel.puffleAdoptionTypeId == 1002) || (this.adoptionModel.puffleAdoptionTypeId == 1003)))
                {
                    dinoPuffleTypeString = this.localizer.getLocalizedString("w.p2014.prehistoric.dialogue.adoptionText.triceratops");
                }
                else
                {
                    if (((this.adoptionModel.puffleAdoptionTypeId == 1004) || (this.adoptionModel.puffleAdoptionTypeId == 1005)))
                    {
                        dinoPuffleTypeString = this.localizer.getLocalizedString("w.p2014.prehistoric.dialogue.adoptionText.stegosaurus");
                    }
                    else
                    {
                        dinoPuffleTypeString = "";
                    };
                };
            };
            this.localText.setText(this.view.dinoAdoptionTitle, this.localizer.getLocalizedString("w.p2014.prehistoric.dialogue.adoptionText", dinoPuffleTypeString));
        }

        private function setupServerSignals():void
        {
            this.view.addEventListener(Event.REMOVED_FROM_STAGE, this.doGarbageCollection, false, 0, true);
            this.adoptionModel.invalidNameSelected.add(this.onInvalidNameSelected);
            this.adoptionModel.validNameSelected.add(this.onValidNameSelected);
            this.adoptionModel.puffleAdopted.add(this.onPuffleAdopted);
        }

        private function doGarbageCollection(event:Event):void
        {
            this.adoptionModel.invalidNameSelected.remove(this.onInvalidNameSelected);
            this.adoptionModel.validNameSelected.remove(this.onValidNameSelected);
            this.adoptionModel.puffleAdopted.remove(this.onPuffleAdopted);
        }

        private function onInvalidNameSelected():void
        {
            (this.adoptionSignalBus.sendError as Signal).dispatch(this.NAME_NOT_ALLOWED);
            this._adoptionAttemptInTransit = false;
        }

        private function onPuffleAdopted():void
        {
            this.cleanup();
            this._dinoCertificateView = new DinoCertificateView(EmbeddedAdoptionAssets.DinoCertificateAsset);
            this.view.addChild(this._dinoCertificateView);
        }

        private function onValidNameSelected():void
        {
            this.adoptionModel.adoptSelectedPuffle();
        }

        private function onButtonMouseOver(mouseEvent:MouseEvent):void
        {
            mouseEvent.currentTarget.gotoAndStop("_over");
        }

        private function onButtonMouseOut(mouseEvent:MouseEvent):void
        {
            mouseEvent.currentTarget.gotoAndStop("_up");
        }

        private function cleanup():void
        {
            this.view.closeButton.removeEventListener(MouseEvent.MOUSE_UP, this.onCloseClicked);
            this.view.adoptButton.removeEventListener(MouseEvent.MOUSE_OVER, this.onButtonMouseOver);
            this.view.adoptButton.removeEventListener(MouseEvent.MOUSE_OUT, this.onButtonMouseOut);
            this.view.adoptButton.removeEventListener(MouseEvent.MOUSE_DOWN, this.onButtonMouseOut);
            this.view.adoptButton.removeEventListener(MouseEvent.MOUSE_UP, this.onAdoptClicked);
        }


    }
}//package com.clubpenguin.puffles.adoption.mediators
