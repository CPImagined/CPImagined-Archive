dynamic class com.clubpenguin.world.rooms2014.frozen.party.FrozenParty
{
    static var CLASS_NAME: String = "FrozenParty";
    static var _this = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty;
    static var _isActive: Boolean = false;
    static var _cookie = new com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO();

    function FrozenParty()
    {
    }

    static function init()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("FROZEN PARTY - INIT");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._isActive = true;
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell = _global.getCurrentShell();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower = _global.getCurrentAirtower();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface = _global.getCurrentInterface();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._engine = _global.getCurrentEngine();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._party = _global.getCurrentParty();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.initPartyAvatars();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().init();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.activateInterfaceOverrides();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.activateEngineOverrides();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._handleUpdateRoomStateDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._this, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.handleUpdateRoomState);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.addListener(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().UPDATE_ROOM_STATE, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._handleUpdateRoomStateDelegate);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._handleBallLandedDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._this, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.onSnowballLand);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.addListener(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.BALL_LAND, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._handleBallLandedDelegate);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.init();
    }

    static function destroy()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("FROZEN PARTY - destroy()");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._isActive = false;
    }

    static function configurePartySettings()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().ICE_PALACE_UNLOCK_DAY = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().PARTY_SERVICE.icePalaceUnlockDay;
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().ICE_PALACE_UNLOCK_TIME = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().PARTY_SERVICE.icePalaceUnlockTime;
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("CONSTANTS.ICE_PALACE_UNLOCK_DAY " + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().ICE_PALACE_UNLOCK_DAY);
        var __reg4 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().PARTY_SERVICE.questSettingList;
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest = new Array();
        var __reg3 = 0;
        while (__reg3 < __reg4.length) 
        {
            var __reg1 = new com.clubpenguin.world.rooms2014.frozen.vo.FrozenQuestRoomVO();
            var __reg2 = __reg4[__reg3];
            __reg1.roomId = __reg2.roomId;
            __reg1.snowflakeIds = __reg2.snowflakeIds;
            __reg1.memberItemId = __reg2.memberItemId;
            __reg1.nonMemberItemId = __reg2.nonmemberItemId;
            __reg1.createItemVOs();
            com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest.push(__reg1);
            ++__reg3;
        }
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("configurePartySettings() _quest " + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest);
    }

    static function get partyCookie()
    {
        return com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO(com.clubpenguin.party.BaseParty.__get__serverCookie());
    }

    static function get isActive()
    {
        return com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._isActive;
    }

    static function get CONSTANTS()
    {
        return com.clubpenguin.party.BaseParty.CONSTANTS;
    }

    static function pebug(msg, prefix)
    {
        com.clubpenguin.party.BaseParty.pebug(msg, prefix);
    }

    static function playSound(ui, soundId, volume)
    {
        com.clubpenguin.party.BaseParty.playSound(ui, soundId, volume);
    }

    static function checkForFirstTimeLogin(playerObj)
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("checkForFirstTimeLogin ");
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getMyPlayerId() != playerObj.player_id || com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getRoomObject().room_id == 112) 
        {
            return undefined;
        }
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().__get__msgViewedArray()[com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().LOGIN_MESSAGE_NUMBER] == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().MSG_NOT_VIEWED) 
        {
            com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.showContent(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().LOGIN_PROMPT_PATH);
        }
    }

    static function showMemberItemOopsMessage()
    {
        _global.getCurrentInterface().showContent(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().OOPS_MEMBER_ITEM_MESSAGE);
    }

    static function get interfaceOverrides()
    {
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interfaceOverrides == null) 
        {
            com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interfaceOverrides = new com.clubpenguin.world.rooms2014.frozen.party.FrozenParty_InterfaceOverrides();
        }
        return com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interfaceOverrides;
    }

    static function get partyIconVisible()
    {
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().__get__msgViewedArray()[com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().LOGIN_MESSAGE_NUMBER] == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().MSG_VIEWED) 
        {
            return true;
        }
        return false;
    }

    static function get localPlayerAvatarID()
    {
        return com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getPlayerObjectById(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getMyPlayerId()).avatarVO.avatar_id;
    }

    static function getSnowflakeIdsByRoomId(roomId)
    {
        var __reg1 = 0;
        while (__reg1 < com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest.length) 
        {
            var __reg2 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest[__reg1];
            if (roomId == __reg2.roomId) 
            {
                return com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest[__reg1].snowflakeIds;
            }
            ++__reg1;
        }
        return undefined;
    }

    static function getRoomVOByRoomID(roomID)
    {
        var __reg1 = 0;
        while (__reg1 < com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest.length) 
        {
            var __reg2 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest[__reg1];
            if (roomID == __reg2.roomId) 
            {
                return com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest[__reg1];
            }
            ++__reg1;
        }
        return undefined;
    }

    static function get isInStateChangingRoom()
    {
        var __reg1 = 0;
        while (__reg1 < com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest.length) 
        {
            var __reg2 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest[__reg1];
            if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getRoomObject().room_id == __reg2.roomId) 
            {
                return true;
            }
            ++__reg1;
        }
        return false;
    }

    static function checkForElsaCharacterDialogue()
    {
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().__get__msgViewedArray()[com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().ELSA_MESSAGE_NUMBER] == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().MSG_NOT_VIEWED && com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getRoomObject().room_id == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().FIRST_PARTY_ROOM_ID) 
        {
            com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.showContent(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().ELSA_PROMPT_PATH);
        }
    }

    static function hasFrozenPowers()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("partyCookie.freezingPowers " + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().__get__freezingPowers());
        return com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().__get__freezingPowers() == 1 || com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__localPlayerAvatarID() == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().OLAF_TRANSFORMATION_ID || com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__localPlayerAvatarID() == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().MARSHMALLOW_TRANSFORMATION_ID ? true : false;
    }

    static function get isIcePalaceAvailable()
    {
        return com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().PARTY_DAY >= com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().ICE_PALACE_UNLOCK_DAY;
    }

    static function addSnowballBurst(snowballInfo)
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._engine.avatarManager.effectManager.playEffectAtLocation(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FREEZE_BURST, snowballInfo.x, snowballInfo.y);
    }

    static function getSnowflakesForRoom(roomId)
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("getSnowflakesForRoom roomId" + roomId);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("getSnowflakesForRoom partyCookie.snowflakes" + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().__get__snowflakes());
        return com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().__get__snowflakes() ? com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().getSnowflakesForRoom(roomId) : undefined;
    }

    static function setSnowflakeCollectedForRoomAtIndex(roomId, offset)
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("setSnowflakeCollectedForRoomAtIndex: " + roomId + ", " + offset);
        var __reg1 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().getSnowflakesStartIndexForRoom(roomId);
        var __reg2 = __reg1 + offset;
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.checkIfAllSnowflakesCollected();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("setSnowflakeCollectedForRoomAtIndex partyCookie.snowflakes " + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().__get__snowflakes());
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.sendSnowflakeCollected(__reg2);
    }

    static function checkIfAllSnowflakesCollected()
    {
        var __reg1 = 0;
        while (__reg1 < com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().__get__snowflakes().length) 
        {
            if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().__get__snowflakes()[__reg1] == 0) 
            {
                return undefined;
            }
            ++__reg1;
        }
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("checkIfAllSnowflakesCollected() play PARTY_ICON collectedSparkles animation");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.PARTY_ICON._visible = true;
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.PARTY_ICON.collectedSparkles.play();
    }

    static function handleUpdateRoomState(data)
    {
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__isInStateChangingRoom()) 
        {
            var __reg5 = Number(data[0]);
            var __reg4 = Number(data[1]);
            var __reg10 = Number(data[2]);
            var __reg6 = Number(data[3]);
            var __reg7 = Number(data[4]);
            var __reg3 = Number(data[5]);
            if (!isNaN(__reg5) && !isNaN(__reg4)) 
            {
                if (__reg6 == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().FREEZE_STATE) 
                {
                    if (!isNaN(__reg7) && !isNaN(__reg3)) 
                    {
                        var __reg1 = {};
                        __reg1.player_id = __reg4;
                        __reg1.x = __reg7;
                        __reg1.y = __reg3;
                        var __reg8 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.playerIndexInRoom(__reg1.player_id);
                        var __reg9 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getPlayerList();
                        __reg9[__reg8].frame = 1;
                        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.handleThrowFrozenBall(__reg1);
                    }
                    else 
                    {
                        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.$e("[shell] handlePlayerThrowBall() -> The snowballs xpos or ypos was NaN. xpos: " + __reg3 + " ypos: " + __reg3);
                    }
                }
                __reg6 != com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().THAW_STATE;
                return undefined;
            }
            com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.$e("[shell] handlePlayerThrowBall() -> Did not receive a valid player id or smart room id. player_id: " + __reg4 + " smart_room_id: " + __reg5);
        }
    }

    static function handleThrowFrozenBall(event)
    {
        var __reg2 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getPlayerObjectById(event.player_id);
        __reg2.thrownSnowballInCurrentRoom = true;
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getMyPlayerId() != event.player_id) 
        {
            com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._engine.snowballManager.throwBall(event.player_id, event.x, event.y, new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN, -100, 20));
        }
    }

    static function collectFurniturePack(collectButton)
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.sendCollectFurniturePack();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._handleCollectFurniturePackDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._this, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.handleCollectFurniturePack, collectButton);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.addListener(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().COLLECT_FURNITURE_PACK_COMMAND, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._handleCollectFurniturePackDelegate);
    }

    static function handleCollectFurniturePack(data, collectButton)
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.removeListener(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().COLLECT_FURNITURE_PACK_COMMAND, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._handleCollectFurniturePackDelegate);
        collectButton.gotoAndStop(2);
        com.clubpenguin.util.TrackerAS2.getInstance().trackRewardEarned(com.clubpenguin.util.TrackerAS2.CURRENCY_ITEMS, -1, "999_FurnitureBundle", "Frozen Furniture Pack", com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getMyPlayerTotalCoins());
    }

    static function initPartyAvatars()
    {
        var __reg2 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._engine.avatarManager.model;
        var __reg1 = __reg2.createAvatarFromTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID);
        __reg1.isSpriteTransformed = true;
        __reg1.defaultTransitionEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE;
        __reg1.defaultRevertEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE;
        __reg1.hasCustomPlayerCard = true;
        __reg1.canRevertToDefault = true;
        __reg1.attachItems = false;
        __reg1.hasColorVersions = false;
        __reg1.isMemberOnly = true;
        __reg1.spritePath = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().OLAF_TRANSFORMATION_TOKEN;
        __reg2.setAvatarTemplate(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().OLAF_TRANSFORMATION_ID, __reg1);
        var __reg3 = __reg1.clone();
        __reg3.spritePath = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().MARSHMALLOW_TRANSFORMATION_TOKEN;
        __reg2.setAvatarTemplate(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().MARSHMALLOW_TRANSFORMATION_ID, __reg3);
    }

    static function requestOlafTransformation()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.sendTransformation(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().OLAF_TRANSFORMATION_ID);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.sendTransformBI("olaf");
    }

    static function requestMarshmallowTransformation()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.sendTransformation(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().MARSHMALLOW_TRANSFORMATION_ID);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.sendTransformBI("marshmallow");
    }

    static function onSnowballLand(snowballInfo)
    {
        if (snowballInfo.snowballType == com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN || snowballInfo.snowballType == com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN_LARGE) 
        {
            com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.playSnowballImpact();
        }
    }

    static function get snowballCoolDownExpirationDate()
    {
        return com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._snowballCoolDownExpirationDate == undefined ? com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getPenguinStandardTime().getTime() : com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._snowballCoolDownExpirationDate;
    }

    static function startSnowballCoolDown()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._snowballCoolDownExpirationDate = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getPenguinStandardTime().getTime() + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().SNOWBALL_COOLDOWN;
    }

    static function get isSnowballEnabled()
    {
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__snowballCoolDownExpirationDate() <= com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getPenguinStandardTime().getTime()) 
        {
            return true;
        }
        return false;
    }

    static function get snowballCoolDownRemainderPercentage()
    {
        var __reg2 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getPenguinStandardTime().getTime();
        var __reg3 = __reg2 - com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._snowballCoolDownExpirationDate;
        var __reg1 = 100 - Math.abs(Math.round(__reg3 / com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().SNOWBALL_COOLDOWN * 100));
        return __reg1 == 0 ? 1 : __reg1;
    }

    static function activateInterfaceOverrides()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.PARTY_ICON.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().partyIconOnRelease);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.updateAvatarCard = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().updateAvatarCard);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.revertAvatar = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().revertAvatar);
    }

    static function activateEngineOverrides()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("activateEngineOverrides PARTY VERSION");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._engine.snowballManager = new com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySnowballManager(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._engine, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface);
    }

    static function activateSnowballOverrides()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.showCrosshair = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().showCrosshair);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.doCrossHairRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().doCrossHairRelease);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.sendEmote = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().sendEmote);
    }

    static function deactivateSnowballOverrides()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.doCrossHairRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().defaultDoCrossHairRelease);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.showCrosshair = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().defaultShowCrosshair);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.sendEmote = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().defaultSendEmote);
    }

    static function sendCollectFurniturePack()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.send(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().COLLECT_FURNITURE_PACK_COMMAND, [0], "str", com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getCurrentServerRoomId());
    }

    static function sendGetConcertCountdown()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.send(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().REQUEST_CONCERT_COUNTDOWN, [0], "str", com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getCurrentServerRoomId());
    }

    static function sendSnowflakeCollected(snowflakeIndex)
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.send(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().SNOWFLAKE_FOUND, [snowflakeIndex], "str", com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getCurrentServerRoomId());
    }

    static function sendUpdateRoomState(sectionId, sectionState, x, y)
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.send(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().UPDATE_ROOM_STATE, [sectionId, sectionState, x, y], "str", com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getCurrentServerRoomId());
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.sendRoomStateUpdateBI(sectionState == 0 ? "thawed" : "frozen");
    }

    static function sendActivateFreezingPower()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.send(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().ACTIVE_FREEZING_POWER, [0], "str", com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getCurrentServerRoomId());
    }

    static function sendTransformation(id)
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.send(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().SET_FROZEN_TRANSFORM, [id], "str", com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getCurrentServerRoomId());
    }

    static function sendElsaAttendPerformanceBI()
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("Let It Go!", "attend_room_performance");
    }

    static function sendTransformBI(transformName)
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(transformName, "avatar_transform");
        com.clubpenguin.util.TrackerAS2.getInstance().trackStepTimingEvent("avatar_transform_" + transformName, "start");
    }

    static function sendUnTransformBI()
    {
        var __reg1 = undefined;
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__localPlayerAvatarID() == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().OLAF_TRANSFORMATION_ID) 
        {
            __reg1 = "olaf";
        }
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__localPlayerAvatarID() == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().MARSHMALLOW_TRANSFORMATION_ID) 
        {
            __reg1 = "marshmallow";
        }
        com.clubpenguin.util.TrackerAS2.getInstance().trackStepTimingEvent("avatar_transform_" + __reg1, "end");
    }

    static function sendRoomStateUpdateBI(state)
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(state, "room_asset_effect");
    }

    static function sendOpenQuestBI()
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "quest_open");
    }

    static function sendScrollQuestBI()
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "quest_ui_end");
    }

}
