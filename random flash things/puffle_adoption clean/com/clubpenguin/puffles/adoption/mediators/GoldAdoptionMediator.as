//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.puffles.adoption.view.GoldAdoptionView;
    import com.clubpenguin.lib.signals.CloseModuleSignal;
    import com.clubpenguin.puffles.adoption.AdoptionContext;
    import com.clubpenguin.puffles.adoption.model.AdoptionModel;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.puffles.adoption.signals.AdoptionSignalBus;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.vo.PathsVO;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.tools.localtext.core.LocalText;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import flash.events.MouseEvent;
    import org.osflash.signals.Signal;
    import com.clubpenguin.puffles.adoption.model.AdoptionConstants;
    import com.clubpenguin.lib.enums.puffle.PuffleTypeEnum;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import flash.events.Event;
    import com.clubpenguin.puffles.adoption.view.GoldCongratsView;
    import com.clubpenguin.puffles.adoption.view.EmbeddedAdoptionAssets;

    public class GoldAdoptionMediator extends Mediator 
    {

        private const MAX_PUFFLES:uint = 440;
        private const NAME_NOT_ALLOWED:uint = 441;

        [Inject]
        public var view:GoldAdoptionView;
        [Inject]
        public var closeModule:CloseModuleSignal;
        [Inject]
        public var context:AdoptionContext;
        [Inject]
        public var adoptionModel:AdoptionModel;
        [Inject]
        public var localizer:ILocalizationManager;
        [Inject]
        public var adoptionSignalBus:AdoptionSignalBus;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var signalBus:AdoptionSignalBus;
        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var pathsVO:PathsVO;
        [Inject]
        public var environmentDataVO:EnvironmentDataVO;
        [Inject]
        public var tracker:Tracker;
        private var localText:LocalText;
        private var _adoptionAttemptInTransit:Boolean = false;


        override public function onRegister():void
        {
            this.localText = (LocalTextProxy.localText as LocalText);
            this.view.onCompleted.addOnce(this.onComplete);
        }

        private function onComplete():void
        {
            this.setupButtons();
            this.setupTextFields();
            this.setupServerSignals();
        }

        private function setupButtons():void
        {
            this.view.closeButton.addEventListener(MouseEvent.MOUSE_UP, this.onCloseClicked);
            this.view.adoptButton_btn.addEventListener(MouseEvent.MOUSE_OVER, this.onButtonMouseOver);
            this.view.adoptButton_btn.addEventListener(MouseEvent.MOUSE_OUT, this.onButtonMouseOut);
            this.view.adoptButton_btn.addEventListener(MouseEvent.MOUSE_UP, this.onAdoptClicked);
        }

        private function onCloseClicked(mouseEvent:MouseEvent):void
        {
            (this.adoptionSignalBus.showPuffleSignal as Signal).dispatch(this.adoptionModel.playerVO.player_id);
            this.closeCurrentModule();
        }

        private function closeCurrentModule():void
        {
            this.cleanup();
            try
            {
                this.closeModule.dispatch(this.context.contextView);
            }
            catch(error:Error)
            {
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
                    this.attemptGoldAdoption();
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

        final private function attemptGoldAdoption():void
        {
            var puffleTypeEnum:PuffleTypeEnum = PuffleTypeEnum.GOLD;
            var chosenPuffleVO:PuffleVO = new PuffleVO();
            chosenPuffleVO.type = puffleTypeEnum;
            Signal(this.signalBus.setChosenPuffle).dispatch(chosenPuffleVO);
            var puffleNameCandidate:String = this.view.puffleName_txt.text;
            this.adoptionModel.setPuffleName(puffleNameCandidate);
            this.adoptionModel.checkValidPuffleName();
        }

        private function showAdoptionOopsDialog():void
        {
            var membershipPrompt:Signal = this.mainModel.getAVMBridge().getShowMembershipPrompt();
            var data:Object = AdoptionConstants.getOopsObjectByPuffleName();
            var oopsMessageFilePath:String = this.pathsVO.data["local"][data.fileKey];
            var messageUrl:String = (this.environmentDataVO.localContentPath + oopsMessageFilePath);
            membershipPrompt.dispatch(messageUrl, data);
            this._adoptionAttemptInTransit = false;
        }

        private function setupTextFields():void
        {
            this.localText.setText(ILocalTextComponent(this.view.titlemc.getChildByName("adoptionTagline_txt")).localTextField, this.localizer.getLocalizedString("w.puffleadoption.gold.title"));
            this.localText.setText(ILocalTextComponent(this.view.choosemc.getChildByName("chooseName_txt")).localTextField, this.localizer.getLocalizedString("w.puffleadoption.rainbow.choose.name"));
            this.localText.setText(this.view.adoptButton_txt, this.localizer.getLocalizedString("w.puffleadoption.rainbow.adopt"));
            this.view.puffleName_txt.text = "";
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

        private function onValidNameSelected():void
        {
            this.adoptionModel.adoptSelectedPuffle();
        }

        private function onPuffleAdopted():void
        {
            this.cleanup();
            var goldCongratsView:GoldCongratsView = new GoldCongratsView(EmbeddedAdoptionAssets.GoldCongratulationsAsset);
            contextView.addChild(goldCongratsView);
        }

        private function onButtonMouseOver(mouseEvent:MouseEvent):void
        {
            mouseEvent.currentTarget.gotoAndStop("over");
        }

        private function onButtonMouseOut(mouseEvent:MouseEvent):void
        {
            mouseEvent.currentTarget.gotoAndStop("up");
        }

        private function cleanup():void
        {
            this.view.closeButton.removeEventListener(MouseEvent.MOUSE_UP, this.onCloseClicked);
            this.view.adoptButton_btn.removeEventListener(MouseEvent.MOUSE_OVER, this.onButtonMouseOver);
            this.view.adoptButton_btn.removeEventListener(MouseEvent.MOUSE_OUT, this.onButtonMouseOut);
            this.view.adoptButton_btn.removeEventListener(MouseEvent.MOUSE_UP, this.onAdoptClicked);
        }


    }
}//package com.clubpenguin.puffles.adoption.mediators
