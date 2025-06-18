//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.party.PirateParty
    {
        static var _shell, _airtower, _interface, _engine, _party, _partycookieUpdateHandlerDelegate, _swordVOs, _questVOs, _finalAwardVO, _engineOverrides, _interfaceOverrides, _collectSwordRewardDelegate, _puffleIDBeingWalked;
        function PirateParty () {
            trace("PirateParty: Entering");
        }
        static function init() {
            pebug("PIRATE PARTY - INIT");
            trace("PirateParty.init");
            com.clubpenguin.party.BaseParty.CLASS_NAME = _this.CLASS_NAME;
            com.clubpenguin.party.BaseParty.CURRENT_PARTY = _this;
            com.clubpenguin.party.BaseParty.setConditionalPartyIconVisibility();
            com.clubpenguin.party.BaseParty.addListenerForPartySettings(CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME);
            _isActive = true;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            activateEngineOverrides();
            initPirateAvatars();
            com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.init();
            activatePartyCookieListener();
            sendRequestPartyCookie();
            var _local_2 = [com.clubpenguin.world.rooms2014.pirate.swordfight.BattleManager];
            com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory.register("com.clubpenguin.world.rooms2014.pirate.swordfight.BattleManager");
        }
        static function partycookieUpdateHandler() {
            pebug("partycookieUpdateHandler");
            _airtower.removeListener("partycookie", _partycookieUpdateHandlerDelegate);
            com.clubpenguin.party.BaseParty.partyIconState();
            com.clubpenguin.world.rooms2014.pirate.party.PiratePartyQuestCommunicator.init();
            _engine.getRoomMovieClip().room.initializePartyCookieDependentAssets();
            _engine.getRoomMovieClip().roomFunctionality.initializePartyCookieDependentAssets();
            checkTriggerQuestCommunicatorMessages();
        }
        static function activatePartyCookieListener() {
            _partycookieUpdateHandlerDelegate = com.clubpenguin.util.Delegate.create(_this, partycookieUpdateHandler);
            _airtower.addListener("partycookie", _partycookieUpdateHandlerDelegate);
        }
        static function checkTriggerQuestCommunicatorMessages() {
            var _local_2 = _swordVOs[1].points;
            var _local_1 = _swordVOs[Number(_swordVOs.length - 1)].points;
            if ((partyCookie.points >= _local_2) && (!partyCookie.hasPlayerViewedQCMessage(CONSTANTS.QC_NEW_SWORD_MESSAGE_NUMBER))) {
                com.clubpenguin.world.rooms2014.pirate.party.PiratePartyQuestCommunicator.displayNewSwordMessage();
            }
            if ((partyCookie.points >= _local_1) && (!partyCookie.hasPlayerViewedQCMessage(CONSTANTS.QC_UNLOCK_LAST_SWORD_MESSAGE_NUMBER))) {
                com.clubpenguin.world.rooms2014.pirate.party.PiratePartyQuestCommunicator.displayLastSwordMessage();
                _airtower.removeListener("partycookie", _partycookieUpdateHandlerDelegate);
            }
        }
        static function configurePartySettings() {
            var _local_6 = CONSTANTS.PARTY_SERVICE.questSettingList;
            var _local_7 = CONSTANTS.PARTY_SERVICE.swordsList;
            CONSTANTS.NUMBER_OF_TASKS = CONSTANTS.PARTY_SERVICE.numofquest;
            if ((_local_6 == undefined) || (_local_7 == undefined)) {
                return(undefined);
            }
            _questVOs = new Array();
            _swordVOs = new Array();
            var _local_4 = 0;
            while (_local_4 < _local_6.length) {
                var _local_1 = new com.clubpenguin.world.rooms2014.pirate.vo.PiratePartyQuestVO();
                var _local_2 = _local_6[_local_4];
                _local_1.roomId = _local_2.roomId;
                _local_1.unlockDay = _local_2.unlockDay;
                _local_1.questItemIndex = _local_2.questItemIndex;
                _local_1.memberItemId = _local_2.memberItemId;
                _local_1.nonMemberItemId = _local_2.nonmemberItemId;
                _local_1.createItemVOs();
                _questVOs.push(_local_1);
                _local_4++;
            }
            _local_4 = 0;
            while (_local_4 < _local_7.length) {
                var _local_3 = new com.clubpenguin.world.rooms2014.pirate.vo.PiratePartySwordVO();
                var _local_5 = _local_7[_local_4];
                _local_3.swordID = _local_5.swordId;
                _local_3.points = _local_5.points;
                _local_3.itemID = _local_5.itemId;
                _local_3.createItemVOs(((_local_4 == 0) ? false : true));
                _swordVOs.push(_local_3);
                _local_4++;
            }
            _finalAwardVO = new com.clubpenguin.world.rooms2014.pirate.vo.PiratePartyQuestVO();
            var _local_8 = CONSTANTS.PARTY_SERVICE.finalRewards;
            _finalAwardVO.memberItemId = _local_8.memberItemId;
            _finalAwardVO.nonMemberItemId = _local_8.nonMemberItemId;
            _finalAwardVO.points = _local_8.points;
            _finalAwardVO.createItemVOs();
        }
        static function get partyCookie() {
            return(com.clubpenguin.world.rooms2014.pirate.vo.PiratePartyCookieVO(com.clubpenguin.party.BaseParty.serverCookie));
        }
        static function get isActive() {
            return(_isActive);
        }
        static function pebug(msg, prefix) {
            com.clubpenguin.party.BaseParty.pebug(msg, prefix);
        }
        static function playSound(ui, soundId, volume) {
            com.clubpenguin.party.BaseParty.playSound(ui, soundId, volume);
        }
        static function checkForFirstTimeLogin(playerObj) {
            if ((_shell.getMyPlayerId() != playerObj.player_id) || (_shell.getRoomObject().room_id == 112)) {
                return(undefined);
            }
            if (!partyCookie.hasPlayerViewedMessage(CONSTANTS.LOGIN_MESSAGE_NUMBER)) {
                showLoginPrompt();
            }
        }
        static function get partyIconVisible() {
            if (partyCookie.hasPlayerViewedMessage(CONSTANTS.LOGIN_MESSAGE_NUMBER)) {
                return(true);
            }
            return(false);
        }
        static function get handleWearButtonClicked() {
            if (_global.getCurrentShell().getRoomObject().room_id == CONSTANTS.CRAB_BATTLE_ROOM_ID) {
                _global.getCurrentShell().sendJoinLastRoom();
            } else {
                _global.getCurrentInterface().closeContent();
            }
        }
        static function get engineOverrides() {
            if (_engineOverrides == null) {
                _engineOverrides = new com.clubpenguin.world.rooms2014.pirate.party.PirateParty_EngineOverrides();
            }
            return(_engineOverrides);
        }
        static function get interfaceOverrides() {
            if (_interfaceOverrides == null) {
                _interfaceOverrides = new com.clubpenguin.world.rooms2014.pirate.party.PirateParty_InterfaceOverrides();
            }
            return(_interfaceOverrides);
        }
        static function activateFirstTimeUserPartyFunctionality() {
            _engine.getRoomMovieClip().room.configureRoomElements();
            _airtower.addListener("partycookie", _partycookieUpdateHandlerDelegate);
        }
        static function get questVOs() {
            return(_questVOs);
        }
        static function get swordVOs() {
            return(_swordVOs);
        }
        static function get finalRewardsVO() {
            return(_finalAwardVO);
        }
        static function showLoginPrompt() {
            _interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
        }
        static function showRockhopperCrabFightingIntro() {
            _interface.showContent(CONSTANTS.CRAB_FIGHT_PROMPT_PATH);
        }
        static function showRockhopperSwordFightingInstructions() {
            _interface.showContent(CONSTANTS.SWORD_FIGHT_PROMPT_PATH);
        }
        static function showRockhopperFinal() {
            if (!partyCookie.hasPlayerViewedMessage(CONSTANTS.ROCKHOPPER_FINAL_MESSAGE_NUMBER)) {
                _interface.showContent(CONSTANTS.CONGRATULATIONS_PROMPT_PATH);
            }
        }
        static function showFinaleComic() {
            _interface.showContent(CONSTANTS.FINALE_COMIC_PATH);
        }
        static function getTaskStatus(questVO) {
            return(partyCookie.questItems[questVO.questItemIndex] == 1);
        }
        static function getSwordVOByID(swordID) {
            var _local_1 = 0;
            while (_local_1 < _swordVOs.length) {
                var _local_2 = _swordVOs[_local_1];
                if (swordID == _local_2.swordID) {
                    return(_swordVOs[_local_1]);
                }
                _local_1++;
            }
            return(undefined);
        }
        static function getQuestVOByRoomID(roomID) {
            var _local_1 = 0;
            while (_local_1 < _questVOs.length) {
                var _local_2 = _questVOs[_local_1];
                if (roomID == _local_2.roomId) {
                    return(_questVOs[_local_1]);
                }
                _local_1++;
            }
            return(undefined);
        }
        static function getQuestVOByQuestID(questID) {
            var _local_1 = 0;
            while (_local_1 < _questVOs.length) {
                var _local_2 = _questVOs[_local_1];
                if (questID == _local_2.questItemIndex) {
                    return(_questVOs[_local_1]);
                }
                _local_1++;
            }
            return(undefined);
        }
        static function isPlayerABattleAvatar(player_id) {
            var _local_1 = _shell.getPlayerObjectById(player_id).avatar_id;
            return(((((_local_1 == CONSTANTS.PIRATE_WOODEN_SWORD_AVATAR_ID) || (_local_1 == CONSTANTS.PIRATE_CHEESE_SWORD_AVATAR_ID)) || (_local_1 == CONSTANTS.PIRATE_BALLOON_SWORD_AVATAR_ID)) || (_local_1 == CONSTANTS.PIRATE_ROGUE_SWORD_AVATAR_ID)) || (_local_1 == CONSTANTS.PIRATE_JEWEL_SWORD_AVATAR_ID));
        }
        static function isSwordEquipped(player_id) {
            var _local_3 = Number(_shell.getPlayerObjectById(player_id).hand);
            pebug("PirateParty.isSwordEquipped itemID " + _local_3);
            var _local_1 = 0;
            while (_local_1 < _swordVOs.length) {
                var _local_2 = _swordVOs[_local_1];
                pebug("PirateParty.isSwordEquipped swordVO.swordID " + _local_2.itemID);
                if (_local_3 == _local_2.itemID) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        static function initPirateAvatars() {
            var _local_2 = _engine.avatarManager.model;
            var _local_1 = _local_2.createAvatarFromTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID);
            _local_1.spritePath = CONSTANTS.AVATAR_PIRATE_WOODEN_SWORD_PATH;
            _local_1.clearEffectTransitions();
            _local_1.defaultTransitionEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE;
            _local_1.setEffectTransition(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID, com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE);
            _local_1.attachItems = false;
            _local_1.attributes.ignoresBlockLayer = true;
            _local_2.setAvatarTemplate(CONSTANTS.PIRATE_WOODEN_SWORD_AVATAR_ID, _local_1);
            var _local_5 = _local_1.clone();
            _local_5.spritePath = CONSTANTS.AVATAR_PIRATE_CHEESE_SWORD_PATH;
            _local_2.setAvatarTemplate(CONSTANTS.PIRATE_CHEESE_SWORD_AVATAR_ID, _local_5);
            var _local_6 = _local_1.clone();
            _local_6.spritePath = CONSTANTS.AVATAR_PIRATE_BALLOON_SWORD_PATH;
            _local_2.setAvatarTemplate(CONSTANTS.PIRATE_BALLOON_SWORD_AVATAR_ID, _local_6);
            var _local_3 = _local_1.clone();
            _local_3.spritePath = CONSTANTS.AVATAR_PIRATE_ROGUE_SWORD_PATH;
            _local_2.setAvatarTemplate(CONSTANTS.PIRATE_ROGUE_SWORD_AVATAR_ID, _local_3);
            var _local_4 = _local_1.clone();
            _local_4.spritePath = CONSTANTS.AVATAR_PIRATE_JEWEL_SWORD_PATH;
            _local_2.setAvatarTemplate(CONSTANTS.PIRATE_JEWEL_SWORD_AVATAR_ID, _local_4);
        }
        static function getBattleAvatarIdForPlayer(player_Obj) {
            var _local_1 = player_Obj.hand;
            if (_local_1 == com.clubpenguin.world.rooms2014.pirate.vo.PiratePartySwordVO(_swordVOs[0]).itemID) {
                return(CONSTANTS.PIRATE_WOODEN_SWORD_AVATAR_ID);
            }
            if (_local_1 == com.clubpenguin.world.rooms2014.pirate.vo.PiratePartySwordVO(_swordVOs[1]).itemID) {
                return(CONSTANTS.PIRATE_CHEESE_SWORD_AVATAR_ID);
            }
            if (_local_1 == com.clubpenguin.world.rooms2014.pirate.vo.PiratePartySwordVO(_swordVOs[2]).itemID) {
                return(CONSTANTS.PIRATE_BALLOON_SWORD_AVATAR_ID);
            }
            if (_local_1 == com.clubpenguin.world.rooms2014.pirate.vo.PiratePartySwordVO(_swordVOs[3]).itemID) {
                return(CONSTANTS.PIRATE_ROGUE_SWORD_AVATAR_ID);
            }
            if (_local_1 == com.clubpenguin.world.rooms2014.pirate.vo.PiratePartySwordVO(_swordVOs[4]).itemID) {
                return(CONSTANTS.PIRATE_JEWEL_SWORD_AVATAR_ID);
            }
            return(undefined);
        }
        static function configureTreasureChestState(chestMC, crabs_mc, chestButton) {
            var _local_2 = getQuestVOByRoomID(_shell.getRoomObject().room_id);
            chestMC._visible = false;
            crabs_mc._visible = false;
            chestButton._visible = false;
            if (CONSTANTS.PARTY_DAY >= _local_2.unlockDay) {
                chestMC._visible = true;
                crabs_mc._visible = true;
                chestButton._visible = true;
            }
            if (getTaskStatus(_local_2)) {
                chestMC.gotoAndStop(2);
                crabs_mc._visible = false;
                chestButton._visible = false;
                chestButton.useHandCursor = false;
            } else {
                chestButton.onRelease = com.clubpenguin.util.Delegate.create(_this, enterCrabBattle);
            }
        }
        static function enterCrabBattle() {
            if (!partyCookie.hasPlayerViewedMessage(CONSTANTS.ROCKHOPPER_SWORD_CRAB_FIGHT_MESSAGE_NUMBER)) {
                showRockhopperCrabFightingIntro();
            } else {
                unequipCurrentPuffle();
                _shell.sendJoinRoom("partysolo1");
            }
        }
        static function sendRequestPartyCookie() {
            _airtower.send(_airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.pirate.vo.PiratePartyCookieVO.PIRATE_COOKIE_HANDLER_NAME + "#partycookie", [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendMessageViewed(message) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.pirate.vo.PiratePartyCookieVO.PIRATE_COOKIE_HANDLER_NAME + "#") + CONSTANTS.MESSAGE_VIEWED_COMMAND, [message], "str", _shell.getCurrentServerRoomId());
        }
        static function sendCollectSwordReward(level) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.pirate.vo.PiratePartyCookieVO.PIRATE_COOKIE_HANDLER_NAME + "#") + CONSTANTS.COLLECT_SWORD_REWARD_COMMAND, [level], "str", _shell.getCurrentServerRoomId());
            _collectSwordRewardDelegate = com.clubpenguin.util.Delegate.create(_this, handleCollectSwordReward);
            _airtower.addListener(CONSTANTS.COLLECT_SWORD_REWARD_COMMAND, _collectSwordRewardDelegate);
        }
        static function handleCollectSwordReward(data) {
            _airtower.removeListener(CONSTANTS.COLLECT_SWORD_REWARD_COMMAND, _collectSwordRewardDelegate);
            var _local_1 = Number(data[1]);
            var _local_2 = Number(_shell.getMyPlayerTotalCoins());
            _shell.setMyPlayerTotalCoins(_local_1);
            var _local_3 = Number(_local_1 - _local_2);
            sendCollectCoinRewardBI(_local_3);
        }
        static function sendItemCollected(itemIndex) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.pirate.vo.PiratePartyCookieVO.PIRATE_COOKIE_HANDLER_NAME + "#") + CONSTANTS.COLLECT_QUEST_ITEM_COMMAND, [itemIndex.toString()], "str", _shell.getCurrentServerRoomId());
            sendTaskCompleteBI(itemIndex);
        }
        static function getEquippedSwordName(player_id) {
            var _local_3 = _shell.getPlayerObjectById(player_id);
            var _local_2 = _local_3.hand;
            var _local_1 = "sword";
            if (_local_2 == CONSTANTS.WOODEN_SWORD_ITEM_ID) {
                _local_1 = "wooden_sword";
            }
            if (_local_2 == CONSTANTS.CHEESE_SWORD_ITEM_ID) {
                _local_1 = "cheese_sword";
            }
            if (_local_2 == CONSTANTS.BALLOON_SWORD_ITEM_ID) {
                _local_1 = "balloon_sword";
            }
            if (_local_2 == CONSTANTS.ROGUE_SWORD_ITEM_ID) {
                _local_1 = "rogue_sword";
            }
            if (_local_2 == CONSTANTS.JEWEL_SWORD_ITEM_ID) {
                _local_1 = "jewel_sword";
            }
            return(_local_1);
        }
        static function unequipCurrentPuffle() {
            puffleIDBeingWalked = (_shell.getMyPlayerObject().attachedPuffle.id);
            if (puffleIDBeingWalked != undefined) {
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.WALK_PUFFLE, [puffleIDBeingWalked, 0], "str", _shell.getCurrentServerRoomId());
            }
        }
        static function reequipCurrentPuffle() {
            pebug("reequipCurrentPuffle " + puffleIDBeingWalked);
            if (puffleIDBeingWalked != undefined) {
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.WALK_PUFFLE, [puffleIDBeingWalked, 1], "str", _shell.getCurrentServerRoomId());
                puffleIDBeingWalked = (null);
            }
        }
        static function set puffleIDBeingWalked(id) {
            _puffleIDBeingWalked = id;
            //return(puffleIDBeingWalked);
        }
        static function get puffleIDBeingWalked() {
            return(_puffleIDBeingWalked);
        }
        static function activateEngineOverrides() {
            _engine.sendPlayerFrame = com.clubpenguin.util.Delegate.create(_engine, engineOverrides.sendPlayerFrame);
            _engine.startMouse = com.clubpenguin.util.Delegate.create(_engine, engineOverrides.startMouse);
            _engine.sendPlayerAction = com.clubpenguin.util.Delegate.create(_engine, engineOverrides.sendPlayerAction);
        }
        static function activateInterfaceOverrides() {
            _interface.showCrosshair = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.showCrosshair);
        }
        static function sendTaskCompleteBI(taskID) {
            var _local_2 = _shell.getRoomObject().room_id;
            var _local_1 = _shell.getRoomNameById(_local_2);
            com.clubpenguin.party.BaseParty.sendTaskCompleteBI(taskID, _local_1);
        }
        static function sendCrabFightBI(crabId, battleResult) {
            var _local_1 = {message:battleResult};
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(String("crab_" + crabId), "crab_fight", _local_1);
        }
        static function sendBossCrabFightBI(roundId, battleResult) {
            var _local_1 = {message:battleResult};
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(String("round_" + roundId), "boss_crab_fight", _local_1);
        }
        static function sendSwordFightInvitationBI() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "sword_fight_invite");
        }
        static function sendSwordFightJoinBI(player_id, isHost) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction((isHost ? "is_host" : "is_guest"), "sword_fight_join", {message:getEquippedSwordName(player_id)});
        }
        static function sendSwordFightResultBI(result, attack) {
            var _local_1 = {message:attack};
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(result, "sword_fight_result", _local_1);
        }
        static function sendSpecialSwordDanceBI() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(getEquippedSwordName(_shell.getMyPlayerId()), "sword_dance");
        }
        static function sendCollectCoinRewardBI(coinsAdded) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackRewardEarned(com.clubpenguin.util.TrackerAS2.CURRENCY_COINS, coinsAdded, "pirate_points", "pirate_points", _global.getCurrentShell().getMyPlayerTotalCoins());
        }
        static function sendFinalComicBI(pageNum) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("november", "outro_comic", {message:String("page_" + pageNum)});
        }
        static var CONSTANTS = com.clubpenguin.world.rooms2014.pirate.party.PiratePartyConstants;
        static var CLASS_NAME = "PirateParty";
        static var PARTY_COOKIE_ID = "20141002";
        static var _this = com.clubpenguin.world.rooms2014.pirate.party.PirateParty;
        static var _isActive = false;
    }
