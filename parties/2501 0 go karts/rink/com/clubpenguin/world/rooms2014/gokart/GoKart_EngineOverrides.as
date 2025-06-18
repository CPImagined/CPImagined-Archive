//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.gokart.GoKart_EngineOverrides
    {
        var _propController, defaultUpdatePlayerFrame;
        function GoKart_EngineOverrides (controller) {
            controller = _propController;
        }
        function init() {
            defaultUpdatePlayerFrame = _global.getCurrentEngine().updatePlayerFrame;
        }
        function updatePlayerFrame(player_id, frame, is_action) {
            var mc = _global.getCurrentEngine().getPlayerMovieClip(player_id);
            var _local_4 = _global.getCurrentEngine().SHELL.getPlayerObjectById(player_id);
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
                _global.getCurrentEngine()._global.getCurrentEngine().playerRingCheck(player_id, mc.shadow_ring_mc);
                if (is_action) {
                    _global.getCurrentEngine().SHELL.setFrameHacked(player_id, false);
                    mc.frame = 1;
                } else {
                    mc.frame = frame;
                }
                return(undefined);
            }
            var _local_3;
            if (frame == _global.getCurrentEngine().SHELL.WAVE_FRAME) {
                com.clubpenguin.util.Log.debug("Player waving", com.clubpenguin.util.Log.ENGINE);
                _local_3 = _local_4.wave_frame;
                if (_local_4.avatarVO.isSpriteTransformed) {
                    _local_3 = _global.getCurrentEngine().SHELL.WAVE_FRAME;
                }
                if ((_local_4.wave_frame != _global.getCurrentEngine().SHELL.WAVE_FRAME) || (_local_4.avatarVO.isSpriteTransformed)) {
                    com.clubpenguin.util.Log.debug("\t-special waving or transformed sprite", com.clubpenguin.util.Log.ENGINE);
                    if (_global.getCurrentEngine().SHELL.isMyPlayer(_local_4.player_id)) {
                        if (_global.getCurrentEngine().SHELL.playerModel.updateActionStatusWave()) {
                            com.clubpenguin.util.Log.debug("\t\t-special waving for the first time", com.clubpenguin.util.Log.ENGINE);
                            _global.getCurrentEngine().INTERFACE.firstTimeActionPerformed();
                            var _local_6 = _global.getCurrentEngine().SHELL.AIRTOWER;
                            _local_6.send(_local_6.PLAY_EXT, (_local_6.NEW_USER_EXPERIENCE_HANDLER + "#") + _local_6.SEND_ACTION_WAVE, [], "str", _global.getCurrentEngine().SHELL.getCurrentServerRoomId());
                        }
                    }
                }
            } else if (frame == _global.getCurrentEngine().SHELL.DANCE_FRAME) {
                com.clubpenguin.util.Log.debug("Player dancing", com.clubpenguin.util.Log.ENGINE);
                _local_3 = _local_4.dance_frame;
                if (_local_4.avatarVO.isSpriteTransformed) {
                    _local_3 = _global.getCurrentEngine().SHELL.DANCE_FRAME;
                }
                if (mc[_local_4.dance_frame].loaded || (_local_4.avatarVO.isSpriteTransformed)) {
                    com.clubpenguin.util.Log.debug("updating the dance frame to: " + _local_4.dance_frame, com.clubpenguin.util.Log.ENGINE);
                    if (_global.getCurrentEngine().SHELL.isMyPlayer(_local_4.player_id)) {
                        if (_global.getCurrentEngine().SHELL.playerModel.updateActionStatusDance()) {
                            com.clubpenguin.util.Log.debug("\t-special dancing for the first time", com.clubpenguin.util.Log.ENGINE);
                            _global.getCurrentEngine().INTERFACE.firstTimeActionPerformed();
                            var _local_6 = _global.getCurrentEngine().SHELL.AIRTOWER;
                            _local_6.send(_local_6.PLAY_EXT, (_local_6.NEW_USER_EXPERIENCE_HANDLER + "#") + _local_6.SEND_ACTION_DANCE, [], "str", _global.getCurrentEngine().SHELL.getCurrentServerRoomId());
                        }
                    }
                    com.clubpenguin.util.Log.debug("Make the shadow invisible ", com.clubpenguin.util.Log.ENGINE);
                    mc.shadow_ring_mc.shadow_mc._visible = false;
                } else {
                    _local_3 = _global.getCurrentEngine().SHELL.DANCE_FRAME;
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
                _global.getCurrentEngine().playerRingCheck(player_id, mc[String(_local_3)]);
                _global.getCurrentEngine().updateColour(mc[String(_local_3)].body, mc.colour_id);
            } else {
                mc.art_mc._visible = !_local_4.avatarVO.attributes.isInvisible;
                mc.shadow_ring_mc.shadow_mc._visible = !_local_4.avatarVO.attributes.isFloating;
                _global.getCurrentEngine().playerRingCheck(player_id, mc.shadow_ring_mc);
                mc.art_mc.gotoAndStop(1);
                if ((_propController.isPlayerWithProp(player_id) && (_local_3 >= 9)) && (_local_3 <= 16)) {
                    mc.art_mc.gotoAndStop(Number(_local_3 - 8));
                } else {
                    mc.art_mc.gotoAndStop(_local_3);
                }
                mc.art_mc._x = 0;
                _global.getCurrentEngine().updateColour(mc.art_mc.body, mc.colour_id);
            }
            if ((is_action && (_local_3 >= _global.getCurrentEngine().SHELL.CJ_BOW_RIGHT_FRAME)) && (_local_3 <= _global.getCurrentEngine().SHELL.CJ_BOW_RIGHT_FRAME_ANGLE_UP)) {
                mc.blackHoleAnimPlaying = true;
                _global.getCurrentEngine().toggleClothingVisibility(false, mc);
                mc.art_mc.ring._visible = false;
                _global.getCurrentEngine().getNicknameMovieClip(player_id)._visible = false;
                mc.art_mc.blackHole.onEnterFrame = com.clubpenguin.util.Delegate.create(this, function () {
                    mc.art_mc.blackHole.onEnterFrame = null;
                    var _local_4 = com.clubpenguin.util.Delegate.create(this, _global.getCurrentEngine().onBlackHoleAnimationComplete, player_id);
                    mc.art_mc.blackHole.setAnimationCompleteCallback(_local_4, player_id);
                    var _local_3 = _global.getCurrentEngine().SHELL.getPlayerHexFromId(mc.penguin_colour_id);
                    var _local_5 = _global.getCurrentEngine().SHELL.getBeltColourHexFromRank(mc.belt_colour_id);
                    mc.art_mc.blackHole.setBodyColour(_local_3, _local_5);
                });
            } else {
                if ((_propController.isPlayerWithProp(player_id) && (_local_3 >= 9)) && (_local_3 <= 16)) {
                    _local_3 = _local_3 - 8;
                }
                _global.getCurrentEngine().updatePlayerItemFrame(mc.head_mc, _local_3);
                _global.getCurrentEngine().updatePlayerItemFrame(mc.face_mc, _local_3);
                _global.getCurrentEngine().updatePlayerItemFrame(mc.neck_mc, _local_3);
                _global.getCurrentEngine().updatePlayerItemFrame(mc.body_mc, _local_3);
                _global.getCurrentEngine().updatePlayerItemFrame(mc.hand_mc, _local_3);
                _global.getCurrentEngine().updatePlayerItemFrame(mc.feet_mc, _local_3);
                _global.getCurrentEngine().updatePlayerItemFrame(mc.head_mc, _local_3);
            }
            if (is_action) {
                _global.getCurrentEngine().SHELL.setFrameHacked(player_id, false);
                mc.frame = 1;
            } else {
                mc.frame = frame;
            }
            _local_4.frame = mc.frame;
            if (_global.getCurrentEngine().SHELL.isMyPlayer(player_id)) {
                _global.getCurrentEngine().SHELL.setMyPlayerFrame(mc.frame);
            }
            if (_global.getCurrentEngine().SHELL.getRoomObject().room_id == 856) {
                mc.art_mc._visible = false;
                mc.head_mc._visible = false;
                mc.hand_mc._visible = false;
                mc.feet_mc._visible = false;
                mc.body_mc._visible = false;
                mc.neck_mc._visible = false;
                mc.face_mc._visible = false;
            }
            com.clubpenguin.util.Log.debug("GoKart_EvergreenOverrides- sending dispatch update player frame");
            _propController.dispatchUpdatePlayerFrame(player_id);
            com.clubpenguin.party.BaseParty.dispatchUpdatePlayerFrame(player_id);
        }
        static var CLASS_NAME = "GoKart_EngineOverrides";
    }
