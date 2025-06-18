//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.july.party.JulyParty_EngineOverrides
    {
        function JulyParty_EngineOverrides () {
        }
        function sendPlayerAction(frame) {
            var _local_2 = this;
            var _local_3 = _local_2.SHELL.getMyPlayerId();
            if (_local_2.validateUpdateFrame(_local_3, frame)) {
                _local_2.updatePlayerFrame(_local_3, frame, true);
                _local_2.setPlayerAction("custom");
                _local_2.SHELL.sendPlayerAction(frame);
                var _local_4 = com.clubpenguin.world.rooms2015.july.party.JulyParty.localPlayerAvatarID;
                if (frame == _local_2.SHELL.WAVE_FRAME) {
                    if (_local_4 == com.clubpenguin.world.rooms2015.july.party.JulyParty.CONSTANTS.TRANSFORMATION_ID_BINGBONG) {
                        com.clubpenguin.world.rooms2015.july.party.JulyPartySounds.playBingBongWave();
                    }
                    if (_local_4 == com.clubpenguin.world.rooms2015.july.party.JulyParty.CONSTANTS.TRANSFORMATION_ID_UNICORN) {
                        com.clubpenguin.world.rooms2015.july.party.JulyPartySounds.playRainbowUnicornWave();
                    }
                }
            }
        }
        function sendPlayerFrame(frame) {
            com.clubpenguin.util.Log.debug("july send player frame " + frame);
            var _local_2 = this;
            var _local_4 = _local_2.SHELL.getMyPlayerId();
            if (_local_2.validateUpdateFrame(_local_4, frame)) {
                _local_2.SHELL.updateListeners(_local_2.SHELL.UPDATE_PLAYER, _local_2.SHELL.getMyPlayerObject());
                _local_2.updatePlayerFrame(_local_4, frame);
                _local_2.setPlayerAction("custom");
                _local_2.SHELL.sendPlayerFrame(frame);
                var _local_5 = com.clubpenguin.world.rooms2015.july.party.JulyParty.localPlayerAvatarID;
                if (frame == _local_2.SHELL.DANCE_FRAME) {
                    if (_local_5 == com.clubpenguin.world.rooms2015.july.party.JulyParty.CONSTANTS.TRANSFORMATION_ID_UNICORN) {
                        com.clubpenguin.world.rooms2015.july.party.JulyPartySounds.playUnicornDanceLoop();
                    }
                }
            }
        }
        function updatePlayerFrame(player_id, frame, is_action) {
            var _this = this;
            var _local_7 = com.clubpenguin.world.rooms2015.july.party.JulyParty.localPlayerAvatarID;
            if (_local_7 == com.clubpenguin.world.rooms2015.july.party.JulyParty.CONSTANTS.TRANSFORMATION_ID_UNICORN) {
                com.clubpenguin.world.rooms2015.july.party.JulyPartySounds.stopUnicornDanceLoop();
            }
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
                mc.secretFrame = frame;
                _this.playerRingCheck(player_id, mc.shadow_ring_mc);
                if (is_action) {
                    _this.SHELL.setFrameHacked(player_id, false);
                    mc.frame = 1;
                } else {
                    mc.frame = frame;
                }
                if ((frame == _this.SHELL.WAVE_FRAME) && (_this.SHELL.isMyPlayer(_local_3.player_id))) {
                    if (_local_7 == com.clubpenguin.world.rooms2015.july.party.JulyParty.CONSTANTS.TRANSFORMATION_ID_BINGBONG) {
                        com.clubpenguin.world.rooms2015.july.party.JulyPartySounds.playBingBongWave();
                    }
                    if (_local_7 == com.clubpenguin.world.rooms2015.july.party.JulyParty.CONSTANTS.TRANSFORMATION_ID_UNICORN) {
                        com.clubpenguin.world.rooms2015.july.party.JulyPartySounds.playRainbowUnicornWave();
                    }
                    if (_this.SHELL.playerModel.updateActionStatusWave()) {
                        com.clubpenguin.util.Log.debug(" -special waving for the first time", com.clubpenguin.util.Log.ENGINE);
                        _this.INTERFACE.firstTimeActionPerformed();
                        var _local_6 = _this.SHELL.AIRTOWER;
                        _this.AIRTOWER.send(_local_6.PLAY_EXT, (_local_6.NEW_USER_EXPERIENCE_HANDLER + "#") + _local_6.SEND_ACTION_WAVE, [], "str", _this.SHELL.getCurrentServerRoomId());
                    }
                }
                if (frame == _this.SHELL.DANCE_FRAME) {
                    _this.SHELL.playerModel.updateActionStatusDance();
                    if (_local_7 == com.clubpenguin.world.rooms2015.july.party.JulyParty.CONSTANTS.TRANSFORMATION_ID_UNICORN) {
                        com.clubpenguin.world.rooms2015.july.party.JulyPartySounds.playUnicornDanceLoop();
                    }
                    if (_this.SHELL.isMyPlayer(_local_3.player_id)) {
                        if (_this.SHELL.playerModel.updateActionStatusDance()) {
                            com.clubpenguin.util.Log.debug("\t-special dancing for the first time", com.clubpenguin.util.Log.ENGINE);
                            _this.INTERFACE.firstTimeActionPerformed();
                            var _local_6 = _this.SHELL.AIRTOWER;
                            _local_6.send(_local_6.PLAY_EXT, (_local_6.NEW_USER_EXPERIENCE_HANDLER + "#") + _local_6.SEND_ACTION_DANCE, [], "str", _this.SHELL.getCurrentServerRoomId());
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
                            var _local_6 = _this.SHELL.AIRTOWER;
                            _this.AIRTOWER.send(_local_6.PLAY_EXT, (_local_6.NEW_USER_EXPERIENCE_HANDLER + "#") + _local_6.SEND_ACTION_WAVE, [], "str", _this.SHELL.getCurrentServerRoomId());
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
                        if (_this.SHELL.playerModel.updateActionStatusDance()) {
                            com.clubpenguin.util.Log.debug("\t-special dancing for the first time", com.clubpenguin.util.Log.ENGINE);
                            _this.INTERFACE.firstTimeActionPerformed();
                            var _local_6 = _this.SHELL.AIRTOWER;
                            _local_6.send(_local_6.PLAY_EXT, (_local_6.NEW_USER_EXPERIENCE_HANDLER + "#") + _local_6.SEND_ACTION_DANCE, [], "str", _this.SHELL.getCurrentServerRoomId());
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
                var _local_9 = _this.SHELL.getPlayerObjectById(player_id).hand;
                if (com.clubpenguin.world.rooms.common.skateboard.SkateboardConstants.isSkateboard(_local_9)) {
                    var _local_5 = com.clubpenguin.world.rooms.common.skateboard.SkateboardConstants.getSkateboardFrame(_local_2);
                    mc.art_mc.gotoAndStop(_local_5);
                    _this.updatePlayerItemFrame(mc.head_mc, _local_5);
                    _this.updatePlayerItemFrame(mc.face_mc, _local_5);
                    _this.updatePlayerItemFrame(mc.neck_mc, _local_5);
                    _this.updatePlayerItemFrame(mc.body_mc, _local_5);
                    _this.updatePlayerItemFrame(mc.feet_mc, _local_5);
                    _this.updatePlayerItemFrame(mc.head_mc, _local_5);
                    _this.updatePlayerItemFrame(mc.hand_mc, _local_2);
                } else {
                    mc.art_mc.gotoAndStop(_local_2);
                    _this.updatePlayerItemFrame(mc.head_mc, _local_2);
                    _this.updatePlayerItemFrame(mc.face_mc, _local_2);
                    _this.updatePlayerItemFrame(mc.neck_mc, _local_2);
                    _this.updatePlayerItemFrame(mc.body_mc, _local_2);
                    _this.updatePlayerItemFrame(mc.hand_mc, _local_2);
                    _this.updatePlayerItemFrame(mc.feet_mc, _local_2);
                    _this.updatePlayerItemFrame(mc.head_mc, _local_2);
                }
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
            mc.shadow_ring_mc.shadow_mc._visible = false;
        }
        static var CLASS_NAME = "JulyParty_EngineOverrides";
    }
