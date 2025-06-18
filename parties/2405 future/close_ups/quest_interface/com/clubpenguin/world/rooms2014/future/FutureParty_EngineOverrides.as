//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.future.FutureParty_EngineOverrides
    {
        var defaultUpdatePlayerFrame, defaultMovePlayer;
        function FutureParty_EngineOverrides () {
        }
        function init() {
            defaultUpdatePlayerFrame = _global.getCurrentEngine().updatePlayerFrame;
            defaultMovePlayer = _global.getCurrentEngine().movePlayer;
        }
        function updatePlayerFrame(player_id, frame, is_action) {
            var _this = this;
            var _local_6 = FutureParty;
            var mc = _this.getPlayerMovieClip(player_id);
            var _local_3 = _this.SHELL.getPlayerObjectById(player_id);
            if (mc.blackHoleAnimPlaying == true) {
                return(undefined);
            }
            if (frame == undefined) {
                frame = mc.frame;
            }
            if (_local_3.avatarVO.isSpriteTransformed) {
                mc.art_mc.gotoAndStop(1);
                mc.art_mc.gotoAndStop(frame);
                _local_6.MECHCONTROLLER.checkUpdateMechFrame(player_id, frame);
                mc.secretFrame = frame;
                _this.playerRingCheck(player_id, mc.shadow_ring_mc);
                if (is_action) {
                    _this.SHELL.setFrameHacked(player_id, false);
                    mc.frame = 1;
                } else {
                    mc.frame = frame;
                }
                if ((frame == _this.SHELL.WAVE_FRAME) && (_this.SHELL.isMyPlayer(_local_3.player_id))) {
                    if (_this.SHELL.playerModel.updateActionStatusWave()) {
                        com.clubpenguin.util.Log.debug(" -special waving for the first time", com.clubpenguin.util.Log.ENGINE);
                        _this.INTERFACE.firstTimeActionPerformed();
                        var _local_7 = _this.SHELL.AIRTOWER;
                        _this.AIRTOWER.send(_local_7.PLAY_EXT, (_local_7.NEW_USER_EXPERIENCE_HANDLER + "#") + _local_7.SEND_ACTION_WAVE, [], "str", _this.SHELL.getCurrentServerRoomId());
                    }
                }
                if (frame == _this.SHELL.DANCE_FRAME) {
                    _this.SHELL.playerModel.updateActionStatusDance();
                    _local_6.checkPlayerBlastoff(player_id);
                    if (_this.SHELL.isMyPlayer(_local_3.player_id)) {
                        if (_this.SHELL.playerModel.updateActionStatusDance()) {
                            com.clubpenguin.util.Log.debug("\t-special dancing for the first time", com.clubpenguin.util.Log.ENGINE);
                            _this.INTERFACE.firstTimeActionPerformed();
                            var _local_7 = _this.SHELL.AIRTOWER;
                            _local_7.send(_local_7.PLAY_EXT, (_local_7.NEW_USER_EXPERIENCE_HANDLER + "#") + _local_7.SEND_ACTION_DANCE, [], "str", _this.SHELL.getCurrentServerRoomId());
                        }
                    }
                }
                return(undefined);
            }
            var _local_2;
            if (frame == _this.SHELL.WAVE_FRAME) {
                _local_2 = _local_3.wave_frame;
                if (_local_3.avatarVO.isSpriteTransformed) {
                    _local_2 = _this.SHELL.WAVE_FRAME;
                }
                if ((_local_3.wave_frame != _this.SHELL.WAVE_FRAME) || (_local_3.avatarVO.isSpriteTransformed)) {
                    com.clubpenguin.util.Log.debug("\t-special waving or transformed sprite", com.clubpenguin.util.Log.ENGINE);
                    if (_this.SHELL.isMyPlayer(_local_3.player_id)) {
                        if (_this.SHELL.playerModel.updateActionStatusWave()) {
                            com.clubpenguin.util.Log.debug(" -special waving for the first time", com.clubpenguin.util.Log.ENGINE);
                            _this.INTERFACE.firstTimeActionPerformed();
                            var _local_7 = _this.SHELL.AIRTOWER;
                            _this.AIRTOWER.send(_local_7.PLAY_EXT, (_local_7.NEW_USER_EXPERIENCE_HANDLER + "#") + _local_7.SEND_ACTION_WAVE, [], "str", _this.SHELL.getCurrentServerRoomId());
                        }
                    }
                }
                _this.SHELL.updateListeners(_this.SHELL.PLAYER_WAVE_START, _local_3);
            } else if (frame == _this.SHELL.DANCE_FRAME) {
                _local_2 = _local_3.dance_frame;
                if (_local_3.avatarVO.isSpriteTransformed) {
                    _local_2 = _this.SHELL.DANCE_FRAME;
                }
                if (mc[_local_3.dance_frame].loaded || (_local_3.avatarVO.isSpriteTransformed)) {
                    com.clubpenguin.util.Log.debug("updating the dance frame to: " + _local_3.dance_frame, com.clubpenguin.util.Log.ENGINE);
                    if (_this.SHELL.isMyPlayer(_local_3.player_id)) {
                        if (_local_6.MECHCONTROLLER.isPlayerOnJetpack(player_id)) {
                            _local_6.checkPlayerBlastoff(player_id);
                        }
                        if (_this.SHELL.playerModel.updateActionStatusDance()) {
                            com.clubpenguin.util.Log.debug("\t-special dancing for the first time", com.clubpenguin.util.Log.ENGINE);
                            _this.INTERFACE.firstTimeActionPerformed();
                            var _local_7 = _this.SHELL.AIRTOWER;
                            _local_7.send(_local_7.PLAY_EXT, (_local_7.NEW_USER_EXPERIENCE_HANDLER + "#") + _local_7.SEND_ACTION_DANCE, [], "str", _this.SHELL.getCurrentServerRoomId());
                        }
                    }
                    mc.shadow_ring_mc.shadow_mc._visible = false;
                } else {
                    _local_2 = _this.SHELL.DANCE_FRAME;
                }
                _this.SHELL.updateListeners(_this.SHELL.PLAYER_DANCE_START, _local_3);
            } else if ((frame >= _this.MIN_SITTING_FRAME) && (frame <= _this.MAX_SITTING_FRAME)) {
                _this.SHELL.updateListeners(_this.SHELL.PLAYER_SIT_START, _local_3);
                _local_2 = frame;
            } else {
                _local_2 = frame;
            }
            var _local_8 = String(mc.secretFrame);
            mc[_local_8]._visible = false;
            mc[_local_8]._x = -2000;
            mc[_local_8].stop();
            if (mc[String(_local_2)]) {
                mc.art_mc._visible = false;
                mc.art_mc.stop();
                mc.art_mc._x = -2000;
                mc[String(_local_2)]._visible = !_local_3.avatarVO.attributes.isInvisible;
                mc[String(_local_2)]._x = 0;
                mc[String(_local_2)].gotoAndStop(1);
                mc[String(_local_2)].gotoAndStop(2);
                mc.secretFrame = _local_2;
                _this.playerRingCheck(player_id, mc[String(_local_2)]);
                _this.updateColour(mc[String(_local_2)].body, mc.colour_id);
            } else {
                mc.art_mc._visible = !_local_3.avatarVO.attributes.isInvisible;
                mc.shadow_ring_mc.shadow_mc._visible = !_local_3.avatarVO.attributes.isFloating;
                _this.playerRingCheck(player_id, mc.shadow_ring_mc);
                mc.art_mc.gotoAndStop(1);
                mc.art_mc.gotoAndStop(_local_2);
                mc.art_mc._x = 0;
                _this.updateColour(mc.art_mc.body, mc.colour_id);
            }
            if (((is_action && (_local_2 >= _this.SHELL.CJ_BOW_RIGHT_FRAME)) && (_local_2 <= _this.SHELL.CJ_BOW_RIGHT_FRAME_ANGLE_UP)) && (_local_2 != undefined)) {
                com.clubpenguin.util.Log.debug("setting the blackHoleAnimPlaying to true " + _local_2);
                mc.blackHoleAnimPlaying = true;
                _this.toggleClothingVisibility(false, mc);
                mc.art_mc.ring._visible = false;
                _this.getNicknameMovieClip(player_id)._visible = false;
                mc.art_mc.blackHole.onEnterFrame = com.clubpenguin.util.Delegate.create(this, function () {
                    mc.art_mc.blackHole.onEnterFrame = null;
                    var _local_3 = com.clubpenguin.util.Delegate.create(this, _this.onBlackHoleAnimationComplete, player_id);
                    mc.art_mc.blackHole.setAnimationCompleteCallback(_local_3, player_id);
                    var _local_2 = _this.SHELL.getPlayerHexFromId(mc.penguin_colour_id);
                    var _local_4 = _this.SHELL.getBeltColourHexFromRank(mc.belt_colour_id);
                    mc.art_mc.blackHole.setBodyColour(_local_2, _local_4);
                });
            } else {
                _this.updatePlayerItemFrame(mc.head_mc, _local_2);
                _this.updatePlayerItemFrame(mc.face_mc, _local_2);
                _this.updatePlayerItemFrame(mc.neck_mc, _local_2);
                _this.updatePlayerItemFrame(mc.body_mc, _local_2);
                _this.updatePlayerItemFrame(mc.hand_mc, _local_2);
                _this.updatePlayerItemFrame(mc.feet_mc, _local_2);
                _this.updatePlayerItemFrame(mc.head_mc, _local_2);
            }
            if (is_action) {
                _this.SHELL.setFrameHacked(player_id, false);
                mc.frame = 1;
            } else {
                mc.frame = frame;
            }
            _local_3.frame = mc.frame;
            if (_this.SHELL.isMyPlayer(player_id)) {
                _this.SHELL.setMyPlayerFrame(mc.frame);
            }
            if ((_local_2 == _this.SHELL.DANCE_FRAME) && (_local_6.MECHCONTROLLER.isPlayerOnJetpack(player_id))) {
                _local_6.checkPlayerBlastoff(player_id);
            }
            if ((_local_6.inSpaceRoom && (((_local_2 >= 9) && (_local_2 <= 16)) || (_local_2 == _this.SHELL.DANCE_FRAME))) && (_local_6.MECHCONTROLLER.isPlayerOnJetpack(player_id))) {
                var _local_5;
                if ((_local_2 >= 9) && (_local_2 <= 16)) {
                    _local_5 = _local_2 - 8;
                }
                if (_local_2 == _this.SHELL.DANCE_FRAME) {
                    _local_5 = 1;
                }
                mc.art_mc.gotoAndStop(_local_5);
                _this.updatePlayerItemFrame(mc.head_mc, _local_5);
                _this.updatePlayerItemFrame(mc.face_mc, _local_5);
                _this.updatePlayerItemFrame(mc.neck_mc, _local_5);
                _this.updatePlayerItemFrame(mc.body_mc, _local_5);
                _this.updatePlayerItemFrame(mc.hand_mc, _local_5);
                _this.updatePlayerItemFrame(mc.feet_mc, _local_5);
                _this.updatePlayerItemFrame(mc.head_mc, _local_5);
                _this.SHELL.setMyPlayerFrame(_local_5);
                _this.updateColour(mc.art_mc.body, mc.colour_id);
            }
            mc.shadow_ring_mc.shadow_mc._visible = false;
        }
        function movePlayer(player_id, target_x, target_y, is_trigger, frame) {
            var _this = this;
            trace("ENGINE:movePlayer:" + player_id);
            if (_this.SHELL.isPlayerJumping(player_id)) {
                return(undefined);
            }
            var mc = _this.getPlayerMovieClip(player_id);
            var _local_4 = _this.SHELL.getPlayerObjectById(player_id);
            _local_4.hasNotMovedSince = -1;
            mc.cacheAsBitmap = false;
            mc.debug_mc.clear();
            if (mc.is_reading) {
                _this.removePlayerBook(player_id);
            }
            if (!mc.is_ready) {
                _this.updatePlayerPosition(player_id, target_x, target_y);
                return(undefined);
            }
            var start_x = Math.round(mc._x);
            var start_y = Math.round(mc._y);
            var _local_6 = _this.findDistance(start_x, start_y, target_x, target_y);
            if (_global.getCurrentShell().playerModel.isPlayerStealthModerator() && (_global.getCurrentShell().playerModel.isMyPlayer(player_id))) {
                var duration = (_local_6 / 32);
            } else {
                var duration = ((_local_6 / 4) * (100 / _local_4.avatarVO.attributes.spriteSpeed));
            }
            var _local_11 = _this.findAngle(start_x, start_y, target_x, target_y);
            var d = _this.findDirection(_local_11);
            var change_x = (target_x - start_x);
            var change_y = (target_y - start_y);
            if (is_trigger == undefined) {
                is_trigger = true;
            }
            var _local_7 = _this.getRoomMovieClip();
            var easeFunction = _local_7.easeMethod;
            if (easeFunction == undefined) {
                easeFunction = _this.mathLinearTween;
            }
            if ((_local_4.avatarVO.attributes.isFloating || ((!_global.getCurrentParty().FutureParty.MECHCONTROLLER.canPlayerBlastOff(player_id)) && (_global.getCurrentParty().FutureParty.inSpaceRoom))) || (_global.getCurrentShell().getRoomObject().room_id == 854)) {
                com.clubpenguin.util.Log.debug("use float movement");
                easeFunction = _this.mathEaseFloat;
            }
            var _local_12 = mc.is_moving;
            mc.is_moving = true;
            mc.lastMoveDirection = d;
            var _local_3;
            if (easeFunction == _this.mathEaseFloat) {
                _local_3 = d;
            } else {
                _local_3 = d + _this.MAX_STANDING_FRAME;
                if (_local_7.invertedPenguins) {
                    _local_3 = _local_3 + 4;
                    if (_local_3 > _this.MAX_WALKING_FRAME) {
                        var _local_10 = _this.MAX_STANDING_FRAME + (_local_3 - _this.MAX_WALKING_FRAME);
                        _local_3 = _local_10;
                    }
                }
            }
            _this.updatePlayerFrame(player_id, _local_3);
            var t = 0;
            _this.movingPlayers["p" + player_id] = mc;
            mc.updateMCPosition = function () {
                t++;
                if ((mc.is_moving && (t < duration)) && (((mc.frame >= _this.MIN_WALKING_FRAME) && (mc.frame <= _this.MAX_WALKING_FRAME)) || (easeFunction == _this.mathEaseFloat))) {
                    var _local_3;
                    var _local_2;
                    if (easeFunction == _this.mathEaseFloat) {
                        var _local_1 = easeFunction(t, start_x, target_x, start_y, target_y, duration);
                        _local_3 = _local_1.x;
                        _local_2 = _local_1.y;
                    } else {
                        _local_3 = Math.round(easeFunction(t, start_x, change_x, duration));
                        _local_2 = Math.round(easeFunction(t, start_y, change_y, duration));
                    }
                    _this.updatePlayerPosition(player_id, _local_3, _local_2);
                } else if (mc.is_moving && (t >= duration)) {
                    mc.is_moving = false;
                    _this.updatePlayerFrame(player_id, d);
                    _this.SHELL.sendPlayerMoveDone(player_id);
                    delete _this.movingPlayers["p" + player_id];
                    if (_this.SHELL.isMyPlayer(player_id)) {
                        var _local_4 = false;
                        _this.playerMoved.dispatch();
                        _this.setPlayerAction("wait");
                        if (is_trigger && (_this.isMouseActive())) {
                            _this.checkTrigger(mc);
                        }
                        if (frame != undefined) {
                            _this.sendPlayerFrame(frame);
                        }
                    }
                }
            };
            if (!_local_12) {
                _this.SHELL.updateListeners(_this.SHELL.PLAYER_MOVE_START, _local_4);
            }
        }
        static var CLASS_NAME = "FutureParty_EngineOverrides";
    }
