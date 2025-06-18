//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.mediator.dialogs
{
    import org.robotlegs.mvcs.Mediator;
    import flash.utils.Dictionary;
    import com.clubpenguin.main.view.PromptView;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.main.vo.PromptVO;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.services.notifications.INotificationService;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.tools.localtext.core.ILocalText;
    import flash.net.URLLoader;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import flash.events.Event;
    import flash.net.URLRequest;
    import com.clubpenguin.lib.enums.resource.CacheTypeEnum;
    import org.osflash.signals.natives.NativeSignal;
    import flash.events.MouseEvent;
    import flash.display.DisplayObject;
    import com.clubpenguin.lib.services.http.LoadSWFService;
    import flash.display.Loader;
    import com.clubpenguin.lib.services.http.LoadSWFResponse;
    import com.clubpenguin.main.vo.CardDataVO;
    import com.adobe.serialization.json.JSONDecoder;
    import com.clubpenguin.main.vo.CardVO;
    import com.clubpenguin.main.view.CardView;
    import flash.display.MovieClip;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class PromptMediator extends Mediator 
    {

        private static const PROMPT_STYLE_QUESTION:String = "question";
        private static const PROMPT_STYLE_GAME:String = "game";
        private static const PROMPT_STYLE_OK:String = "ok";
        private static const PROMPT_STYLE_WAIT:String = "wait";
        private static const PROMPT_STYLE_IGLOO:String = "igloo";
        private static const PROMPT_STYLE_SHOP:String = "shop";
        private static const PROMPT_STYLE_COIN:String = "coin";
        private static const PROMPT_STYLE_INPUT:String = "input";
        private static const PROMPT_STYLE_WARN:String = "warn";
        private static const PROMPT_STYLE_IGNORE:String = "ignore";
        private static const PROMPT_STYLE_BUY_CARDS:String = "buyCards";
        private static const PROMPT_STYLE_GET_CARDS:String = "getCards";
        private static const CARDS_JSON:String = "cards.json";
        private static const CARD_ICONS_SUB_DIR:String = "card/icons/";

        private const cardViewToContainer:Dictionary = new Dictionary();

        [Inject]
        public var view:PromptView;
        [Inject]
        public var signalBus:SignalBus;
        [Inject]
        public var localizationManager:ILocalizationManager;
        [Inject]
        public var promptVO:PromptVO;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var notificationService:INotificationService;
        [Inject]
        public var environmentDataVO:EnvironmentDataVO;
        [Inject]
        public var mainModel:MainModel;
        private var localText:ILocalText;


        override public function onRegister():void
        {
            var webServicePath:String;
            var loader:URLLoader;
            this.localText = (LocalTextProxy.localText as ILocalText);
            this.view.gotoAndStop(this.promptVO.style);
            switch (this.promptVO.style)
            {
                case PROMPT_STYLE_SHOP:
                    this.loadIcon();
                    break;
                case PROMPT_STYLE_INPUT:
                    this.loadIcon();
                    this.view.text_input.restrict = this.localizationManager.getLocalizedString("chat_restrict");
                    this.view.stage.focus = this.view.text_input;
                    this.view.text_input.setSelection(this.view.text_input.text.length, this.view.text_input.text.length);
                    break;
                case PROMPT_STYLE_IGNORE:
                    LocalTextProxy.localText.setText(this.view.message_bottom_txt, this.localizationManager.getLocalizedString("ignore_prompt_help"));
                    break;
                case PROMPT_STYLE_GET_CARDS:
                    this.view.loading.gotoAndPlay(2);
                    webServicePath = ((this.environmentDataVO.getBaseConfigPath() + this.environmentDataVO.language) + this.environmentDataVO.web_service);
                    loader = new URLLoader();
                    loader.addEventListener(Event.COMPLETE, this.onCardsJsonLoaded);
                    try
                    {
                        loader.load(new URLRequest(((webServicePath + CARDS_JSON) + CacheTypeEnum.getCacheAsStringByType("config"))));
                    }
                    catch(error:Error)
                    {
                        mainModel.onClosePrompt();
                    };
                    this.mainModel.cardsCache = null;
                    break;
            };
            if (this.view.message != null)
            {
                this.localText.setText(this.view.message, this.promptVO.message);
            };
            if (this.view.continue_btn != null)
            {
                this.promptButtonSetup(this.view.continue_btn, this.onContinueClicked);
            };
            if (this.view.yes_btn != null)
            {
                this.promptButtonSetup(this.view.yes_btn, this.onYesClicked);
            };
            if (this.view.no_btn != null)
            {
                this.promptButtonSetup(this.view.no_btn, this.onNoClicked);
            };
            if (this.view.ok_btn != null)
            {
                this.promptButtonSetup(this.view.ok_btn, this.onOkClicked);
            };
            if (this.view.close_btn != null)
            {
                this.promptButtonSetup(this.view.close_btn, this.onCloseClicked);
            };
        }

        private function promptButtonSetup(button:DisplayObject, buttonFunction:Function):void
        {
            new NativeSignal(button, MouseEvent.CLICK).addOnce(buttonFunction);
        }

        private function loadIcon():void
        {
            this.view.loading.gotoAndPlay(2);
            var loadSWFService:LoadSWFService = new LoadSWFService(this.promptVO.file);
            loadSWFService.requestFailed.addOnce(this.onIconLoadedResponse);
            loadSWFService.responseReceived.addOnce(this.onIconLoadedResponse);
            loadSWFService.send();
        }

        private function onIconLoadedResponse(response:LoadSWFResponse):void
        {
            if (response.success)
            {
                this.view.icon_mc.addChild(Loader(response.data));
                this.view.loading.gotoAndStop(1);
            };
        }

        public function onCardsJsonLoaded(event:Event):void
        {
            var card:Object;
            var cardID1:uint;
            var cardID2:uint;
            var cardID3:uint;
			var cardID4:uint;
            var cardID5:uint;
            var cardID6:uint;
            var cardDataVO:CardDataVO;
            this.view.loading.gotoAndStop(1);
            var jsonDecoder:JSONDecoder = new JSONDecoder(event.target.data, false);
            var decodedObject:Object = jsonDecoder.getValue();
            var cardDataVOs:Array = [];
            for each (card in decodedObject)
            {
                cardDataVO = new CardDataVO(card.card_id, card.element, card.color, card.value, card.power_id);
                cardDataVOs[cardDataVO.cardId] = cardDataVO;
            };
            CardVO.CARD_LOADER_DATA[CardVO.ICON_URL] = (this.environmentDataVO.gamesPath + CARD_ICONS_SUB_DIR);
            cardID1 = this.promptVO.cards.pop();
            this.createCardView(this.view.card5, cardDataVOs[cardID1], cardID1);
            cardID2 = this.promptVO.cards.pop();
            this.createCardView(this.view.card1, cardDataVOs[cardID2], cardID2);
            cardID3 = this.promptVO.cards.pop();
            this.createCardView(this.view.card2, cardDataVOs[cardID3], cardID3);
			cardID4 = this.promptVO.cards.pop();
            this.createCardView(this.view.card3, cardDataVOs[cardID4], cardID4);
			cardID5 = this.promptVO.cards.pop();
            this.createCardView(this.view.card4, cardDataVOs[cardID5], cardID5);
			cardID6 = this.promptVO.cards.pop();
            this.createCardView(this.view.card0, cardDataVOs[cardID6], cardID6);
        }

        private function createCardView(promptCardView:MovieClip, cardCardDataVO:CardDataVO, cardID:uint):void
        {
            if (!cardCardDataVO)
            {
                return;
            };
            var cardVO:CardVO = new CardVO(cardCardDataVO.cardId, cardCardDataVO.element, cardCardDataVO.colorHex, cardCardDataVO.value, cardCardDataVO.isPowercard);
            var cardView:CardView = new CardView(cardVO);
            this.cardViewToContainer[cardView] = promptCardView;
            cardView.created.addOnce(this.onCardViewCreated);
        }

        private function onCardViewCreated(cardView:CardView):void
        {
            cardView.memberOnly(false);
            var promptCardView:MovieClip = (this.cardViewToContainer[cardView] as MovieClip);
            this.cardViewToContainer[cardView] = null;
            promptCardView.addChild(cardView.skin);
        }

        private function onCloseClicked(event:MouseEvent):void
        {
            this.sendSelectedMessage("close", "");
        }

        private function onContinueClicked(event:MouseEvent):void
        {
            this.sendSelectedMessage("continue", this.view.text_input.text);
        }

        private function onYesClicked(event:MouseEvent):void
        {
            this.sendSelectedMessage("yes", "");
        }

        private function onNoClicked(event:MouseEvent):void
        {
            this.sendSelectedMessage("no", "");
        }

        private function onOkClicked(event:MouseEvent):void
        {
            this.sendSelectedMessage("ok", "");
        }

        override public function onRemove():void
        {
        }

        private function sendSelectedMessage(action:String, input:String):void
        {
            var message:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_PROMPT_ACTION_SELECTED);
            message.data = {
                "action":action,
                "input":input
            };
            this.bridge.send(message);
        }


    }
}//package com.clubpenguin.main.mediator.dialogs
