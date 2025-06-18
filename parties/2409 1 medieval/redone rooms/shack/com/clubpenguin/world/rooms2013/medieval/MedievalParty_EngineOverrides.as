//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.medieval.MedievalParty_EngineOverrides
    {
        var _shell, _airtower, _interface, _engine, _party, defaultUpdatePlayerFrame;
        function MedievalParty_EngineOverrides () {
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
            var mc = _engine.getPlayerMovieClip(player_id);
            var _local_3 = _shell.getPlayerObjectById(player_id);
            if (mc.blackHoleAnimPlaying == true) {
                return(undefined);
            }
            if (frame == undefined) {
                frame = mc.frame;
            }
            if (_engine.avatarManager.model.getTransformationData(_local_3.avatarVO.avatar_id).isSpriteTransformed) {
                mc.art_mc.gotoAndStop(1);
                mc.art_mc.gotoAndStop(frame);
                mc.secretFrame = frame;
                if (_local_3.avatarVO.attributes.isInvisible) {
                    _engine.playerRingCheck(player_id, mc.shadow_ring_mc);
                } else {
                    _engine.playerRingCheck(player_id, mc.art_mc);
                }
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
                _local_2 = _local_3.wave_frame;
            } else if ((frame == _shell.DANCE_FRAME) && (_local_3.avatarVO.avatar_id == com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID)) {
                if (mc[_local_3.dance_frame].loaded) {
                    _local_2 = _local_3.dance_frame;
                    mc.shadow_ring_mc.shadow_mc._visible = false;
                } else {
                    _local_2 = _shell.DANCE_FRAME;
                }
            } else {
                _local_2 = frame;
            }
            var _local_5 = String(mc.secretFrame);
            mc[_local_5]._visible = false;
            mc[_local_5]._x = -2000;
            mc[_local_5].stop();
            if (mc[String(_local_2)]) {
                mc.art_mc._visible = false;
                mc.art_mc.stop();
                mc.art_mc._x = -2000;
                mc[String(_local_2)]._visible = true;
                mc[String(_local_2)]._x = 0;
                mc[String(_local_2)].gotoAndStop(1);
                mc[String(_local_2)].gotoAndStop(2);
                mc.secretFrame = _local_2;
                _engine.playerRingCheck(player_id, mc[String(_local_2)]);
                _engine.updateColour(mc[String(_local_2)].body, mc.colour_id);
            } else {
                if (_local_3.avatarVO.attributes.isInvisible) {
                    mc.art_mc._visible = false;
                } else {
                    mc.art_mc._visible = true;
                }
                if (_local_3.avatarVO.attributes.isFloating && (!_local_3.avatarVO.attributes.isInvisible)) {
                    mc.shadow_ring_mc.shadow_mc._visible = false;
                } else {
                    mc.shadow_ring_mc.shadow_mc._visible = true;
                }
                _engine.playerRingCheck(player_id, mc.shadow_ring_mc);
                mc.art_mc.gotoAndStop(1);
                if (((((!_shell.getIsRoomIgloo()) && (_party.MedievalParty.instance.isStaticPenguinRequired(player_id))) && (_local_3.avatarVO.avatar_id != com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DRAGON_ID)) && (_local_2 >= (_shell.DANCE_FRAME + 1))) && (_local_2 <= (_shell.DANCE_FRAME + 4))) {
                    var _local_7 = _local_2 - _shell.DANCE_FRAME;
                    mc.art_mc.gotoAndStop(_local_7 * 2);
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
                if ((((!_shell.getIsRoomIgloo()) && (_party.MedievalParty.instance.isStaticPenguinRequired(player_id))) && (_local_2 >= (_shell.DANCE_FRAME + 1))) && (_local_2 <= (_shell.DANCE_FRAME + 4))) {
                    var _local_7 = _local_2 - _shell.DANCE_FRAME;
                    _local_2 = _local_7 * 2;
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
            _shell.setMyPlayerFrame(mc.frame);
        }
    }
