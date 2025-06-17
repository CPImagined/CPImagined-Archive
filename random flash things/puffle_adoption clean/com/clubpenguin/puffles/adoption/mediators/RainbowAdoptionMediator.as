//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.puffles.adoption.view.RainbowAdoptionView;
    import com.clubpenguin.puffles.adoption.signals.AdoptionSignalBus;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.puffles.adoption.model.AdoptionModel;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.vo.PathsVO;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import com.clubpenguin.puffles.adoption.services.PuffleAdoptionDLearningService;
    import com.clubpenguin.lib.signals.CloseModuleSignal;
    import com.clubpenguin.puffles.adoption.AdoptionContext;
    import com.clubpenguin.services.socket.puffles.PuffleCareItemsService;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.puffles.adoption.view.AdoptionDialogView;
    import com.clubpenguin.tools.localtext.core.LocalText;
    import com.clubpenguin.puffles.adoption.view.PuffleCongratsView;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import flash.events.Event;
    import org.osflash.signals.Signal;
    import flash.events.MouseEvent;
    import com.clubpenguin.puffles.adoption.model.AdoptionConstants;
    import com.clubpenguin.lib.enums.puffle.PuffleTypeEnum;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import com.clubpenguin.puffles.adoption.view.EmbeddedAdoptionAssets;

    public class RainbowAdoptionMediator extends Mediator 
    {

        private const MAX_PUFFLES:uint = 440;
        private const NAME_NOT_ALLOWED:uint = 441;

        [Inject]
        public var view:RainbowAdoptionView;
        [Inject]
        public var adoptionSignalBus:AdoptionSignalBus;
        [Inject]
        public var localizer:ILocalizationManager;
        [Inject]
        public var adoptionModel:AdoptionModel;
        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var pathsVO:PathsVO;
        [Inject]
        public var environmentDataVO:EnvironmentDataVO;
        [Inject]
        public var signalBus:AdoptionSignalBus;
        [Inject]
        public var dlearningService:PuffleAdoptionDLearningService;
        [Inject]
        public var closeModule:CloseModuleSignal;
        [Inject]
        public var context:AdoptionContext;
        [Inject]
        public var getInventoryService:PuffleCareItemsService;
        [Inject]
        public var bridge:IAVMBridgeService;
        private var adoptionDialogView:AdoptionDialogView;
        private var _adoptionAttemptInTransit:Boolean = false;
        private var localText:LocalText;
        private var _puffleCongrats:PuffleCongratsView;


        override public function onRegister():void
        {
            this.localText = (LocalTextProxy.localText as LocalText);
            this.view.onCompleted.addOnce(this.onComplete);
        }

        private function onComplete():void
        {
            this.setupButtons();
            this.setupTextFields();
            this.view.modalClip.visible = false;
            this.setupServerSignals();
        }

        private function setupServerSignals():void
        {
            this.view.addEventListener(Event.REMOVED_FROM_STAGE, this.doGarbageCollection, false, 0, true);
            this.adoptionModel.invalidNameSelected.add(this.onInvalidNameSelected);
            this.adoptionModel.validNameSelected.add(this.onValidNameSelected);
            this.adoptionModel.puffleAdopted.add(this.onPuffleAdopted);
        }

        final private function onInvalidNameSelected():void
        {
            (this.adoptionSignalBus.sendError as Signal).dispatch(this.NAME_NOT_ALLOWED);
            this._adoptionAttemptInTransit = false;
        }

        final private function onValidNameSelected():void
        {
            this.adoptionModel.adoptSelectedPuffle();
        }

        final private function setupButtons():void
        {
            this.view.closeButton.addEventListener(MouseEvent.CLICK, this.onCloseClicked, false, 0, true);
            this.view.adoptBtn.addEventListener(MouseEvent.CLICK, this.onAdoptClicked, false, 0, true);
        }

        final private function onAdoptClicked(event:MouseEvent):void
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
            if (this.view.puffleName_txt.text.length == 0)
            {
                this.adoptionModel.invalidNameSelected.dispatch();
                this._adoptionAttemptInTransit = false;
                return;
            };
            if (isMember)
            {
                if (!overPuffleLimit)
                {
                    this.attemptRainbowAdoption();
                }
                else
                {
                    (this.adoptionSignalBus.sendError as Signal).dispatch(this.MAX_PUFFLES);
                    this._adoptionAttemptInTransit = false;
                };
            }
            else
            {
                this.showAdoptionOopsDialog();
                this._adoptionAttemptInTransit = false;
            };
        }

        final private function attemptRainbowAdoption():void
        {
            var puffleTypeEnum:PuffleTypeEnum = PuffleTypeEnum.RAINBOW;
            var chosenPuffleVO:PuffleVO = new PuffleVO();
            chosenPuffleVO.type = puffleTypeEnum;
            Signal(this.signalBus.setChosenPuffle).dispatch(chosenPuffleVO);
            var puffleNameCandidate:String = this.view.puffleName_txt.text;
            this.adoptionModel.setPuffleName(puffleNameCandidate);
            this.adoptionModel.checkValidPuffleName();
        }

        final private function onCloseAdoption(yesAdoptClicked:Boolean):void
        {
            if (!yesAdoptClicked)
            {
                this.view.modalClip.visible = false;
            };
            this.view.removeChild(this.adoptionDialogView);
        }

        private function showAdoptionOopsDialog():void
        {
            var membershipPrompt:Signal = this.mainModel.getAVMBridge().getShowMembershipPrompt();
            var data:Object = AdoptionConstants.getOopsObjectByPuffleName();
            var oopsMessageFilePath:String = this.pathsVO.data["global"][AdoptionConstants.OOPS_ADOPT_MEMBER_PUFFLE_FILE_KEY];
            var messageUrl:String = (this.environmentDataVO.globalContentPath + oopsMessageFilePath);
            membershipPrompt.dispatch(messageUrl, data);
            this._adoptionAttemptInTransit = false;
        }

        final private function onCloseClicked(event:MouseEvent):void
        {
            try
            {
                this.closeModule.dispatch(this.context.contextView);
            }
            catch(error:Error)
            {
            };
        }

        final private function setupTextFields():void
        {
            this.localText.setText(this.view.adoptionTagline_txt, this.localizer.getLocalizedString(AdoptionConstants.RAINBOW_CHOSEN_YOU));
            this.localText.setText(this.view.chooseName_txt, this.localizer.getLocalizedString(AdoptionConstants.RAINBOW_CHOOSE_NAME));
            this.localText.setText(this.view.adopt_txt, this.localizer.getLocalizedString(AdoptionConstants.RAINBOW_ADOPT));
        }

        private function walkPuffle():void
        {
            this.adoptionModel.trackAdoptedWithoutQuiz();
            this.view.adoptBtn.visible = false;
            var dataObject:Object = new Object();
            dataObject.puffleID = this.adoptionModel.selectedPuffle.id;
            dataObject.showAdoptionAnimation = false;
            var walkMessage:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_WALK_PUFFLE);
            walkMessage.data = dataObject;
            this.bridge.send(walkMessage);
        }

        private function onPuffleAdopted():void
        {
            this.dlearningService.adoptPuffle(this.adoptionModel.selectedPuffle.type.colorName);
            this.walkPuffle();
            this.getInventoryService.requestInventory();
            this._puffleCongrats = new PuffleCongratsView(EmbeddedAdoptionAssets.PuffleCongratsAsset);
            this.view.addChild(this._puffleCongrats);
        }

        final private function doGarbageCollection(event:Event):void
        {
            this.adoptionModel.invalidNameSelected.remove(this.onInvalidNameSelected);
            this.adoptionModel.validNameSelected.remove(this.onValidNameSelected);
            this.adoptionModel.puffleAdopted.remove(this.onPuffleAdopted);
        }


    }
}//package com.clubpenguin.puffles.adoption.mediators
