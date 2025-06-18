//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty_EngineOverrides
    {
        var _shell, _airtower, _interface, _engine, _party, defaultUpdatePlayerFrame;
        function PrehistoricParty_EngineOverrides () {
        }
        function init() {
            _shell = _global.getCurrent_shell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            defaultUpdatePlayerFrame = _engine.updatePlayerFrame;
        }
        function updatePlayerFrame(player_id, frame, is_action) {
            var _this = this;
            var mc = _this.getPlayerMovieClip(player_id);
            var _local_4 = _this.SHELL.getPlayerObjectById(player_id);
            if (mc.blackHoleAnimPlaying == true) {
                return(undefined);
            }
            if (frame == undefined) {
                frame = mc.frame;
            }
            var _local_3;
            if (frame == _this.SHELL.WAVE_FRAME) {
                _this.Log.debug("Player waving", _this.Log.ENGINE);
                _local_3 = _local_4.wave_frame;
                if (_local_4.avatarVO.isSpriteTransformed) {
                    _local_3 = _this.SHELL.WAVE_FRAME;
                }
                if ((_local_4.wave_frame != _this.SHELL.WAVE_FRAME) || (_local_4.avatarVO.isSpriteTransformed)) {
                    _this.Log.debug("\t-special waving or transformed sprite", _this.Log.ENGINE);
                    if (_this.SHELL.isMyPlayer(_local_4.player_id)) {
                        if (_this.SHELL.playerModel.updateActionStatusWave()) {
                            _this.Log.debug("\t\t-special waving for the first time", _this.Log.ENGINE);
                            _this.INTERFACE.firstTimeActionPerformed();
                            var _local_13 = _this.SHELL.AIRTOWER;
                            _this.AIRTOWER.send(_this.AIRTOWER.PLAY_EXT, (_this.AIRTOWER.NEW_USER_EXPERIENCE_HANDLER + "#") + _this.AIRTOWER.SEND_ACTION_WAVE, [], "str", _this.SHELL.getCurrentServerRoomId());
                        }
                    }
                }
                _this.SHELL.updateListeners(_this.SHELL.PLAYER_WAVE_START, _local_4);
            } else if (frame == _this.SHELL.DANCE_FRAME) {
                _this.Log.debug("Player dancing", _this.Log.ENGINE);
                _local_3 = _local_4.dance_frame;
                if (_local_4.avatarVO.isSpriteTransformed) {
                    _local_3 = _this.SHELL.DANCE_FRAME;
                }
                if (mc[_local_4.dance_frame].loaded || (_local_4.avatarVO.isSpriteTransformed)) {
                    _this.Log.debug("updating the dance frame to: " + _local_4.dance_frame, _this.Log.ENGINE);
                    if (_this.SHELL.isMyPlayer(_local_4.player_id)) {
                        if (_this.SHELL.playerModel.updateActionStatusDance()) {
                            _this.Log.debug("\t-special dancing for the first time", _this.Log.ENGINE);
                            _this.INTERFACE.firstTimeActionPerformed();
                            var _local_13 = _this.SHELL.AIRTOWER;
                            _this.AIRTOWER.send(_this.AIRTOWER.PLAY_EXT, (_this.AIRTOWER.NEW_USER_EXPERIENCE_HANDLER + "#") + _this.AIRTOWER.SEND_ACTION_DANCE, [], "str", _this.SHELL.getCurrentServerRoomId());
                        }
                    }
                    _this.Log.debug("Make the shadow invisible ", _this.Log.ENGINE);
                    mc.shadow_ring_mc.shadow_mc._visible = false;
                } else {
                    _local_3 = _this.SHELL.DANCE_FRAME;
                }
                _this.SHELL.updateListeners(_this.SHELL.PLAYER_DANCE_START, _local_4);
            } else {
                _local_3 = frame;
            }
            var _local_7 = String(mc.secretFrame);
            mc[_local_7]._visible = false;
            mc[_local_7]._x = -2000;
            mc[_local_7].stop();
            if (mc[String(_local_3)]) {
                mc.art_mc._visible = false;
                mc.art_mc.stop();
                mc.art_mc._x = -2000;
                mc[String(_local_3)]._visible = !_local_4.avatarVO.attributes.isInvisible;
                mc[String(_local_3)]._x = 0;
                mc[String(_local_3)].gotoAndStop(1);
                mc[String(_local_3)].gotoAndStop(2);
                mc.secretFrame = _local_3;
                _this.playerRingCheck(player_id, mc[String(_local_3)]);
                _this.updateColour(mc[String(_local_3)].body, mc.colour_id);
            } else {
                mc.art_mc._visible = !_local_4.avatarVO.attributes.isInvisible;
                mc.shadow_ring_mc.shadow_mc._visible = !_local_4.avatarVO.attributes.isFloating;
                _this.playerRingCheck(player_id, mc.shadow_ring_mc);
                mc.art_mc.gotoAndStop(1);
                mc.art_mc.gotoAndStop(_local_3);
                mc.art_mc._x = 0;
                _this.updateColour(mc.art_mc.body, mc.colour_id);
            }
            if ((is_action && (_local_3 >= _this.SHELL.CJ_BOW_RIGHT_FRAME)) && (_local_3 <= _this.SHELL.CJ_BOW_RIGHT_FRAME_ANGLE_UP)) {
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
                _this.updatePlayerItemFrame(mc.head_mc, _local_3);
                _this.updatePlayerItemFrame(mc.face_mc, _local_3);
                _this.updatePlayerItemFrame(mc.neck_mc, _local_3);
                _this.updatePlayerItemFrame(mc.body_mc, _local_3);
                var _local_8 = mc.hand_mc.puffle;
                PrehistoricParty.pebug("dinoEggAnimating=" + _local_8.dinoEggAnimating);
                if (!_local_8.dinoEggAnimating) {
                    PrehistoricParty.pebug(("_this.updatePlayerItemFrame(mc.hand_mc, " + _local_3) + ")");
                    _this.updatePlayerItemFrame(mc.hand_mc, _local_3);
                }
                _this.updatePlayerItemFrame(mc.feet_mc, _local_3);
                _this.updatePlayerItemFrame(mc.head_mc, _local_3);
                var PrehistoricParty = _global.getCurrentParty().PrehistoricParty;
                if ((player_id == _this.SHELL.getMyPlayerId()) && (PrehistoricParty.isDinoPuffleEggEquipped(player_id))) {
                    var _local_10 = _this.SHELL.getPlayerObjectById(player_id).hand;
                    var _local_5 = PrehistoricParty.getStateOfDinoPuffle(_local_10);
                    if ((_local_3 >= 9) && (_local_3 <= 17)) {
                        PrehistoricParty.pebug("Check what the state of the puffle is " + _local_5);
                        mc.hand_mc.puffle_onecrack._visible = false;
                        mc.hand_mc.puffle_twocracks._visible = false;
                        if ((_local_5 == 2) && (!PrehistoricParty.dinoEggAnimating)) {
                            mc.hand_mc.puffle_onecrack._visible = true;
                        }
                        if ((_local_5 == 3) && (!PrehistoricParty.dinoEggAnimating)) {
                            mc.hand_mc.puffle_twocracks._visible = true;
                        }
                    } else {
                        PrehistoricParty.pebug("f < 9 || f>17");
                        if ((_local_5 == 2) && (!PrehistoricParty.dinoEggAnimating)) {
                            mc.hand_mc.puffle.gotoAndStop("crack1");
                        }
                        if ((_local_5 == 3) && (!PrehistoricParty.dinoEggAnimating)) {
                            mc.hand_mc.puffle.gotoAndStop("crack2");
                        }
                    }
                } else {
                    mc.hand_mc.puffle_onecrack._visible = false;
                    mc.hand_mc.puffle_twocracks._visible = false;
                }
            }
            if (is_action) {
                _this.SHELL.setFrameHacked(player_id, false);
                mc.frame = 1;
            } else {
                mc.frame = frame;
            }
            _local_4.frame = mc.frame;
            if (_this.SHELL.isMyPlayer(player_id)) {
                _this.SHELL.setMyPlayerFrame(mc.frame);
            }
        }
    }
