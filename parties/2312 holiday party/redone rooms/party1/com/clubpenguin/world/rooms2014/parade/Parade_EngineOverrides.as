//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.parade.Parade_EngineOverrides
    {
        var _shell, _airtower, _interface, _engine, defaultUpdatePlayerFrame;
        function Parade_EngineOverrides () {
        }
        function init() {
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            defaultUpdatePlayerFrame = _global.getCurrentEngine().updatePlayerFrame;
        }
        function hasVehicleItemEquipped(player_id) {
            return(isItemVehicle(player_id));
        }
        function isItemVehicle(player_id) {
            var _local_4 = _shell.getPlayerObjectById(player_id);
            var _local_3 = _local_4.body;
            var _local_2 = 0;
            while (_local_2 < VEHICLE_BODY_ITEM_IDS.length) {
                if (_local_3 == VEHICLE_BODY_ITEM_IDS[_local_2]) {
                    return(true);
                }
                _local_2++;
            }
            _local_3 = _local_4.hand;
            _local_2 = 0;
            while (_local_2 < VEHICLE_HAND_ITEM_IDS.length) {
                if (_local_3 == VEHICLE_HAND_ITEM_IDS[_local_2]) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function updatePlayerFrame(player_id, frame, is_action) {
            trace("updatePlayerFrame: Parade");
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
            var _local_7 = false;
            var _local_3;
            if (frame == _global.getCurrentEngine().SHELL.WAVE_FRAME) {
                com.clubpenguin.util.Log.debug("Player waving", com.clubpenguin.util.Log.ENGINE);
                _local_3 = _local_4.wave_frame;
                if (_local_4.avatarVO.isSpriteTransformed) {
                    _local_3 = _global.getCurrentEngine().SHELL.WAVE_FRAME;
                }
                if ((_local_4.wave_frame != _global.getCurrentEngine().SHELL.WAVE_FRAME) || (_local_4.avatarVO.isSpriteTransformed)) {
                    com.clubpenguin.util.Log.debug("\t-special waving or transformed sprite", com.clubpenguin.util.Log.ENGINE);
                    _local_7 = true;
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
                        _local_7 = true;
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
            var _local_8 = String(mc.secretFrame);
            mc[_local_8]._visible = false;
            mc[_local_8]._x = -2000;
            mc[_local_8].stop();
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
                if ((!mc.art_mc.hitTest(_global.getCurrentEngine().getRoomMovieClip().triggers_mc.float_mc)) && (!_local_7)) {
                    trace("off float mc");
                    _local_3 = PENGUIN_WADDLE_FRAME;
                }
                trace("After check state1");
                mc.art_mc._visible = !_local_4.avatarVO.attributes.isInvisible;
                mc.shadow_ring_mc.shadow_mc._visible = !_local_4.avatarVO.attributes.isFloating;
                _global.getCurrentEngine().playerRingCheck(player_id, mc.shadow_ring_mc);
                mc.art_mc.gotoAndStop(1);
                mc.art_mc.gotoAndStop(_local_3);
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
                trace("Before check state2");
                if ((!mc.art_mc.hitTest(_global.getCurrentEngine().getRoomMovieClip().triggers_mc.float_mc)) && (!_local_7)) {
                    trace("off float mc");
                    _local_3 = PENGUIN_WADDLE_FRAME;
                }
                trace("After check state2");
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
            trace("updatePlayerFrame: Parade Complete");
        }
        static var CLASS_NAME = "Parade_EngineOverrides";
        static var PENGUIN_FACING_RIGHT_FRAME = 7;
        static var PENGUIN_FIRST_WADDLE_FRAME = 9;
        static var PENGUIN_LAST_WADDLE_FRAME = 16;
        static var PENGUIN_WADDLE_FRAME = 15;
        static var PENGUIN_SIT_FRONT_CENTER = 17;
        static var PENGUIN_SIT_FRONT_LEFT = 18;
        static var PENGUIN_SIT_LEFT = 19;
        static var PENGUIN_SIT_BACK_LEFT = 20;
        static var PENGUIN_SIT_BACK_CENTER = 21;
        static var PENGUIN_SIT_BACK_RIGHT = 22;
        static var PENGUIN_SIT_RIGHT = 23;
        static var PENGUIN_SIT_FRONT_RIGHT = 24;
        static var VEHICLE_BODY_ITEM_IDS = new Array(4414, 4415, 14437, 4421, 4518, 4715, 4794, 4759, 4760, 4905, 14570, 4906);
        static var VEHICLE_HAND_ITEM_IDS = new Array(5344, 5346, 5345);
    }
