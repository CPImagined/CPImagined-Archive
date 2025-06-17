//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.puffles.PuffleParty
    {
        static var _shell, _airtower, _interface, _engine, _party, _serverCookieService, _serverCookie, _quests, _interfaceOverrides;
        function PuffleParty () {
        }
        static function init() {
            pebug("PUFFLE PARTY - INIT");
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
            _serverCookieService = _shell.getServerCookieService();
            _serverCookie = new com.clubpenguin.world.rooms2014.puffles.vo.PufflePartyCookieVO(PARTY_COOKIE_ID);
            _serverCookieService.registerCookieVO(_serverCookie.getID(), _serverCookie);
            initPartyAvatars();
            activateInterfaceOverrides();
        }
        static function get partyCookie() {
            return(com.clubpenguin.world.rooms2014.puffles.vo.PufflePartyCookieVO(_serverCookie));
        }
        static function configurePartySettings() {
            _quests = new Array();
            var _local_4 = CONSTANTS.PARTY_SERVICE.pufflePartyRewards;
            var _local_3 = 0;
            while (_local_3 < _local_4.length) {
                var _local_1 = new com.clubpenguin.world.rooms2014.puffles.vo.PufflePartyInfoVO();
                var _local_2 = _local_4[_local_3];
                _local_1.id = _local_2.unlockDay;
                _local_1.roomId = _local_2.roomId;
                _local_1.memberItemId = _local_2.memberItemId;
                _local_1.nonMemberItemId = _local_2.nonmemberItemId;
                _local_1.createItemVOs();
                _quests.push(_local_1);
                _local_3++;
            }
            pebug("_quests " + _quests);
        }
        static function sendMessageViewed(message) {
            _airtower.send(_airtower.PLAY_EXT, (CONSTANTS.PUFFLEPARTY_COOKIE_HANDLER_NAME + "#") + CONSTANTS.MESSAGE_VIEWED_COMMAND, [message], "str", _global.getCurrentShell().getCurrentServerRoomId());
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
            if (partyCookie.msgViewedArray[0] == 0) {
                pebug("Show login prompt");
                _interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
            }
        }
        static function showMemberContentOopsMessage() {
            _global.getCurrentInterface().showContent(CONSTANTS.OOPS_MEMBER_PUFFLES_MESSAGE);
        }
        static function showMemberItemOopsMessage() {
            _global.getCurrentInterface().showContent(CONSTANTS.OOPS_MEMBER_ITEM_MESSAGE);
        }
        static function get itemOnIglooList() {
            return(new com.clubpenguin.party.items.IglooItem(CONSTANTS.IGLOO_LIST_ITEM_ID, true, 1500, "Puffle Tree House"));
        }
        static function get interfaceOverrides() {
            if (_interfaceOverrides == null) {
                _interfaceOverrides = new com.clubpenguin.world.rooms2014.puffles.PuffleParty_InterfaceOverrides();
            }
            return(_interfaceOverrides);
        }
        static function get partyIconVisible() {
            if (partyCookie.msgViewedArray[0] == 1) {
                return(true);
            }
            return(false);
        }
        static function getPartyDayByRoomId(roomId) {
            var _local_1 = 0;
            while (_local_1 < _quests.length) {
                if (_quests[_local_1].roomId == roomId) {
                    return(_quests[_local_1].id);
                }
                _local_1++;
            }
            return(-1);
        }
        static function getQuestByPartyDay(partyDay) {
            if ((partyDay < _quests.length) && (partyDay >= 0)) {
                return(_quests[partyDay]);
            } else {
                return(null);
            }
        }
        static function getMemberItemVOByPartyDay(partyDay) {
            return(_quests[partyDay].memberItemVO);
        }
        static function getNonMemberItemVOByPartyDay(partyDay) {
            return(_quests[partyDay].nonMemberItemVO);
        }
        static function isGalaUnlocked() {
            return(CONSTANTS.PARTY_DAY < 8);
        }
        static function showItemBoothPrompt() {
            if ((!getRoomItemsCollected(_shell.getRoomObject().room_id)) || (!isCurrentRoomItemAvailable)) {
                _global.getCurrentInterface().showContent(CONSTANTS.ITEM_BOOTH_PATH);
            }
        }
        static function showIglooList() {
            pebug("SS:showIglooList!");
            trace("SS:showIglooList!");
            _interface.showContent(CONSTANTS.IGLOO_LIST_PATH);
        }
        static function configureItemBooth(mc, triggerMC) {
            if (isCurrentRoomItemAvailable) {
                mc.gotoAndStop(CONSTANTS.BOOTH_UNLOCKED);
                if (getRoomItemsCollected(_shell.getRoomObject().room_id)) {
                    mc.booth_btn.enabled = false;
                }
            } else {
                mc.gotoAndStop(CONSTANTS.BOOTH_LOCKED);
            }
        }
        static function getRoomItemsCollected(roomId) {
            var _local_1 = getPartyDayByRoomId(roomId);
            var _local_2 = _quests[_local_1].memberItemId;
            var _local_3 = _quests[_local_1].nonMemberItemId;
            if (_shell.isItemInMyInventory(_local_2) && (_shell.isItemInMyInventory(_local_3))) {
                return(true);
            }
            return(false);
        }
        static function updateRoomTriggerState() {
            if (_engine.getRoomMovieClip().room != undefined) {
                _engine.getRoomMovieClip().room.updateItemBoothState();
            }
            if (_engine.getRoomMovieClip().roomFunctionality != undefined) {
                _engine.getRoomMovieClip().roomFunctionality.updateItemBoothState();
            }
        }
        static function get isCurrentRoomItemAvailable() {
            var _local_1 = _shell.getRoomObject().room_id;
            return(getPartyDayByRoomId(_local_1) <= CONSTANTS.PARTY_DAY);
        }
        static function initPartyAvatars() {
            var _local_5 = _engine.avatarManager.model;
            var _local_3 = _local_5.createAvatarFromTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID);
            _local_3.isSpriteTransformed = true;
            _local_3.defaultTransitionEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BROWN_SMALL;
            _local_3.defaultRevertEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BROWN_SMALL;
            _local_3.hasCustomPlayerCard = true;
            _local_3.canRevertToDefault = true;
            _local_3.attachItems = false;
            _local_3.hasColorVersions = false;
            _local_3.speechBubbleOffsetY = 0;
            _local_3.speechBubbleOffsetX = 0;
            _local_3.nicknameOffsetY = 0;
            _local_3.isMemberOnly = false;
            _local_3.attachItems = false;
            _local_3.spritePath = "";
            var _local_4 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 1000, 1001, 1002, 1003, 1004, 1005, 1006, 1007];
            var _local_1 = 0;
            while (_local_1 < _local_4.length) {
                var _local_2 = _local_3.clone();
                _local_2.spritePath = "w.avatarSprite.puffle." + getPuffleTypeByID(_local_4[_local_1]);
                _local_2.dynamicPlayerCardLabelFunc = com.clubpenguin.util.Delegate.create(_this, getDynamicPufflePlayerCardLabel);
                _local_5.setAvatarTemplate(_local_4[_local_1] + 1000, _local_2);
                _local_1++;
            }
        }
        static function getPuffleTypeByID(puffleID) {
            switch (puffleID) {
                case 0 : 
                    return("blue");
                case 1 : 
                    return("pink");
                case 2 : 
                    return("black");
                case 3 : 
                    return("green");
                case 4 : 
                    return("purple");
                case 5 : 
                    return("red");
                case 6 : 
                    return("yellow");
                case 7 : 
                    return("white");
                case 8 : 
                    return("orange");
                case 9 : 
                    return("brown");
                case 10 : 
                    return("rainbow");
                case 11 : 
                    return("gold");
                case 1000 : 
                    return("trex_black");
                case 1001 : 
                    return("trex_purple");
                case 1002 : 
                    return("triceratops_red");
                case 1003 : 
                    return("triceratops_blue");
                case 1004 : 
                    return("stegasaurus_yellow");
                case 1005 : 
                    return("stegasaurus_pink");
                case 1006 : 
                    return("dog");
                case 1007 : 
                    return("cat");
            }
        }
        static function getDynamicPufflePlayerCardLabel(player) {
            if (player != null) {
                return("id" + player.avatarVO.avatar_id);
            }
            return("id1000");
        }
        static function canUsePuffleCareStation(player_id) {
            return((com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_shell.getPlayerObjectById(player_id), com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE) ? true : false));
        }
        static function getIsPlayerPuffle(player_id) {
            var _local_1 = _shell.getPlayerObjectById(player_id).avatarVO.avatar_id;
            if (((_local_1 >= 1000) && (_local_1 <= 1011)) || ((_local_1 >= 2000) && (_local_1 <= 2007))) {
                return(true);
            }
            return(false);
        }
        static function getIsPuffleTransformWithoutPuffleWalk(player_id) {
            return(((getIsPlayerPuffle(player_id) && (!canUsePuffleCareStation(player_id))) ? true : false));
        }
        static function sendPuffleTransformation(transformNum) {
            if (_this.getIsPlayerPuffle(_shell.getMyPlayerId())) {
                _global.getCurrentParty().PuffleParty.sendPuffleUnTransformBI();
            }
            sendPuffleTransformBI(transformNum);
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.puffles.vo.PufflePartyCookieVO.PUFFLEPARTY_COOKIE_HANDLER_NAME + "#") + com.clubpenguin.world.rooms2014.puffles.vo.PufflePartyCookieVO.PUFFLE_TRANSFORM_COMMAND, [transformNum], "str", _shell.getCurrentServerRoomId());
        }
        static function activateInterfaceOverrides() {
            pebug("Activate engine overrides");
            _interface.revertAvatar = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.revertAvatar);
            _interface.closeContent = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.closeContent);
        }
        static function sendPuffleCareStationUsed(type, stationName) {
            com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(stationName, type);
        }
        static function sendPHSpriteView() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("PH", "npc_view");
        }
        static function sendPuffleTransformBI(transformNum) {
            var _local_1 = getPuffleTypeByID(Number(transformNum - 1000));
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_local_1, "puffle_transform");
            com.clubpenguin.util.TrackerAS2.getInstance().trackStepTimingEvent("puffle_transform_" + _local_1, "start");
        }
        static function sendPuffleUnTransformBI() {
            var _local_1 = _shell.getPlayerObjectById(_shell.getMyPlayerId()).avatarVO.avatar_id;
            var _local_2 = getPuffleTypeByID(Number(_local_1 - 1000));
            com.clubpenguin.util.TrackerAS2.getInstance().trackStepTimingEvent("puffle_transform_" + _local_2, "end");
        }
        static var CONSTANTS = com.clubpenguin.world.rooms2014.puffles.PufflePartyConstants;
        static var CLASS_NAME = "PuffleParty";
        static var PARTY_COOKIE_ID = "20140401";
        static var _this = com.clubpenguin.world.rooms2014.puffles.PuffleParty;
        static var _isActive = false;
    }
