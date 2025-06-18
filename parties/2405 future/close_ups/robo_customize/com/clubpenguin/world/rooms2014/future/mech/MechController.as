//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.future.mech.MechController
    {
        static var _this, _shell, _airtower, _interface, _engine, _party;
        function MechController () {
        }
        static function init() {
            _this = com.clubpenguin.world.rooms2014.future.mech.MechController;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            com.clubpenguin.util.Log.debug("MechController.init()");
        }
        static function isPlayerMech(player_id) {
            if (player_id == undefined) {
                return(false);
            }
            var _local_1 = _shell.getPlayerObjectById(player_id).avatarVO.avatar_id;
            return((_local_1 >= _party.FutureParty.CONSTANTS.FIRST_MECH_ID) && (_local_1 <= _party.FutureParty.CONSTANTS.LAST_MECH_ID));
        }
        static function getRobotType(player_id) {
            var _local_1 = _shell.getPlayerObjectById(player_id).avatarVO.avatar_id;
            return(getRobotTypeFromAvatarId(_local_1));
        }
        static function getRobotTypeFromAvatarId(avatarId) {
            var _local_3 = 0;
            while (_local_3 < _party.FutureParty.CONSTANTS.ROBO_A_IDS.length) {
                com.clubpenguin.util.Log.debug("Type A id" + _party.FutureParty.CONSTANTS.ROBO_A_IDS[_local_3]);
                if (_party.FutureParty.CONSTANTS.ROBO_A_IDS[_local_3] == avatarId) {
                    return(_party.FutureParty.CONSTANTS.ROBO_TYPE_A);
                }
                _local_3++;
            }
            var _local_2 = 0;
            while (_local_2 < _party.FutureParty.CONSTANTS.ROBO_B_IDS.length) {
                com.clubpenguin.util.Log.debug("Type B id" + _party.FutureParty.CONSTANTS.ROBO_B_IDS[_local_2]);
                if (_party.FutureParty.CONSTANTS.ROBO_B_IDS[_local_2] == avatarId) {
                    return(_party.FutureParty.CONSTANTS.ROBO_TYPE_B);
                }
                _local_2++;
            }
            var _local_1 = 0;
            while (_local_1 < _party.FutureParty.CONSTANTS.ROBO_C_IDS.length) {
                com.clubpenguin.util.Log.debug("Type C id" + _party.FutureParty.CONSTANTS.ROBO_C_IDS[_local_1]);
                if (_party.FutureParty.CONSTANTS.ROBO_C_IDS[_local_1] == avatarId) {
                    return(_party.FutureParty.CONSTANTS.ROBO_TYPE_C);
                }
                _local_1++;
            }
            return(-1);
        }
        static function getRoboColourIdFromAvatarId(avatarId) {
            var _local_3 = 0;
            while (_local_3 < _party.FutureParty.CONSTANTS.ROBO_A_IDS.length) {
                if (_party.FutureParty.CONSTANTS.ROBO_A_IDS[_local_3] == avatarId) {
                    return(_local_3);
                }
                _local_3++;
            }
            var _local_2 = 0;
            while (_local_2 < _party.FutureParty.CONSTANTS.ROBO_B_IDS.length) {
                if (_party.FutureParty.CONSTANTS.ROBO_B_IDS[_local_2] == avatarId) {
                    return(_local_2);
                }
                _local_2++;
            }
            var _local_1 = 0;
            while (_local_1 < _party.FutureParty.CONSTANTS.ROBO_C_IDS.length) {
                if (_party.FutureParty.CONSTANTS.ROBO_C_IDS[_local_1] == avatarId) {
                    return(_local_1);
                }
                _local_1++;
            }
            return(-1);
        }
        static function isPlayerOnJetpack(player_id) {
            return(_shell.getPlayerObjectById(player_id).neck == _party.FutureParty.CONSTANTS.JETPACK_ITEM_ID);
        }
        static function canPlayerBlastOff(player_id) {
            return(_party.FutureParty.isFutureRoom && (isPlayerMech(player_id) || (isPlayerOnJetpack(player_id))));
        }
        static function triggerBlastoff(player_id) {
            com.clubpenguin.util.Log.debug("MechController.triggerBlastoff() " + player_id);
            if (_shell.getMyPlayerId() == player_id) {
                _engine.disableMouseMovement();
                _interface.stopQuickKeys();
            }
            var _local_2 = _engine.getPlayerMovieClip(player_id);
            var _local_3;
            var _local_4;
            var _local_5;
            if (isPlayerMech(player_id)) {
                _local_3 = (_party.FutureParty.inSpaceRoom ? (_local_2.art_mc.robot_space.robot) : (_local_2.art_mc.robot_land.robot));
                _local_4 = 2;
                _local_5 = _local_3._totalframes;
                var _local_6 = new com.clubpenguin.world.rooms2013.common.CallbackAnimation(_local_3, com.clubpenguin.util.Delegate.create(_this, tweenPlayer, player_id), _local_4, _local_5);
                return(undefined);
            }
            if (isPlayerOnJetpack(player_id)) {
                tweenPlayer(player_id);
            }
        }
        static function tweenPlayer(player_id) {
            com.clubpenguin.util.Log.debug("MechController.tweenPlayer() " + player_id);
            var _local_2 = _engine.getPlayerMovieClip(player_id);
            var _local_5 = _engine.getNicknameMovieClip(player_id);
            var _local_4 = (_party.FutureParty.inSpaceRoom ? (Stage.height) : 0);
            var _local_1 = _local_2._y / MECH_BLASTOFF_SPEED;
            com.clubpenguin.util.Log.debug("MechController.tweenSpeed " + _local_1);
            if (_party.FutureParty.inSpaceRoom) {
                _local_1 = _local_1 * 2;
            }
            com.greensock.TweenMax.to(_local_2, _local_1, {_x:_local_2._x, _y:_local_4, _xscale:(_party.FutureParty.inSpaceRoom ? 1 : 100), _yscale:(_party.FutureParty.inSpaceRoom ? 1 : 100), overwrite:true, onComplete:com.clubpenguin.util.Delegate.create(_this, sendContextualJoinRoom, _local_2._x, player_id)});
            com.greensock.TweenMax.to(_local_5, _local_1, {_x:_local_5._x, _y:_local_4});
            if (!_party.FutureParty.inSpaceRoom) {
                showBlastoffSmoke(player_id);
            }
        }
        static function sendContextualJoinRoom(xPos, player_id) {
            com.clubpenguin.util.Log.debug("MechController.sendContextualJoinRoom() " + player_id);
            var _local_1 = _shell.getRoomObject().room_id;
            if (_party.FutureParty.isIndoorFutureRoom) {
                showCeilingCrumble(xPos, 0);
            }
            if (_shell.getMyPlayerId() != player_id) {
                return(undefined);
            }
            _engine.enableMouseMovement();
            _interface.startQuickKeys();
            var _local_2;
            if ((_local_1 >= 856) && (_local_1 <= 858)) {
                _local_2 = 859;
            }
            if ((_local_1 >= 851) && (_local_1 <= 855)) {
                _local_2 = 860;
            }
            if ((_local_1 == 859) || (_local_1 == 860)) {
                _shell.sendJoinLastRoom();
                return(undefined);
            }
            if (_local_1 == 861) {
                _local_2 = 851;
            }
            var _local_3 = _shell.getRoomNameById(_local_2);
            _shell.sendJoinRoom(_local_3);
            _shell.attachIdleListeners();
        }
        static function checkUpdateMechFrame(player_id, frame) {
            if (!isPlayerMech(player_id)) {
                return(undefined);
            }
            var _local_1 = _engine.getPlayerMovieClip(player_id);
            var _local_4;
            if (_party.FutureParty.inSpaceRoom) {
                _local_1.art_mc.robot_land._visible = false;
                _local_1.art_mc.robot_land.gotoAndStop(1);
                _local_1.art_mc.robot_space._visible = true;
                _local_1.art_mc.robot_space.gotoAndStop(1);
                _local_1.art_mc.robot_space.gotoAndStop(frame);
            } else {
                _local_1.art_mc.robot_space._visible = false;
                _local_1.art_mc.robot_space.gotoAndStop(1);
                _local_1.art_mc.robot_land._visible = true;
                _local_1.art_mc.robot_land.gotoAndStop(1);
                _local_1.art_mc.robot_land.gotoAndStop(frame);
            }
        }
        static function showBlastoffSmoke(player_id) {
            var _local_1 = _shell.getPlayerObjectById(player_id);
            _engine.avatarManager.effectManager.playEffectForPlayer(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.BLASTOFF_SMOKE, _local_1);
        }
        static function showCeilingCrumble(xPos, yPos) {
            _engine.avatarManager.effectManager.playEffectAtLocation(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.CEILING_CRUMBLE, xPos, yPos);
        }
        static var MECH_BLASTOFF_SPEED = 750;
    }
