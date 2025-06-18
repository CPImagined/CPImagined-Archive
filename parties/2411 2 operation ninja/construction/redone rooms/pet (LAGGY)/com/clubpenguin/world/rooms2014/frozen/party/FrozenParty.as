//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.frozen.party.FrozenParty
    {
        static var _shell, _airtower, _interface, _engine, _party, _handleUpdateRoomStateDelegate, _handleBallLandedDelegate, _quest, _interfaceOverrides, _handleCollectFurniturePackDelegate, _snowballCoolDownExpirationDate;
        function FrozenParty () {
        }
        static function init() {
            pebug("FROZEN PARTY - INIT");
            _isActive = true;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            initPartyAvatars();
            interfaceOverrides.init();
            activateInterfaceOverrides();
            activateEngineOverrides();
            _handleUpdateRoomStateDelegate = com.clubpenguin.util.Delegate.create(_this, handleUpdateRoomState);
            _airtower.addListener(CONSTANTS.UPDATE_ROOM_STATE, _handleUpdateRoomStateDelegate);
            _handleBallLandedDelegate = com.clubpenguin.util.Delegate.create(_this, onSnowballLand);
            _shell.addListener(_shell.BALL_LAND, _handleBallLandedDelegate);
            com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.init();
        }
        static function destroy() {
            pebug("FROZEN PARTY - destroy()");
            _isActive = false;
        }
        static function configurePartySettings() {
            CONSTANTS.ICE_PALACE_UNLOCK_DAY = CONSTANTS.PARTY_SERVICE.icePalaceUnlockDay;
            CONSTANTS.ICE_PALACE_UNLOCK_TIME = CONSTANTS.PARTY_SERVICE.icePalaceUnlockTime;
            pebug("CONSTANTS.ICE_PALACE_UNLOCK_DAY " + CONSTANTS.ICE_PALACE_UNLOCK_DAY);
            var _local_4 = CONSTANTS.PARTY_SERVICE.questSettingList;
            _quest = new Array();
            var _local_3 = 0;
            while (_local_3 < _local_4.length) {
                var _local_1 = new com.clubpenguin.world.rooms2014.frozen.vo.FrozenQuestRoomVO();
                var _local_2 = _local_4[_local_3];
                _local_1.roomId = _local_2.roomId;
                _local_1.snowflakeIds = _local_2.snowflakeIds;
                _local_1.memberItemId = _local_2.memberItemId;
                _local_1.nonMemberItemId = _local_2.nonmemberItemId;
                _local_1.createItemVOs();
                _quest.push(_local_1);
                _local_3++;
            }
            pebug("configurePartySettings() _quest " + _quest);
        }
        static function get partyCookie() {
            return(com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO(com.clubpenguin.party.BaseParty.serverCookie));
        }
        static function get isActive() {
            return(_isActive);
        }
        static function get CONSTANTS() {
            return(com.clubpenguin.party.BaseParty.CONSTANTS);
        }
        static function pebug(_arg_2, _arg_1) {
            com.clubpenguin.party.BaseParty.pebug(_arg_2, _arg_1);
        }
        static function playSound(_arg_1, _arg_2, _arg_3) {
            com.clubpenguin.party.BaseParty.playSound(_arg_1, _arg_2, _arg_3);
        }
        static function checkForFirstTimeLogin(_arg_1) {
            pebug("checkForFirstTimeLogin ");
            if ((_shell.getMyPlayerId() != _arg_1.player_id) || (_shell.getRoomObject().room_id == 112)) {
                return(undefined);
            }
            if (partyCookie.msgViewedArray[CONSTANTS.LOGIN_MESSAGE_NUMBER] == CONSTANTS.MSG_NOT_VIEWED) {
                _interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
            }
        }
        static function showMemberItemOopsMessage() {
            _global.getCurrentInterface().showContent(CONSTANTS.OOPS_MEMBER_ITEM_MESSAGE);
        }
        static function get interfaceOverrides() {
            if (_interfaceOverrides == null) {
                _interfaceOverrides = new com.clubpenguin.world.rooms2014.frozen.party.FrozenParty_InterfaceOverrides();
            }
            return(_interfaceOverrides);
        }
        static function get partyIconVisible() {
            if (partyCookie.msgViewedArray[CONSTANTS.LOGIN_MESSAGE_NUMBER] == CONSTANTS.MSG_VIEWED) {
                return(true);
            }
            return(false);
        }
        static function get localPlayerAvatarID() {
            return(_shell.getPlayerObjectById(_shell.getMyPlayerId()).avatarVO.avatar_id);
        }
        static function getSnowflakeIdsByRoomId(_arg_3) {
            var _local_1 = 0;
            while (_local_1 < _quest.length) {
                var _local_2 = _quest[_local_1];
                if (_arg_3 == _local_2.roomId) {
                    return(_quest[_local_1].snowflakeIds);
                }
                _local_1++;
            }
            return(undefined);
        }
        static function getRoomVOByRoomID(_arg_3) {
            var _local_1 = 0;
            while (_local_1 < _quest.length) {
                var _local_2 = _quest[_local_1];
                if (_arg_3 == _local_2.roomId) {
                    return(_quest[_local_1]);
                }
                _local_1++;
            }
            return(undefined);
        }
        static function get isInStateChangingRoom() {
            var _local_1 = 0;
            while (_local_1 < _quest.length) {
                var _local_2 = _quest[_local_1];
                if (_shell.getRoomObject().room_id == _local_2.roomId) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        static function checkForElsaCharacterDialogue() {
            if ((partyCookie.msgViewedArray[CONSTANTS.ELSA_MESSAGE_NUMBER] == CONSTANTS.MSG_NOT_VIEWED) && (_shell.getRoomObject().room_id == CONSTANTS.FIRST_PARTY_ROOM_ID)) {
                _interface.showContent(CONSTANTS.ELSA_PROMPT_PATH);
            }
        }
        static function hasFrozenPowers() {
            pebug("partyCookie.freezingPowers " + partyCookie.freezingPowers);
            return(((((partyCookie.freezingPowers == 1) || (localPlayerAvatarID == CONSTANTS.OLAF_TRANSFORMATION_ID)) || (localPlayerAvatarID == CONSTANTS.MARSHMALLOW_TRANSFORMATION_ID)) ? true : false));
        }
        static function get isIcePalaceAvailable() {
            return(CONSTANTS.PARTY_DAY >= CONSTANTS.ICE_PALACE_UNLOCK_DAY);
        }
        static function addSnowballBurst(_arg_1) {
            _engine.avatarManager.effectManager.playEffectAtLocation(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FREEZE_BURST, _arg_1.x, _arg_1.y);
        }
        static function getSnowflakesForRoom(_arg_1) {
            pebug("getSnowflakesForRoom roomId" + _arg_1);
            pebug("getSnowflakesForRoom partyCookie.snowflakes" + partyCookie.snowflakes);
            return((partyCookie.snowflakes ? (partyCookie.getSnowflakesForRoom(_arg_1)) : undefined));
        }
        static function setSnowflakeCollectedForRoomAtIndex(_arg_4, _arg_3) {
            pebug((("setSnowflakeCollectedForRoomAtIndex: " + _arg_4) + ", ") + _arg_3);
            var _local_1 = partyCookie.getSnowflakesStartIndexForRoom(_arg_4);
            var _local_2 = _local_1 + _arg_3;
            checkIfAllSnowflakesCollected();
            pebug("setSnowflakeCollectedForRoomAtIndex partyCookie.snowflakes " + partyCookie.snowflakes);
            sendSnowflakeCollected(_local_2);
        }
        static function checkIfAllSnowflakesCollected() {
            var _local_1 = 0;
            while (_local_1 < partyCookie.snowflakes.length) {
                if (partyCookie.snowflakes[_local_1] == 0) {
                    return(undefined);
                }
                _local_1++;
            }
            pebug("checkIfAllSnowflakesCollected() play PARTY_ICON collectedSparkles animation");
            _interface.PARTY_ICON._visible = true;
            _interface.PARTY_ICON.collectedSparkles.play();
        }
        static function handleUpdateRoomState(_arg_1) {
            if (!isInStateChangingRoom) {
                return(undefined);
            }
            var _local_7 = Number(_arg_1[0]);
            var _local_4 = Number(_arg_1[1]);
            var _local_10 = Number(_arg_1[2]);
            var _local_6 = Number(_arg_1[3]);
            var _local_5 = Number(_arg_1[4]);
            var _local_3 = Number(_arg_1[5]);
            if ((!isNaN(_local_7)) && (!isNaN(_local_4))) {
                if (_local_6 == CONSTANTS.FREEZE_STATE) {
                    if ((!isNaN(_local_5)) && (!isNaN(_local_3))) {
                        var _local_2 = {};
                        _local_2.player_id = _local_4;
                        _local_2.x = _local_5;
                        _local_2.y = _local_3;
                        var _local_9 = _shell.playerIndexInRoom(_local_2.player_id);
                        var _local_8 = _shell.getPlayerList();
                        _local_8[_local_9].frame = 1;
                        handleThrowFrozenBall(_local_2);
                    } else {
                        _shell.$e((("[shell] handlePlayerThrowBall() -> The snowballs xpos or ypos was NaN. xpos: " + _local_3) + " ypos: ") + _local_3);
                    }
                }
                if (_local_6 == CONSTANTS.THAW_STATE) {
                }
            } else {
                _shell.$e((("[shell] handlePlayerThrowBall() -> Did not receive a valid player id or smart room id. player_id: " + _local_4) + " smart_room_id: ") + _local_7);
            }
        }
        static function handleThrowFrozenBall(_arg_1) {
            var _local_2 = _shell.getPlayerObjectById(_arg_1.player_id);
            _local_2.thrownSnowballInCurrentRoom = true;
            if (_shell.getMyPlayerId() != _arg_1.player_id) {
                _engine.snowballManager.throwBall(_arg_1.player_id, _arg_1.x, _arg_1.y, new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN, -100, 20));
            }
        }
        static function collectFurniturePack(_arg_1) {
            sendCollectFurniturePack();
            _handleCollectFurniturePackDelegate = com.clubpenguin.util.Delegate.create(_this, handleCollectFurniturePack, _arg_1);
            _airtower.addListener(CONSTANTS.COLLECT_FURNITURE_PACK_COMMAND, _handleCollectFurniturePackDelegate);
        }
        static function handleCollectFurniturePack(data, _arg_1) {
            _airtower.removeListener(CONSTANTS.COLLECT_FURNITURE_PACK_COMMAND, _handleCollectFurniturePackDelegate);
            _arg_1.gotoAndStop(2);
            com.clubpenguin.util.TrackerAS2.getInstance().trackRewardEarned(com.clubpenguin.util.TrackerAS2.CURRENCY_ITEMS, -1, "999_FurnitureBundle", "Frozen Furniture Pack", _shell.getMyPlayerTotalCoins());
        }
        static function initPartyAvatars() {
            var _local_2 = _engine.avatarManager.model;
            var _local_1 = _local_2.createAvatarFromTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID);
            _local_1.isSpriteTransformed = true;
            _local_1.defaultTransitionEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE;
            _local_1.defaultRevertEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE;
            _local_1.hasCustomPlayerCard = true;
            _local_1.canRevertToDefault = true;
            _local_1.attachItems = false;
            _local_1.hasColorVersions = false;
            _local_1.isMemberOnly = true;
            _local_1.spritePath = CONSTANTS.OLAF_TRANSFORMATION_TOKEN;
            _local_2.setAvatarTemplate(CONSTANTS.OLAF_TRANSFORMATION_ID, _local_1);
            var _local_3 = _local_1.clone();
            _local_3.spritePath = CONSTANTS.MARSHMALLOW_TRANSFORMATION_TOKEN;
            _local_2.setAvatarTemplate(CONSTANTS.MARSHMALLOW_TRANSFORMATION_ID, _local_3);
        }
        static function requestOlafTransformation() {
            sendTransformation(CONSTANTS.OLAF_TRANSFORMATION_ID);
            sendTransformBI("olaf");
        }
        static function requestMarshmallowTransformation() {
            sendTransformation(CONSTANTS.MARSHMALLOW_TRANSFORMATION_ID);
            sendTransformBI("marshmallow");
        }
        static function onSnowballLand(_arg_1) {
            if ((_arg_1.snowballType == com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN) || (_arg_1.snowballType == com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN_LARGE)) {
                com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.playSnowballImpact();
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
        static function get snowballCoolDownRemainderPercentage() {
            var _local_3 = _shell.getPenguinStandardTime().getTime();
            var _local_2 = _local_3 - _snowballCoolDownExpirationDate;
            var _local_1 = 100 - Math.abs(Math.round((_local_2 / CONSTANTS.SNOWBALL_COOLDOWN) * 100));
            return(((_local_1 == 0) ? 1 : (_local_1)));
        }
        static function activateInterfaceOverrides() {
            _interface.PARTY_ICON.onRelease = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.partyIconOnRelease);
            _interface.updateAvatarCard = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.updateAvatarCard);
            _interface.revertAvatar = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.revertAvatar);
        }
        static function activateEngineOverrides() {
            pebug("activateEngineOverrides PARTY VERSION");
            _engine.snowballManager = new com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySnowballManager(_shell, _engine, _interface);
        }
        static function activateSnowballOverrides() {
            _interface.showCrosshair = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.showCrosshair);
            _interface.doCrossHairRelease = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.doCrossHairRelease);
            _interface.sendEmote = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.sendEmote);
        }
        static function deactivateSnowballOverrides() {
            _interface.doCrossHairRelease = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.defaultDoCrossHairRelease);
            _interface.showCrosshair = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.defaultShowCrosshair);
            _interface.sendEmote = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.defaultSendEmote);
        }
        static function sendCollectFurniturePack() {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#") + CONSTANTS.COLLECT_FURNITURE_PACK_COMMAND, [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendGetConcertCountdown() {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#") + CONSTANTS.REQUEST_CONCERT_COUNTDOWN, [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendSnowflakeCollected(_arg_1) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#") + CONSTANTS.SNOWFLAKE_FOUND, [_arg_1], "str", _shell.getCurrentServerRoomId());
        }
        static function sendUpdateRoomState(_arg_2, _arg_1, _arg_4, _arg_3) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#") + CONSTANTS.UPDATE_ROOM_STATE, [_arg_2, _arg_1, _arg_4, _arg_3], "str", _shell.getCurrentServerRoomId());
            sendRoomStateUpdateBI(((_arg_1 == 0) ? "thawed" : "frozen"));
        }
        static function sendActivateFreezingPower() {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#") + CONSTANTS.ACTIVE_FREEZING_POWER, [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendTransformation(_arg_1) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#") + CONSTANTS.SET_FROZEN_TRANSFORM, [_arg_1], "str", _shell.getCurrentServerRoomId());
        }
        static function sendElsaAttendPerformanceBI() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("Let It Go!", "attend_room_performance");
        }
        static function sendTransformBI(_arg_1) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_arg_1, "avatar_transform");
            com.clubpenguin.util.TrackerAS2.getInstance().trackStepTimingEvent("avatar_transform_" + _arg_1, "start");
        }
        static function sendUnTransformBI() {
            var _local_1;
            if (localPlayerAvatarID == CONSTANTS.OLAF_TRANSFORMATION_ID) {
                _local_1 = "olaf";
            }
            if (localPlayerAvatarID == CONSTANTS.MARSHMALLOW_TRANSFORMATION_ID) {
                _local_1 = "marshmallow";
            }
            com.clubpenguin.util.TrackerAS2.getInstance().trackStepTimingEvent("avatar_transform_" + _local_1, "end");
        }
        static function sendRoomStateUpdateBI(_arg_1) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_arg_1, "room_asset_effect");
        }
        static function sendOpenQuestBI() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "quest_open");
        }
        static function sendScrollQuestBI() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "quest_ui_end");
        }
        static var CLASS_NAME = "FrozenParty";
        static var _this = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty;
        static var _isActive = false;
        static var _cookie = new com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO();
    }
