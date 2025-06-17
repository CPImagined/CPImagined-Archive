//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.avatar.transformation.AvatarTransformationManager
    {
        var _SHELL, _ENGINE, _AIRTOWER, _INTERFACE, _avatarManager;
        function AvatarTransformationManager () {
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            _AIRTOWER = _global.getCurrentAirtower();
            _INTERFACE = _global.getCurrentInterface();
            _avatarManager = _ENGINE.avatarManager;
            _SHELL.addListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, handlePlayerAvatarTransformed, this);
        }
        function createAvatar(roomMC, player, mcName, depth) {
            var _local_2 = roomMC.createEmptyMovieClip(mcName, depth);
            var _local_4 = player.avatarVO;
            _local_2.createEmptyMovieClip("art_mc", 3);
            if (_local_4.attachItems) {
                attachItems(_local_2);
            }
            _local_2.player_id = player.player_id;
            _local_2.nickname = player.nickname;
            _local_2.depth_id = depth;
            _local_2.frame = player.frame;
            _local_2.is_moving = false;
            _local_2.is_ready = false;
            _local_2.is_reading = false;
            _local_2.is_table = false;
            _local_2.blackHoleAnimPlaying = false;
            _local_2._visible = false;
            processAvatarAttributes(_local_2, player, _local_4);
            return(_local_2);
        }
        function drawShadowAndRing(shadowAndRingMC, player) {
            var _local_7 = shadowAndRingMC.createEmptyMovieClip("shadow_mc", shadowAndRingMC.getNextHighestDepth());
            var _local_3 = 4278190080;
            var _local_4 = 11250603 /* 0xABABAB */;
            var _local_2 = 1;
            var _local_1 = new flash.geom.Point(0, 0);
            var _local_5 = 28.55 * (player.avatarVO.shadowScaleX / 100);
            var _local_6 = 18.85 * (player.avatarVO.shadowScaleY / 100);
            _local_7._alpha = 20;
            com.clubpenguin.util.DrawUtil.drawEllipse(_local_7, new flash.geom.Rectangle(_local_1.x, _local_1.y, _local_5, _local_6), _local_3, _local_4, _local_2);
            var _local_8 = shadowAndRingMC.createEmptyMovieClip("ring", shadowAndRingMC.getNextHighestDepth());
            _local_3 = 3381759 /* 0x3399FF */;
            _local_4 = 3381759 /* 0x3399FF */;
            _local_2 = 2;
            _local_5 = 32;
            _local_6 = 22;
            _local_8._visible = false;
            com.clubpenguin.util.DrawUtil.drawRing(_local_8, new flash.geom.Rectangle(_local_1.x, _local_1.y, _local_5, _local_6), _local_3, _local_4, _local_2);
        }
        function processAvatarAttributes(avatarMC, player, avatar) {
            if (_global.getCurrentShell().playerModel.isPlayerStealthModeratorByID(avatarMC.player_id)) {
                avatarMC._alpha = _global.getCurrentShell().playerModel.getMyPlayerObject().avatarAlpha;
            } else {
                avatarMC._alpha = player.avatarVO.attributes.spriteAlpha;
            }
            avatarMC._yscale = (avatarMC._xscale = player.avatarVO.attributes.spriteScale);
            avatarMC.colour_id = -1;
        }
        function attachItems(avatarMC) {
            if (avatarMC.head_mc == undefined) {
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
            } else {
                avatarMC.book_mc._visible = true;
                avatarMC.head_mc._visible = true;
                avatarMC.face_mc._visible = true;
                avatarMC.hand_mc._visible = true;
                avatarMC.neck_mc._visible = true;
                avatarMC.body_mc._visible = true;
                avatarMC.feet_mc._visible = true;
            }
        }
        function detachItems(avatarMC) {
            if (avatarMC.head_mc != undefined) {
                avatarMC.book_mc.removeMovieClip();
                avatarMC.head_mc.removeMovieClip();
                avatarMC.face_mc.removeMovieClip();
                avatarMC.hand_mc.removeMovieClip();
                avatarMC.neck_mc.removeMovieClip();
                avatarMC.body_mc.removeMovieClip();
                avatarMC.feet_mc.removeMovieClip();
            }
        }
        function localTransformPlayer(player, avatarId, keepOldAttributes) {
            var _local_2 = player.avatarVO;
            var _local_4 = _ENGINE.avatarManager.model.createAvatarFromTemplate(avatarId);
            player.avatarVO = _local_4;
            if ((keepOldAttributes != null) && (keepOldAttributes)) {
                player.avatarVO.attributes = _local_2.attributes;
            }
            return(transformPlayer(player, _local_2));
        }
        function transformPlayer(player, previousAvatarVO) {
            var _local_14 = previousAvatarVO.avatar_id;
            var _local_6 = previousAvatarVO;
            var _local_4 = player.avatarVO;
            var _local_10 = new org.osflash.signals.Signal(Object, com.clubpenguin.engine.avatar.model.AvatarVO);
            var _local_5 = _ENGINE.getPlayerMovieClip(player.player_id);
            if (_local_4.attachItems) {
                attachItems(_local_5);
            } else {
                detachItems(_local_5);
            }
            processAvatarAttributes(_local_5, player, _local_4);
            var _local_7 = _local_4.getEffectTransition(_local_14);
            if (_local_4.avatar_id == com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID) {
                if (_local_7 == com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT) {
                    _local_7 = _local_6.defaultRevertEffect;
                }
                if ((_local_6.revertSoundEffectSymbol != null) && (_SHELL.isMyPlayer(player))) {
                    var _local_11 = _global.getCurrentRoom().soundManager;
                    var _local_8 = _local_11.getRegisteredSymbolId(_local_6.revertSoundEffectSymbol);
                    if (_local_8 == null) {
                        _local_8 = _local_11.registerSymbolName(_local_6.revertSoundEffectSymbol);
                    }
                    _local_11.playSound(_local_8, null, 100, null, null);
                }
            }
            if (_local_7 != com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT) {
                _avatarManager.effectManager.playEffectForPlayer(_local_7, player);
            }
            if (player.avatarVO.duration > 0) {
                _avatarManager.expirationManager.addExpirationTimer(player.avatarVO.duration);
            } else if ((_avatarManager.expirationManager.expirationTimer != null) && (_SHELL.isMyPlayer(player.player_id))) {
                _avatarManager.expirationManager.stopExpirationTimer();
            }
            if (_SHELL.isMyPlayer(player.player_id)) {
                if (player.avatarVO.isSpriteTransformed) {
                    _INTERFACE.enableSpecialDance();
                    _INTERFACE.enableSpecialWave();
                }
            }
            var _local_9 = _local_4.spritePath;
            if (_local_4.dynamicSpritePathFunc != null) {
                _local_9 = _local_4.dynamicSpritePathFunc(player);
            }
            if (((_local_6 == null) || (_local_9 != _local_6.spritePath)) || (!player.isSpriteLoaded)) {
                var _local_12 = com.clubpenguin.util.URLUtils.getCacheResetURL(_SHELL.getPath(_local_9));
                if (_local_4.hasColorVersions) {
                    _local_12 = com.clubpenguin.util.StringUtils.replaceString("%color%", String(_SHELL.getPlayerColorName(player.colour_id)), _local_12);
                }
                var _local_13 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
                _local_13.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onTransformLoadComplete, player, _local_4, _local_10));
                if (_SHELL.isMyPlayer(player.player_id)) {
                    _local_13.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, com.clubpenguin.util.Delegate.create(this, onTransformLoadProgress));
                    _INTERFACE.showMembershipRemaining();
                }
                if (_local_5.art_mc != undefined) {
                    _local_5.art_mc.removeMovieClip();
                }
                _local_5.createEmptyMovieClip("art_mc", 3);
                _local_13.loadClip(_local_12, _local_5.art_mc, "AvatarTransformationManager.as transformPlayer()");
                player.isSpriteLoaded = true;
                _local_5._visible = false;
            } else {
                onTransformLoadComplete(null, player, _local_4, _local_10);
            }
            return(_local_10);
        }
        function onTransformLoadProgress(event) {
            var _local_2 = event.target;
            _SHELL.loadingScreenLoadProgress(_local_2.getBytesLoaded(), _local_2.getBytesTotal());
        }
        function onTransformLoadComplete(event, player, newAvatar, completed) {
            var _local_4 = _ENGINE.getPlayerMovieClip(player.player_id);
            _local_4._visible = true;
            _local_4.art_mc.gotoAndStop(1);
            _local_4.art_mc.player_id = player.player_id;
            var _local_7 = _ENGINE.getRoomMovieClip();
            _ENGINE.scalePlayer(player);
            var _local_6 = _local_4.createEmptyMovieClip("shadow_ring_mc", 1);
            if (!_ENGINE.isPositionValid(player.x, player.y)) {
                _ENGINE.movePlayerToSpawnLocation(player, false);
                if (_SHELL.isMyPlayer(player.player_id)) {
                    if (_SHELL.PARTY.CFCParty.isActive) {
                        var _local_5 = _global.getCurrentRoom().trainManager.getPlayerTrain(player.player_id);
                        if ((_local_5 != null) && (_local_5.driverId != player.player_id)) {
                            _SHELL.sendPlayerMove(player.x, player.y);
                        }
                    } else {
                        _SHELL.sendPlayerMove(player.x, player.y);
                    }
                }
            } else {
                _ENGINE.updatePlayerPosition(player.player_id, player.x, player.y);
            }
            drawShadowAndRing(_local_6, player);
            _ENGINE.updatePlayer(player);
            _local_4.art_mc.hotspot.onRelease = com.clubpenguin.util.Delegate.create(_ENGINE, _ENGINE.clickPlayer, player.player_id, player.nickname);
            completed.dispatch(player, newAvatar);
            completed.removeAll();
        }
        function sendTransformPlayer(avatarId) {
            _AIRTOWER.send(_AIRTOWER.PLAY_EXT, (_AIRTOWER.PLAYER_TRANSFORMATION_HANDLER + "#") + _AIRTOWER.PLAYER_TRANSFORMATION, [avatarId], "str", _SHELL.getCurrentServerRoomId());
        }
        function handlePlayerAvatarTransformed(eventData) {
            var _local_3 = _ENGINE.getPlayerMovieClip(eventData.player.player_id);
            if (_local_3 == undefined) {
                return(undefined);
            }
            if (_SHELL.isMyPlayer(eventData.player.player_id)) {
                if (_avatarManager.expirationManager.isActive) {
                    _avatarManager.expirationManager.stopExpirationTimer();
                }
            }
            if (_local_3 != undefined) {
                transformPlayer(eventData.player, eventData.previousAvatarVO);
            }
            _SHELL.updateListeners(_SHELL.UPDATE_PLAYER, eventData.previousAvatarVO);
        }
        var BOOK_LAYER = 270;
        var HEAD_LAYER = 260;
        var FACE_LAYER = 250;
        var HAND_LAYER = 240;
        var NECK_LAYER = 230;
        var BODY_LAYER = 220;
        var FEET_LAYER = 210;
        var DEBUG_LAYER = 300;
    }
