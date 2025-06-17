class com.clubpenguin.engine.avatar.transformation.AvatarTransformationManager
{
    var _SHELL, _ENGINE, _AIRTOWER, _INTERFACE, _avatarManager;
    function AvatarTransformationManager()
    {
        _SHELL = _global.getCurrentShell();
        _ENGINE = _global.getCurrentEngine();
        _AIRTOWER = _global.getCurrentAirtower();
        _INTERFACE = _global.getCurrentInterface();
        _avatarManager = _ENGINE.avatarManager;
        _SHELL.addListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, handlePlayerAvatarTransformed, this);
    } // End of the function
    function createAvatar(roomMC, player, mcName, depth)
    {
        var _loc2 = roomMC.createEmptyMovieClip(mcName, depth);
        var _loc4 = player.avatarVO;
        _loc2.createEmptyMovieClip("art_mc", 3);
        if (_loc4.attachItems)
        {
            this.attachItems(_loc2);
        } // end if
        _loc2.player_id = player.player_id;
        _loc2.nickname = player.nickname;
        _loc2.depth_id = depth;
        _loc2.frame = player.frame;
        _loc2.is_moving = false;
        _loc2.is_ready = false;
        _loc2.is_reading = false;
        _loc2.is_table = false;
        _loc2.blackHoleAnimPlaying = false;
        _loc2._visible = false;
        this.processAvatarAttributes(_loc2, player, _loc4);
        return (_loc2);
    } // End of the function
    function drawShadowAndRing(shadowAndRingMC, player)
    {
        var _loc7 = shadowAndRingMC.createEmptyMovieClip("shadow_mc", shadowAndRingMC.getNextHighestDepth());
        var _loc3 = 4278190080.000000;
        var _loc4 = 11250603;
        var _loc2 = 1;
        var _loc1 = new flash.geom.Point(0, 0);
        var _loc5 = 28.550000 * (player.avatarVO.shadowScaleX / 100);
        var _loc6 = 18.850000 * (player.avatarVO.shadowScaleY / 100);
        _loc7._alpha = 20;
        com.clubpenguin.util.DrawUtil.drawEllipse(_loc7, new flash.geom.Rectangle(_loc1.x, _loc1.y, _loc5, _loc6), _loc3, _loc4, _loc2);
        var _loc8 = shadowAndRingMC.createEmptyMovieClip("ring", shadowAndRingMC.getNextHighestDepth());
        _loc3 = 3381759;
        _loc4 = 3381759;
        _loc2 = 2;
        _loc5 = 32;
        _loc6 = 22;
        _loc8._visible = false;
        com.clubpenguin.util.DrawUtil.drawRing(_loc8, new flash.geom.Rectangle(_loc1.x, _loc1.y, _loc5, _loc6), _loc3, _loc4, _loc2);
    } // End of the function
    function processAvatarAttributes(avatarMC, player, avatar)
    {
        if (_global.getCurrentShell().playerModel.isPlayerStealthModeratorByID(avatarMC.player_id))
        {
            avatarMC._alpha = _global.getCurrentShell().playerModel.getMyPlayerObject().avatarAlpha;
        }
        else
        {
            avatarMC._alpha = player.avatarVO.attributes.spriteAlpha;
        } // end else if
        avatarMC._yscale = avatarMC._xscale = player.avatarVO.attributes.spriteScale;
        avatarMC.colour_id = -1;
    } // End of the function
    function attachItems(avatarMC)
    {
        if (avatarMC.head_mc == undefined)
        {
            avatarMC.createEmptyMovieClip("book_mc", BOOK_LAYER);
            avatarMC.createEmptyMovieClip("head_mc", HEAD_LAYER);
            avatarMC.createEmptyMovieClip("face_mc", FACE_LAYER);
            avatarMC.createEmptyMovieClip("hand_mc", HAND_LAYER);
            avatarMC.createEmptyMovieClip("neck_mc", NECK_LAYER);
            avatarMC.createEmptyMovieClip("body_mc", BODY_LAYER);
            avatarMC.createEmptyMovieClip("feet_mc", FEET_LAYER);
            avatarMC.createEmptyMovieClip("debug_mc", DEBUG_LAYER);
            avatarMC.book_mc._visible = false;
            avatarMC.head_mc._visible = false;
            avatarMC.face_mc._visible = false;
            avatarMC.hand_mc._visible = false;
            avatarMC.neck_mc._visible = false;
            avatarMC.body_mc._visible = false;
            avatarMC.feet_mc._visible = false;
            avatarMC.head = 0;
            avatarMC.face = 0;
            avatarMC.neck = 0;
            avatarMC.body = 0;
            avatarMC.hand = 0;
            avatarMC.feet = 0;
        }
        else
        {
            avatarMC.book_mc._visible = true;
            avatarMC.head_mc._visible = true;
            avatarMC.face_mc._visible = true;
            avatarMC.hand_mc._visible = true;
            avatarMC.neck_mc._visible = true;
            avatarMC.body_mc._visible = true;
            avatarMC.feet_mc._visible = true;
        } // end else if
    } // End of the function
    function detachItems(avatarMC)
    {
        if (avatarMC.head_mc != undefined)
        {
            avatarMC.book_mc.removeMovieClip();
            avatarMC.head_mc.removeMovieClip();
            avatarMC.face_mc.removeMovieClip();
            avatarMC.hand_mc.removeMovieClip();
            avatarMC.neck_mc.removeMovieClip();
            avatarMC.body_mc.removeMovieClip();
            avatarMC.feet_mc.removeMovieClip();
        } // end if
    } // End of the function
    function localTransformPlayer(player, avatarId, keepOldAttributes)
    {
        var _loc2 = player.avatarVO;
        var _loc4 = _ENGINE.avatarManager.model.createAvatarFromTemplate(avatarId);
        player.avatarVO = _loc4;
        if (keepOldAttributes != null && keepOldAttributes)
        {
            player.avatarVO.attributes = _loc2.attributes;
        } // end if
        return (this.transformPlayer(player, _loc2));
    } // End of the function
    function transformPlayer(player, previousAvatarVO)
    {
        var _loc14 = previousAvatarVO.avatar_id;
        var _loc6 = previousAvatarVO;
        var _loc4 = player.avatarVO;
        var _loc10 = new org.osflash.signals.Signal(Object, com.clubpenguin.engine.avatar.model.AvatarVO);
        var _loc5 = _ENGINE.getPlayerMovieClip(player.player_id);
        if (_loc4.attachItems)
        {
            this.attachItems(_loc5);
        }
        else
        {
            this.detachItems(_loc5);
        } // end else if
        this.processAvatarAttributes(_loc5, player, _loc4);
        var _loc7 = _loc4.getEffectTransition(_loc14);
        if (_loc4.avatar_id == com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID)
        {
            if (_loc7 == com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT)
            {
                _loc7 = _loc6.defaultRevertEffect;
            } // end if
            if (_loc6.revertSoundEffectSymbol != null && _SHELL.isMyPlayer(player))
            {
                var _loc11 = _global.getCurrentRoom().soundManager;
                var _loc8 = _loc11.getRegisteredSymbolId(_loc6.revertSoundEffectSymbol);
                if (_loc8 == null)
                {
                    _loc8 = _loc11.registerSymbolName(_loc6.revertSoundEffectSymbol);
                } // end if
                _loc11.playSound(_loc8, null, 100, null, null);
            } // end if
        } // end if
        if (_loc7 != com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT)
        {
            _avatarManager.__get__effectManager().playEffectForPlayer(_loc7, player);
        } // end if
        if (player.avatarVO.duration > 0)
        {
            _avatarManager.__get__expirationManager().addExpirationTimer(player.avatarVO.duration);
        }
        else if (_avatarManager.__get__expirationManager().__get__expirationTimer() != null && _SHELL.isMyPlayer(player.player_id))
        {
            _avatarManager.__get__expirationManager().stopExpirationTimer();
        } // end else if
        if (_SHELL.isMyPlayer(player.player_id))
        {
            if (player.avatarVO.isSpriteTransformed)
            {
                _INTERFACE.enableSpecialDance();
                _INTERFACE.enableSpecialWave();
            } // end if
        } // end if
        var _loc9 = _loc4.spritePath;
        if (_loc4.dynamicSpritePathFunc != null)
        {
            _loc9 = _loc4.dynamicSpritePathFunc(player);
        } // end if
        if (_loc6 == null || _loc9 != _loc6.spritePath || !player.isSpriteLoaded)
        {
            var _loc12 = com.clubpenguin.util.URLUtils.getCacheResetURL(_SHELL.getPath(_loc9));
            if (_loc4.hasColorVersions)
            {
                _loc12 = com.clubpenguin.util.StringUtils.replaceString("%color%", String(_SHELL.getPlayerColorName(player.colour_id)), _loc12);
            } // end if
            var _loc13 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _loc13.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onTransformLoadComplete, player, _loc4, _loc10));
            if (_SHELL.isMyPlayer(player.player_id))
            {
                _loc13.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, com.clubpenguin.util.Delegate.create(this, onTransformLoadProgress));
                _INTERFACE.showMembershipRemaining();
            } // end if
            if (_loc5.art_mc != undefined)
            {
                _loc5.art_mc.removeMovieClip();
            } // end if
            _loc5.createEmptyMovieClip("art_mc", 3);
            _loc13.loadClip(_loc12, _loc5.art_mc, "AvatarTransformationManager.as transformPlayer()");
            player.isSpriteLoaded = true;
            _loc5._visible = false;
        }
        else
        {
            this.onTransformLoadComplete(null, player, _loc4, _loc10);
        } // end else if
        return (_loc10);
    } // End of the function
    function onTransformLoadProgress(event)
    {
        var _loc2 = event.target;
        _SHELL.loadingScreenLoadProgress(_loc2.getBytesLoaded(), _loc2.getBytesTotal());
    } // End of the function
    function onTransformLoadComplete(event, player, newAvatar, completed)
    {
        var _loc4 = _ENGINE.getPlayerMovieClip(player.player_id);
        _loc4._visible = true;
        _loc4.art_mc.gotoAndStop(1);
        _loc4.art_mc.player_id = player.player_id;
        var _loc7 = _ENGINE.getRoomMovieClip();
        _ENGINE.scalePlayer(player);
        var _loc6 = _loc4.createEmptyMovieClip("shadow_ring_mc", 1);
        if (!_ENGINE.isPositionValid(player.x, player.y))
        {
            _ENGINE.movePlayerToSpawnLocation(player, false);
            if (_SHELL.isMyPlayer(player.player_id))
            {
                if (_SHELL.PARTY.CFCParty.isActive)
                {
                    var _loc5 = _global.getCurrentRoom().trainManager.getPlayerTrain(player.player_id);
                    if (_loc5 != null && _loc5.driverId != player.player_id)
                    {
                        _SHELL.sendPlayerMove(player.x, player.y);
                    } // end if
                }
                else
                {
                    _SHELL.sendPlayerMove(player.x, player.y);
                } // end if
            } // end else if
        }
        else
        {
            _ENGINE.updatePlayerPosition(player.player_id, player.x, player.y);
        } // end else if
        this.drawShadowAndRing(_loc6, player);
        _ENGINE.updatePlayer(player);
        _loc4.art_mc.hotspot.onRelease = com.clubpenguin.util.Delegate.create(_ENGINE, _ENGINE.clickPlayer, player.player_id, player.nickname);
        completed.dispatch(player, newAvatar);
        completed.removeAll();
    } // End of the function
    function sendTransformPlayer(avatarId)
    {
        _AIRTOWER.send(_AIRTOWER.PLAY_EXT, _AIRTOWER.PLAYER_TRANSFORMATION_HANDLER + "#" + _AIRTOWER.PLAYER_TRANSFORMATION, [avatarId], "str", _SHELL.getCurrentServerRoomId());
    } // End of the function
    function handlePlayerAvatarTransformed(eventData)
    {
        var _loc3 = _ENGINE.getPlayerMovieClip(eventData.player.player_id);
        if (_loc3 == undefined)
        {
            return;
        } // end if
        if (_SHELL.isMyPlayer(eventData.player.player_id))
        {
            if (_avatarManager.__get__expirationManager().__get__isActive())
            {
                _avatarManager.__get__expirationManager().stopExpirationTimer();
            } // end if
        } // end if
        if (_loc3 != undefined)
        {
            this.transformPlayer(eventData.player, eventData.previousAvatarVO);
        } // end if
        _SHELL.updateListeners(_SHELL.UPDATE_PLAYER, eventData.previousAvatarVO);
    } // End of the function
    var BOOK_LAYER = 270;
    var HEAD_LAYER = 260;
    var FACE_LAYER = 250;
    var HAND_LAYER = 240;
    var NECK_LAYER = 230;
    var BODY_LAYER = 220;
    var FEET_LAYER = 210;
    var DEBUG_LAYER = 300;
} // End of Class
