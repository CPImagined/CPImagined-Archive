//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.model
{
    import org.robotlegs.mvcs.Actor;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.main.signal.SignalBus;
    import com.playdom.tracker.Tracker;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.puffle.CareItemVO;
    import com.clubpenguin.lib.vo.PlayerVO;
    import com.clubpenguin.lib.vo.party.PartyVO;
    import com.clubpenguin.lib.util.collection.Bag;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;
    import com.clubpenguin.main.model.puffle.PuffleStateManager;
    import com.clubpenguin.managers.resource.ResourceManager;
    import flash.utils.Dictionary;
    import com.clubpenguin.lib.vo.PathsVO;
    import com.clubpenguin.main.view.PromptView;
    import com.clubpenguin.lib.services.AVMBridgeService;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import com.clubpenguin.services.socket.puffles.PuffleService;
    import com.clubpenguin.services.socket.world.WorldService;
    import com.clubpenguin.main.service.ErrorService;
    import com.clubpenguin.main.service.DLearningService;
    import com.clubpenguin.main.overlays.vo.LoadingOverlayVO;
    import flash.net.SharedObject;
    import com.clubpenguin.main.view.MainView;
    import flash.system.Security;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.services.socket.IConnection;
    import com.clubpenguin.managers.localization.LocalizationManager;
    import com.clubpenguin.lib.enums.puffle.CareItemInventoryTypeEnum;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.lib.module.ModuleFilenamesEnum;
    import com.clubpenguin.lib.module.WindowModuleContext;
    import com.clubpenguin.lib.module.INotificationModule;
    import flash.external.ExternalInterface;
    import flash.net.URLVariables;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.navigateToURL;
    import com.hurlant.crypto.hash.MD5;
    import flash.utils.ByteArray;
    import com.hurlant.util.Hex;
    import com.clubpenguin.lib.enums.errors.ErrorCodeEnum;
    import com.clubpenguin.lib.vo.ModuleVO;
    import com.asual.swfaddress.SWFAddress;
    import com.asual.swfaddress.SWFAddressEvent;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.vo.IPlayerVO;

    public class MainModel extends Actor implements IAppModel 
    {

        public static const START_SCREEN_STATE:String = "start";
        public static const CREATE_ACCOUNT_STATE:String = "create";
        public static const LOGIN_STATE:String = "login";
        public static const REDEMPTION_STATE:String = "redeem";
        private static var SAVED_GAME_LOCATION:String = "/";
        private static var SAVED_GAME_NAME:String = "SaveGame";

        public var signalBus:SignalBus;
        [Inject]
        public var tracker:Tracker;
        private var _currentState:String;
        public var onConfigLoaded:Signal = new Signal();
        public var onModelReady:Signal = new Signal();
        public var onAppClosed:Signal = new Signal();
        public var onStateChanged:Signal = new Signal(String);
        public var onEnteredWorld:Signal = new Signal();
        public var onRoomUpdated:Signal = new Signal();
        public var onPuffleCareItemPurchased:Signal = new Signal(CareItemVO);
        public var myPlayerVO:PlayerVO = new PlayerVO();
        public var partyVO:PartyVO = new PartyVO();
        public var roomPuffles:Bag = new Bag(PuffleVO);
        public var myPufflesStateManager:PuffleStateManager = new PuffleStateManager();
        public var roomPufflesStateManager:PuffleStateManager = new PuffleStateManager();
        public var resourceManager:ResourceManager;
        public var allWorlds:Dictionary;
        public var moduleModel:ModuleModel;
        public var pathsVO:PathsVO = new PathsVO();
        public var generalConfigVO:Object;
        public var currentRoomId:int;
        public var playerCount:int;
        public var currentWorldData:Object;
        public var _buildParam:String = "";
        public var isAutoLogin:Boolean = false;
        public var autoLoginLocation:String = "";
        public var firstLogin:Boolean = false;
        public var loginRoomload:Boolean = true;
        public var loginRoomComplete:Boolean = false;
        public var activePrompt:PromptView;
        private var _bridge:AVMBridgeService;
        private var _environmentData:EnvironmentDataVO;
        private var _currentNewspaperPath:String;
        private var _puffleService:PuffleService = new PuffleService();
        private var _worldService:WorldService = new WorldService();
        private var _errorService:ErrorService = new ErrorService();
        private var _dlearningService:DLearningService;
        private var _overlayCount:int;
        public var loadingOverlayVO:LoadingOverlayVO;
        public var overrideBlockAllNotifications:Boolean = false;
        private var _savedGame:SharedObject;
        private var _cardsCache:Array;
        public var sessionUuid:String;
        public var browserId:String;
        public var playerColors:Object;
        public var mainView:MainView;
        public var updateLoginFloodManager:Signal = new Signal();
        public var overlayCountUpdated:Signal = new Signal();
        public var startSoundStudio:Signal = new Signal();
        public var showMusicPlayerWidget:Signal = new Signal();
        public var hideMusicPlayerWidget:Signal = new Signal();
        public var muteMusicPlayer:Signal = new Signal();
        public var unmuteMusicPlayer:Signal = new Signal();

        public function MainModel()
        {
            this._overlayCount = 0;
            Security.exactSettings = false;
            this._environmentData = new EnvironmentDataVO();
            this.pathsVO.init(this._environmentData);
        }

        public function init(bridge:IAVMBridgeService, socketConnection:IConnection, localizationManager:LocalizationManager, dlearningService:DLearningService):void
        {
            this._bridge = (bridge as AVMBridgeService);
            this._worldService.init(socketConnection, this);
            this._errorService.init(this._bridge, this, localizationManager);
            this._errorService.updateLoginFloodManager.add(this.onUpdateFloodControl);
            this._puffleService.init(socketConnection, this);
            this._dlearningService = dlearningService;
            this.myPufflesStateManager.init(this._puffleService, this.myPlayerVO.puffles, true);
            this.roomPufflesStateManager.init(this._puffleService, this.roomPuffles, false);
            this.signalBus.getCurrentWorldReceived().add(this.onCurrentWorldReceived);
            this._bridge.doesPlayerOwnPuffleItem.add(this.onDoesPlayerOwnPuffleItem);
        }

        public function get overlayCount():int
        {
            return (this._overlayCount);
        }

        public function set overlayCount(value:int):void
        {
            if (this._overlayCount != value)
            {
                this._overlayCount = value;
                if (this._overlayCount < 1)
                {
                    this._overlayCount = 0;
                };
                this.overlayCountUpdated.dispatch();
            };
        }

        public function onCurrentWorldReceived(worldData:Object):void
        {
            var msg:String;
            var el:String;
            msg = "-------------------------------------\n";
            msg = (msg + "worldData\n");
            for each (el in worldData)
            {
                msg = (msg + (((("        ." + el) + " = ") + worldData[el]) + "\n"));
            };
            msg = (msg + "-------------------------------------");
            this.currentWorldData = worldData;
        }

        public function onDoesPlayerOwnPuffleItem(itemId:int, itemCategory:String):void
        {
            var inventory:Bag = this.myPlayerVO.getCareItemInventoryByCategory(CareItemInventoryTypeEnum.getEnumByInstanceName(itemCategory));
            var careItemVO:CareItemVO = CareItemVO(inventory.getItem(itemId));
            var quantity:int;
            var hasItem:* = (!(careItemVO == null));
            if (hasItem)
            {
                quantity = careItemVO.quantity;
            };
            var message:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_GET_DOES_PLAYER_OWN_PUFFLE_ITEM);
            message.data = {
                "itemId":itemId,
                "itemCategory":itemCategory,
                "hasItem":hasItem,
                "quantity":quantity
            };
            this._bridge.send(message);
        }

        public function getAVMBridge():IAVMBridgeService
        {
            if (!this._bridge)
            {
                throw (new Error("getAVMBridge() when _bridge is not ready in the MainModel!"));
            };
            return (this._bridge);
        }

        public function createAVMBridge():void
        {
            if (this._bridge)
            {
                this._bridge.getCreateMyPlayerVO().add(this.onUpdateMyPlayerVO);
                this._bridge.getOpenModule().add(this.onOpenModule);
                this._bridge.puffleCareItemInfoRequested.add(this.onPuffleCareItemInfoRequested);
                this._bridge.addPuffleCareItem.add(this.addPuffleCareItem);
                this._bridge.getShowMembershipPrompt().add(this.onShowMembershipPrompt);
                this._bridge.getShowMembershipFAQ().add(this.onShowMembershipFAQ);
                this._bridge.onJoinedRoom.add(this.onJoinedNewRoom);
                this._bridge.onLeavingRoom.add(this.signalBus.leavingRoom.dispatch);
                this._bridge.navigateToBuyMembership.add(this.onNavigateToBuyMembership);
                this._bridge.addPuffleCarePoints.add(this.onAddPuffleCarePoints);
                this._bridge.getClearCardsCache().add(this.onClearCardsCache);
                this._bridge.idlePlayerTimeout.add(this.signalBus.idlePlayerTimeout.dispatch);
                this._bridge.hideLikeWindow.add(this.hideLikeWindowOnLoad);
                this._bridge.closeLikeWindow.add(this.closeLikeWindow);
                this._bridge.getClosePrompt().add(this.onClosePrompt);
                this._bridge.getStartSoundStudio().add(this.onStartSounStudio);
                this._bridge.getShowMusicPlayerWidget().add(this.onShowMusicPlayerWidget);
                this._bridge.getHideMusicPlayerWidget().add(this.onHideMusicPlayerWidget);
                this._bridge.getMuteMusicPlayer().add(this.onMuteMusicPlayer);
                this._bridge.getUnmuteMusicPlayer().add(this.onUnmuteMusicPlayer);
            }
            else
            {
                throw (new Error("MainModel -> createAVMBridge(). Trying to connect to bridge when bridge is not ready or does not exist!"));
            };
        }

        private function onUpdateFloodControl():void
        {
            this.updateLoginFloodManager.dispatch();
        }

        private function onAddPuffleCarePoints(puffleID:int, food:uint, play:uint, rest:uint, clean:uint):void
        {
            var puffle:PuffleVO;
            var puffles:Array = this.myPlayerVO.puffles.getAllItems();
            var i:int;
            while (i < puffles.length)
            {
                puffle = puffles[i];
                if (puffle.id == puffleID)
                {
                    puffle.statsVO.food = (puffle.statsVO.food + food);
                    puffle.statsVO.play = (puffle.statsVO.play + play);
                    puffle.statsVO.rest = (puffle.statsVO.rest + rest);
                    puffle.statsVO.clean = (puffle.statsVO.clean + clean);
                };
                i++;
            };
        }

        private function hideLikeWindowOnLoad():void
        {
            var likeModule:BaseModule;
            if (this.moduleModel.isModuleOpen(ModuleFilenamesEnum.LIKE_WINDOW_MODULE))
            {
                likeModule = this.moduleModel.getModuleWithKey(ModuleFilenamesEnum.LIKE_WINDOW_MODULE);
                if (!(likeModule.getContext() as WindowModuleContext).isWindowLoaded)
                {
                    this.signalBus.likeModuleLoaded.add(this.onLikeModuleLoaded);
                };
            }
            else
            {
                this.signalBus.likeModuleLoaded.add(this.onLikeModuleLoaded);
            };
        }

        private function onLikeModuleLoaded():void
        {
            this._bridge.hideLikeWindow.dispatch();
            this.signalBus.likeModuleLoaded.remove(this.onLikeModuleLoaded);
        }

        private function closeLikeWindow():void
        {
            this.signalBus.likeModuleLoaded.removeAll();
        }

        public function onClosePrompt():void
        {
            var notifcationModule:INotificationModule;
            if (this.activePrompt != null)
            {
                notifcationModule = INotificationModule(this.moduleModel.getModuleWithKey(ModuleFilenamesEnum.NOTIFICATIONS));
                notifcationModule.getNotificationService().start();
                this.activePrompt.destroy();
                this.signalBus.closeView.dispatch(this.activePrompt);
                this.activePrompt = null;
            };
        }

        private function onNavigateToBuyMembership(tag:String):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("window.metrics.setSWID", this.myPlayerVO.player_swid);
                ExternalInterface.call("window.metrics.stepTime", "oops_message", "start");
            };
            var lang:String = this.getEnvironmentData().language;
            var URL:String = this.pathsVO.getLinkPath("member_web");
            var hashedKey:String = this.hashActiveLoginKey(this.myPlayerVO.activeKey);
            var urlVars:URLVariables = new URLVariables();
            urlVars.tag = ((tag + "_") + lang);
            urlVars.player_id = this.myPlayerVO.player_id;
            urlVars.active_key = hashedKey;
            var request:URLRequest = new URLRequest(URL);
            request.method = URLRequestMethod.POST;
            request.data = urlVars;
            navigateToURL(request);
        }

        private function hashActiveLoginKey(key:String):String
        {
            var md5:MD5 = new MD5();
            var input:ByteArray = new ByteArray();
            input.writeUTFBytes(("(LHny:TyGynR" + key));
            var output:ByteArray = md5.hash(input);
            var hashedKey:String = Hex.fromArray(output);
            return (hashedKey);
        }

        private function onJoinedNewRoom(room_id:int, player_count:int):void
        {
            if (!this.loginRoomComplete)
            {
                this.tracker.trackAssetLoadingEnd(0, "load.world");
                this.loginRoomComplete = true;
                this.onEnteredWorld.dispatch();
                this.currentRoomId = room_id;
                this.playerCount = player_count;
                if (((!(this.moduleModel.isModuleOpen(ModuleFilenamesEnum.PRE_ACTIVATION))) && (!(this.moduleModel.isModuleOpen(ModuleFilenamesEnum.MEMBERSHIP_TRIAL)))))
                {
                    this.onRoomUpdated.dispatch();
                };
            }
            else
            {
                this.currentRoomId = room_id;
                this.playerCount = player_count;
                if (!this.moduleModel.isModuleOpen(ModuleFilenamesEnum.PRE_ACTIVATION))
                {
                    this.onRoomUpdated.dispatch();
                };
            };
        }

        public function releaseAVMBridge():void
        {
            this._bridge.disconnect();
        }

        public function connectAVMBridge():void
        {
            this._environmentData.multiClientCheckFailed = (!(this._bridge.connect(this._environmentData.connectionID)));
            if (this._environmentData.multiClientCheckFailed)
            {
                this._errorService.onResponded({"errorCode":ErrorCodeEnum.MULTI_CONNECTIONS.getId()});
            };
        }

        private function onUpdateMyPlayerVO(genericPlayerObject:Object):void
        {
            var genericProp:*;
            if (((!(this.myPlayerVO.player_id == -1)) && (!(this._dlearningService.isInitialized()))))
            {
                this._dlearningService.init(this.myPlayerVO.player_id.toString());
            };
            for (genericProp in genericPlayerObject)
            {
                if (this.myPlayerVO.hasOwnProperty(genericProp))
                {
                    this.myPlayerVO[genericProp] = genericPlayerObject[genericProp];
                };
            };
        }

        private function onClearCardsCache():void
        {
            this._cardsCache = null;
        }

        private function onCoinsUpdated(coins:int):void
        {
            this.myPlayerVO.coins = coins;
        }

        private function onOpenModule(moduleVO:ModuleVO):void
        {
            Signal(this.signalBus.loadModule).dispatch(moduleVO);
        }

        private function onShowMembershipPrompt(filePath:String, data:Object):void
        {
            Signal(this.signalBus.loadMembershipPrompt).dispatch(filePath, data);
        }

        private function onShowMembershipFAQ(filePath:String, data:Object):void
        {
            Signal(this.signalBus.loadMembershipFAQ).dispatch(filePath, data);
        }

        public function setEnvironmentData(__params:Object):void
        {
            this._environmentData.setDataFromObject(__params);
        }

        public function getEnvironmentData():EnvironmentDataVO
        {
            return (this._environmentData);
        }

        public function close():void
        {
            this.onAppClosed.dispatch();
        }

        public function initSWFAddress():void
        {
            SWFAddress.addEventListener(SWFAddressEvent.INIT, this.onSWFAddressInit, false, 0, true);
        }

        private function onSWFAddressInit(e:SWFAddressEvent):void
        {
            Log.info("MainModel.onSWFAddressInit", Log.DEFAULT);
            SWFAddress.removeEventListener(SWFAddressEvent.INIT, this.onSWFAddressInit, false);
            SWFAddress.addEventListener(SWFAddressEvent.CHANGE, this.onSWFAddressChange);
        }

        public function addPuffleCareItem(id:int, quantity:int, addToExistingQuantity:Boolean):void
        {
            var myCareItemVO:CareItemVO;
            var isHat:Boolean;
            var masterCollection:Bag = ResourceManager(this.resourceManager).getPuffleCareItemCollection();
            var masterCareItemCopy:CareItemVO = CareItemVO(masterCollection.getItem(id)).copy();
            var inventory:Bag = this.myPlayerVO.getCareItemInventoryByCategory(masterCareItemCopy.category);
            if (inventory)
            {
                myCareItemVO = (inventory.getItem(id) as CareItemVO);
                if (myCareItemVO)
                {
                    if (addToExistingQuantity)
                    {
                        myCareItemVO.quantity = (myCareItemVO.quantity + quantity);
                    }
                    else
                    {
                        myCareItemVO.quantity = quantity;
                    };
                    isHat = ((myCareItemVO.category == CareItemInventoryTypeEnum.HEAD) ? true : false);
                    if (isHat)
                    {
                        myCareItemVO.totalHatQuantity = myCareItemVO.quantity;
                    };
                }
                else
                {
                    masterCareItemCopy.quantity = quantity;
                    inventory.add(masterCareItemCopy);
                };
            };
        }

        public function puffleCareItemPurchased(careItemVO:CareItemVO):void
        {
            this.onPuffleCareItemPurchased.dispatch(careItemVO);
        }

        private function onPuffleCareItemInfoRequested(itemID:int):void
        {
            var inventory:Bag;
            var puffleCareItemInfoMessage:AVMBridgeMessage;
            var careItemPossessed:CareItemVO;
            var isHat:Boolean;
            var updatedQuantity:int;
            var quantity:int;
            var maxPossesedQuantity:int;
            var totalQuantityRequested:Number;
            var puffleCareItemCollection:Bag = this.resourceManager.getPuffleCareItemCollection();
            var requestedCareItemVO:CareItemVO = CareItemVO(puffleCareItemCollection.getItem(itemID)).copy();
            if (requestedCareItemVO)
            {
                inventory = this.myPlayerVO.getCareItemInventoryByCategory(requestedCareItemVO.category);
                if (inventory)
                {
                    puffleCareItemInfoMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_SEND_BUY_PUFFLE_CARE_ITEM_INFO);
                    careItemPossessed = (inventory.getItem(requestedCareItemVO.rootItemID) as CareItemVO);
                    isHat = ((requestedCareItemVO.category == CareItemInventoryTypeEnum.HEAD) ? true : false);
                    if (careItemPossessed != null)
                    {
                        if (isHat)
                        {
                            updatedQuantity = careItemPossessed.totalHatQuantity;
                        }
                        else
                        {
                            updatedQuantity = careItemPossessed.quantity;
                        };
                    }
                    else
                    {
                        updatedQuantity = 0;
                    };
                    quantity = ((careItemPossessed != null) ? updatedQuantity : 0);
                    maxPossesedQuantity = ((careItemPossessed != null) ? careItemPossessed.getMaxQuantity() : 0);
                    totalQuantityRequested = (quantity + requestedCareItemVO.quantityPerCost);
                    puffleCareItemInfoMessage.data = {};
                    puffleCareItemInfoMessage.data.itemID = itemID;
                    puffleCareItemInfoMessage.data.max_quantity = requestedCareItemVO.getMaxQuantity();
                    puffleCareItemInfoMessage.data.assetPath = requestedCareItemVO.assetPath;
                    puffleCareItemInfoMessage.data.cost = requestedCareItemVO.cost;
                    puffleCareItemInfoMessage.data.prompt = requestedCareItemVO.prompt;
                    puffleCareItemInfoMessage.data.isMemberOnly = requestedCareItemVO.isMemberOnly;
                    puffleCareItemInfoMessage.data.isHat = ((requestedCareItemVO.category == CareItemInventoryTypeEnum.HEAD) ? true : false);
                    puffleCareItemInfoMessage.data.quantityLimitReached = ((!(careItemPossessed == null)) && (totalQuantityRequested > maxPossesedQuantity));
                    this._bridge.send(puffleCareItemInfoMessage);
                }
                else
                {
                    throw (new Error(("[MainModel] -> onPuffleCareItemInfoRequested(): ERROR!!! No inventory collection found in my player vo with category = " + requestedCareItemVO.category)));
                };
            }
            else
            {
                throw (new Error((("[MainModel] -> onPuffleCareItemInfoRequested(): ERROR!!! No care item with id = " + itemID) + " found in puffle care item collection!")));
            };
        }

        private function onSWFAddressChange(e:SWFAddressEvent):void
        {
            var newState:String = SWFAddress.getPathNames()[0];
            switch (newState)
            {
                case MainModel.START_SCREEN_STATE:
                case MainModel.CREATE_ACCOUNT_STATE:
                case MainModel.LOGIN_STATE:
                case MainModel.REDEMPTION_STATE:
                    this._currentState = newState;
                    break;
                default:
                    this._currentState = MainModel.START_SCREEN_STATE;
            };
            Log.info(("MainModel -> SWFAddressChange. New State: " + this._currentState), Log.HTTP);
            this.onStateChanged.dispatch(this._currentState);
        }

        public function onStartSounStudio():void
        {
            Log.debug("MainModel.onStartSounStudio");
            this.startSoundStudio.dispatch();
        }

        public function onShowMusicPlayerWidget():void
        {
            Log.debug("MainModel.onShowMusicPlayerWidget");
            this.showMusicPlayerWidget.dispatch();
        }

        public function onHideMusicPlayerWidget():void
        {
            Log.debug("MainModel.onHideMusicPlayerWidget");
            this.hideMusicPlayerWidget.dispatch();
        }

        public function onMuteMusicPlayer():void
        {
            Log.debug("MainModel.onMuteMusicPlayer");
            this.muteMusicPlayer.dispatch();
        }

        public function onUnmuteMusicPlayer():void
        {
            Log.debug("MainModel.onUnmuteMusicPlayer");
            this.unmuteMusicPlayer.dispatch();
        }

        public function get currentState():String
        {
            return (this._currentState);
        }

        public function getNewspaperPath():String
        {
            return (this._currentNewspaperPath);
        }

        public function getUsername():String
        {
            return (this.myPlayerVO.username);
        }

        public function getNickname():String
        {
            return (this.myPlayerVO.nickname);
        }

        public function getPlayerID():int
        {
            return (this.myPlayerVO.player_id);
        }

        public function getLanguage():String
        {
            return (this._environmentData.language);
        }

        public function getBasePath():String
        {
            return (this._environmentData.basePath);
        }

        public function getClientPath():String
        {
            return (this._environmentData.clientPath);
        }

        public function isMember():Boolean
        {
            return (this.myPlayerVO.is_member);
        }

        public function isSafeMode():Boolean
        {
            return (this.myPlayerVO.getIsSafeMode());
        }

        public function getCoins():int
        {
            return (this.myPlayerVO.coins);
        }

        public function getPlayerVO():PlayerVO
        {
            return (this.myPlayerVO);
        }

        public function getLocalPlayerVO():IPlayerVO
        {
            return (this.myPlayerVO);
        }

        public function getRoomUpdated():Signal
        {
            return (this.onRoomUpdated);
        }

        public function getCurrentWorldData():Object
        {
            return (this.currentWorldData);
        }

        public function getOverrideBlockAllNotifications():Boolean
        {
            return (this.overrideBlockAllNotifications);
        }

        public function setOverrideBlockAllNotifications(_value:Boolean):void
        {
            this.overrideBlockAllNotifications = _value;
        }

        public function getBuildParam():String
        {
            return (this._buildParam);
        }

        public function set buildParam(buildParam:String):void
        {
            this._buildParam = buildParam;
        }

        public function getSavedGame():SharedObject
        {
            if (this._savedGame == null)
            {
                this._savedGame = SharedObject.getLocal(SAVED_GAME_NAME, SAVED_GAME_LOCATION);
            };
            return (this._savedGame);
        }

        public function getPlayerColors():Object
        {
            return (this.playerColors);
        }

        public function getCardsCache():Array
        {
            return (this._cardsCache);
        }

        public function setCurrentRoomId(value:int):void
        {
            this.myPlayerVO.currentRoom = value;
            this.currentRoomId = value;
        }

        public function getCurrentRoomId():int
        {
            return (this.currentRoomId);
        }

        public function getPlayerCount():int
        {
            return (this.playerCount);
        }

        public function setMyPlayerMembership(value:Boolean):void
        {
            this.myPlayerVO.setIsMember(value);
        }

        public function setMyPlayerMembershipEnum(value:int):void
        {
            this.myPlayerVO.setMembershipEnum(value);
        }

        public function set cardsCache(cards:Array):void
        {
            this._cardsCache = cards;
        }

        public function getPathsVO():PathsVO
        {
            return (this.pathsVO);
        }

        public function getShowMusicPlayerWidget():Signal
        {
            return (this.showMusicPlayerWidget);
        }

        public function getHideMusicPlayerWidget():Signal
        {
            return (this.hideMusicPlayerWidget);
        }

        public function getMuteMusicPlayer():Signal
        {
            return (this.muteMusicPlayer);
        }

        public function getUnmuteMusicPlayer():Signal
        {
            return (this.unmuteMusicPlayer);
        }


    }
}//package com.clubpenguin.main.model
