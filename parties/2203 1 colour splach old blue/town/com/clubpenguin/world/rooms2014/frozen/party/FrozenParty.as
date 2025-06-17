class com.clubpenguin.world.rooms2014.frozen.party.FrozenParty
{
    static var _shell, _airtower, _interface, _engine, _party, __get__interfaceOverrides, _handleUpdateRoomStateDelegate, __get__CONSTANTS, _handleBallLandedDelegate, _partycookieUpdateHandlerDelegate, _quest, __get__partyCookie, _interfaceOverrides, __get__localPlayerAvatarID, __get__isInStateChangingRoom, _handleCollectFurniturePackDelegate, _snowballCoolDownExpirationDate, __get__snowballCoolDownExpirationDate, __get__isActive, __get__isIcePalaceAvailable, __get__isSnowballEnabled, __get__partyIconVisible, __get__snowballCoolDownRemainderPercentage;
    function FrozenParty()
    {
    } // End of the function
    static function init()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("FROZEN PARTY - INIT");
        _isActive = true;
        _shell = _global.getCurrentShell();
        _airtower = _global.getCurrentAirtower();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        _party = _global.getCurrentParty();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.initPartyAvatars();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().init();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.activateInterfaceOverrides();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.activateEngineOverrides();
        _handleUpdateRoomStateDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._this, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.handleUpdateRoomState);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.addListener(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().UPDATE_ROOM_STATE, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._handleUpdateRoomStateDelegate);
        _handleBallLandedDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._this, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.onSnowballLand);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.addListener(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.BALL_LAND, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._handleBallLandedDelegate);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.init();
        _partycookieUpdateHandlerDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._this, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.partycookieUpdateHandler);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.addListener("partycookie", com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._partycookieUpdateHandlerDelegate);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.sendRequestPartyCookie();
    } // End of the function
    static function partycookieUpdateHandler()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.removeListener("partycookie", com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._partycookieUpdateHandlerDelegate);
        com.clubpenguin.party.BaseParty.partyIconState();
    } // End of the function
    static function destroy()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("FROZEN PARTY - destroy()");
        _isActive = false;
    } // End of the function
    static function configurePartySettings()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().ICE_PALACE_UNLOCK_DAY = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().PARTY_SERVICE.icePalaceUnlockDay;
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().ICE_PALACE_UNLOCK_TIME = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().PARTY_SERVICE.icePalaceUnlockTime;
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("CONSTANTS.ICE_PALACE_UNLOCK_DAY " + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().ICE_PALACE_UNLOCK_DAY);
        var _loc4 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().PARTY_SERVICE.questSettingList;
        _quest = new Array();
        for (var _loc3 = 0; _loc3 < _loc4.length; ++_loc3)
        {
            var _loc1 = new com.clubpenguin.world.rooms2014.frozen.vo.FrozenQuestRoomVO();
            var _loc2 = _loc4[_loc3];
            _loc1.roomId = _loc2.roomId;
            _loc1.snowflakeIds = _loc2.snowflakeIds;
            _loc1.memberItemId = _loc2.memberItemId;
            _loc1.nonMemberItemId = _loc2.nonmemberItemId;
            _loc1.createItemVOs();
            com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest.push(_loc1);
        } // end of for
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("configurePartySettings() _quest " + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest);
    } // End of the function
    static function get partyCookie()
    {
        //return ((com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO)(com.clubpenguin.party.BaseParty.serverCookie()));
    } // End of the function
    static function get isActive()
    {
        return (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._isActive);
    } // End of the function
    static function get CONSTANTS()
    {
        return (com.clubpenguin.party.BaseParty.CONSTANTS);
    } // End of the function
    static function pebug(msg, prefix)
    {
        com.clubpenguin.party.BaseParty.pebug(msg, prefix);
    } // End of the function
    static function playSound(ui, soundId, volume)
    {
        com.clubpenguin.party.BaseParty.playSound(ui, soundId, volume);
    } // End of the function
    static function checkForFirstTimeLogin(playerObj)
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("checkForFirstTimeLogin ");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("checkForFirstTimeLogin partycookie " + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie());
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getMyPlayerId() != playerObj.player_id || com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getRoomObject().room_id == 112 || com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie() == undefined)
        {
            return;
        } // end if
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().__get__msgViewedArray()[com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().LOGIN_MESSAGE_NUMBER] == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().MSG_NOT_VIEWED)
        {
            com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.showContent(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().LOGIN_PROMPT_PATH);
        } // end if
    } // End of the function
    static function showMemberItemOopsMessage()
    {
        _global.getCurrentInterface().showContent(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().OOPS_MEMBER_ITEM_MESSAGE);
    } // End of the function
    static function get interfaceOverrides()
    {
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interfaceOverrides == null)
        {
            _interfaceOverrides = new com.clubpenguin.world.rooms2014.frozen.party.FrozenParty_InterfaceOverrides();
        } // end if
        return (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interfaceOverrides);
    } // End of the function
    static function get partyIconVisible()
    {
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().__get__msgViewedArray()[com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().LOGIN_MESSAGE_NUMBER] == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().MSG_VIEWED)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    static function activateFirstTimeUserPartyFunctionality()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("activateFirstTimeUserPartyFunctionality");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.sendRequestPartyCookie();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._engine.getRoomMovieClip().room.configureFrozenRoomElements();
    } // End of the function
    static function get localPlayerAvatarID()
    {
        return (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getPlayerObjectById(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getMyPlayerId()).avatarVO.avatar_id);
    } // End of the function
    static function getSnowflakeIdsByRoomId(roomId)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest.length; ++_loc1)
        {
            var _loc2 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest[_loc1];
            if (roomId == _loc2.roomId)
            {
                return (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest[_loc1].snowflakeIds);
            } // end if
        } // end of for
        return;
    } // End of the function
    static function getRoomVOByRoomID(roomID)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest.length; ++_loc1)
        {
            var _loc2 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest[_loc1];
            if (roomID == _loc2.roomId)
            {
                return (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest[_loc1]);
            } // end if
        } // end of for
        return;
    } // End of the function
    static function get isInStateChangingRoom()
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest.length; ++_loc1)
        {
            var _loc2 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._quest[_loc1];
            if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getRoomObject().room_id == _loc2.roomId)
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    static function checkForElsaCharacterDialogue()
    {
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().__get__msgViewedArray()[com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().ELSA_MESSAGE_NUMBER] == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().MSG_NOT_VIEWED && com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getRoomObject().room_id == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().FIRST_PARTY_ROOM_ID)
        {
            com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.showContent(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().ELSA_PROMPT_PATH);
        } // end if
    } // End of the function
    static function hasFrozenPowers()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("partyCookie.freezingPowers " + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().__get__freezingPowers());
        //return (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.partyCookie().__get__freezingPowers() == 1 || com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__localPlayerAvatarID() == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().OLAF_TRANSFORMATION_ID || com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__localPlayerAvatarID() == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().MARSHMALLOW_TRANSFORMATION_ID ? (true) : (false));
    } // End of the function
    static function get isIcePalaceAvailable()
    {
        //return (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.CONSTANTS().PARTY_DAY >= com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().ICE_PALACE_UNLOCK_DAY);
    } // End of the function
    static function addSnowballBurst(snowballInfo)
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._engine.avatarManager.effectManager.playEffectAtLocation(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FREEZE_BURST, snowballInfo.x, snowballInfo.y);
    } // End of the function
    static function getSnowflakesForRoom(roomId)
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("getSnowflakesForRoom roomId" + roomId);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("getSnowflakesForRoom partyCookie.snowflakes" + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().__get__snowflakes());
        //return (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.partyCookie().__get__snowflakes() ? (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().getSnowflakesForRoom(roomId)) : (undefined));
    } // End of the function
    static function setSnowflakeCollectedForRoomAtIndex(roomId, offset)
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("setSnowflakeCollectedForRoomAtIndex: " + roomId + ", " + offset);
        var _loc1 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().getSnowflakesStartIndexForRoom(roomId);
        var _loc2 = _loc1 + offset;
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.checkIfAllSnowflakesCollected();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("setSnowflakeCollectedForRoomAtIndex partyCookie.snowflakes " + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().__get__snowflakes());
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.sendSnowflakeCollected(_loc2);
    } // End of the function
    static function checkIfAllSnowflakesCollected()
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().__get__snowflakes().length; ++_loc1)
        {
            if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__partyCookie().__get__snowflakes()[_loc1] == 0)
            {
                return;
            } // end if
        } // end of for
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("checkIfAllSnowflakesCollected() play PARTY_ICON collectedSparkles animation");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.PARTY_ICON._visible = true;
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.PARTY_ICON.collectedSparkles._currentframe == 1)
        {
            com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.PARTY_ICON.collectedSparkles.gotoAndStop(2);
        } // end if
    } // End of the function
    static function playPartyIconSparkles()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.PARTY_ICON._visible = true;
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.PARTY_ICON.collectedSparkles._currentframe == 1)
        {
            com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.PARTY_ICON.collectedSparkles.gotoAndStop(2);
        } // end if
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.sendSnowflakeCollectedBI(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getRoomObject().room_id, "frozen_snowflake");
    } // End of the function
    static function handleUpdateRoomState(data)
    {
        if (!com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__isInStateChangingRoom())
        {
            return;
        } // end if
        var _loc7 = Number(data[0]);
        var _loc4 = Number(data[1]);
        var _loc10 = Number(data[2]);
        var _loc6 = Number(data[3]);
        var _loc5 = Number(data[4]);
        var _loc3 = Number(data[5]);
        if (!isNaN(_loc7) && !isNaN(_loc4))
        {
            if (_loc6 == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().FREEZE_STATE)
            {
                if (!isNaN(_loc5) && !isNaN(_loc3))
                {
                    var _loc2 = {};
                    _loc2.player_id = _loc4;
                    _loc2.x = _loc5;
                    _loc2.y = _loc3;
                    var _loc9 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.playerIndexInRoom(_loc2.player_id);
                    var _loc8 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getPlayerList();
                    _loc8[_loc9].frame = 1;
                    com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.handleThrowFrozenBall(_loc2);
                }
                else
                {
                    com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.$e("[shell] handlePlayerThrowBall() -> The snowballs xpos or ypos was NaN. xpos: " + _loc3 + " ypos: " + _loc3);
                } // end if
            } // end else if
            if (_loc6 == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().THAW_STATE)
            {
            } // end if
        }
        else
        {
            com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.$e("[shell] handlePlayerThrowBall() -> Did not receive a valid player id or smart room id. player_id: " + _loc4 + " smart_room_id: " + _loc7);
        } // end else if
    } // End of the function
    static function handleThrowFrozenBall(event)
    {
        var _loc2 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getPlayerObjectById(event.player_id);
        _loc2.thrownSnowballInCurrentRoom = true;
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getMyPlayerId() != event.player_id)
        {
            com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._engine.snowballManager.throwBall(event.player_id, event.x, event.y, new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN, -100, 20));
        } // end if
    } // End of the function
    static function collectFurniturePack(collectButton)
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.sendCollectFurniturePack();
        _handleCollectFurniturePackDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._this, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.handleCollectFurniturePack, collectButton);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.addListener(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().COLLECT_FURNITURE_PACK_COMMAND, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._handleCollectFurniturePackDelegate);
    } // End of the function
    static function handleCollectFurniturePack(data, collectButton)
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.removeListener(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().COLLECT_FURNITURE_PACK_COMMAND, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._handleCollectFurniturePackDelegate);
        collectButton.gotoAndStop(2);
        _global.getCurrentShell().getFurnitureListFromServer(true);
        com.clubpenguin.util.TrackerAS2.getInstance().trackRewardEarned(com.clubpenguin.util.TrackerAS2.CURRENCY_ITEMS, -1, "999_FurnitureBundle", "Frozen Furniture Pack", com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getMyPlayerTotalCoins());
    } // End of the function
    static function initPartyAvatars()
    {
        var _loc2 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._engine.avatarManager.model;
        var _loc1 = _loc2.createAvatarFromTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID);
        _loc1.isSpriteTransformed = true;
        _loc1.defaultTransitionEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE;
        _loc1.defaultRevertEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE;
        _loc1.hasCustomPlayerCard = true;
        _loc1.canRevertToDefault = true;
        _loc1.attachItems = false;
        _loc1.hasColorVersions = false;
        _loc1.isMemberOnly = true;
        _loc1.spritePath = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().OLAF_TRANSFORMATION_TOKEN;
        _loc2.setAvatarTemplate(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().OLAF_TRANSFORMATION_ID, _loc1);
        var _loc3 = _loc1.clone();
        _loc3.spritePath = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().MARSHMALLOW_TRANSFORMATION_TOKEN;
        _loc2.setAvatarTemplate(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().MARSHMALLOW_TRANSFORMATION_ID, _loc3);
    } // End of the function
    static function requestOlafTransformation()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.sendTransformation(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().OLAF_TRANSFORMATION_ID);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.sendTransformBI("olaf");
    } // End of the function
    static function requestMarshmallowTransformation()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.sendTransformation(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().MARSHMALLOW_TRANSFORMATION_ID);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.sendTransformBI("marshmallow");
    } // End of the function
    static function onSnowballLand(snowballInfo)
    {
        if (snowballInfo.snowballType == com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN || snowballInfo.snowballType == com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FROZEN_LARGE)
        {
            com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.playSnowballImpact();
        } // end if
    } // End of the function
    static function get snowballCoolDownExpirationDate()
    {
        return (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._snowballCoolDownExpirationDate == undefined ? (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getPenguinStandardTime().getTime()) : (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._snowballCoolDownExpirationDate));
    } // End of the function
    static function startSnowballCoolDown()
    {
        _snowballCoolDownExpirationDate = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getPenguinStandardTime().getTime() + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().SNOWBALL_COOLDOWN;
    } // End of the function
    static function get isSnowballEnabled()
    {
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__snowballCoolDownExpirationDate() <= com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getPenguinStandardTime().getTime())
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    static function get snowballCoolDownRemainderPercentage()
    {
        var _loc3 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getPenguinStandardTime().getTime();
        var _loc2 = _loc3 - com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._snowballCoolDownExpirationDate;
        var _loc1 = 100 - Math.abs(Math.round(_loc2 / com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().SNOWBALL_COOLDOWN * 100));
        return (_loc1 == 0 ? (1) : (_loc1));
    } // End of the function
    static function activateInterfaceOverrides()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.PARTY_ICON.icon_Btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().partyIconOnRelease);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.updateAvatarCard = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().updateAvatarCard);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.revertAvatar = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().revertAvatar);
    } // End of the function
    static function activateEngineOverrides()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.pebug("activateEngineOverrides PARTY VERSION");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._engine.snowballManager = new com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySnowballManager(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._engine, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface);
    } // End of the function
    static function activateSnowballOverrides()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.showCrosshair = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().showCrosshair);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.doCrossHairRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().doCrossHairRelease);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.sendEmote = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().sendEmote);
    } // End of the function
    static function deactivateSnowballOverrides()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.doCrossHairRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().defaultDoCrossHairRelease);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.showCrosshair = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().defaultShowCrosshair);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface.sendEmote = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._interface, com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__interfaceOverrides().defaultSendEmote);
    } // End of the function
    static function sendCollectFurniturePack()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.send(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().COLLECT_FURNITURE_PACK_COMMAND, [0], "str", com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getCurrentServerRoomId());
    } // End of the function
    static function sendGetConcertCountdown()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.send(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().REQUEST_CONCERT_COUNTDOWN, [0], "str", com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getCurrentServerRoomId());
    } // End of the function
    static function sendSnowflakeCollected(snowflakeIndex)
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.send(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().SNOWFLAKE_FOUND, [snowflakeIndex], "str", com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getCurrentServerRoomId());
    } // End of the function
    static function sendUpdateRoomState(sectionId, sectionState, x, y)
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.send(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().UPDATE_ROOM_STATE, [sectionId, sectionState, x, y], "str", com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getCurrentServerRoomId());
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.sendRoomStateUpdateBI(sectionState == 0 ? ("thawed") : ("frozen"));
    } // End of the function
    static function sendActivateFreezingPower()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.send(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().ACTIVE_FREEZING_POWER, [0], "str", com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getCurrentServerRoomId());
    } // End of the function
    static function sendTransformation(id)
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.send(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().SET_FROZEN_TRANSFORM, [id], "str", com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getCurrentServerRoomId());
    } // End of the function
    static function sendRequestPartyCookie()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.send(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#partycookie", [0], "str", com.clubpenguin.world.rooms2014.frozen.party.FrozenParty._shell.getCurrentServerRoomId());
    } // End of the function
    static function sendElsaAttendPerformanceBI()
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("Let It Go!", "attend_room_performance");
    } // End of the function
    static function sendTransformBI(transformName)
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(transformName, "avatar_transform");
        com.clubpenguin.util.TrackerAS2.getInstance().trackStepTimingEvent("avatar_transform_" + transformName, "start");
    } // End of the function
    static function sendUnTransformBI()
    {
        var _loc1;
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__localPlayerAvatarID() == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().OLAF_TRANSFORMATION_ID)
        {
            _loc1 = "olaf";
        } // end if
        if (com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__localPlayerAvatarID() == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().MARSHMALLOW_TRANSFORMATION_ID)
        {
            _loc1 = "marshmallow";
        } // end if
        com.clubpenguin.util.TrackerAS2.getInstance().trackStepTimingEvent("avatar_transform_" + _loc1, "end");
    } // End of the function
    static function sendRoomStateUpdateBI(state)
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(state, "room_asset_effect");
    } // End of the function
    static function sendGoThereBI(room)
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(room, "quest_go_there");
    } // End of the function
    static function sendOpenQuestBI()
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "quest_open");
    } // End of the function
    static function sendScrollQuestBI()
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "quest_ui_end");
    } // End of the function
    static function sendSnowflakeCollectedBI(questID, taskName)
    {
        var _loc2 = questID;
        var _loc1 = {message: taskName};
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_loc2, "quest_task", _loc1);
    } // End of the function
    static var CLASS_NAME = "FrozenParty";
    static var _this = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty;
    static var _isActive = false;
    static var _cookie = new com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO();
} // End of Class
