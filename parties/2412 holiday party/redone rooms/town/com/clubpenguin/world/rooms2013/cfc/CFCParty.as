//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.CFCParty
    {
        static var _shell, _airtower, _interface, _engine, _party, _serverCookieService, _serverCookie, _purchaseItemThrottler, CFCWorldTotalUpdated, updatePlayerFrame, _instance, _engineOverrides, _engineOverridesTrainRoom, _interfaceOverrides, _shellOverrides, _snowballCoolDownExpirationDate, _previousWorldCoinTotal, _bundleBoughtDelegate, _buyItemDelegate, _buyFurnitureDelegate, _buyIglooDelegate, _handleUpdatePlayerCoinsDelegate;
        function CFCParty () {
        }
        static function init() {
            pebug("CFC PARTY - INIT");
            _isActive = true;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            _serverCookieService = _shell.getServerCookieService();
            _serverCookie = new com.clubpenguin.world.rooms2013.cfc.vo.CFCPartyCookieVO(PARTY_COOKIE_ID);
            _serverCookieService.registerCookieVO(_serverCookie.getID(), _serverCookie);
            _purchaseItemThrottler = new com.clubpenguin.util.EventThrottler();
            _purchaseItemThrottler.delayBetweenEvents = 2000;
            activateCFCEngineOverrides();
            activateCFCInterfaceOverrides();
            activateCFCShellOverrides();
            _airtower.addListener(CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME, handleUpdatePartySettings);
            _airtower.addListener(CONSTANTS.CFC_TOTALWORLDCOINS_BROADCAST_NAME, handleCFCTotalBroadcast);
            _airtower.addListener(CONSTANTS.TRAIN_ROOM_COMMAND_NAME, handleTrainStateUpdate);
            _shell.addListener(_shell.UPDATE_PLAYER, com.clubpenguin.util.Delegate.create(_this, checkForTrainItemEquipped));
            CFCWorldTotalUpdated = new org.osflash.signals.Signal(Number);
            updatePlayerFrame = new org.osflash.signals.Signal(Number);
            com.clubpenguin.world.rooms2013.cfc.trains.TrainLoader.init();
        }
        static function get partyCookie() {
            return(com.clubpenguin.world.rooms2013.cfc.vo.CFCPartyCookieVO(_serverCookie));
        }
        static function handleUpdatePartySettings(data) {
            var _local_4 = com.clubpenguin.util.JSONParser.parse(data[1]);
            _airtower.removeListener(CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME, handleUpdatePartySettings);
            CONSTANTS.MAX_TRAIN_PASSENGERS = _local_4.maxTrainPassengers;
            var _local_5 = new Array();
            CONSTANTS.MILESTONES = _local_5;
            var _local_3 = 0;
            while (_local_3 < _local_4.cfcmilestones.length) {
                var _local_2 = getIndexOfMilestoneWithValue(_local_4.cfcmilestones[_local_3].coinsDonated);
                if (_local_2 >= 0) {
                    pebug("Milestone value already exists, add to previous value " + _local_2);
                    var _local_1 = CONSTANTS.MILESTONES[_local_2].unlockedId;
                    if (typeof(_local_1) == "number") {
                        var _local_7 = _local_1;
                        _local_1 = new Array();
                        _local_1.push({id:CONSTANTS.MILESTONES[_local_2].unlockedId, quantity:CONSTANTS.MILESTONES[_local_2].quantity});
                    }
                    if (typeof(_local_1) == "object") {
                        _local_1.push({id:_local_4.cfcmilestones[_local_3].unlockedId, quantity:_local_4.cfcmilestones[_local_3].quantity});
                    }
                    CONSTANTS.MILESTONES[_local_2].unlockedId = _local_1;
                    pebug("Updated set of item ids: " + _local_1);
                } else {
                    _local_5.push(_local_4.cfcmilestones[_local_3]);
                }
                CONSTANTS.MILESTONES = _local_5;
                _local_3++;
            }
        }
        static function getIndexOfMilestoneWithValue(value) {
            var _local_1 = 0;
            while (_local_1 < CONSTANTS.MILESTONES.length) {
                if (CONSTANTS.MILESTONES[_local_1].coinsDonated == value) {
                    return(_local_1);
                }
                _local_1++;
            }
            return(-1);
        }
        static function handleCFCTotalBroadcast(data) {
            var _local_1 = Number(data[1]);
            CONSTANTS.CFC_DONATION_TOTAL = _local_1;
            CFCWorldTotalUpdated.dispatch(_local_1);
        }
        static function pebug(msg, prefix) {
            if (undefined == prefix) {
                prefix = CLASS_NAME;
            }
            com.clubpenguin.util.Log.debug((prefix + "::") + msg, com.clubpenguin.util.Log.PARTY);
        }
        static function get isActive() {
            return(_isActive);
        }
        static function checkForFirstTimeLogin(playerObj) {
            checkForTrainItemEquipped(_shell.getMyPlayerObject(), true);
            if (((_shell.getMyPlayerId() != playerObj.player_id) || (partyCookie.loginMsgViewed)) || (_shell.getRoomObject().room_id == 112)) {
                return(undefined);
            }
            _interface.showContent(com.clubpenguin.world.rooms2013.cfc.CFCPartyConstants.CHARACTER_DIALOGUE_PATH_LOGIN);
        }
        static function showPartyCatalogue() {
            _global.getCurrentInterface().showContent(CONSTANTS.PARTY_CATALOGUE);
        }
        static function playSound(ui, soundId) {
            var _local_1 = new Sound(ui);
            _local_1.attachSound(soundId);
            _local_1.start();
        }
        static function dispatchUpdatePlayerFrame(player_id) {
            updatePlayerFrame.dispatch(player_id);
        }
        static function get instance() {
            if (_instance == null) {
                _instance = new com.clubpenguin.world.rooms2013.cfc.CFCParty();
            }
            return(_instance);
        }
        static function get engineOverrides() {
            if (_engineOverrides == null) {
                _engineOverrides = new com.clubpenguin.world.rooms2013.cfc.CFCParty_EngineOverrides();
                _engineOverrides.init();
            }
            return(_engineOverrides);
        }
        static function get engineOverridesTrainRoom() {
            if (_engineOverridesTrainRoom == null) {
                _engineOverridesTrainRoom = new com.clubpenguin.world.rooms2013.cfc.CFCParty_EngineOverrides_TrainRoom();
                _engineOverridesTrainRoom.init();
            }
            return(_engineOverridesTrainRoom);
        }
        static function get interfaceOverrides() {
            if (_interfaceOverrides == null) {
                _interfaceOverrides = new com.clubpenguin.world.rooms2013.cfc.CFCParty_InterfaceOverrides();
                _interfaceOverrides.init();
            }
            return(_interfaceOverrides);
        }
        static function get shellOverrides() {
            if (_shellOverrides == null) {
                _shellOverrides = new com.clubpenguin.world.rooms2013.cfc.CFCParty_ShellOverrides();
                _shellOverrides.init();
            }
            return(_shellOverrides);
        }
        static function handleTrainStateUpdate(data) {
            pebug("CFCParty: handleTrainRoomStateUpdateDelegate data " + data);
            var _local_1 = data[1];
            if (_local_1 == "state") {
                trainRoomState = data[2];
            }
        }
        static function isTrainBodyItemEquipped(player_id) {
            if (player_id == null) {
                return(false);
            }
            var _local_2 = _shell.getPlayerObjectById(player_id);
            var _local_1 = _local_2.hand;
            pebug("Hand item is " + _local_1);
            if (((_local_1 != undefined) && (_local_1 >= CONSTANTS.TRAIN_1_ID)) && (_local_1 <= CONSTANTS.TRAIN_4_ID)) {
                return(true);
            }
            return(false);
        }
        static function get snowballCoolDownExpirationDate() {
            return(_snowballCoolDownExpirationDate);
        }
        static function get snowballCoolDownRemainderPercentage() {
            var _local_3 = _shell.getPenguinStandardTime().getTime();
            var _local_2 = _local_3 - _snowballCoolDownExpirationDate;
            var _local_1 = Math.round((_local_2 / CONSTANTS.SNOWBALL_COOLDOWN) * 100);
            return(((_local_1 == 0) ? 1 : (_local_1)));
        }
        static function get isSnowballEnabled() {
            if (snowballCoolDownExpirationDate <= _shell.getPenguinStandardTime().getTime()) {
                return(true);
            }
            return(false);
        }
        static function isInTrainGameRoom() {
            var _local_1 = _shell.getCurrentRoomId();
            return(((_local_1 == com.clubpenguin.world.rooms2013.cfc.CFCPartyConstants.TRAIN_GAME_ROOM_A) || (_local_1 == com.clubpenguin.world.rooms2013.cfc.CFCPartyConstants.TRAIN_GAME_ROOM_B)) || (_local_1 == com.clubpenguin.world.rooms2013.cfc.CFCPartyConstants.TRAIN_GAME_ROOM_C));
        }
        static function checkForTrainItemEquipped(ob, login) {
            pebug("check if train item is equipped login " + login);
            pebug("check if train item is equipped " + isTrainBodyItemEquipped(ob.player_id));
            if ((login == true) && (isTrainBodyItemEquipped(ob.player_id))) {
                trainItemEquipped = true;
                return(undefined);
            }
            if (((ob.player_id == _shell.getMyPlayerId()) && (!trainItemEquipped)) && (isTrainBodyItemEquipped(ob.player_id))) {
                trainItemEquipped = true;
            } else {
                trainItemEquipped = false;
            }
        }
        static function get CFCDonationTotal() {
            return(CONSTANTS.CFC_DONATION_TOTAL);
        }
        static function set previousWorldCoinTotal(value) {
            _previousWorldCoinTotal = value;
            //return(previousWorldCoinTotal);
        }
        static function get previousWorldCoinTotal() {
            return(_previousWorldCoinTotal);
        }
        static function openQuestUI() {
            _interface.showContent(com.clubpenguin.world.rooms2013.cfc.CFCPartyConstants.QUEST_UI_PATH);
        }
        static function showTrainIglooList() {
            _interface.showContent(CONSTANTS.IGLOO_LIST_PATH);
        }
        static function startSnowballCoolDown() {
            _snowballCoolDownExpirationDate = _shell.getPenguinStandardTime().getTime() + CONSTANTS.SNOWBALL_COOLDOWN;
        }
        static function configurePurchaseableItem(itemMC, itemID, itemType, member, prompt) {
            pebug("configurePurchaseableItem itemID " + itemID);
            pebug("configurePurchaseableItem itemType " + itemType);
            if ((itemType == "item") && (_shell.isItemInMyInventory(itemID))) {
                itemMC.nextFrame();
                return(undefined);
            }
            if ((itemType == "furniture") && (_shell.isFurnitureInMyInventory(itemID))) {
                itemMC.nextFrame();
                return(undefined);
            }
            if ((itemType == "igloo") && (_shell.isIglooBuildingInMyInventory(itemID))) {
                itemMC.nextFrame();
                return(undefined);
            }
            itemMC.claim_btn.onRelease = com.clubpenguin.util.Delegate.create(_this, checkPurchaseOfItem, itemMC, itemID, itemType, member, prompt);
        }
        static function configureFurnitureBundle(itemMC, itemIDSet) {
            if (_shell.isFurnitureInMyInventory(itemIDSet[0][0].id)) {
                itemMC.nextFrame();
                return(undefined);
            }
            itemMC.claim_btn.onRelease = com.clubpenguin.util.Delegate.create(_this, buyFurnitureBundle, itemMC, itemIDSet);
        }
        static function buyFurnitureBundle(itemMC, itemIDSet) {
            _bundleBoughtDelegate = com.clubpenguin.util.Delegate.create(_this, onBundleBought, itemMC);
            _airtower.addListener(_airtower.BUY_MULTIPLE_FURNITURE, _bundleBoughtDelegate, _this);
            _airtower.send(_airtower.PLAY_EXT, "g#" + _airtower.BUY_MULTIPLE_FURNITURE, [(itemIDSet[0][0].id + "|") + itemIDSet[0][0].quantity, (itemIDSet[0][1].id + "|") + itemIDSet[0][1].quantity, (itemIDSet[0][2].id + "|") + itemIDSet[0][2].quantity, (itemIDSet[0][3].id + "|") + itemIDSet[0][3].quantity], "str", _shell.getCurrentServerRoomId());
        }
        static function checkPurchaseOfItem(itemMC, itemID, itemType, member, prompt) {
            if (member) {
                if (_shell.isMyPlayerMember()) {
                    buyItem(itemID, itemMC, itemType, prompt);
                } else {
                    _interface.showContent(CONSTANTS.OOPS_CATALOGUE_MESSAGE);
                }
            } else {
                buyItem(itemID, itemMC, itemType, prompt);
            }
        }
        static function buyItem(itemID, itemMC, itemType, prompt) {
            _buyItemDelegate = null;
            _buyFurnitureDelegate = null;
            _buyIglooDelegate = null;
            switch (itemType) {
                case "item" : 
                    if (prompt) {
                        _interface.buyInventory(itemID);
                    } else {
                        _shell.sendBuyInventory(itemID);
                    }
                    if (!prompt) {
                        _buyItemDelegate = com.clubpenguin.util.Delegate.create(_this, onInventoryBought, itemMC, itemID);
                        _shell.addListener(_shell.BUY_INVENTORY, _buyItemDelegate, _this);
                    }
                    break;
                case "furniture" : 
                    if (prompt) {
                        _interface.buyFurniture(itemID);
                    } else {
                        _shell.sendBuyFurniture(itemID);
                    }
                    if (!prompt) {
                        _buyFurnitureDelegate = com.clubpenguin.util.Delegate.create(_this, onFurnitureBought, itemMC, itemID);
                        _shell.addListener(_shell.BUY_FURNITURE, _buyFurnitureDelegate);
                    }
                    break;
                case "igloo" : 
                    if (prompt) {
                        _interface.buyIglooType(itemID);
                    } else {
                        _shell.sendBuyIglooType(itemID);
                    }
                    if (!prompt) {
                        _buyIglooDelegate = com.clubpenguin.util.Delegate.create(_this, onIglooBought, itemMC, itemID);
                        _shell.addListener(_shell.BUY_IGLOO_TYPE, _buyIglooDelegate);
                    }
                    break;
                case "puffle" : 
                    break;
            }
        }
        static function onInventoryBought(event, itemMC, itemID) {
            _shell.removeListener(_shell.BUY_INVENTORY, _buyItemDelegate);
            if (event.success) {
                itemMC.nextFrame();
            }
        }
        static function onFurnitureBought(event, itemMC, itemID) {
            _shell.removeListener(_shell.BUY_FURNITURE, _buyFurnitureDelegate);
            if (event.success) {
                itemMC.nextFrame();
            }
        }
        static function onIglooBought(event, itemMC, itemID) {
            _shell.removeListener(_shell.BUY_IGLOO_TYPE, _buyIglooDelegate);
            if (event.success) {
                itemMC.nextFrame();
            }
        }
        static function onBundleBought(event, itemMC) {
            _airtower.removeListener("buy_multiple_furniture", _bundleBoughtDelegate, _this);
            pebug("Flip item to collected state " + itemMC);
            itemMC.nextFrame();
            com.clubpenguin.util.TrackerAS2.getInstance().trackRewardEarned("coins", 1, "bundle_Furniture", "cfc_2013", _shell.getMyPlayerTotalCoins());
        }
        static function showPartyIcon() {
            _interface.PARTY_ICON._visible = true;
        }
        static function hidePartyIcon() {
            _interface.PARTY_ICON._visible = false;
        }
        static function partyIconState() {
            if (partyCookie.loginMsgViewed) {
                showPartyIcon();
            } else {
                hidePartyIcon();
            }
        }
        static function sendLoginViewed() {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.cfc.vo.CFCPartyCookieVO.CFC_COOKIE_HANDLER_NAME + "#") + CONSTANTS.LOGIN_VIEWED_COMMAND, [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendTargetHit(playerID, targetID) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.cfc.vo.CFCPartyCookieVO.CFC_COOKIE_HANDLER_NAME + "#") + CONSTANTS.TRAIN_ROOM_COMMAND_NAME, [CONSTANTS.TRAIN_ROOM_TARGET_HIT_COMMAND_NAME, playerID, Number(targetID - 1)], "str", _shell.getCurrentServerRoomId());
        }
        static function donateCoins(coinAmount) {
            _handleUpdatePlayerCoinsDelegate = com.clubpenguin.util.Delegate.create(_this, updatePlayerCoins);
            _airtower.addListener(CONSTANTS.CFC_DONATE_COINS_COMMAND, _handleUpdatePlayerCoinsDelegate);
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.cfc.vo.CFCPartyCookieVO.CFC_COOKIE_HANDLER_NAME + "#") + CONSTANTS.CFC_DONATE_COINS_COMMAND, [coinAmount], "str", _shell.getCurrentServerRoomId());
            com.clubpenguin.util.TrackerAS2.getInstance().trackRewardEarned("coins", Number(-coinAmount), "cfc_donation", "room_session_" + _shell.getRoomObject().room_id, _shell.getMyPlayerTotalCoins());
        }
        static function updatePlayerCoins(data) {
            var _local_1 = data[1];
            _airtower.removeListener(CONSTANTS.CFC_DONATE_COINS_COMMAND, _handleUpdatePlayerCoinsDelegate);
            _shell.setMyPlayerTotalCoins(_local_1);
        }
        static function requestWorldTotal() {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.cfc.vo.CFCPartyCookieVO.CFC_COOKIE_HANDLER_NAME + "#") + CONSTANTS.CFC_TOTALWORLDCOINS_BROADCAST_NAME, [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendTrainJoinRoom(room, x, y, disbandTrain) {
            _global.getCurrentRoom().trainManager.service.sendTrainJoinRoom(room, x, y, disbandTrain);
        }
        static function activateCFCEngineOverrides() {
            _engine.updatePlayerFrame = com.clubpenguin.util.Delegate.create(_this, _party.CFCParty.engineOverrides.updatePlayerFrame);
            _engine.sendPlayerFrame = com.clubpenguin.util.Delegate.create(_engine, _party.CFCParty.engineOverrides.sendPlayerFrame);
            _engine.sendPlayerMove = com.clubpenguin.util.Delegate.create(_engine, _party.CFCParty.engineOverrides.sendPlayerMove);
        }
        static function activateCFCEngineOverridesInTrainRoom() {
            pebug("Activate special engine overrides in train room");
            _engine.updatePlayerFrame = com.clubpenguin.util.Delegate.create(_this, _party.CFCParty.engineOverridesTrainRoom.updatePlayerFrame);
            _engine.sendPlayerFrame = com.clubpenguin.util.Delegate.create(_engine, _party.CFCParty.engineOverrides.defaultSendPlayerFrame);
            _engine.snowballManager = new com.clubpenguin.world.rooms2013.cfc.trainroom.CFCSnowballManager(_shell, _engine, _interface);
        }
        static function deactivateCFCEngineOverridesInTrainRoom() {
            pebug("Deactivate special engine overrides in train room");
            _engine.updatePlayerFrame = com.clubpenguin.util.Delegate.create(_this, _party.CFCParty.engineOverridesTrainRoom.defaultUpdatePlayerFrame);
            _engine.sendPlayerFrame = com.clubpenguin.util.Delegate.create(_engine, _party.CFCParty.engineOverrides.sendPlayerFrame);
            _engine.snowballManager = new com.clubpenguin.engine.projectiles.SnowballManager(_shell, _engine, _interface);
        }
        static function activateCFCInterfaceOverrides() {
            _interface.showPartyIcon = com.clubpenguin.util.Delegate.create(_this, _party.CFCParty.interfaceOverrides.showPartyIcon);
            _interface.onPartyIconLoad = com.clubpenguin.util.Delegate.create(_this, _party.CFCParty.interfaceOverrides.onPartyIconLoad);
            _interface.showCrosshair = com.clubpenguin.util.Delegate.create(_this, _party.CFCParty.interfaceOverrides.showCrosshair);
        }
        static function activateCFCShellOverrides() {
            _shell.sendJoinRoom = com.clubpenguin.util.Delegate.create(_shell, _party.CFCParty.shellOverrides.sendJoinRoom);
            _shell.sendJoinRoomFromMap = com.clubpenguin.util.Delegate.create(_shell, _party.CFCParty.shellOverrides.sendJoinRoomFromMap);
        }
        static function deactivateCFCShellOverrides() {
            _shell.sendJoinRoom = com.clubpenguin.util.Delegate.create(_shell, _party.CFCParty.shellOverrides.defaultSendJoinRoom);
            _shell.sendJoinRoomFromMap = com.clubpenguin.util.Delegate.create(_shell, _party.CFCParty.shellOverrides.defaultSendJoinRoomFromMap);
        }
        static function logTrainMessage(msg) {
            _trainLog.push(msg + newline);
            if (_trainLog.length > 300) {
                _trainLog.shift();
            }
        }
        static var CONSTANTS = com.clubpenguin.world.rooms2013.cfc.CFCPartyConstants;
        static var CLASS_NAME = "CFCParty";
        static var PARTY_COOKIE_ID = "20131201";
        static var _this = com.clubpenguin.world.rooms2013.cfc.CFCParty;
        static var _isActive = false;
        static var trainRoomState = 0;
        static var showRunAwayTrainOnJoinRoom = false;
        static var trainItemEquipped = false;
        static var lastKnownTrainGameScore = 0;
        static var _trainLog = new Array();
    }
