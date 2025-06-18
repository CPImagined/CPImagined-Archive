//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.epfparty.EPFParty
    {
        static var _shell, _airtower, _interface, _engine, _party, _serverCookieService, _serverCookie, _purchaseItemThrottler, _newPlayerExperienceComplete, _boatController, _currentController, characterDialogueClosed, chipMatchingComplete, _engineOverrides, _doesPlayerOwnItemDelegate, _buyPuffleItemDelegate, _buyFurnitureItemDelegate, _buyItemDelegate, _coinBonusCollectedDelegate;
        function EPFParty () {
        }
        static function init() {
            pebug("init() START");
            _isActive = true;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            _serverCookieService = _shell.getServerCookieService();
            _serverCookie = new com.clubpenguin.world.rooms2013.epfparty.vo.EPFPartyCookieVO(PARTY_COOKIE_ID);
            _serverCookieService.registerCookieVO(_serverCookie.getID(), _serverCookie);
            activateEPFEngineOverrides();
            _purchaseItemThrottler = new com.clubpenguin.util.EventThrottler();
            _purchaseItemThrottler.delayBetweenEvents = 2000;
            _newPlayerExperienceComplete = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, handleNewPlayerExperienceComplete);
            _shell.addListener(_shell.NEW_PLAYER_EXPERIENCE_COMPLETE, _newPlayerExperienceComplete);
            _airtower.addListener(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.PARTY_SETTINGS_RESPONSE_NAME, handleUpdatePartySettings, com.clubpenguin.world.rooms2013.epfparty.EPFParty);
            pebug("init() Just added listener:" + com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.PARTY_SETTINGS_RESPONSE_NAME);
            _boatController = new com.clubpenguin.world.rooms2013.epfparty.boat.BoatController();
            _currentController = new com.clubpenguin.world.rooms2013.epfparty.boat.CurrentController();
            characterDialogueClosed = new org.osflash.signals.Signal();
            chipMatchingComplete = new org.osflash.signals.Signal();
        }
        static function handleNewPlayerExperienceComplete() {
            pebug("handleNewPlayerExperienceComplete()");
            _shell.removeListener(_shell.NEW_PLAYER_EXPERIENCE_COMPLETE, _newPlayerExperienceComplete);
            _interface.PARTY_ICON._visible = true;
        }
        static function dispatchCharacterDialogueClosed() {
            characterDialogueClosed.dispatch();
        }
        static function dispatchChipMatchingComplete() {
            chipMatchingComplete.dispatch();
        }
        static function pebug(msg, prefix) {
            if (undefined == prefix) {
                prefix = CLASS_NAME;
            }
            com.clubpenguin.util.Log.debug((prefix + "::") + msg, com.clubpenguin.util.Log.PARTY);
        }
        static function get isActive() {
            pebug("get isActive = " + _isActive);
            return(_isActive);
        }
        static function handleUpdatePartySettings(data) {
            pebug(("handleUpdatePartySettings(" + data) + ")");
            pebug("handleUpdatePartySettings() data[0]=" + data[0]);
            pebug("handleUpdatePartySettings() data[1]=" + data[1]);
            PARTY_DAY = Number(data[1]);
            pebug("handleUpdatePartySettings() EPFParty.PARTY_DAY=" + PARTY_DAY);
        }
        static function showPartyCatalogue() {
            pebug("showPartyCatalogue()");
            _interface.showContent(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.PARTY_CATALOGUE);
        }
        static function get partyCookie() {
            return(com.clubpenguin.world.rooms2013.epfparty.vo.EPFPartyCookieVO(_serverCookie));
        }
        static function set partyCookie(cookieString) {
            _serverCookie.deserialize(cookieString);
            //return(partyCookie);
        }
        static function get engineOverrides() {
            if (_engineOverrides == null) {
                _engineOverrides = new com.clubpenguin.world.rooms2013.epfparty.EPFParty_EngineOverrides();
                _engineOverrides.init();
            }
            return(_engineOverrides);
        }
        static function get boatController() {
            return(_boatController);
        }
        static function get score() {
            return(((_serverCookie == null) ? (new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0)) : (_serverCookie.score)));
        }
        static function set score(list) {
            if (_serverCookie != null) {
                _serverCookie.score = list;
            }
            //return(score);
        }
        static function get garyMessageViewed() {
            return(((_serverCookie == null) ? false : (_serverCookie.garyMessageViewed)));
        }
        static function set garyMessageViewed(messageViewed) {
            if (_serverCookie != null) {
                _serverCookie.garyMessageViewed = messageViewed;
            }
            //return(garyMessageViewed);
        }
        static function get directorVideoViewed() {
            return(((_serverCookie == null) ? false : (_serverCookie.directorVideoViewed)));
        }
        static function set directorVideoViewed(videoViewed) {
            if (_serverCookie != null) {
                _serverCookie.directorVideoViewed = videoViewed;
            }
            //return(directorVideoViewed);
        }
        static function get goldenItemIdsUnlocked() {
            return(((_serverCookie == null) ? 0 : (_serverCookie.goldenItemIdsUnlocked)));
        }
        static function get goldenItemIds() {
            return(((_serverCookie == null) ? (Array(0, 0, 0, 0, 0)) : (_serverCookie.goldenItemIds)));
        }
        static function get endGameUnlocked() {
            return(((_serverCookie == null) ? false : (_serverCookie.endGameUnlocked)));
        }
        static function get endGameWon() {
            return(((_serverCookie == null) ? false : (_serverCookie.endGameWon)));
        }
        static function get herbertCoinBonusCollected() {
            return(((_serverCookie == null) ? false : (_serverCookie.coinBonusCollected)));
        }
        static function set herbertCoinBonusCollected(coinBonusCollected) {
            if (_serverCookie != null) {
                _serverCookie.coinBonusCollected = coinBonusCollected;
            }
            //return(herbertCoinBonusCollected);
        }
        static function isGoldenRewardItemUnlocked(itemId) {
            var _local_1 = 0;
            while (_local_1 < goldenItemIdsUnlocked) {
                if (goldenItemIds[_local_1] == itemId) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        static function isPuffleGameTriggerActive(room) {
            var _local_1 = roomPuffleGameIDList[room];
            if (_local_1 <= PARTY_DAY) {
                return(true);
            }
            return(false);
        }
        static function getHerbertRoomId() {
            var _local_1 = com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.HERBERT_MULTIPLAYER_ROOM_ID;
            if (!_serverCookie.endGameWon) {
                _local_1 = com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.HERBERT_SOLO_ROOM_ID;
            }
            return(_local_1);
        }
        static function getHighestChipAvailable() {
            var _local_1 = com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.NUMBER_OF_CHIPS - 1;
            return(((PARTY_DAY > _local_1) ? (_local_1) : (PARTY_DAY)));
        }
        static function getNextAvailableChip() {
            var _local_2 = getHighestChipAvailable();
            var _local_1 = 0;
            while (_local_1 <= _local_2) {
                if (Number(score[_local_1]) == 0) {
                    return(Number(_local_1));
                }
                _local_1++;
            }
            return(Number(_local_2 + 1));
        }
        static function isChipAvailable(chipIndex) {
            return(chipIndex <= PARTY_DAY);
        }
        static function hasPlayerCollectedChip(chipId) {
            return(score[chipId] > 0);
        }
        static function get hasPlayerCollectedAllChips() {
            var _local_1 = 0;
            while (_local_1 < com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.NUMBER_OF_CHIPS) {
                if (!hasPlayerCollectedChip(_local_1)) {
                    return(false);
                }
                _local_1++;
            }
            return(true);
        }
        static function get hasPlayerCollectedAnyChips() {
            var _local_1 = 0;
            while (_local_1 < com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.NUMBER_OF_CHIPS) {
                if (hasPlayerCollectedChip(_local_1)) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        static function getNextGoldenItem() {
            var _local_1;
            if (goldenItemIdsUnlocked <= goldenItemIds.length) {
                _local_1 = goldenItemIds[goldenItemIdsUnlocked];
            }
            return(_local_1);
        }
        static function configureHerbertCoinBonus(itemMC) {
            itemMC.loading._visible = false;
            if (herbertCoinBonusCollected) {
                pebug("Herbert Coin Bonus ALready Collected", CLASS_NAME);
                itemMC.gotoAndStop(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.COLLECTED_LABEL);
            } else if (endGameWon) {
                pebug("endGameWon=true and Herbert Coin Bonus not collected yet", CLASS_NAME);
                itemMC.gotoAndStop(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.AVAILABLE_LABEL);
                itemMC.claim_Btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, checkCollectionOfHerbertCoinBonus, itemMC);
            } else {
                pebug("Herbert Coin Bonus not available yet", CLASS_NAME);
                itemMC.gotoAndStop(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.UNAVAILABLE_LABEL);
            }
        }
        static function checkCollectionOfHerbertCoinBonus(itemMC) {
            playSound(itemMC, "sfx_item");
            if (endGameWon && (!herbertCoinBonusCollected)) {
                itemMC.loading._visible = true;
                sendCollectHerbertCoinBonus(itemMC);
            }
        }
        static function configureGoldenPuffleRewardItem(itemMC, itemId) {
            pebug(((("configureGoldenPuffleRewardItem(" + itemMC) + ",") + itemId) + ")", CLASS_NAME);
            itemMC.loading._visible = false;
            _doesPlayerOwnItemDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, handleDoesPlayerOwnItem, itemId, itemMC);
            _shell.receivedDoesPlayerOwnPuffleItem.add(_doesPlayerOwnItemDelegate, com.clubpenguin.world.rooms2013.epfparty.EPFParty);
            _shell.sendGetDoesPlayerOwnPuffleItem(itemId, "head");
        }
        static function handleDoesPlayerOwnItem(itemId, itemCategory, hasItem, expectedItemId, itemMC) {
            pebug((("handleGetDoesPlayerOwnPuffleItem():itemId=" + itemId) + " itemCategory=") + itemCategory, CLASS_NAME);
            if ((itemId == expectedItemId) && (itemCategory == "head")) {
                _shell.receivedDoesPlayerOwnPuffleItem.remove(_doesPlayerOwnItemDelegate, com.clubpenguin.world.rooms2013.epfparty.EPFParty);
                if (hasItem) {
                    itemMC.gotoAndStop(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.COLLECTED_LABEL);
                } else if (isGoldenRewardItemUnlocked(itemId)) {
                    itemMC.gotoAndStop(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.AVAILABLE_LABEL);
                    itemMC.claim_Btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, checkCollectionOfGoldenPuffleItem, itemMC, itemId);
                } else {
                    itemMC.gotoAndStop(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.UNAVAILABLE_LABEL);
                }
            } else {
                pebug("Isn't the item we're expecting", CLASS_NAME);
            }
        }
        static function checkCollectionOfGoldenPuffleItem(itemMC, itemID) {
            playSound(itemMC, "sfx_item");
            pebug(((("checkCollectionOfGoldenPuffleItem(" + itemMC) + ",") + itemID) + ")", CLASS_NAME);
            if (_shell.isMyPlayerMember() && (isGoldenRewardItemUnlocked(itemID))) {
                pebug("trying to buy it!" + itemMC, CLASS_NAME);
                delete itemMC.claim_Btn.onRelease;
                itemMC.loading._visible = true;
                _purchaseItemThrottler.queueFunction(com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, buyPuffleItem, itemID, itemMC));
            } else {
                _interface.showContent(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.OOPS_MEMBER_MESSAGE);
            }
        }
        static function buyPuffleItem(itemID, itemMC) {
            pebug(((("buyPuffleItem(" + itemID) + ",") + itemMC) + ")", CLASS_NAME);
            _buyPuffleItemDelegate = null;
            _shell.sendBuyPuffleCareItem(itemID);
            _buyPuffleItemDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, onPuffleItemBought, itemMC);
            _shell.addListener(_shell.BUY_PUFFLE_CARE_ITEM, _buyPuffleItemDelegate, com.clubpenguin.world.rooms2013.epfparty.EPFParty);
        }
        static function onPuffleItemBought(event, itemMC) {
            pebug(((("onPuffleItemBought(" + event) + ",") + itemMC) + ")", CLASS_NAME);
            _shell.removeListener(_shell.BUY_PUFFLE_CARE_ITEM, _buyPuffleItemDelegate);
            if (event.success) {
                itemMC.nextFrame();
            }
            itemMC.loading._visible = false;
        }
        static function configureGoldenRewardItem(itemMC, itemID) {
            itemMC.loading._visible = false;
            if (_shell.isItemInMyInventory(itemID)) {
                itemMC.gotoAndStop(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.COLLECTED_LABEL);
            } else if (isGoldenRewardItemUnlocked(itemID)) {
                pebug(itemID + " isGoldenRewardItemUnlocked()==true", CLASS_NAME);
                itemMC.gotoAndStop(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.AVAILABLE_LABEL);
                itemMC.claim_Btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, checkCollectionOfGoldenItem, itemMC, itemID);
            } else {
                itemMC.gotoAndStop(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.UNAVAILABLE_LABEL);
            }
        }
        static function checkCollectionOfGoldenItem(itemMC, itemID) {
            playSound(itemMC, "sfx_item");
            if (_shell.isMyPlayerMember() && (isGoldenRewardItemUnlocked(itemID))) {
                itemMC.loading._visible = true;
                _purchaseItemThrottler.queueFunction(com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, buyItem, itemID, itemMC, false));
                delete itemMC.claim_Btn.onRelease;
            } else {
                _interface.showContent(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.OOPS_MEMBER_MESSAGE);
            }
        }
        static function configureRewardItem(itemMC, itemID, member, chipId) {
            pebug("configureRewardItem():itemID=" + itemID, CLASS_NAME);
            pebug("configureRewardItem():chipId=" + chipId, CLASS_NAME);
            itemMC.loading._visible = false;
            if (_shell.isItemInMyInventory(itemID)) {
                itemMC.gotoAndStop(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.COLLECTED_LABEL);
            } else if (hasPlayerCollectedChip(chipId)) {
                itemMC.gotoAndStop(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.AVAILABLE_LABEL);
                itemMC.claim_Btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, checkClaimOfRewardItem, itemMC, itemID, member, chipId);
            } else {
                itemMC.gotoAndStop(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.UNAVAILABLE_LABEL);
            }
        }
        static function checkClaimOfRewardItem(itemMC, itemID, member, chipId) {
            pebug("checkClaimOfRewardItem()" + itemID, CLASS_NAME);
            if (member) {
                if (_shell.isMyPlayerMember() && (hasPlayerCollectedChip(chipId))) {
                    itemMC.loading._visible = true;
                    _purchaseItemThrottler.queueFunction(com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, buyItem, itemID, itemMC, false));
                    delete itemMC.claim_Btn.onRelease;
                } else {
                    _interface.showContent(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.OOPS_MEMBER_MESSAGE);
                }
            } else if (hasPlayerCollectedChip(chipId)) {
                itemMC.loading._visible = true;
                _purchaseItemThrottler.queueFunction(com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, buyItem, itemID, itemMC, false));
                delete itemMC.claim_Btn.onRelease;
            }
        }
        static function configureHerbertRewardItem(itemMC, itemID) {
            itemMC.loading._visible = false;
            if (_shell.isFurnitureInMyInventory(itemID)) {
                itemMC.gotoAndStop(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.COLLECTED_LABEL);
            } else if (endGameWon) {
                itemMC.gotoAndStop(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.AVAILABLE_LABEL);
                itemMC.claim_Btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, checkCollectionOfHerbertItem, itemMC, itemID);
            } else {
                itemMC.gotoAndStop(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.UNAVAILABLE_LABEL);
            }
        }
        static function checkCollectionOfHerbertItem(itemMC, itemID) {
            playSound(itemMC, "sfx_item");
            if (endGameWon) {
                _purchaseItemThrottler.queueFunction(com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, buyFurnitureItem, itemID, itemMC));
                delete itemMC.claim_Btn.onRelease;
            }
        }
        static function buyFurnitureItem(itemID, itemMC) {
            _buyFurnitureItemDelegate = null;
            _shell.sendBuyFurniture(itemID);
            _buyFurnitureItemDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, onFurnitureItemBought, itemMC);
            _shell.addListener(_shell.BUY_FURNITURE, _buyFurnitureItemDelegate, com.clubpenguin.world.rooms2013.epfparty.EPFParty);
        }
        static function onFurnitureItemBought(event, itemMC) {
            _shell.removeListener(_shell.BUY_FURNITURE, _buyFurnitureItemDelegate);
            if (event.success) {
                itemMC.nextFrame();
            }
            itemMC.loading._visible = false;
        }
        static function buyItem(itemID, itemMC, prompt) {
            _buyItemDelegate = null;
            if (prompt) {
                _interface.buyInventory(itemID);
            } else {
                _shell.sendBuyInventory(itemID);
            }
            if (!prompt) {
                _buyItemDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, onInventoryBought, itemMC, itemID);
                _shell.addListener(_shell.BUY_INVENTORY, _buyItemDelegate, com.clubpenguin.world.rooms2013.epfparty.EPFParty);
            }
        }
        static function onInventoryBought(event, itemMC, itemID) {
            _shell.removeListener(_shell.BUY_INVENTORY, _buyItemDelegate);
            if (event.success) {
                itemMC.nextFrame();
            }
            itemMC.loading._visible = false;
        }
        static function handleCoinBonusCollected(data, itemMC) {
            _airtower.removeListener(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.SET_COIN_BONUS_COLLECTED_COMMAND_NAME, handleCoinBonusCollected);
            pebug((("data.toString()=" + data.toString()) + "data=") + data, CLASS_NAME);
            var _local_2 = Number(data[1]);
            _shell.setMyPlayerTotalCoins(_local_2);
            partyCookie = (String(data[2]));
            itemMC.loading._visible = false;
            itemMC.nextFrame();
        }
        static function sendPenguinOnWaterslide(slideIndex) {
            _airtower.send(_airtower.PLAY_EXT, "u#" + com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.SLIDE_COMMAND_NAME, [slideIndex], "str", _shell.getCurrentServerRoomId());
        }
        static function sendDirectorVideoViewed() {
            sendMessageViewed(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.DIRECTOR_VIDEO_ID);
        }
        static function sendGaryMessageViewed() {
            sendMessageViewed(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.GARY_MESSAGE_ID);
        }
        static function sendMessageViewed(messageId) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.epfparty.vo.EPFPartyCookieVO.EPF_COOKIE_HANDLER_NAME + "#") + com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.SET_MESSAGE_VIEWED_COMMAND_NAME, [messageId], "str", _shell.getCurrentServerRoomId());
        }
        static function sendEndGameComplete() {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.epfparty.vo.EPFPartyCookieVO.EPF_COOKIE_HANDLER_NAME + "#") + com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.SET_END_GAME_WON_COMMAND_NAME, [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendCollectHerbertCoinBonus(itemMC) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.epfparty.vo.EPFPartyCookieVO.EPF_COOKIE_HANDLER_NAME + "#") + com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.SET_COIN_BONUS_COLLECTED_COMMAND_NAME, [0], "str", _shell.getCurrentServerRoomId());
            _coinBonusCollectedDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, handleCoinBonusCollected, itemMC);
            _airtower.addListener(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.SET_COIN_BONUS_COLLECTED_COMMAND_NAME, _coinBonusCollectedDelegate, com.clubpenguin.world.rooms2013.epfparty.EPFParty);
        }
        static function launchChasePreGame(chipId) {
            pebug("EPFParty launchPreGameInterface():chipId=" + chipId);
            puffleChipIdLaunched = chipId;
            _interface.showContent(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.CHASE_PREGAME_UI);
        }
        static function launchChaseGame(useGoldPuffle) {
            pebug("launchChaseGame()");
            var _local_1 = {isAS3:true};
            _local_1.useGoldPuffle = useGoldPuffle;
            _local_1.chipId = puffleChipIdLaunched;
            _local_1.itemId = getNextGoldenItem();
            pebug("launchChaseGame():gameParams.isAS3=" + _local_1.isAS3, CLASS_NAME);
            pebug("launchChaseGame():gameParams.useGoldPuffle=" + _local_1.useGoldPuffle, CLASS_NAME);
            pebug("launchChaseGame():gameParams.chipId=" + _local_1.chipId, CLASS_NAME);
            pebug("launchChaseGame():gameParams.itemId=" + _local_1.itemId, CLASS_NAME);
            var _local_3 = _shell.getMyPlayerObject().x + Math.floor((Math.random() * 75) - 37);
            var _local_2 = _shell.getMyPlayerObject().y + Math.floor((Math.random() * 75) - 37);
            _engine.sendJoinGame(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.CHASE_GAME_PATH, false, {gameStartParams:_local_1});
            _shell.last_known_xpos = _local_3;
            _shell.last_known_ypos = _local_2;
        }
        static function activateEPFInterfaceOverrides() {
            _interface.showPartyIcon = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, _party.EPFParty.interfaceOverrides.showPartyIcon);
            _interface.onPartyIconLoad = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, _party.EPFParty.interfaceOverrides.onPartyIconLoad);
        }
        static function activateEPFEngineOverrides() {
            _engine.updatePlayerFrame = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.epfparty.EPFParty, _party.EPFParty.engineOverrides.updatePlayerFrame);
        }
        static function playSound(ui, soundId) {
            var _local_1 = new Sound(ui);
            _local_1.attachSound(soundId);
            _local_1.start();
        }
        static function configureGamePuffleStateInRoom(roomName, gameMC, triggerMC) {
            pebug("EPF - roomName " + roomName);
            pebug("EPF - EPFParty.isPuffleGameTriggerActive " + isPuffleGameTriggerActive(roomName));
            if (!isPuffleGameTriggerActive(roomName)) {
                pebug("EPF - triggerMC not active " + gameMC);
                gameMC._visible = false;
                triggerMC._visible = false;
                return(undefined);
            }
            gameMC._visible = true;
        }
        static var CLASS_NAME = "EPFParty";
        static var PARTY_COOKIE_ID = "20131120";
        static var _isActive = false;
        static var roomPuffleGameIDList = {party1:0, party9:1, party4:2, party5a:3, party3:4, party7:5, party5b:6, party6:7, party8a:8, party8b:9};
        static var puffleChipIdLaunched = 5;
        static var questJustFinished = false;
        static var goldPuffleName = "";
        static var SFX_ITEM = "sfx_item";
        static var PARTY_DAY = 1;
    }
