//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.may.party.MayParty_EngineOverrides
    {
        var defaultUpdatePlayerFrame;
        function MayParty_EngineOverrides () {
        }
        function init() {
            defaultUpdatePlayerFrame = _global.getCurrentEngine().updatePlayerFrame;
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
            if (_local_4.isSpriteTransformed) {
                com.clubpenguin.util.Log.debug((((("updatePlayerFrame frame: " + frame) + " playerObject.frame_hack: ") + _local_4.frame_hack) + " ") + getTimer(), com.clubpenguin.util.Log.ENGINE);
                mc.art_mc.gotoAndStop(1);
                mc.art_mc.gotoAndStop(frame);
                mc.secretFrame = frame;
                _this._this.playerRingCheck(player_id, mc.shadow_ring_mc);
                if (is_action) {
                    _this.SHELL.setFrameHacked(player_id, false);
                    mc.frame = 1;
                } else {
                    mc.frame = frame;
                }
                return(undefined);
            }
            var _local_3;
            if (frame == _this.SHELL.WAVE_FRAME) {
                com.clubpenguin.util.Log.debug("Player waving", com.clubpenguin.util.Log.ENGINE);
                _local_3 = _local_4.wave_frame;
                if (_local_4.avatarVO.isSpriteTransformed) {
                    _local_3 = _this.SHELL.WAVE_FRAME;
                }
                if ((_local_4.wave_frame != _this.SHELL.WAVE_FRAME) || (_local_4.avatarVO.isSpriteTransformed)) {
                    com.clubpenguin.util.Log.debug("\t-special waving or transformed sprite", com.clubpenguin.util.Log.ENGINE);
                    if (_this.SHELL.isMyPlayer(_local_4.player_id)) {
                        if (_this.SHELL.playerModel.updateActionStatusWave()) {
                            com.clubpenguin.util.Log.debug("\t\t-special waving for the first time", com.clubpenguin.util.Log.ENGINE);
                            _this.INTERFACE.firstTimeActionPerformed();
                            var _local_6 = _this.SHELL.AIRTOWER;
                            _local_6.send(_local_6.PLAY_EXT, (_local_6.NEW_USER_EXPERIENCE_HANDLER + "#") + _local_6.SEND_ACTION_WAVE, [], "str", _this.SHELL.getCurrentServerRoomId());
                        }
                    }
                }
            } else if (frame == _this.SHELL.DANCE_FRAME) {
                com.clubpenguin.util.Log.debug("Player dancing", com.clubpenguin.util.Log.ENGINE);
                _local_3 = _local_4.dance_frame;
                if (_local_4.avatarVO.isSpriteTransformed) {
                    _local_3 = _this.SHELL.DANCE_FRAME;
                }
                if (mc[_local_4.dance_frame].loaded || (_local_4.avatarVO.isSpriteTransformed)) {
                    com.clubpenguin.util.Log.debug("updating the dance frame to: " + _local_4.dance_frame, com.clubpenguin.util.Log.ENGINE);
                    if (_this.SHELL.isMyPlayer(_local_4.player_id)) {
                        if (_this.SHELL.playerModel.updateActionStatusDance()) {
                            com.clubpenguin.util.Log.debug("\t-special dancing for the first time", com.clubpenguin.util.Log.ENGINE);
                            _this.INTERFACE.firstTimeActionPerformed();
                            var _local_6 = _this.SHELL.AIRTOWER;
                            _local_6.send(_local_6.PLAY_EXT, (_local_6.NEW_USER_EXPERIENCE_HANDLER + "#") + _local_6.SEND_ACTION_DANCE, [], "str", _this.SHELL.getCurrentServerRoomId());
                        }
                    }
                    com.clubpenguin.util.Log.debug("Make the shadow invisible ", com.clubpenguin.util.Log.ENGINE);
                    mc.shadow_ring_mc.shadow_mc._visible = false;
                } else {
                    _local_3 = _this.SHELL.DANCE_FRAME;
                }
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
                if ((com.clubpenguin.world.rooms2015.may.BoatController.isPlayerOnBoat(player_id) && (_local_3 >= 9)) && (_local_3 <= 16)) {
                    mc.art_mc.gotoAndStop(Number(_local_3 - 8));
                } else {
                    mc.art_mc.gotoAndStop(_local_3);
                }
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
                if ((com.clubpenguin.world.rooms2015.may.BoatController.isPlayerOnBoat(player_id) && (_local_3 >= 9)) && (_local_3 <= 16)) {
                    _local_3 = _local_3 - 8;
                }
                _this.updatePlayerItemFrame(mc.head_mc, _local_3);
                _this.updatePlayerItemFrame(mc.face_mc, _local_3);
                _this.updatePlayerItemFrame(mc.neck_mc, _local_3);
                _this.updatePlayerItemFrame(mc.body_mc, _local_3);
                _this.updatePlayerItemFrame(mc.hand_mc, _local_3);
                _this.updatePlayerItemFrame(mc.feet_mc, _local_3);
                _this.updatePlayerItemFrame(mc.head_mc, _local_3);
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
            if (_this.SHELL.getRoomObject().room_id == 856) {
                mc.art_mc._visible = false;
                mc.head_mc._visible = false;
                mc.hand_mc._visible = false;
                mc.feet_mc._visible = false;
                mc.body_mc._visible = false;
                mc.neck_mc._visible = false;
                mc.face_mc._visible = false;
            }
            com.clubpenguin.world.rooms2015.may.BoatController.dispatchUpdatePlayerFrame(player_id);
            _global.getCurrentParty().BaseParty.dispatchUpdatePlayerFrame(player_id);
        }
        static var CLASS_NAME = "MayParty_EngineOverrides";
    }
