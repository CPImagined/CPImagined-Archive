//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.epfparty.EPFParty_EngineOverrides
    {
        var _shell, _airtower, _interface, _engine, _party, defaultUpdatePlayerFrame, defaultCheckIsValidPosition;
        function EPFParty_EngineOverrides () {
        }
        function init() {
            com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug("EPFParty_EngineOverrides init", CLASS_NAME);
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            defaultUpdatePlayerFrame = _engine.updatePlayerFrame;
            defaultCheckIsValidPosition = _engine.checkIsValidPosition;
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
                com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug((((("updatePlayerFrame frame: " + frame) + " playerObject.frame_hack: ") + _local_3.frame_hack) + " ") + getTimer(), CLASS_NAME);
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
                com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug("Player waving", CLASS_NAME);
                _local_2 = _local_3.wave_frame;
                if (_local_3.avatarVO.isSpriteTransformed) {
                    _local_2 = _shell.WAVE_FRAME;
                }
                if ((_local_3.wave_frame != _shell.WAVE_FRAME) || (_local_3.avatarVO.isSpriteTransformed)) {
                    com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug("\t-special waving or is transformed", CLASS_NAME);
                    if (_shell.isMyPlayer(_local_3.player_id)) {
                        if (_shell.playerModel.updateActionStatusWave()) {
                            com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug("\t\t-special waving for the first time", CLASS_NAME);
                            _interface.firstTimeActionPerformed();
                            var _local_5 = _shell.AIRTOWER;
                            _local_5.send(_local_5.PLAY_EXT, (_local_5.NEW_USER_EXPERIENCE_HANDLER + "#") + _local_5.SEND_ACTION_WAVE, [], "str", _shell.getCurrentServerRoomId());
                        }
                    }
                }
            } else if (frame == _shell.DANCE_FRAME) {
                com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug("Player dancing", CLASS_NAME);
                _local_2 = _local_3.dance_frame;
                if (_local_3.avatarVO.isSpriteTransformed) {
                    _local_2 = _shell.DANCE_FRAME;
                }
                if (mc[_local_3.dance_frame].loaded || (_local_3.avatarVO.isSpriteTransformed)) {
                    com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug("updating the dance frame to: " + _local_3.dance_frame, CLASS_NAME);
                    if (_shell.isMyPlayer(_local_3.player_id)) {
                        if (_shell.playerModel.updateActionStatusDance()) {
                            com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug("\t-special dancing for the first time", CLASS_NAME);
                            _interface.firstTimeActionPerformed();
                            var _local_5 = _shell.AIRTOWER;
                            _local_5.send(_local_5.PLAY_EXT, (_local_5.NEW_USER_EXPERIENCE_HANDLER + "#") + _local_5.SEND_ACTION_DANCE, [], "str", _shell.getCurrentServerRoomId());
                        }
                    }
                    com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug("Make the shadow invisible ", CLASS_NAME);
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
                if ((com.clubpenguin.world.rooms2013.epfparty.boat.BoatController.isPlayerOnBoat(player_id) && (_local_2 >= 9)) && (_local_2 <= 16)) {
                    mc.art_mc.gotoAndStop(Number(_local_2 - 8));
                } else {
                    mc.art_mc.gotoAndStop(_local_2);
                }
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
                if ((com.clubpenguin.world.rooms2013.epfparty.boat.BoatController.isPlayerOnBoat(player_id) && (_local_2 >= 9)) && (_local_2 <= 16)) {
                    _local_2 = _local_2 - 8;
                }
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
            com.clubpenguin.world.rooms2013.epfparty.boat.BoatController.dispatchUpdatePlayerFrame(player_id);
        }
        static var CLASS_NAME = "EPFParty_EngineOverrides";
    }
