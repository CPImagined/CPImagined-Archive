//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.september2.party.September2Party_EngineOverrides
    {
        var _engine, defaultUpdatePlayerFrame, defaultStartMouse;
        function September2Party_EngineOverrides () {
        }
        function init() {
            _engine = _global.getCurrentEngine();
            defaultUpdatePlayerFrame = _engine.updatePlayerFrame;
            defaultStartMouse = _engine.startMouse;
        }
        function updatePlayerFrame(player_id, frame, is_action) {
            var _local_4 = this;
            var _local_2 = _local_4.getPlayerMovieClip(player_id);
            var _local_5 = _local_4.SHELL.getPlayerObjectById(player_id);
            if (_local_2.blackHoleAnimPlaying == true) {
                return(undefined);
            }
            if (frame == undefined) {
                frame = _local_2.frame;
            }
            var _local_3;
            if (frame == _local_4.SHELL.WAVE_FRAME) {
                _local_3 = _local_5.wave_frame;
                _local_4.SHELL.updateListeners(_local_4.SHELL.PLAYER_WAVE_START, _local_5);
            } else if (frame == _local_4.SHELL.DANCE_FRAME) {
                _local_3 = _local_5.dance_frame;
                if (_local_2[_local_5.dance_frame].loaded) {
                    _local_2.shadow_ring_mc.shadow_mc._visible = false;
                } else {
                    _local_3 = _local_4.SHELL.DANCE_FRAME;
                }
                _local_4.SHELL.updateListeners(_local_4.SHELL.PLAYER_DANCE_START, _local_5);
            } else if ((frame >= MIN_SITTING_FRAME) && (frame <= MAX_SITTING_FRAME)) {
                _local_4.SHELL.updateListeners(_local_4.SHELL.PLAYER_SIT_START, _local_5);
                _local_3 = frame;
            } else {
                frame = com.clubpenguin.world.rooms2015.september2.party.September2Party.CONSTANTS.PENGUIN_WADDLE_FRAME;
                _local_3 = frame;
            }
            if (com.clubpenguin.world.rooms2015.september2.party.September2Party.isInValidSurfingState(_local_2, _local_3)) {
                _local_3 = com.clubpenguin.world.rooms2015.september2.party.September2Party.CONSTANTS.PENGUIN_FACING_RIGHT_FRAME;
            }
            if (com.clubpenguin.world.rooms2015.september2.party.September2Party.isInValidHighwayState(_local_2, _local_3)) {
                _local_3 = ((!com.clubpenguin.world.rooms2015.september2.party.September2Party.hasVehicleItemEquipped(player_id)) ? (com.clubpenguin.world.rooms2015.september2.party.September2Party.CONSTANTS.PENGUIN_WADDLE_FRAME) : (com.clubpenguin.world.rooms2015.september2.party.September2Party.CONSTANTS.PENGUIN_FACING_RIGHT_FRAME));
                if (_local_2.art_mc._currentframe != _local_3) {
                    _local_2.art_mc.gotoAndStop(_local_3);
                }
                if (_local_2.head_mc._currentframe != _local_3) {
                    _local_4.updatePlayerItemFrame(_local_2.head_mc, _local_3);
                    _local_4.updatePlayerItemFrame(_local_2.face_mc, _local_3);
                    _local_4.updatePlayerItemFrame(_local_2.neck_mc, _local_3);
                    _local_4.updatePlayerItemFrame(_local_2.body_mc, _local_3);
                    _local_4.updatePlayerItemFrame(_local_2.feet_mc, _local_3);
                    _local_4.updatePlayerItemFrame(_local_2.hand_mc, _local_3);
                }
            }
            if (com.clubpenguin.world.rooms2015.september2.party.September2Party.isInValidHighwayState(_local_2, _local_3) && (com.clubpenguin.world.rooms2015.september2.party.September2Party.vehicleIsSkateboard(player_id))) {
                _local_3 = 1;
                if (_local_2.art_mc._currentframe != _local_3) {
                    _local_2.art_mc.gotoAndStop(_local_3);
                }
                if (_local_2.head_mc._currentframe != _local_3) {
                    _local_4.updatePlayerItemFrame(_local_2.head_mc, _local_3);
                    _local_4.updatePlayerItemFrame(_local_2.face_mc, _local_3);
                    _local_4.updatePlayerItemFrame(_local_2.neck_mc, _local_3);
                    _local_4.updatePlayerItemFrame(_local_2.body_mc, _local_3);
                    _local_4.updatePlayerItemFrame(_local_2.feet_mc, _local_3);
                }
                _local_4.updatePlayerItemFrame(_local_2.hand_mc, com.clubpenguin.world.rooms2015.september2.party.September2Party.CONSTANTS.PENGUIN_WADDLE_FRAME);
            } else {
                if (_local_2.art_mc._currentframe != _local_3) {
                    _local_2.art_mc.gotoAndStop(_local_3);
                }
                if (_local_2.head_mc._currentframe != _local_3) {
                    _local_4.updatePlayerItemFrame(_local_2.head_mc, _local_3);
                    _local_4.updatePlayerItemFrame(_local_2.face_mc, _local_3);
                    _local_4.updatePlayerItemFrame(_local_2.neck_mc, _local_3);
                    _local_4.updatePlayerItemFrame(_local_2.body_mc, _local_3);
                    _local_4.updatePlayerItemFrame(_local_2.feet_mc, _local_3);
                    _local_4.updatePlayerItemFrame(_local_2.hand_mc, _local_3);
                }
            }
            var _local_8 = String(_local_2.secretFrame);
            _local_2[_local_8]._visible = false;
            _local_2[_local_8]._x = -2000;
            _local_2[_local_8].stop();
            if (_local_2[String(_local_3)]) {
                _local_2.art_mc._visible = false;
                _local_2.art_mc.stop();
                _local_2.art_mc._x = -2000;
                _local_2[String(_local_3)]._visible = !_local_5.avatarVO.attributes.isInvisible;
                _local_2[String(_local_3)]._x = 0;
                _local_2[String(_local_3)].gotoAndStop(1);
                _local_2[String(_local_3)].gotoAndStop(2);
                _local_2.secretFrame = _local_3;
                _local_4.playerRingCheck(player_id, _local_2[String(_local_3)]);
                _local_4.updateColour(_local_2[String(_local_3)].body, _local_2.colour_id);
            } else {
                _local_2.art_mc._visible = !_local_5.avatarVO.attributes.isInvisible;
                _local_2.shadow_ring_mc.shadow_mc._visible = !_local_5.avatarVO.attributes.isFloating;
                _local_4.playerRingCheck(player_id, _local_2.shadow_ring_mc);
                _local_2.art_mc.gotoAndStop(_local_3);
                _local_2.art_mc._x = 0;
                _local_4.updateColour(_local_2.art_mc.body, _local_2.colour_id);
            }
            if (is_action) {
                _local_4.SHELL.setFrameHacked(player_id, false);
                _local_2.frame = 1;
            } else {
                _local_2.frame = frame;
            }
            _local_5.frame = _local_2.frame;
            if (_local_4.SHELL.isMyPlayer(player_id)) {
                _local_4.SHELL.setMyPlayerFrame(_local_2.frame);
            }
        }
        var MIN_SITTING_FRAME = 17;
        var MAX_SITTING_FRAME = 24;
    }
