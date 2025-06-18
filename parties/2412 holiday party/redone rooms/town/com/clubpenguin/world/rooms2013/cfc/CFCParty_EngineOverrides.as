//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.CFCParty_EngineOverrides
    {
        var _shell, _airtower, _interface, _engine, _party, defaultUpdatePlayerFrame, defaultSendPlayerFrame;
        function CFCParty_EngineOverrides () {
        }
        function init() {
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            defaultUpdatePlayerFrame = _engine.updatePlayerFrame;
            defaultSendPlayerFrame = _engine.sendPlayerFrame;
        }
        function updatePlayerFrame(player_id, frame, is_action) {
            var mc = _engine.getPlayerMovieClip(player_id);
            var _local_3 = _shell.getPlayerObjectById(player_id);
            if (mc.blackHoleAnimPlaying == true) {
                return(undefined);
            }
            if (frame == undefined) {
                frame = mc.frame;
            }
            if (_local_3.isSpriteTransformed) {
                com.clubpenguin.util.Log.debug((((("updatePlayerFrame frame: " + frame) + " playerObject.frame_hack: ") + _local_3.frame_hack) + " ") + getTimer(), com.clubpenguin.util.Log.ENGINE);
                mc.art_mc.gotoAndStop(1);
                mc.art_mc.gotoAndStop(frame);
                mc.secretFrame = frame;
                _engine.playerRingCheck(player_id, mc.shadow_ring_mc);
                if (is_action) {
                    _shell.setFrameHacked(player_id, false);
                    mc.frame = 1;
                } else {
                    mc.frame = frame;
                }
                return(undefined);
            }
            var _local_2;
            if (frame == _shell.WAVE_FRAME) {
                com.clubpenguin.util.Log.debug("Player waving", com.clubpenguin.util.Log.ENGINE);
                _local_2 = _local_3.wave_frame;
                if (_local_3.avatarVO.isSpriteTransformed) {
                    _local_2 = _shell.WAVE_FRAME;
                }
                if ((_local_3.wave_frame != _shell.WAVE_FRAME) || (_local_3.avatarVO.isSpriteTransformed)) {
                    com.clubpenguin.util.Log.debug("\t-special waving or transformed sprite", com.clubpenguin.util.Log.ENGINE);
                    if (_shell.isMyPlayer(_local_3.player_id)) {
                        if (_shell.playerModel.updateActionStatusWave()) {
                            com.clubpenguin.util.Log.debug("\t\t-special waving for the first time", com.clubpenguin.util.Log.ENGINE);
                            _interface.firstTimeActionPerformed();
                            var _local_5 = _shell._airtower;
                            _local_5.send(_local_5.PLAY_EXT, (_local_5.NEW_USER_EXPERIENCE_HANDLER + "#") + _local_5.SEND_ACTION_WAVE, [], "str", _shell.getCurrentServerRoomId());
                        }
                    }
                }
            } else if (frame == _shell.DANCE_FRAME) {
                com.clubpenguin.util.Log.debug("Player dancing", com.clubpenguin.util.Log.ENGINE);
                _local_2 = _local_3.dance_frame;
                if (_local_3.avatarVO.isSpriteTransformed) {
                    _local_2 = _shell.DANCE_FRAME;
                }
                if (mc[_local_3.dance_frame].loaded || (_local_3.avatarVO.isSpriteTransformed)) {
                    com.clubpenguin.util.Log.debug("updating the dance frame to: " + _local_3.dance_frame, com.clubpenguin.util.Log.ENGINE);
                    if (_shell.isMyPlayer(_local_3.player_id)) {
                        if (_shell.playerModel.updateActionStatusDance()) {
                            com.clubpenguin.util.Log.debug("\t-special dancing for the first time", com.clubpenguin.util.Log.ENGINE);
                            _interface.firstTimeActionPerformed();
                            var _local_5 = _shell._airtower;
                            _local_5.send(_local_5.PLAY_EXT, (_local_5.NEW_USER_EXPERIENCE_HANDLER + "#") + _local_5.SEND_ACTION_DANCE, [], "str", _shell.getCurrentServerRoomId());
                        }
                    }
                    com.clubpenguin.util.Log.debug("Make the shadow invisible ", com.clubpenguin.util.Log.ENGINE);
                    mc.shadow_ring_mc.shadow_mc._visible = false;
                } else {
                    _local_2 = _shell.DANCE_FRAME;
                }
            } else {
                _local_2 = frame;
            }
            var _local_6 = String(mc.secretFrame);
            mc[_local_6]._visible = false;
            mc[_local_6]._x = -2000;
            mc[_local_6].stop();
            if (mc[String(_local_2)]) {
                mc.art_mc._visible = false;
                mc.art_mc.stop();
                mc.art_mc._x = -2000;
                mc[String(_local_2)]._visible = !_local_3.avatarVO.attributes.isInvisible;
                mc[String(_local_2)]._x = 0;
                mc[String(_local_2)].gotoAndStop(1);
                mc[String(_local_2)].gotoAndStop(2);
                mc.secretFrame = _local_2;
                _engine.playerRingCheck(player_id, mc[String(_local_2)]);
                _engine.updateColour(mc[String(_local_2)].body, mc.colour_id);
            } else {
                mc.art_mc._visible = !_local_3.avatarVO.attributes.isInvisible;
                mc.shadow_ring_mc.shadow_mc._visible = !_local_3.avatarVO.attributes.isFloating;
                _engine.playerRingCheck(player_id, mc.shadow_ring_mc);
                mc.art_mc.gotoAndStop(1);
                mc.art_mc.gotoAndStop(_local_2);
                mc.art_mc._x = 0;
                _engine.updateColour(mc.art_mc.body, mc.colour_id);
            }
            if ((is_action && (_local_2 >= _shell.CJ_BOW_RIGHT_FRAME)) && (_local_2 <= _shell.CJ_BOW_RIGHT_FRAME_ANGLE_UP)) {
                mc.blackHoleAnimPlaying = true;
                _engine.toggleClothingVisibility(false, mc);
                mc.art_mc.ring._visible = false;
                _engine.getNicknameMovieClip(player_id)._visible = false;
                mc.art_mc.blackHole.onEnterFrame = com.clubpenguin.util.Delegate.create(this, function () {
                    mc.art_mc.blackHole.onEnterFrame = null;
                    var _local_3 = com.clubpenguin.util.Delegate.create(this, this._engine.onBlackHoleAnimationComplete, player_id);
                    mc.art_mc.blackHole.setAnimationCompleteCallback(_local_3, player_id);
                    var _local_2 = this._shell.getPlayerHexFromId(mc.penguin_colour_id);
                    var _local_4 = this._shell.getBeltColourHexFromRank(mc.belt_colour_id);
                    mc.art_mc.blackHole.setBodyColour(_local_2, _local_4);
                });
            } else {
                _engine.updatePlayerItemFrame(mc.head_mc, _local_2);
                _engine.updatePlayerItemFrame(mc.face_mc, _local_2);
                _engine.updatePlayerItemFrame(mc.neck_mc, _local_2);
                _engine.updatePlayerItemFrame(mc.body_mc, _local_2);
                _engine.updatePlayerItemFrame(mc.hand_mc, _local_2);
                _engine.updatePlayerItemFrame(mc.feet_mc, _local_2);
                _engine.updatePlayerItemFrame(mc.head_mc, _local_2);
            }
            if (is_action) {
                _shell.setFrameHacked(player_id, false);
                mc.frame = 1;
            } else {
                mc.frame = frame;
            }
            _local_3.frame = mc.frame;
            if (_shell.isMyPlayer(player_id)) {
                _shell.setMyPlayerFrame(mc.frame);
            }
            _party.CFCParty.dispatchUpdatePlayerFrame(player_id);
        }
        function sendPlayerFrame(frame) {
            var _local_3 = this;
            var _local_6 = _local_3.SHELL.getMyPlayerId();
            if (_local_3.validateUpdateFrame(_local_6, frame)) {
                if (frame == _local_3.SHELL.DANCE_FRAME) {
                    var _local_4 = _global.getCurrentRoom().trainManager;
                    var _local_8 = _local_3.SHELL.getMyPlayerId();
                    if (_local_4.isPlayerADriver(_local_8)) {
                        var _local_5 = _local_4.getPlayerTrain(_local_8);
                        if ((_local_5 == null) || (_local_5.state == com.clubpenguin.world.rooms2013.cfc.trains.states.TrainStateEnum.DRIVING)) {
                            _local_4.service.sendOpenTrain();
                            return(undefined);
                        } else if (_local_5.state == com.clubpenguin.world.rooms2013.cfc.trains.states.TrainStateEnum.BOARDING) {
                            _local_4.service.sendCloseTrain();
                        }
                    }
                }
                _local_3.updatePlayerFrame(_local_6, frame);
                _local_3.setPlayerAction("custom");
                _local_3.SHELL.sendPlayerFrame(frame);
            }
        }
        function sendPlayerMove(x, y, is_trigger, frame) {
            var _local_2 = this;
            if (!_local_2.isMouseMovementEnabled) {
                return(undefined);
            }
            if (_local_2.SHELL._localLoginServerData.autoLogin) {
                _local_2.SHELL.sendAS2Clicked(_local_2.MOVE_CLICKED);
            }
            var _local_3 = _local_2.SHELL.getMyPlayerId();
            var _local_6 = _local_2.getPlayerMovieClip(_local_3);
            if (_local_2.SHELL.isPlayerJumping(_local_3) || (_local_2.SHELL.localPlayerIsJumping)) {
                return(undefined);
            }
            if (_local_2.SHELL.isPlayerJumping(_local_3) || (_local_2.SHELL.localPlayerIsJumping)) {
                return(undefined);
            }
            var _local_10 = Math.round(_local_6._x);
            var _local_9 = Math.round(_local_6._y);
            var _local_8 = _local_2.findPlayerPath(_local_3, x, y);
            var _local_4 = _local_8.x;
            var _local_5 = _local_8.y;
            var _local_7 = _local_2.findDistance(_local_10, _local_9, _local_4, _local_5);
            if (_local_7 > 10) {
                _local_2.setPlayerAction("move");
                _local_2.movePlayer(_local_3, _local_4, _local_5, is_trigger, frame);
                _local_2.SHELL.sendPlayerMove(_local_4, _local_5);
            } else if (frame != undefined) {
                _local_2.SHELL.sendPlayerFrame(frame);
            }
        }
        static var CLASS_NAME = "CFCParty_EngineOverrides";
    }
