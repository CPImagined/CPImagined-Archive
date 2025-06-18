//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.coupler
{
    import flash.events.EventDispatcher;
    import com.clubpenguin.lib.signals.CloseModuleSignal;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.lib.module.IAppModel;
    import org.osflash.signals.ISignal;
    import flash.display.DisplayObjectContainer;
    import com.clubpenguin.cardjitsu.ninjaprogress.NinjaProgressMain;
    import com.clubpenguin.cardjitsu.ninjaprogress.coupler.model.CardDataModel;
    import org.osflash.signals.Signal;
    import com.clubpenguin.cardjitsu.ninjaprogress.view.CJProgressViewerContainer;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.state.StateConstants;
    import com.clubpenguin.cardjitsu.ninjaprogress.view.EmbeddedAssets;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.localization.LocalTextComponentReplacer;
    import flash.events.Event;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.NinjaModuleEvent;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.media.SoundMixer;
    import com.clubpenguin.lib.vo.ModuleVO;
    import com.clubpenguin.lib.module.ModuleFilenamesEnum;
    import fl.video.VideoScaleMode;
    import com.clubpenguin.cardjitsu.ninjaprogress.coupler.model.NinjaModuleConstants;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.NinjaConstants;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.LocalizationVO;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.ElementLevelVO;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.StoryVO;
    import com.clubpenguin.cardjitsu.ninjaprogress.coupler.model.vo.CardDataVO;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.CardVO;

    public class NinjaProgressClassicCoupler extends EventDispatcher 
    {

        private static const TOTAL_PROGRESS_DATA_CALLS:int = 5;
        private static const REDEMPTION_DEEPLINK:String = "#/redeem";
        private static const CARD_ICONS_SUB_DIR:String = "card/icons/";
        private static const PATHS_LOCAL_INDEX:String = "local";
        private static const NINJA_CATALOGUE_NAME:String = "ninja_catalogue";
        private static const NINJA_CATALOGUE_POWERCARDS_PAGE:int = 2;

        [Inject]
        public var closeModule:CloseModuleSignal;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var tracker:Tracker;
        private var _localizationManager:ILocalizationManager;
        private var _mainModel:IAppModel;
        private var _loadModule:ISignal;
        private var _videoComplete:ISignal;
        private var _view:DisplayObjectContainer;
        private var _mainModule:NinjaProgressMain;
        private var _cardDataModel:CardDataModel;
        private var _elementLevels:Object;
        private var _progressDataCount:int = 0;
        private var _receivedCardData:String;
        private var _playerHasTuskCape:Boolean = false;
        private var _initialState:String = "progressPanel";
        public var sendServerRequest:Signal = new Signal(String);
        public var loadCardsJson:Signal = new Signal(String);
        private var embeddedViewContainer:CJProgressViewerContainer;


        public function init(view:DisplayObjectContainer):void
        {
            var replaceRoomWithBitmapMessage:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_REPLACE_ROOM_WITH_BITMAP);
            this.bridge.send(replaceRoomWithBitmapMessage);
            this._view = view;
            this._cardDataModel = new CardDataModel();
            this._elementLevels = new Object();
            var moduleData:Object = ((BaseModule(this._view).data != null) ? BaseModule(this._view).data : {});
            this._playerHasTuskCape = ((moduleData.hasOwnProperty("playerHasTuskCape")) ? moduleData.playerHasTuskCape : false);
            this._initialState = ((moduleData.hasOwnProperty("initialState")) ? moduleData.initialState : StateConstants.PROGRESS_STATE);
            if (StateConstants.STATES.indexOf(this._initialState) < 0)
            {
                this._initialState = StateConstants.PROGRESS_STATE;
            };
            this.embeddedViewContainer = new CJProgressViewerContainer(EmbeddedAssets.CardjitsuProgressInventoryAssets);
            this.embeddedViewContainer.onCompleted.addOnce(this.onViewCompleted);
        }

        private function onViewCompleted():void
        {
            this._mainModule = new NinjaProgressMain(this.embeddedViewContainer.getView(), this._initialState, new LocalTextComponentReplacer());
            this._mainModule.addEventListener(Event.CLOSE, this.onModuleClose);
            this._mainModule.addEventListener(NinjaModuleEvent.SERVICE_REQUEST, this.onServiceRequest);
            this._mainModule.addEventListener(NinjaModuleEvent.GOTO_REDEMPTION, this.gotoRedemption);
            this._mainModule.addEventListener(NinjaModuleEvent.PLAY_VIDEO, this.playVideo);
            this._mainModule.addEventListener(NinjaModuleEvent.BUY_POWERCARDS, this.buyPowercards);
            addEventListener(NinjaModuleEvent.SERVICE_RESPONSE, this._mainModule.receivePayload);
            this._view.addChild(this._mainModule);
            this._mainModule.init();
        }

        public function setLocalizationManager(localizationManager:ILocalizationManager):void
        {
            this._localizationManager = localizationManager;
        }

        public function setMainModel(mainModel:IAppModel):void
        {
            this._mainModel = mainModel;
        }

        public function setLoadModule(loadModule:ISignal):void
        {
            this._loadModule = loadModule;
        }

        public function setVideoComplete(videoComplete:ISignal):void
        {
            this._videoComplete = videoComplete;
        }

        private function gotoRedemption(event:NinjaModuleEvent):void
        {
            var environmentData:EnvironmentDataVO = this._mainModel.getEnvironmentData();
            var redemptionURL:String = (environmentData.getCurrentWebDomain() + REDEMPTION_DEEPLINK);
            navigateToURL(new URLRequest(redemptionURL), "_self");
        }

        private function playVideo(event:NinjaModuleEvent):void
        {
            this._view.visible = false;
            this._videoComplete.addOnce(this.onVideoComplete);
            SoundMixer.stopAll();
            var moduleVO:ModuleVO = new ModuleVO();
            moduleVO.moduleName = ModuleFilenamesEnum.VIDEO_PLAYER.key;
            moduleVO.moduleData = {
                "source":event.payload,
                "autoPlay":true,
                "scaleMode":VideoScaleMode.MAINTAIN_ASPECT_RATIO
            };
            moduleVO.modalBackgroundEnabled = true;
            moduleVO.hideLoadingDialog = false;
            moduleVO.blockPuffleNotifications = true;
            Signal(this._loadModule).dispatch(moduleVO);
        }

        private function buyPowercards(event:NinjaModuleEvent):void
        {
            var openCatalogMessage:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_OPEN_CATALOG);
            openCatalogMessage.data = {
                "name":NINJA_CATALOGUE_NAME,
                "page":NINJA_CATALOGUE_POWERCARDS_PAGE
            };
            this.bridge.send(openCatalogMessage);
            this.onModuleClose(event);
        }

        private function onVideoComplete():void
        {
            this._view.visible = true;
        }

        private function onServiceRequest(event:NinjaModuleEvent):void
        {
            var environmentData:EnvironmentDataVO;
            var webServicePath:String;
            switch (event.messageType)
            {
                case NinjaModuleConstants.REQUEST_LOCALIZATION_DATA:
                    this.localize(event.payload);
                    break;
                case NinjaModuleConstants.REQUEST_LOCALIZED_PATHS:
                    this.localizePaths(event.payload);
                    break;
                case NinjaModuleConstants.REQUEST_PROGRESS_DATA:
                    this.sendServerRequest.dispatch(NinjaAirtowerConstants.GET_NINJA_LEVEL);
                    this.sendServerRequest.dispatch(NinjaAirtowerConstants.GET_FIRE_LEVEL);
                    this.sendServerRequest.dispatch(NinjaAirtowerConstants.GET_WATER_LEVEL);
                    this.sendServerRequest.dispatch(NinjaAirtowerConstants.GET_SNOW_LEVEL);
					this.sendServerRequest.dispatch(NinjaAirtowerConstants.GET_SHADOW_LEVEL);
                    break;
                case NinjaModuleConstants.REQUEST_CARD_DATA:
                    this.sendServerRequest.dispatch(NinjaAirtowerConstants.GET_CARD_DATA);
                    environmentData = this._mainModel.getEnvironmentData();
                    webServicePath = ((environmentData.getBaseConfigPath() + environmentData.language) + environmentData.web_service);
                    this.loadCardsJson.dispatch(webServicePath);
                    break;
            };
        }

        public function onCardsJsonLoaded(cardDataVOs:Array):void
        {
            this._cardDataModel.setCardDataVOs(cardDataVOs);
            if (this._receivedCardData != null)
            {
                this.setCardData(this._receivedCardData);
            };
        }

        private function localize(payload:Object):void
        {
            var i:String;
            var currentLang:String;
            var strings:Array = [];
            for (i in payload)
            {
                strings[i] = this._localizationManager.getLocalizedString(payload[i]);
            };
            currentLang = this._mainModel.getEnvironmentData().language;
            switch (currentLang)
            {
                case "de":
                    strings[NinjaConstants.CURRENT_LANG_INDEX] = LocalizationVO.LANG_DE_DE;
                    break;
                case "es":
                    strings[NinjaConstants.CURRENT_LANG_INDEX] = LocalizationVO.LANG_ES_LA;
                    break;
                case "fr":
                    strings[NinjaConstants.CURRENT_LANG_INDEX] = LocalizationVO.LANG_FR_FR;
                    break;
                case "pt":
                    strings[NinjaConstants.CURRENT_LANG_INDEX] = LocalizationVO.LANG_PT_BR;
                    break;
                case "ru":
                    strings[NinjaConstants.CURRENT_LANG_INDEX] = LocalizationVO.LANG_RU_RU;
                    break;
                case "en":
                default:
                    strings[NinjaConstants.CURRENT_LANG_INDEX] = LocalizationVO.LANG_EN_US;
            };
            dispatchEvent(new NinjaModuleEvent(NinjaModuleEvent.SERVICE_RESPONSE, NinjaModuleConstants.REQUEST_LOCALIZATION_DATA, strings));
        }

        private function localizePaths(payload:Object):void
        {
            var i:String;
            var localContentPath:String = this._mainModel.getEnvironmentData().localContentPath;
            var pathsData:Object = this._mainModel.getPathsVO().data;
            var paths:Array = [];
            for (i in payload)
            {
                paths[i] = (localContentPath + pathsData[PATHS_LOCAL_INDEX][payload[i]]);
            };
            dispatchEvent(new NinjaModuleEvent(NinjaModuleEvent.SERVICE_RESPONSE, NinjaModuleConstants.REQUEST_LOCALIZED_PATHS, paths));
        }

        public function receivedPayload(messageType:String, payload:Array):void
        {
            switch (messageType)
            {
                case NinjaAirtowerConstants.GET_NINJA_LEVEL:
                    this.setElementData(NinjaConstants.GAME_TYPE_NINJA, payload[NinjaAirtowerConstants.CURRENT_LEVEL_INDEX], payload[NinjaAirtowerConstants.PROGRESS_PERCENT_INDEX], payload[NinjaAirtowerConstants.MAX_LEVEL_INDEX], NinjaConstants.CHALLENGE_SENSEI_LEVEL_NINJA, NinjaConstants.CONTINUED_REWARDS_NINJA);
					this.setElementData("shadow", payload[NinjaAirtowerConstants.CURRENT_LEVEL_INDEX], payload[NinjaAirtowerConstants.PROGRESS_PERCENT_INDEX], 14, 20, false);
                    break;
                case NinjaAirtowerConstants.GET_FIRE_LEVEL:
                    this.setElementData(NinjaConstants.GAME_TYPE_FIRE, payload[NinjaAirtowerConstants.CURRENT_LEVEL_INDEX], payload[NinjaAirtowerConstants.PROGRESS_PERCENT_INDEX], payload[NinjaAirtowerConstants.MAX_LEVEL_INDEX], NinjaConstants.CHALLENGE_SENSEI_LEVEL_FIRE, NinjaConstants.CONTINUED_REWARDS_FIRE);
                    break;
                case NinjaAirtowerConstants.GET_WATER_LEVEL:
                    this.setElementData(NinjaConstants.GAME_TYPE_WATER, payload[NinjaAirtowerConstants.CURRENT_LEVEL_INDEX], payload[NinjaAirtowerConstants.PROGRESS_PERCENT_INDEX], payload[NinjaAirtowerConstants.MAX_LEVEL_INDEX], NinjaConstants.CHALLENGE_SENSEI_LEVEL_WATER, NinjaConstants.CONTINUED_REWARDS_WATER);
                    break;
                case NinjaAirtowerConstants.GET_SNOW_LEVEL:
                    this.setElementData(NinjaConstants.GAME_TYPE_SNOW, payload[NinjaAirtowerConstants.CURRENT_LEVEL_INDEX], payload[NinjaAirtowerConstants.PROGRESS_PERCENT_INDEX], payload[NinjaAirtowerConstants.MAX_LEVEL_INDEX], NinjaConstants.CHALLENGE_TUSK_LEVEL_SNOW, NinjaConstants.CONTINUED_REWARDS_SNOW);
                    break;
				case NinjaAirtowerConstants.GET_SHADOW_LEVEL:
                    this.setElementData(NinjaConstants.GAME_TYPE_SHADOW, payload[NinjaAirtowerConstants.CURRENT_LEVEL_INDEX], payload[NinjaAirtowerConstants.PROGRESS_PERCENT_INDEX], payload[NinjaAirtowerConstants.MAX_LEVEL_INDEX], NinjaConstants.CHALLENGE_SENSEI_LEVEL_SHADOW, NinjaConstants.CONTINUED_REWARDS_SHADOW);
                    break;
                case NinjaAirtowerConstants.GET_CARD_DATA:
                    if (this._cardDataModel.isReady())
                    {
                        this.setCardData(payload[NinjaAirtowerConstants.CARD_DATA_INDEX]);
                    }
                    else
                    {
                        this._receivedCardData = payload[NinjaAirtowerConstants.CARD_DATA_INDEX];
                    };
                    break;
            };
        }

        private function setElementData(gameType:String, currentLevel:int, progressPct:Number, maxLevels:int, finalChallengeRank:int, continuedRewards:Boolean):void
        {
            this._elementLevels[gameType] = new ElementLevelVO(gameType, currentLevel, maxLevels, progressPct, finalChallengeRank, continuedRewards);
            this._progressDataCount++;
            if (this._progressDataCount == TOTAL_PROGRESS_DATA_CALLS)
            {
                StoryVO.CINEMATIC_9_STATUS[StoryVO.HAS_TUSK_CAPE] = this._playerHasTuskCape;
                dispatchEvent(new NinjaModuleEvent(NinjaModuleEvent.SERVICE_RESPONSE, NinjaModuleConstants.REQUEST_PROGRESS_DATA, this._elementLevels));
            };
        }

        private function setCardData(cardData:String):void
        {
            var data:String;
            var powercards:Array;
            var nonPowercards:Array;
            var cardCollection:Array;
            var isMember:Boolean;
            var card:Array;
            var environmentData:EnvironmentDataVO;
            var values:Array;
            var cardId:Number;
            var totalCount:Number;
            var memberOnlyCount:Number;
            var nonMemberCount:Number;
            var cardDataVO:CardDataVO;
            var cardVO:CardVO;
            var parsedCardData:Array = [];
            for each (data in cardData.split("|"))
            {
                values = data.split(",");
                parsedCardData.push(values);
            };
            powercards = [];
            nonPowercards = [];
            cardCollection = [];
            isMember = this._mainModel.isMember();
            for each (card in parsedCardData)
            {
                cardId = card[NinjaAirtowerConstants.CARD_ID_INDEX];
                totalCount = card[NinjaAirtowerConstants.TOTAL_COUNT_INDEX];
                memberOnlyCount = card[NinjaAirtowerConstants.MEMBER_ONLY_COUNT_INDEX];
                nonMemberCount = (totalCount - memberOnlyCount);
                cardDataVO = this._cardDataModel.getCardDataVOById(cardId);
                if (cardDataVO != null)
                {
                    if (nonMemberCount > 0)
                    {
                        cardVO = new CardVO(cardId, cardDataVO.element, cardDataVO.colorHex, cardDataVO.value, cardDataVO.isPowercard, nonMemberCount, false, true);
                        if (cardDataVO.isPowercard == true)
                        {
                            powercards.push(cardVO);
                        }
                        else
                        {
                            nonPowercards.push(cardVO);
                        };
                    };
                    if (memberOnlyCount > 0)
                    {
                        cardVO = new CardVO(cardId, cardDataVO.element, cardDataVO.colorHex, cardDataVO.value, cardDataVO.isPowercard, memberOnlyCount, true, isMember);
                        if (cardDataVO.isPowercard == true)
                        {
                            powercards.push(cardVO);
                        }
                        else
                        {
                            nonPowercards.push(cardVO);
                        };
                    };
                };
            };
            cardCollection = powercards.concat(nonPowercards);
            environmentData = this._mainModel.getEnvironmentData();
            CardVO.CARD_LOADER_DATA[CardVO.ICON_URL] = (environmentData.gamesPath + CARD_ICONS_SUB_DIR);
            dispatchEvent(new NinjaModuleEvent(NinjaModuleEvent.SERVICE_RESPONSE, NinjaModuleConstants.REQUEST_CARD_DATA, cardCollection));
        }

        private function onModuleClose(event:Event):void
        {
            this.closeModule.dispatch(this._view);
        }

        public function destroy():void
        {
            var removeRoomBitmapMessage:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_REMOVE_ROOM_BITMAP);
            this.bridge.send(removeRoomBitmapMessage);
            this._view.removeChild(this._mainModule);
            this._view = null;
            this._localizationManager;
            this._mainModel;
            this._loadModule;
            this._videoComplete = null;
            this.sendServerRequest;
            this.loadCardsJson = null;
            this._cardDataModel.destroy();
            this._cardDataModel;
            this._elementLevels = null;
            this._mainModule.removeEventListener(Event.CLOSE, this.onModuleClose);
            this._mainModule.removeEventListener(NinjaModuleEvent.SERVICE_REQUEST, this.onServiceRequest);
            this._mainModule.removeEventListener(NinjaModuleEvent.GOTO_REDEMPTION, this.gotoRedemption);
            this._mainModule.removeEventListener(NinjaModuleEvent.PLAY_VIDEO, this.playVideo);
            this._mainModule.removeEventListener(NinjaModuleEvent.BUY_POWERCARDS, this.buyPowercards);
            removeEventListener(NinjaModuleEvent.SERVICE_RESPONSE, this._mainModule.receivePayload);
            this._mainModule.destroy();
            this._mainModule = null;
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.coupler
