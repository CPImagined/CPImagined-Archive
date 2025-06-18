//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.future.FutureParty
    {
        static var _shell, _airtower, _interface, _engine, _party, _serverCookieService, _serverCookie, MECHCONTROLLER, _quests, _engineOverrides, _interfaceOverrides, _snowballCoolDownExpirationDate;
        function FutureParty () {
        }
        static function init() {
            pebug("FUTURE PARTY - INIT");
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
            _serverCookie = new com.clubpenguin.world.rooms2014.future.vo.FuturePartyCookieVO(PARTY_COOKIE_ID);
            _serverCookieService.registerCookieVO(_serverCookie.getID(), _serverCookie);
            MECHCONTROLLER = com.clubpenguin.world.rooms2014.future.mech.MechController;
            com.clubpenguin.world.rooms2014.future.mech.MechController.init();
            initPartyAvatars();
            engineOverrides.init();
            interfaceOverrides.init();
            activateInterfaceOverrides();
            activateEngineOverrides();
            activateFutureSnowballManagerOverride();
        }
        static function get partyCookie() {
            return(com.clubpenguin.world.rooms2014.future.vo.FuturePartyCookieVO(_serverCookie));
        }
        static function configurePartySettings() {
            _quests = new Array();
            CONSTANTS.PROTOBOT_BATTLE_PARTY_DAY = CONSTANTS.PARTY_SERVICE.protobotStartDay;
            CONSTANTS.ROBO_COLORS = CONSTANTS.PARTY_SERVICE.roboColors;
            CONSTANTS.IGLOO_LIST_ITEM_ID = CONSTANTS.PARTY_SERVICE.partySettings.partyIglooItems[0];
            var _local_4 = CONSTANTS.PARTY_SERVICE.futurePartyRewards;
            var _local_3 = 0;
            while (_local_3 < _local_4.length) {
                var _local_1 = new com.clubpenguin.world.rooms2014.future.vo.FuturePartyInfoVO();
                var _local_2 = _local_4[_local_3];
                _local_1.id = _local_2.unlockDay;
                _local_1.memberItemId = _local_2.memberItemId;
                _local_1.nonMemberItemId = _local_2.nonmemberItemId;
                _local_1.createItemVOs();
                _quests.push(_local_1);
                _local_3++;
            }
            var _local_5 = new com.clubpenguin.world.rooms2014.future.vo.FuturePartyInfoVO();
            _local_5.id = CONSTANTS.PROTOBOT_BATTLE_PARTY_DAY;
            _local_5.memberItemId = CONSTANTS.PARTY_SERVICE.secondWeekItems[0];
            _local_5.nonMemberItemId = CONSTANTS.PARTY_SERVICE.secondWeekItems[1];
            _local_5.createItemVOs();
            _quests.push(_local_1);
        }
        static function get isActive() {
            return(_isActive);
        }
        static function pebug(msg, prefix) {
            com.clubpenguin.party.BaseParty.pebug(msg, prefix);
        }
        static function playSound(ui, soundId, volume, looping) {
            com.clubpenguin.party.BaseParty.playSound(ui, soundId, volume, looping);
        }
        static function stopSound(ui, soundId) {
            com.clubpenguin.party.BaseParty.stopSound(ui, soundId);
        }
        static function checkForFirstTimeLogin(playerObj) {
            if ((_shell.getMyPlayerId() != playerObj.player_id) || (_shell.getRoomObject().room_id == 112)) {
                return(undefined);
            }
            if (partyCookie.msgViewedArray[0] == 0) {
                pebug("Show login prompt");
                _interface.showContent(CONSTANTS.PROMPT_GARY_LOGIN);
            } else if ((partyCookie.msgViewedArray[2] == 0) && (CONSTANTS.PARTY_DAY > 5)) {
                pebug("Show protobot prompt");
                _interface.showContent(CONSTANTS.PROMPT_GARY_PROTOBOT);
            }
        }
        static function checkForFirstTimeTransform() {
            if (partyCookie.msgViewedArray[1] == 0) {
                pebug("Show trasnform prompt");
                _interface.showContent(CONSTANTS.PROMPT_GARY_TRANSFORM);
            }
        }
        static function showMemberContentOopsMessage() {
            _global.getCurrentInterface().showContent(CONSTANTS.OOPS_MEMBER_PUFFLES_MESSAGE);
        }
        static function showMemberItemOopsMessage() {
            _global.getCurrentInterface().showContent(CONSTANTS.OOPS_MEMBER_ITEM_MESSAGE);
        }
        static function get itemOnIglooList() {
            pebug("FutureParty.itemOnIglooList CURRENT_PARTY.itemOnIglooList " + CONSTANTS.IGLOO_LIST_ITEM_ID);
            return(new com.clubpenguin.party.items.IglooItem(CONSTANTS.IGLOO_LIST_ITEM_ID, true, 1500, "Puffle Tree House"));
        }
        static function get engineOverrides() {
            if (_engineOverrides == null) {
                _engineOverrides = new com.clubpenguin.world.rooms2014.future.FutureParty_EngineOverrides();
            }
            return(_engineOverrides);
        }
        static function get interfaceOverrides() {
            if (_interfaceOverrides == null) {
                _interfaceOverrides = new com.clubpenguin.world.rooms2014.future.FutureParty_InterfaceOverrides();
            }
            return(_interfaceOverrides);
        }
        static function get partyIconVisible() {
            if (partyCookie.msgViewedArray[0] == 1) {
                return(true);
            }
            return(false);
        }
        static function getNonmemberPartyItemByUnlockDay(index) {
            if (_quests[index].id <= CONSTANTS.PARTY_DAY) {
                return(_quests[index].nonMemberItemVO);
            }
            return(undefined);
        }
        static function getMemberPartyItemByUnlockDay(index) {
            if (_quests[index].id <= CONSTANTS.PARTY_DAY) {
                return(_quests[index].memberItemVO);
            }
            return(undefined);
        }
        static function get localPlayerAvatarID() {
            return(_shell.getPlayerObjectById(_shell.getMyPlayerId()).avatarVO.avatar_id);
        }
        static function get inSpaceRoom() {
            var _local_1 = _shell.getRoomObject().room_id;
            return(((_local_1 == CONSTANTS.SPACE_ROOM_1_ID) || (_local_1 == CONSTANTS.SPACE_ROOM_2_ID)) || (_local_1 == CONSTANTS.SPACE_ROOM_3_ID));
        }
        static function get isFutureRoom() {
            return((_shell.getRoomObject().room_id >= CONSTANTS.FIRST_PARTY_ROOM_ID) && (_shell.getRoomObject().room_id <= CONSTANTS.LAST_PARTY_ROOM_ID));
        }
        static function get isIndoorFutureRoom() {
            return(((_shell.getRoomObject().room_id >= 853) && (_shell.getRoomObject().room_id <= 855)) || (_shell.getRoomObject().room_id == 858));
        }
        static function checkPlayerBlastoff(player_id) {
            if (com.clubpenguin.world.rooms2014.future.mech.MechController.canPlayerBlastOff(player_id)) {
                com.clubpenguin.world.rooms2014.future.mech.MechController.triggerBlastoff(player_id);
            } else {
                showBlastoffErrorPrompt();
            }
        }
        static function showBlastoffErrorPrompt() {
            _interface.showContent(CONSTANTS.BLASTOFF_ERROR);
        }
        static function get currentRoomCollisionItems() {
            if (!inSpaceRoom) {
                return(undefined);
            }
            var _local_1 = _engine.getRoomMovieClip();
            return(((_local_1.room != undefined) ? (_local_1.room.collisionItems) : undefined));
        }
        static function dispatchCollision(collidableId, playerID, snowballObject) {
            if (!inSpaceRoom) {
                return(undefined);
            }
            var _local_1 = _engine.getRoomMovieClip();
            pebug("FUTURE PARTY------snowballObject.x " + snowballObject.x);
            if (_local_1.room != undefined) {
                _local_1.room.handleCollision(collidableId, playerID, snowballObject);
            }
        }
        static function get snowballCoolDownExpirationDate() {
            return(((_snowballCoolDownExpirationDate == undefined) ? (_shell.getPenguinStandardTime().getTime()) : (_snowballCoolDownExpirationDate)));
        }
        static function startSnowballCoolDown() {
            _snowballCoolDownExpirationDate = _shell.getPenguinStandardTime().getTime() + CONSTANTS.SNOWBALL_COOLDOWN;
        }
        static function get isSnowballEnabled() {
            if (snowballCoolDownExpirationDate <= _shell.getPenguinStandardTime().getTime()) {
                return(true);
            }
            return(false);
        }
        static function initPartyAvatars() {
            var _local_4 = _engine.avatarManager.model;
            var _local_3 = _local_4.createAvatarFromTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID);
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
            var _local_1 = CONSTANTS.FIRST_MECH_ID;
            while (_local_1 <= CONSTANTS.LAST_MECH_ID) {
                var _local_2 = _local_3.clone();
                _local_2.spritePath = "w.avatarSprite.robo." + _local_1;
                _local_2.dynamicPlayerCardLabelFunc = com.clubpenguin.util.Delegate.create(_this, getDynamicMechPlayerCardLabel);
                _local_4.setAvatarTemplate(_local_1, _local_2);
                _local_1++;
            }
        }
        static function getDynamicMechPlayerCardLabel(player) {
            if (player != null) {
                return("id" + player.avatarVO.avatar_id);
            }
            return("id" + CONSTANTS.FIRST_MECH_ID);
        }
        static function sendMechTransformation(transformNum) {
            if (com.clubpenguin.world.rooms2014.future.mech.MechController.isPlayerMech(_shell.getMyPlayerId())) {
                sendMechUnTransformBI();
            }
            if (partyCookie.msgViewedArray[CONSTANTS.TRANSFORM_MESSAGE_NUMBER] == 0) {
                _interface.showContent(CONSTANTS.PROMPT_GARY_TRANSFORM);
            }
            _engine.avatarManager.transformationManager.sendTransformPlayer(Number(transformNum));
            sendMechTransformBI(transformNum);
        }
        static function activateEngineOverrides() {
            _engine.updatePlayerFrame = com.clubpenguin.util.Delegate.create(_engine, engineOverrides.updatePlayerFrame);
        }
        static function activateInterfaceOverrides() {
            _interface.revertAvatar = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.revertAvatar);
            _interface.showMapIcon = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.showMapIcon);
        }
        static function activateFutureSnowballManagerOverride() {
            _engine.snowballManager = new com.clubpenguin.world.rooms2014.future.FuturePartyLandSnowballManager(_shell, _engine, _interface);
        }
        static function activateSpaceOverrides() {
            _engine.snowballManager = new com.clubpenguin.world.rooms2014.future.FuturePartySnowballManager(_shell, _engine, _interface);
            _engine.movePlayer = com.clubpenguin.util.Delegate.create(_engine, engineOverrides.movePlayer);
            _interface.showCrosshair = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.showCrosshair);
            _interface.doCrossHairRelease = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.doCrossHairRelease);
        }
        static function activateFloatMovement() {
            _engine.movePlayer = com.clubpenguin.util.Delegate.create(_engine, engineOverrides.movePlayer);
        }
        static function deactivateFloatMovement() {
            _engine.movePlayer = com.clubpenguin.util.Delegate.create(_engine, engineOverrides.defaultMovePlayer);
        }
        static function deactivateSpaceOverrides() {
            _engine.snowballManager = new com.clubpenguin.world.rooms2014.future.FuturePartyLandSnowballManager(_shell, _engine, _interface);
            _engine.movePlayer = com.clubpenguin.util.Delegate.create(_engine, engineOverrides.defaultMovePlayer);
            _interface.showCrosshair = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.defaultShowCrosshair);
            _interface.doCrossHairRelease = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.defaultDoCrossHairRelease);
        }
        static function sendRequestPartyCookie() {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.future.vo.FuturePartyCookieVO.FUTURE_COOKIE_HANDLER_NAME + "#") + com.clubpenguin.world.rooms2014.future.vo.FuturePartyCookieVO.FUTURE_RECEIVE_COMMAND_NAME, [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendPaintCurrentRobo(roboId, colorId) {
            sendMechColorize(roboId, colorId);
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.future.vo.FuturePartyCookieVO.FUTURE_COOKIE_HANDLER_NAME + "#") + CONSTANTS.PAINT_ROBO_COMMAND, [roboId, colorId], "str", _shell.getCurrentServerRoomId());
        }
        static function sendPurchaseFutureItem(itemId) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.future.vo.FuturePartyCookieVO.FUTURE_COOKIE_HANDLER_NAME + "#") + CONSTANTS.FUTURE_USE_POINTS, [itemId], "str", _shell.getCurrentServerRoomId());
        }
        static function sendGetProtobotCountdown() {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.future.vo.FuturePartyCookieVO.FUTURE_COOKIE_HANDLER_NAME + "#") + CONSTANTS.GET_PROTOBOT_COUNTDOWN, [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendProtobotDefeated() {
            if (partyCookie.hasDefeatedProtobot) {
                return(undefined);
            }
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.future.vo.FuturePartyCookieVO.FUTURE_COOKIE_HANDLER_NAME + "#") + CONSTANTS.SET_PROTOBOT_DEFEATED, [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendJetpackEquippedBI() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "jetpack_equip");
        }
        static function sendMechTransformBI(avatarID) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(getRobotTypeAsString(avatarID), "robot_transform", {message:getRobotColorAsString(avatarID)});
            com.clubpenguin.util.TrackerAS2.getInstance().trackStepTimingEvent("robot_transform_" + getRobotNameAsString(avatarID), "start");
        }
        static function sendMechUnTransformBI() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackStepTimingEvent("robot_transform_" + getRobotNameAsString(localPlayerAvatarID), "end");
        }
        static function getRobotTypeAsString(avatarID) {
            var _local_1 = com.clubpenguin.world.rooms2014.future.mech.MechController.getRobotTypeFromAvatarId(avatarID);
            return(CONSTANTS.ROBO_NAMES[_local_1]);
        }
        static function getRobotColorAsString(avatarID) {
            var _local_1 = com.clubpenguin.world.rooms2014.future.mech.MechController.getRoboColourIdFromAvatarId(avatarID);
            return(CONSTANTS[("ROBO_COLOR_" + _local_1) + "_NAME"]);
        }
        static function getRobotNameAsString(avatarID) {
            return((getRobotTypeAsString(avatarID) + "_") + getRobotColorAsString(avatarID));
        }
        static function sendMechCustomizerOpen() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "robot_customizer_open");
        }
        static function sendMechColorize(roboId, colorId) {
            var _local_1 = CONSTANTS.ROBO_NAMES[roboId];
            var _local_2 = CONSTANTS[("ROBO_COLOR_" + colorId) + "_NAME"];
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_local_1, "robot_colorize", {message:_local_2});
        }
        static function sendOutfitRandomizerOpen() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "outfit_randomizer_open");
        }
        static function sendOutfitRandomizerChosen() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "outfit_randomizer_chosen");
        }
        static function sendPurchaseFutureItemBI(itemID) {
            var _local_2 = _shell.getInventoryObjectById(itemID);
            var _local_1 = _local_2.cost;
            var _local_3 = _local_2.name;
            var _local_4 = String(itemID) + "_Clothing";
            com.clubpenguin.util.TrackerAS2.getInstance().trackRewardEarned("asteroid_points", -_local_1, _local_4, _local_3, partyCookie.asteroidPoints - _local_1);
        }
        static function sendSpaceBattlePayoutBI(waveId, points) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackRewardEarned("asteroid_points", points, "space_battle_payout", CONSTANTS.WAVE_COLLECTION_NAMES[waveId], partyCookie.asteroidPoints);
        }
        static function sendSpaceBattleResultBI(waveId, result) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(CONSTANTS.WAVE_COLLECTION_NAMES[waveId], "space_battle", {message:result});
        }
        static var CONSTANTS = com.clubpenguin.world.rooms2014.future.FuturePartyConstants;
        static var CLASS_NAME = "FutureParty";
        static var PARTY_COOKIE_ID = "20140501";
        static var _this = com.clubpenguin.world.rooms2014.future.FutureParty;
        static var _isActive = false;
    }
