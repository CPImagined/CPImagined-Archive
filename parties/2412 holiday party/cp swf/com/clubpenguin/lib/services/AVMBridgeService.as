//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.services
{
    import org.robotlegs.mvcs.Actor;
    import com.clubpenguin.lib.friends.FriendsSignalBus;
    import com.clubpenguin.lib.module.IAppSignalBus;
    import com.clubpenguin.main.signal.loadingScreen.ShowLoadingScreenSignal;
    import com.clubpenguin.main.signal.loadingScreen.HideLoadingScreenSignal;
    import com.clubpenguin.main.signal.loadingScreen.UpdateLoadingScreenSignal;
    import com.clubpenguin.main.signal.QuestStatusUpdatedSignal;
    import com.clubpenguin.main.signal.QuestSettingsSignal;
    import org.robotlegs.core.IInjector;
    import com.clubpenguin.lib.model.IMetricsModel;
    import com.clubpenguin.lib.vo.PlayerVO;
    import com.gskinner.utils.SWFBridgeAS3;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import flash.display.MovieClip;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.ModuleVO;
    import com.clubpenguin.lib.vo.BuddyVO;
    import com.clubpenguin.lib.vo.map.MapActionVO;
    import com.clubpenguin.main.vo.PromptVO;
    import com.clubpenguin.main.vo.ComplexPromptVO;
    import com.clubpenguin.main.vo.AssetPromptVO;
    import com.clubpenguin.lib.vo.puffle.PuffleTreasureVO;
    import com.clubpenguin.lib.util.SecurityUtil;
    import com.clubpenguin.lib.enums.metrics.MetricsConstant;
    import flash.events.AsyncErrorEvent;
    import flash.events.SecurityErrorEvent;
    import com.clubpenguin.lib.vo.ErrorVO;
    import com.clubpenguin.lib.enums.errors.ErrorCodeEnum;
    import com.asual.swfaddress.SWFAddress;
    import com.clubpenguin.lib.util.Log;
    import com.adobe.serialization.json.JSON;
    import flash.external.ExternalInterface;
    import flash.events.Event;

    public class AVMBridgeService extends Actor implements IAVMBridgeService 
    {

        public static const END_OF_CHUNKING_DELIMITER:String = "@END_OF_CHUNKING@";
        private static const MAX_LOCAL_CONNECTION_SEND_BYTES:Number = 40000;
        private static const AS2_GATEWAY_METHOD:String = "messageFromAS3";

        public var response:LocalConnectionResponse;
        [Inject]
        public var friendsSignalBus:FriendsSignalBus;
        [Inject]
        public var signalBus:IAppSignalBus;
        [Inject]
        public var showLoadingScreen:ShowLoadingScreenSignal;
        [Inject]
        public var hideLoadingScreen:HideLoadingScreenSignal;
        [Inject]
        public var updateLoadingScreen:UpdateLoadingScreenSignal;
        [Inject]
        public var questStatusUpdated:QuestStatusUpdatedSignal;
        [Inject]
        public var questSettings:QuestSettingsSignal;
        [Inject]
        public var injector:IInjector;
        [Inject]
        public var metricsModel:IMetricsModel;
        [Inject]
        public var myPlayer:PlayerVO;
        public var _bridge:SWFBridgeAS3;
        private var currentMessage:AVMBridgeMessage;
        private var messageQueue:AVMBridgeMessageQueue;
        private var timerMC:MovieClip;
        private var randomID:Number;
        private var wasClosed:Boolean = false;
        private var epoch:Date;

        public const connected:Signal = new Signal();
        public const sendWSData:Signal = new Signal();
        public const disconnected:Signal = new Signal();
        public const initialized:Signal = new Signal(int, String);
        public const openNewspaper:Signal = new Signal(String);
        public const createMyPlayerVO:Signal = new Signal(Object);
        public const openModule:Signal = new Signal(ModuleVO);
        public const addedBuddy:Signal = new Signal(BuddyVO);
        public const updatedCoins:Signal = new Signal();
        public const puffleCareItemInfoRequested:Signal = new Signal(int);
        public const addPuffleCareItem:Signal = new Signal(int, int);
        public const selectedPuffle:Signal = new Signal(Number);
        public const addPuffleCarePoints:Signal = new Signal(int, uint, uint, uint);
        public const doesPlayerOwnPuffleItem:Signal = new Signal(int, String);
        public const messageReceived:Signal = new Signal(Object);
        public const airTowerEventReceived:Signal = new Signal(String);
        public const trackingDataReceived:Signal = new Signal(String, Object);
        public const showMembershipPrompt:Signal = new Signal(String, Object);
        public const showMembershipFAQ:Signal = new Signal(String, Object);
        public const mapAction:Signal = new Signal(MapActionVO);
        public const triggerReceived:Signal = new Signal(String);
        public const onHideTriggers:Signal = new Signal();
        public const onShowTriggers:Signal = new Signal();
        public const onClickFromAS2:Signal = new Signal(String);
        public const onMapCategorySelected:Signal = new Signal(String);
        public const onJoinedRoom:Signal = new Signal(int, int);
        public const onLeavingRoom:Signal = new Signal();
        public var showError:Signal = new Signal(Object);
        public const navigateToBuyMembership:Signal = new Signal(String);
        public const startNotificationServices:Signal = new Signal();
        public const stopNotificationServices:Signal = new Signal();
        public const showPrompt:Signal = new Signal(PromptVO);
        public const showComplexPrompt:Signal = new Signal(ComplexPromptVO);
        public const showAssetPrompt:Signal = new Signal(AssetPromptVO);
        public const closeAssetPrompt:Signal = new Signal();
        public const closePrompt:Signal = new Signal();
        public const idlePlayerTimeout:Signal = new Signal();
        public const stampEarned:Signal = new Signal(Object);
        public const roomLoaded:Signal = new Signal(int);
        public const showPoster:Signal = new Signal(String);
        public const hideLikeWindow:Signal = new Signal();
        public const showLikeWindow:Signal = new Signal();
        public const closeLikeWindow:Signal = new Signal();
        public const receivedDoesPlayerOwnItem:Signal = new Signal(int, Boolean);
        public const as2MouseReleased:Signal = new Signal();
        public const clearCardsCache:Signal = new Signal();
        public const phraseAutocompleteText:Signal = new Signal();
        public const as2DataReceived:Signal = new Signal(String, Object);
        public const consoleDebug:Signal = new Signal(Object);
        public const hideQuestUI:Signal = new Signal();
        public const showQuestUI:Signal = new Signal();
        public const focusPhraseChat:Signal = new Signal();
        public const partyInit:Signal = new Signal();
        public const endGameScreenData:Signal = new Signal(Object);
        public const mapLegendAnimComplete:Signal = new Signal();
        public const showPuffleTricksHUD:Signal = new Signal();
        public const enablePuffleTricksHUD:Signal = new Signal();
        public const disablePuffleTricksHUD:Signal = new Signal();
        public const showPuffleTreasureNotification:Signal = new Signal(PuffleTreasureVO, Boolean);
        public const loadPuffleTreasureInfographic:Signal = new Signal();
        public const localPlayerIgnoreList:Signal = new Signal(Array);
        public const startSoundStudio:Signal = new Signal();
        public const showMusicPlayerWidget:Signal = new Signal();
        public const hideMusicPlayerWidget:Signal = new Signal();
        public const muteMusicPlayer:Signal = new Signal();
        public const unmuteMusicPlayer:Signal = new Signal();
        public const startIglooMusicSignal:Signal = new Signal(Object);
        public const stopIglooMusicSignal:Signal = new Signal();

        public function AVMBridgeService()
        {
            this.randomID = Math.floor((Math.random() * 0x0100));
            this.messageQueue = new AVMBridgeMessageQueue();
        }

        public function connect(connectionName:String):Boolean
        {
            try
            {
                this.wasClosed = false;
                this._bridge = new SWFBridgeAS3(connectionName, this, SecurityUtil.getAllowedDomains());
                this.metricsModel.counters.registerCounter(MetricsConstant.COUNT_BRIDGE_CALLS);
            }
            catch(e:Error)
            {
                return (false);
            };
            this._bridge.error.add(this.onBridgeError);
            this._bridge.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onBridgeAsyncError);
            this._bridge.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onBridgeSecurityError);
            return (true);
        }

        public function disconnect():void
        {
            if (this.isConnected())
            {
                this._bridge.close();
                this._bridge.error.remove(this.onBridgeError);
                this._bridge.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onBridgeAsyncError);
                this._bridge.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onBridgeSecurityError);
            };
        }

        public function isConnected():Boolean
        {
            if (this._bridge == null)
            {
                return (false);
            };
            return (this._bridge.connected);
        }

        public function isAS2BridgeConnected():Boolean
        {
            if (this._bridge == null)
            {
                return (false);
            };
            return (true);
        }

        public function onBridgeAsyncError(event:AsyncErrorEvent):void
        {
            Signal(this.signalBus.getBridgeError()).dispatch(new ErrorVO(((((event.target.toString() + " ") + event.error.errorID) + " ") + event.error.message), ErrorCodeEnum.BRIDGE_ASYNC_ERROR.getId()));
        }

        public function onBridgeSecurityError(event:SecurityErrorEvent):void
        {
            Signal(this.signalBus.getBridgeError()).dispatch(new ErrorVO(String(event.errorID), ErrorCodeEnum.BRIDGE_SECURITY_ERROR.getId()));
        }

        public function messageFromAS2(messageObject:Object):void
        {
            var currentTS:Number;
            var sentTS:Number;
            var lag:Number;
            var moduleVO:ModuleVO;
            var buddyVO:BuddyVO;
            var buddyObject:Object;
            var room_id:int;
            var player_count:int;
            var promptVO:PromptVO;
            var complexPromptVO:ComplexPromptVO;
            var stamp:Object;
            var loaded_room_id:int;
            var posterPath:String;
            var message:AVMBridgeMessage;
            var s:String;
            var t:String;
            this.metricsModel.counters.incrementCounter(MetricsConstant.COUNT_BRIDGE_CALLS);
            if (messageObject.timestamp != undefined)
            {
                this.epoch = new Date();
                currentTS = this.epoch.valueOf();
                sentTS = messageObject.timestamp;
                lag = (currentTS - sentTS);
                this.metricsModel.recordBridgeTime(messageObject.msgId, messageObject.type, sentTS, currentTS);
            };
            switch (messageObject.type)
            {
                case AVMBridgeMessage.MSG_AS2_READY:
                    this.connected.dispatch();
                    break;
                case AVMBridgeMessage.MSG_AS2_WEB_SERVICE_REQUEST:
                    this.sendWSData.dispatch();
                    break;
                case AVMBridgeMessage.MSG_AS2_INITIALIZED:
                    this.initialized.dispatch(messageObject.localizedLangFrame, messageObject.environment);
                    break;
                case AVMBridgeMessage.MSG_UPDATE_PLAYER_VO:
                    this.createMyPlayerVO.dispatch(messageObject.myGenericPlayerObject);
                    this.updatedCoins.dispatch();
                    break;
                case AVMBridgeMessage.MSG_OPEN_MODULE:
                    if (messageObject.moduleArgs == null)
                    {
                        throw (new Error((this + " -> messageFromAS2(): module args is udnefined!")));
                    };
                    moduleVO = new ModuleVO();
                    moduleVO.moduleName = messageObject.name;
                    moduleVO.moduleData = messageObject.data;
                    moduleVO.modalBackgroundEnabled = messageObject.moduleArgs.modalBackgroundEnabled;
                    moduleVO.hideLoadingDialog = messageObject.moduleArgs.hideLoadingDialog;
                    moduleVO.blockPuffleNotifications = messageObject.moduleArgs.blockPuffleNotifications;
                    this.openModule.dispatch(moduleVO);
                    break;
                case AVMBridgeMessage.MSG_AIRTOWER_EVENT:
                    this.airTowerEventReceived.dispatch(messageObject.str);
                    break;
                case AVMBridgeMessage.MSG_ADD_BUDDY:
                    buddyVO = new BuddyVO();
                    buddyObject = messageObject.buddy_obj;
                    buddyVO.playerID = buddyObject.playerID;
                    buddyVO.nickname = buddyObject.nickname;
                    buddyVO.isOnline = buddyObject.isOnline;
                    this.addedBuddy.dispatch(buddyVO);
                    break;
                case AVMBridgeMessage.MSG_SET_PUFFLE:
                    this.selectedPuffle.dispatch(messageObject.puffle_id);
                    break;
                case AVMBridgeMessage.MSG_SET_SWF_ADDRESS:
                    SWFAddress.setValue(messageObject.deepLink);
                    break;
                case AVMBridgeMessage.MSG_GET_BUY_PUFFLE_CARE_ITEM_INFO:
                    this.puffleCareItemInfoRequested.dispatch(int(messageObject.itemID));
                    break;
                case AVMBridgeMessage.MSG_ADD_PUFFLE_CARE_ITEM:
                    this.addPuffleCareItem.dispatch(int(messageObject.itemID), int(messageObject.quantity), Boolean(messageObject.addToExistingQuantity));
                    break;
                case AVMBridgeMessage.MSG_ADD_PUFFLE_CARE_POINTS:
                    this.addPuffleCarePoints.dispatch(int(messageObject.puffleID), uint(messageObject.food), uint(messageObject.play), uint(messageObject.rest), uint(messageObject.clean));
                    break;
                case AVMBridgeMessage.MSG_GET_DOES_PLAYER_OWN_PUFFLE_ITEM:
                    this.doesPlayerOwnPuffleItem.dispatch(int(messageObject.itemId), String(messageObject.itemCategory));
                    break;
                case AVMBridgeMessage.MSG_SHOW_ERROR_FROM_AS2:
                    this.showError.dispatch(messageObject);
                    break;
                case AVMBridgeMessage.MSG_SEND_TRACKING_DATA:
                    this.trackingDataReceived.dispatch(messageObject.trackingKey, messageObject.paramsJSONString);
                    break;
                case AVMBridgeMessage.MSG_SHOW_CONTENT:
                    if (messageObject.data == null)
                    {
                        messageObject.data = {};
                    };
                    messageObject.data.fileKey = messageObject.fileKey;
                    if (messageObject.fileKey.indexOf("oops_") >= 0)
                    {
                        this.showMembershipPrompt.dispatch(messageObject.filePath, messageObject.data);
                    };
                    break;
                case AVMBridgeMessage.MSG_SHOW_CONTENT_FAQ:
                    if (messageObject.data == null)
                    {
                        messageObject.data = {};
                    };
                    messageObject.data.fileKey = messageObject.fileKey;
                    this.showMembershipFAQ.dispatch(messageObject.filePath, messageObject.data);
                    break;
                case AVMBridgeMessage.MSG_MAP_ACTION:
                    this.mapAction.dispatch(new MapActionVO(messageObject.categoryID, messageObject.mapID, messageObject.triggerID, messageObject.makeTriggersVisible));
                    break;
                case AVMBridgeMessage.MSG_MAP_CATEGORY_SELECTED:
                    this.onMapCategorySelected.dispatch(messageObject.category);
                    break;
                case AVMBridgeMessage.MSG_SEND_TRIGGER:
                    this.triggerReceived.dispatch(messageObject.triggerName);
                    break;
                case AVMBridgeMessage.MSG_CLICKED_IN_AS2:
                    this.onClickFromAS2.dispatch(String(messageObject.clickName));
                    break;
                case AVMBridgeMessage.MSG_JOINED_ROOM:
                    room_id = messageObject.room_id;
                    player_count = messageObject.player_count;
                    this.onJoinedRoom.dispatch(room_id, player_count);
                    break;
                case AVMBridgeMessage.MSG_LEAVING_ROOM:
                    this.onLeavingRoom.dispatch();
                    break;
                case AVMBridgeMessage.MSG_HIDE_TRIGGERS:
                    this.onHideTriggers.dispatch();
                    break;
                case AVMBridgeMessage.MSG_SHOW_TRIGGERS:
                    this.onShowTriggers.dispatch();
                    break;
                case AVMBridgeMessage.MSG_NAVIGATE_TO_BUY_MEMBERSHIP:
                    this.navigateToBuyMembership.dispatch(messageObject.tag);
                    break;
                case AVMBridgeMessage.MSG_NAVIGATE_TO_BUY_MEMBERSHIP:
                    this.navigateToBuyMembership.dispatch(messageObject.tag);
                    break;
                case AVMBridgeMessage.MSG_START_NOTIFICATION_SERVICES:
                    this.startNotificationServices.dispatch();
                    break;
                case AVMBridgeMessage.MSG_STOP_NOTIFICATION_SERVICES:
                    this.stopNotificationServices.dispatch();
                    break;
                case AVMBridgeMessage.MSG_NAVIGATE_TO_BUY_MEMBERSHIP:
                    this.navigateToBuyMembership.dispatch(messageObject.tag);
                    break;
                case AVMBridgeMessage.MSG_SHOW_PROMPT:
                    promptVO = new PromptVO();
                    promptVO.style = messageObject.style;
                    promptVO.message = messageObject.message;
                    if (messageObject.file)
                    {
                        promptVO.file = messageObject.file;
                    };
                    if (messageObject.cards)
                    {
                        promptVO.cards = messageObject.cards.split(",");
                    };
                    this.showPrompt.dispatch(promptVO);
                    break;
                case AVMBridgeMessage.MSG_CLOSE_PROMPT:
                    this.closePrompt.dispatch();
                    break;
                case AVMBridgeMessage.MSG_SHOW_COMPLEX_PROMPT:
                    complexPromptVO = new ComplexPromptVO(messageObject.style, messageObject.data);
                    this.showComplexPrompt.dispatch(complexPromptVO);
                    break;
                case AVMBridgeMessage.MSG_SHOW_ASSET_PROMPT:
                    this.parseAssetVOAndSend(messageObject.data);
                    break;
                case AVMBridgeMessage.MSG_SHOW_PUFFLE_TRICKS_HUD:
                    this.showPuffleTricksHUD.dispatch();
                    break;
                case AVMBridgeMessage.MSG_ENABLE_PUFFLE_TRICKS_HUD:
                    this.enablePuffleTricksHUD.dispatch();
                    break;
                case AVMBridgeMessage.MSG_DISABLE_PUFFLE_TRICKS_HUD:
                    this.disablePuffleTricksHUD.dispatch();
                    break;
                case AVMBridgeMessage.MSG_SHOW_PUFFLE_TREASURE_NOTIFICATION:
                    this.parsePuffleTreasureVOAndSend(messageObject.data);
                    break;
                case AVMBridgeMessage.MSG_LOAD_PUFFLE_TREASURE_INFOGRAPHIC:
                    this.loadPuffleTreasureInfographic.dispatch();
                    break;
                case AVMBridgeMessage.MSG_RECEIVE_WORLD_DATA_BY_ID:
                    Signal(this.signalBus.getWorldDataReceived()).dispatch(messageObject.worldData);
                    break;
                case AVMBridgeMessage.MSG_SET_CURRENT_WORLD:
                    Signal(this.signalBus.getCurrentWorldReceived()).dispatch(messageObject.worldData);
                    break;
                case AVMBridgeMessage.MSG_IDLE_PLAYER_TIMEOUT:
                    this.idlePlayerTimeout.dispatch();
                    break;
                case AVMBridgeMessage.MSG_SHOW_STAMP_EARNED:
                    stamp = messageObject.stampObject;
                    this.stampEarned.dispatch(stamp);
                    break;
                case AVMBridgeMessage.MSG_ROOM_LOADED:
                    loaded_room_id = messageObject.room_id;
                    this.roomLoaded.dispatch(loaded_room_id);
                    this.onShowTriggers.dispatch();
                    break;
                case AVMBridgeMessage.MSG_SHOW_POSTER:
                    posterPath = messageObject.posterPath;
                    this.showPoster.dispatch(posterPath);
                    break;
                case AVMBridgeMessage.MSG_LOG_DIMG_BI_EVENT:
                    Signal(this.signalBus.getLogDimgBiEvent()).dispatch(messageObject.params);
                    break;
                case AVMBridgeMessage.MSG_LOG_RAW_BI_EVENT:
                    Signal(this.signalBus.getLogRawBiEvent()).dispatch(messageObject.params);
                    break;
                case AVMBridgeMessage.MSG_START_TRACKER:
                    Signal(this.signalBus.getStartTracker()).dispatch();
                    break;
                case AVMBridgeMessage.MSG_LOG_OFF_CLEANUP_COMPLETE:
                    Signal(this.signalBus.getLogOffCleanupComplete()).dispatch();
                    break;
                case AVMBridgeMessage.MSG_START_ASSET_LOAD:
                    Signal(this.signalBus.getTrackerEvent()).dispatch(messageObject, AVMBridgeMessage.MSG_START_ASSET_LOAD);
                    break;
                case AVMBridgeMessage.MSG_GET_PLAYER_STATUS:
                    if (messageObject.currentRoom == undefined)
                    {
                        messageObject.currentRoom = -1;
                    };
                    if (messageObject.playerCount == undefined)
                    {
                        messageObject.playerCount = -1;
                    };
                    Signal(this.signalBus.getSetPlayerStatus()).dispatch(messageObject);
                    break;
                case AVMBridgeMessage.MSG_GET_DOES_PLAYER_OWN_ITEM:
                    this.receivedDoesPlayerOwnItem.dispatch(messageObject.itemID, messageObject.isItemOwned);
                    break;
                case AVMBridgeMessage.MSG_CLEAR_CARDS_CACHE:
                    this.clearCardsCache.dispatch();
                    break;
                case AVMBridgeMessage.MSG_SHOW_LOADING_SCREEN:
                    Log.debug(("\t\t-as2 > as3: MSG_SHOW_LOADING_SCREEN, messageObject.loadingText: " + messageObject.loadingText));
                    this.showLoadingScreen.dispatch(messageObject.loadingText);
                    break;
                case AVMBridgeMessage.MSG_HIDE_LOADING_SCREEN:
                    this.hideLoadingScreen.dispatch();
                    break;
                case AVMBridgeMessage.MSG_UPDATE_LOADING_SCREEN:
                    this.updateLoadingScreen.dispatch(messageObject.progress);
                    break;
                case AVMBridgeMessage.MSG_HIDE_LIKE_WINDOW:
                    this.hideLikeWindow.dispatch();
                    break;
                case AVMBridgeMessage.MSG_SHOW_LIKE_WINDOW:
                    this.showLikeWindow.dispatch();
                    break;
                case AVMBridgeMessage.MSG_CLOSE_LIKE_WINDOW:
                    this.closeLikeWindow.dispatch();
                    break;
                case AVMBridgeMessage.MSG_AS2_MOUSE_RELEASED:
                    this.as2MouseReleased.dispatch();
                    break;
                case AVMBridgeMessage.MSG_AS2_DATA_PAYLOAD:
                    if (messageObject.payloadType == "debug")
                    {
                        this.consoleDebug.dispatch({
                            "type":"BridgeArgumentError",
                            "payload":messageObject.payload
                        });
                    }
                    else
                    {
                        this.as2DataReceived.dispatch(messageObject.payloadType, messageObject.payload);
                    };
                    break;
                case AVMBridgeMessage.MSG_ACTIVATE_QUESTS:
                    message = new AVMBridgeMessage(AVMBridgeMessage.MSG_ACTIVATE_QUESTS);
                    this.send(message);
                    break;
                case AVMBridgeMessage.MSG_QUEST_STATUS:
                    Log.debug("[AVMBridgeService] received (QUEST STATUS) from the client");
                    this.questStatusUpdated.dispatch(com.adobe.serialization.json.JSON.decode((messageObject.payload as String)));
                    break;
                case AVMBridgeMessage.MSG_QUEST_SETTINGS:
                    Log.debug("[AVMBridgeService] received (QUEST SETTINGS) from the client");
                    this.questSettings.dispatch(com.adobe.serialization.json.JSON.decode((messageObject.payload as String)));
                    break;
                case AVMBridgeMessage.MSG_HIDE_QUEST_UI:
                    Log.debug("[AVMBridgeService] received MSG_HIDE_QUEST_UI from as2");
                    this.hideQuestUI.dispatch();
                    break;
                case AVMBridgeMessage.MSG_SHOW_QUEST_UI:
                    Log.debug("[AVMBridgeService] received MSG_SHOW_QUEST_UI from as2");
                    this.showQuestUI.dispatch();
                    break;
                case AVMBridgeMessage.MSG_FOCUS_PHRASE_CHAT:
                    this.focusPhraseChat.dispatch();
                    break;
                case AVMBridgeMessage.MSG_PARTY_INITIALIZED:
                    Log.debug("[AVMBridgeMessage.MSG_PARTY_INITIALIZED] received from as2");
                    this.partyInit.dispatch();
                    break;
                case AVMBridgeMessage.MSG_MAP_LEGEND_ANIM_COMPLETE:
                    Log.debug("[AVMBridgeMessage] received MSG_MAP_LEGEND_ANIM_COMPLETE from as2");
                    this.mapLegendAnimComplete.dispatch();
                    break;
                case AVMBridgeMessage.MSG_TELL_WEB_MEMBER_SWID:
                    Log.debug("[AVMBridgeMessage.MSG_TELL_WEB_MEMBER_SWID] received from as2");
                    ExternalInterface.call("showMembershipBanner", this.myPlayer.player_swid);
                    break;
                case AVMBridgeMessage.MSG_SEND_AS2_END_GAME_DATA:
                    Log.debug("[AVMBridgeMessage.MSG_SEND_AS2_ENG_GAME_DATA] received from as2");
                    this.endGameScreenData.dispatch(messageObject);
                    for (s in messageObject)
                    {
                        Log.debug((((" [AVMBridgeMessage]: messageObject[" + s) + "] = ") + messageObject[s]));
                        for (t in messageObject[s])
                        {
                        };
                    };
                    break;
                case AVMBridgeMessage.MSG_SHOW_MUSIC_PLAYER_WIDGET:
                    Log.debug("AVMBridgeMessage.MSG_SHOW_MUSIC_PLAYER_WIDGET");
                    this.showMusicPlayerWidget.dispatch();
                    break;
                case AVMBridgeMessage.MSG_HIDE_MUSIC_PLAYER_WIDGET:
                    Log.debug("AVMBridgeMessage.MSG_HIDE_MUSIC_PLAYER_WIDGET");
                    this.hideMusicPlayerWidget.dispatch();
                    break;
                case AVMBridgeMessage.MSG_START_IGLOO_STUDIO_MUSIC:
                    Log.debug("AVMBridgeMessage.MSG_START_IGLOO_STUDIO_MUSIC received from AS2");
                    this.startIglooMusicSignal.dispatch(messageObject.payload);
                    break;
                case AVMBridgeMessage.MSG_STOP_IGLOO_STUDIO_MUSIC:
                    Log.debug("AVMBridgeMessage.MSG_STOP_IGLOO_STUDIO_MUSIC received from AS2");
                    this.stopIglooMusicSignal.dispatch();
                    break;
                case AVMBridgeMessage.MSG_START_SOUND_STUDIO:
                    Log.debug("AVMBridgeMessage.MSG_START_SOUND_STUDIO received from AS2");
                    this.startSoundStudio.dispatch();
                    break;
                case AVMBridgeMessage.MSG_GET_LOCAL_PLAYER_IGNORE_LIST:
                    Log.debug(("[AVMBridgeMessage.MSG_GET_LOCAL_PLAYER_IGNORE_LIST messageObject.payload " + messageObject.payload));
                    this.localPlayerIgnoreList.dispatch(messageObject.payload);
                    break;
                case AVMBridgeMessage.MSG_MUTE_MUSIC_PLAYER:
                    this.muteMusicPlayer.dispatch();
                    break;
                case AVMBridgeMessage.MSG_UNMUTE_MUSIC_PLAYER:
                    this.unmuteMusicPlayer.dispatch();
                    break;
                default:
                    this.friendsSignalBus.handleFriendsBridgeMessage.dispatch(messageObject);
            };
        }

        public function airTowerEvent(message:Object):void
        {
            this.airTowerEventReceived.dispatch(message);
        }

        public function send(message:AVMBridgeMessage):void
        {
            if (this.canSendMessageImmediately())
            {
                this.currentMessage = message;
                try
                {
                    this._bridge.send(AS2_GATEWAY_METHOD, {
                        "isChunked":false,
                        "type":message.type,
                        "data":message.data
                    });
                }
                catch(e:Error)
                {
                    Signal(signalBus.getBridgeError()).dispatch(new ErrorVO(e.message, ErrorCodeEnum.BRIDGE_ARGUMENT_ERROR.getId()));
                };
            }
            else
            {
                if (!this.wasClosed)
                {
                    this.messageQueue.addItem(message);
                    if (!this.timerMC.hasEventListener(Event.ENTER_FRAME))
                    {
                        this.timerMC.addEventListener(Event.ENTER_FRAME, this.onTimerFrame);
                    };
                };
            };
        }

        public function sendStringInChunks(str:String, messageType:String):void
        {
            var i:Number;
            var numChunks:Number = Math.ceil((str.length / MAX_LOCAL_CONNECTION_SEND_BYTES));
            if (numChunks <= 1)
            {
                try
                {
                    this._bridge.send(AS2_GATEWAY_METHOD, {
                        "isChunked":false,
                        "type":messageType,
                        "data":str
                    });
                }
                catch(e:Error)
                {
                    Signal(signalBus.getBridgeError()).dispatch(new ErrorVO(e.message, ErrorCodeEnum.BRIDGE_ARGUMENT_ERROR.getId()));
                };
            }
            else
            {
                str = (str + END_OF_CHUNKING_DELIMITER);
                numChunks = Math.ceil((str.length / MAX_LOCAL_CONNECTION_SEND_BYTES));
                i = 0;
                while (i < numChunks)
                {
                    try
                    {
                        this._bridge.send(AS2_GATEWAY_METHOD, {
                            "isChunked":true,
                            "type":messageType,
                            "str":str.substr((MAX_LOCAL_CONNECTION_SEND_BYTES * i), MAX_LOCAL_CONNECTION_SEND_BYTES)
                        });
                    }
                    catch(e:Error)
                    {
                        Signal(signalBus.getBridgeError()).dispatch(new ErrorVO(e.message, ErrorCodeEnum.BRIDGE_ARGUMENT_ERROR.getId()));
                    };
                    i++;
                };
            };
        }

        public function sendServerCommand(command:String):void
        {
            this.sendStringInChunks(command, AVMBridgeMessage.MSG_SEND_SERVER_COMMAND);
        }

        public function trackEvent(eventTag:String):void
        {
            var message:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_TRACK_EVENT);
            message.data = {"eventTag":eventTag};
            this.send(message);
        }

        public function close():void
        {
            if (((!(this._bridge == null)) && (this._bridge.connected)))
            {
                this._bridge.close();
                this._bridge.error.remove(this.onBridgeError);
            };
            this.wasClosed = true;
            this.connected.removeAll();
            this.disconnected.removeAll();
            this.initialized.removeAll();
            this.openNewspaper.removeAll();
            this.createMyPlayerVO.removeAll();
            this.openModule.removeAll();
            this.messageReceived.removeAll();
            this.airTowerEventReceived.removeAll();
        }

        public function getCreateMyPlayerVO():Signal
        {
            return (this.createMyPlayerVO);
        }

        public function getOpenModule():Signal
        {
            return (this.openModule);
        }

        public function getEndGameScreenData():Signal
        {
            return (this.endGameScreenData);
        }

        public function getInitialized():Signal
        {
            return (this.initialized);
        }

        public function getUpdateCoins():Signal
        {
            return (this.updatedCoins);
        }

        public function getShowMembershipPrompt():Signal
        {
            return (this.showMembershipPrompt);
        }

        public function getShowMembershipFAQ():Signal
        {
            return (this.showMembershipFAQ);
        }

        public function getAS2Clicked():Signal
        {
            return (this.onClickFromAS2);
        }

        public function getHideTriggers():Signal
        {
            return (this.onHideTriggers);
        }

        public function getShowTriggers():Signal
        {
            return (this.onShowTriggers);
        }

        public function getStampEarned():Signal
        {
            return (this.stampEarned);
        }

        public function getStartNotificationServices():Signal
        {
            return (this.startNotificationServices);
        }

        public function getStopNotificationServices():Signal
        {
            return (this.stopNotificationServices);
        }

        public function getHideLikeWindow():Signal
        {
            return (this.hideLikeWindow);
        }

        public function getShowLikeWindow():Signal
        {
            return (this.showLikeWindow);
        }

        public function getCloseLikeWindow():Signal
        {
            return (this.closeLikeWindow);
        }

        public function getShowPrompt():Signal
        {
            return (this.showPrompt);
        }

        public function getClosePrompt():Signal
        {
            return (this.closePrompt);
        }

        public function getRoomLoaded():Signal
        {
            return (this.roomLoaded);
        }

        public function getReceivedDoesPlayerOwnItem():Signal
        {
            return (this.receivedDoesPlayerOwnItem);
        }

        public function getAS2MouseReleased():Signal
        {
            return (this.as2MouseReleased);
        }

        public function getClearCardsCache():Signal
        {
            return (this.clearCardsCache);
        }

        public function getAS2DataReceived():Signal
        {
            return (this.as2DataReceived);
        }

        public function getConsoleDebug():Signal
        {
            return (this.consoleDebug);
        }

        public function getShowComplexPrompt():Signal
        {
            return (this.showComplexPrompt);
        }

        public function getShowPuffleTricksHUD():Signal
        {
            return (this.showPuffleTricksHUD);
        }

        public function getEnablePuffleTricksHUD():Signal
        {
            return (this.enablePuffleTricksHUD);
        }

        public function getDisablePuffleTricksHUD():Signal
        {
            return (this.disablePuffleTricksHUD);
        }

        public function getShowPuffleTreasureNotification():Signal
        {
            return (this.showPuffleTreasureNotification);
        }

        public function getHideQuestUI():Signal
        {
            return (this.hideQuestUI);
        }

        public function getShowQuestUI():Signal
        {
            return (this.showQuestUI);
        }

        public function getShowAssetPrompt():Signal
        {
            return (this.showAssetPrompt);
        }

        public function getCloseAssetPrompt():Signal
        {
            return (this.closeAssetPrompt);
        }

        public function getFocusPhraseChat():Signal
        {
            return (this.focusPhraseChat);
        }

        public function getPartyInit():Signal
        {
            return (this.partyInit);
        }

        public function getMapLegendAnimComplete():Signal
        {
            return (this.mapLegendAnimComplete);
        }

        public function getStartSoundStudio():Signal
        {
            return (this.startSoundStudio);
        }

        public function getShowMusicPlayerWidget():Signal
        {
            return (this.showMusicPlayerWidget);
        }

        public function getHideMusicPlayerWidget():Signal
        {
            return (this.hideMusicPlayerWidget);
        }

        public function getLocalPlayerIgnoreList():Signal
        {
            return (this.localPlayerIgnoreList);
        }

        public function getMuteMusicPlayer():Signal
        {
            return (this.muteMusicPlayer);
        }

        public function getUnmuteMusicPlayer():Signal
        {
            return (this.unmuteMusicPlayer);
        }

        public function getStartIglooMusicSignal():Signal
        {
            return (this.startIglooMusicSignal);
        }

        public function getStopIglooMusicSignal():Signal
        {
            return (this.stopIglooMusicSignal);
        }

        public function addTimerMC(timerMC:MovieClip):void
        {
            this.timerMC = timerMC;
        }

        private function onBridgeError(error:ErrorVO):void
        {
            Signal(this.signalBus.getBridgeError()).dispatch(new ErrorVO(((error.errorCode + " ") + error.errorMessage), ErrorCodeEnum.BRIDGE_DISCONNECT.getId()));
            this.messageQueue.addItem(this.currentMessage, true);
            if (!this.timerMC.hasEventListener(Event.ENTER_FRAME))
            {
                this.timerMC.addEventListener(Event.ENTER_FRAME, this.onTimerFrame);
            };
        }

        public function onTimerFrame(e:Event):void
        {
            if (this.canSendMessage())
            {
                this.timerMC.removeEventListener(Event.ENTER_FRAME, this.onTimerFrame);
                this.sendMessageQueue();
            };
        }

        private function sendMessageQueue():void
        {
            while (this.messageQueue.hasNext)
            {
                if (this.canSendMessage())
                {
                    this.currentMessage = this.messageQueue.next();
                    try
                    {
                        this._bridge.send(AS2_GATEWAY_METHOD, {
                            "isChunked":false,
                            "type":this.currentMessage.type,
                            "data":this.currentMessage.data
                        });
                    }
                    catch(e:Error)
                    {
                        Signal(signalBus.getBridgeError()).dispatch(new ErrorVO(e.message, ErrorCodeEnum.BRIDGE_ARGUMENT_ERROR.getId()));
                    };
                }
                else
                {
                    break;
                };
            };
        }

        private function canSendMessageImmediately():Boolean
        {
            return ((this.canSendMessage()) && (!(this.messageQueue.hasNext)));
        }

        private function canSendMessage():Boolean
        {
            if (this._bridge != null)
            {
            };
            return ((!(this._bridge == null)) && (this._bridge.connected));
        }

        private function parseAssetVOAndSend(data:Object):void
        {
            var assetPromptVO:AssetPromptVO = new AssetPromptVO();
            assetPromptVO.url = data.assetPath;
            if (data.textClipStringTokens)
            {
                assetPromptVO.textClipStringTokens = data.textClipStringTokens;
            };
            if (data.textClipLocalizedStrings)
            {
                assetPromptVO.textClipLocalizedStrings = data.textClipLocalizedStrings;
            };
            if (data.buttonClipPredefinedActions)
            {
                assetPromptVO.buttonClipPredefinedActions = data.buttonClipPredefinedActions;
            };
            if (data.startFrames)
            {
                assetPromptVO.startFrames = data.startFrames;
            };
            if (data.hideLoadingDialog)
            {
                assetPromptVO.hideLoadingDialog = data.hideLoadingDialog;
            };
            if (data.joinRoomActions)
            {
                assetPromptVO.joinRoomActions = data.joinRoomActions;
            };
            this.showAssetPrompt.dispatch(assetPromptVO);
        }

        private function parsePuffleTreasureVOAndSend(data:Object):void
        {
            var puffleTreasureVO:PuffleTreasureVO = new PuffleTreasureVO(data.puffleId, data.treasureType, data.treasureId, data.quantity);
            this.showPuffleTreasureNotification.dispatch(puffleTreasureVO, false);
        }


    }
}//package com.clubpenguin.lib.services
