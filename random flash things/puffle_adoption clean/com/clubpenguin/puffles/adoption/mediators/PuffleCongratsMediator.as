//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.puffles.adoption.view.PuffleCongratsView;
    import com.clubpenguin.puffles.adoption.AdoptionContext;
    import com.clubpenguin.lib.signals.CloseModuleSignal;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.puffles.adoption.model.AdoptionModel;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.managers.resource.ResourceManager;
    import com.clubpenguin.tools.localtext.core.LocalText;
    import com.clubpenguin.lib.vo.puffle.CareItemVO;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import com.clubpenguin.lib.enums.puffle.PuffleTypeEnum;
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.services.http.LoadSWFService;
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import com.clubpenguin.lib.services.http.LoadSWFResponse;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class PuffleCongratsMediator extends Mediator 
    {

        private static var WILD_FRAME_LABEL:String = "wild_";
        private static var CARE_ICON_LOCATION:String = "global/puffle/care_icons/";
        private static var PUFFLE_ITEM_1_ID:Number = 3;
        private static var ITEM_1_QUANTITY:Number = 5;
        private static var PUFFLE_ITEM_2_ID:Number = 79;
        private static var ITEM_2_QUANTITY:Number = 1;
        private static var CARE_ITEM_SCALE:Number = 1.3;
        private static var CARE_ITEM_X_OFFSET:Number = 19;
        private static var CARE_ITEM_Y_OFFSET:Number = 15;

        [Inject]
        public var view:PuffleCongratsView;
        [Inject]
        public var context:AdoptionContext;
        [Inject]
        public var closeModule:CloseModuleSignal;
        [Inject]
        public var localizer:ILocalizationManager;
        [Inject]
        public var adoptionModel:AdoptionModel;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var mainModel:IAppModel;
        [Inject]
        public var resourceManager:ResourceManager;
        private var localText:LocalText;
        private var MONTH_STRING:Array = [];
        private var _isWildPuffle:Boolean;
        private var _careItem1VO:CareItemVO;
        private var _careItem2VO:CareItemVO;


        override public function onRegister():void
        {
            this.localText = (LocalTextProxy.localText as LocalText);
            this.view.onCompleted.addOnce(this.onComplete);
        }

        private function onComplete():void
        {
            this._isWildPuffle = this.adoptionModel.selectedPuffle.isWild;
            this.setView();
            this.setupButtons();
            this.setPuffleName();
            if (((!(this._isWildPuffle)) && (!(this.adoptionModel.selectedPuffle.type.id == PuffleTypeEnum.RAINBOW.id))))
            {
                this.getItemIcon();
                this.localizeText();
                this.loadCareItemIcons();
            }
            else
            {
                this.localizeText();
            };
        }

        private function setView():void
        {
            var frameLabel:String;
            if (this._isWildPuffle)
            {
                frameLabel = (WILD_FRAME_LABEL + String(this.adoptionModel.selectedPuffle.subType.id));
            }
            else
            {
                frameLabel = this.adoptionModel.selectedPuffle.type.colorName;
            };
            MovieClip(this.view.getView()).gotoAndStop(frameLabel);
        }

        private function setupButtons():void
        {
            this.view.closeButton.addEventListener(MouseEvent.MOUSE_UP, this.onCloseButtonPressed);
            this.view.okButton.addEventListener(MouseEvent.MOUSE_UP, this.onOKButtonPressed);
            this.view.okButton.addEventListener(MouseEvent.MOUSE_DOWN, this.onButtonMouseDown);
            this.view.okButton.addEventListener(MouseEvent.MOUSE_OVER, this.onButtonMouseOver);
            this.view.okButton.addEventListener(MouseEvent.MOUSE_OUT, this.onButtonMouseOut);
        }

        private function setPuffleName():void
        {
            if (this.adoptionModel.getPuffleName() != null)
            {
                this.localText.setText(this.view.puffleName_Txt, this.adoptionModel.getPuffleName());
            }
            else
            {
                Log.error(("ERROR: Puffle Name is " + this.adoptionModel.getPuffleName()));
            };
        }

        private function getItemIcon():void
        {
            this._careItem1VO = CareItemVO(this.resourceManager.getPuffleCareItemCollection().getItem(PUFFLE_ITEM_1_ID));
            this._careItem2VO = CareItemVO(this.resourceManager.getPuffleCareItemCollection().getItem(PUFFLE_ITEM_2_ID));
        }

        private function loadCareItemIcons():void
        {
            var itemAsset1URL:String = ((this.mainModel.getEnvironmentData().contentPath + CARE_ICON_LOCATION) + this._careItem1VO.assetPath);
            var loadSWFService:LoadSWFService = new LoadSWFService(itemAsset1URL);
            loadSWFService.requestFailed.addOnce(this.onPuffleItem1IconLoaded);
            loadSWFService.responseReceived.addOnce(this.onPuffleItem1IconLoaded);
            loadSWFService.send();
        }

        private function onPuffleItem1IconLoaded(response:LoadSWFResponse):void
        {
            var mc:DisplayObject;
            if (response.success)
            {
                mc = this.view.item1.addChild(Loader(response.data));
                mc.x = (mc.x + CARE_ITEM_X_OFFSET);
                mc.y = (mc.y + CARE_ITEM_Y_OFFSET);
                mc.scaleX = CARE_ITEM_SCALE;
                mc.scaleY = CARE_ITEM_SCALE;
            }
            else
            {
                Log.error((("ERROR: Could not load " + this._careItem1VO.prompt) + " icon"));
            };
            var itemAsset2URL:String = ((this.mainModel.getEnvironmentData().contentPath + CARE_ICON_LOCATION) + this._careItem2VO.assetPath);
            var loadSWFService:LoadSWFService = new LoadSWFService(itemAsset2URL);
            loadSWFService.requestFailed.addOnce(this.onPuffleItem2IconLoaded);
            loadSWFService.responseReceived.addOnce(this.onPuffleItem2IconLoaded);
            loadSWFService.send();
        }

        private function onPuffleItem2IconLoaded(response:LoadSWFResponse):void
        {
            var mc:DisplayObject;
            if (response.success)
            {
                mc = this.view.item2.addChild(Loader(response.data));
                mc.x = (mc.x + CARE_ITEM_X_OFFSET);
                mc.y = (mc.y + CARE_ITEM_Y_OFFSET);
                mc.scaleX = CARE_ITEM_SCALE;
                mc.scaleY = CARE_ITEM_SCALE;
            }
            else
            {
                Log.error((("ERROR: Could not load " + this._careItem2VO.prompt) + " icon"));
            };
        }

        private function localizeText():void
        {
            var lang:String;
            var updatedStringWithPlayer:String;
            var updatedStringWithPuffle:String = this.localizer.getLocalizedString("w.puffleadoption.congratulations.wherepuffle", this.adoptionModel.getPuffleName());
            if (((this._isWildPuffle) || (this.adoptionModel.selectedPuffle.type.id == PuffleTypeEnum.RAINBOW.id)))
            {
                lang = this.mainModel.getLanguage();
                this.view.adoptionCertificateTitle.gotoAndStop(lang);
                updatedStringWithPlayer = this.localizer.getLocalizedString("w.pufflecare.certificate.adoptedby", this.mainModel.getUsername());
                this.localText.setText(this.view.hasChosen_Txt, this.localizer.getLocalizedString("w.pufflecare.certificate.thiscertifies"));
                this.localText.setText(this.view.wasAdopted_Txt, updatedStringWithPlayer);
                this.localText.setText(this.view.whereWildPuffle_Txt, updatedStringWithPuffle);
                this.localText.setText(this.view.careOfPuffle_Txt, this.localizer.getLocalizedString("w.pufflecare.certificate.playcare"));
                this.localText.setText(this.view.date_Txt, this.getAdoptionDateString());
            }
            else
            {
                this.localText.setText(this.view.title_Txt, this.localizer.getLocalizedString("w.puffleadoption.gold.congratulations.title"));
                this.localText.setText(this.view.description_Txt, this.localizer.getLocalizedString("w.puffleadoption.congratulations.items"));
                this.localText.setText(this.view.adoptionCertificate_Txt, this.localizer.getLocalizedString("w.pufflecare.manual.card.revamp.label.certificate"));
                this.localText.setText(this.view.item1_Txt, String(this._careItem1VO.prompt));
                this.view.item1Amount_Txt.text = String(ITEM_1_QUANTITY);
                this.localText.setText(this.view.item2_Txt, String(this._careItem2VO.prompt));
                this.view.item2Amount_Txt.text = String(ITEM_2_QUANTITY);
                this.localText.setText(this.view.whereRegularPuffle_Txt, updatedStringWithPuffle);
            };
            this.localText.setText(this.view.button_Txt, this.localizer.getLocalizedString("w.puffleadoption.gold.poster.memberbutton"));
        }

        private function getAdoptionDateString():String
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
                completeText = this.localizer.getLocalizedString("w.pufflecare.certificate.adoptedon", month, day, year);
            }
            else
            {
                completeText = "...";
            };
            return (completeText);
        }

        private function onCloseButtonPressed(mouseEvent:MouseEvent):void
        {
            this.closeCurrentModule();
        }

        private function onOKButtonPressed(mouseEvent:MouseEvent):void
        {
            this.closeCurrentModule();
        }

        private function closeCurrentModule():void
        {
            this.walkPuffle();
            this.destroy();
            this.view.closeButton.removeEventListener(MouseEvent.MOUSE_UP, this.onCloseButtonPressed);
            try
            {
                this.closeModule.dispatch(this.context.contextView);
            }
            catch(error:Error)
            {
                Log.fatal(("[PuffleCongratsMediator] Close Crash: \n" + error.getStackTrace()));
            };
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

        private function onButtonMouseOver(mouseEvent:MouseEvent):void
        {
            MovieClip(mouseEvent.currentTarget).gotoAndStop("over");
        }

        private function onButtonMouseOut(mouseEvent:MouseEvent):void
        {
            MovieClip(mouseEvent.currentTarget).gotoAndStop("up");
        }

        private function onButtonMouseDown(mouseEvent:MouseEvent):void
        {
            MovieClip(mouseEvent.currentTarget).gotoAndStop("down");
        }

        private function destroy():void
        {
            this.view.closeButton.removeEventListener(MouseEvent.MOUSE_UP, this.onCloseButtonPressed);
            this.view.okButton.removeEventListener(MouseEvent.MOUSE_UP, this.onOKButtonPressed);
            this.view.okButton.removeEventListener(MouseEvent.MOUSE_DOWN, this.onButtonMouseDown);
            this.view.okButton.removeEventListener(MouseEvent.MOUSE_OVER, this.onButtonMouseOver);
            this.view.okButton.removeEventListener(MouseEvent.MOUSE_OUT, this.onButtonMouseOut);
        }


    }
}//package com.clubpenguin.puffles.adoption.mediators
