﻿//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty_EngineOverrides
    {
        var _shell, _airtower, _interface, _engine, _party, defaultUpdatePlayerFrame, defaultCheckIsValidPosition;
        function TeenBeachParty_EngineOverrides () {
        }
        function init() {
            trace("JC: TeenBeachParty_EngineOverrides init");
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            defaultUpdatePlayerFrame = _engine.updatePlayerFrame;
            defaultCheckIsValidPosition = _engine.checkIsValidPosition;
        }
        function updatePlayerFrame(player_id, frame, is_action) {
            trace("JC: TeenBeachParty_EngineOverrides UPDATE PLAYER FRAME OVERRIDE");
            if (_party.TeenBeachParty.instance.isPenguinOnWaterslide(player_id) && (is_action == undefined)) {
                return(undefined);
            }
            var mc = _engine.getPlayerMovieClip(player_id);
            var _local_4 = _shell.getPlayerObjectById(player_id);
            if (mc.blackHoleAnimPlaying == true) {
                return(undefined);
            }
            if (frame == undefined) {
                frame = mc.frame;
            }
            if (_engine.avatarManager.model.getAvatarData(_local_4.avatar_id).isSpriteTransformed) {
                trace((((("updatePlayerFrame frame: " + frame) + " playerObject.frame_hack: ") + _local_4.frame_hack) + " ") + getTimer());
                mc.art_mc.gotoAndStop(1);
                mc.art_mc.gotoAndStop(frame);
                mc.book_mc._visible = false;
                mc.head_mc._visible = false;
                mc.face_mc._visible = false;
                mc.hand_mc._visible = false;
                mc.neck_mc._visible = false;
                mc.body_mc._visible = false;
                mc.feet_mc._visible = false;
                mc.secretFrame = frame;
                _engine.playerRingCheck(player_id, mc.art_mc);
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
                _local_2 = _local_4.wave_frame;
            } else if (frame == _shell.DANCE_FRAME) {
                trace("Player dancing");
                if (mc[_local_4.dance_frame].loaded) {
                    trace("updating the dance frame to: " + _local_4.dance_frame);
                    _local_2 = _local_4.dance_frame;
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
                mc.art_mc._visible = true;
                mc.art_mc.gotoAndStop(1);
                if (_party.TeenBeachParty.instance.isInValidSurfingState(mc, _local_2)) {
                    _local_2 = _party.TeenBeachParty.PENGUIN_FACING_RIGHT_FRAME;
                }
                if (_party.TeenBeachParty.instance.isInValidHighwayState(mc, _local_2)) {
                    _local_2 = ((!_party.TeenBeachParty.instance.hasVehicleItemEquipped(player_id)) ? (_party.TeenBeachParty.PENGUIN_WADDLE_FRAME) : (_party.TeenBeachParty.PENGUIN_FACING_RIGHT_FRAME));
                }
                mc.art_mc.gotoAndStop(_local_2);
                mc.art_mc._x = 0;
                _engine.playerRingCheck(player_id, mc.art_mc);
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
                if (_party.TeenBeachParty.instance.isInValidSurfingState(mc, _local_2)) {
                    _local_2 = _party.TeenBeachParty.PENGUIN_FACING_RIGHT_FRAME;
                }
                if (_party.TeenBeachParty.instance.isInValidHighwayState(mc, _local_2)) {
                    _local_2 = ((!_party.TeenBeachParty.instance.hasVehicleItemEquipped(player_id)) ? (_party.TeenBeachParty.PENGUIN_WADDLE_FRAME) : (_party.TeenBeachParty.PENGUIN_FACING_RIGHT_FRAME));
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
        function checkIsValidPosition(x, y, player) {
            if (_engine.isNaN(x) || (_engine.isNaN(y))) {
                return(false);
            }
            if (_engine.avatarManager.model.getAvatarData(player.avatar_id).ignoresBlockLayer) {
                return(true);
            }
            if (player.player_id != _shell.getMyPlayerId()) {
                if (_shell.isPlayerMascotById(player.player_id)) {
                    return(true);
                }
            } else if (_party.TeenBeachParty.instance.isPlayerMascot) {
                return(true);
            }
            var _local_2 = _engine.getRoomBlockMovieClip();
            return(!_local_2.hitTest(x, y, true));
        }
    }
