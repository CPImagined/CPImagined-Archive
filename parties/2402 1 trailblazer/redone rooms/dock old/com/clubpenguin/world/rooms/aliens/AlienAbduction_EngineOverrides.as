//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides
    {
        static var _abductedPlayerID;
        var isInit, defaultMovePlayer, defaultSendPlayerMove, defaultUpdatePlayerPosition, defaultUpdatePlayerFrame;
        function AlienAbduction_EngineOverrides () {
            trace("AlienAbduction_EngineOverrides : CONSTRUCTOR");
        }
        function init(abductedPlayer) {
            if (isInit) {
                return(undefined);
            }
            isInit = true;
            trace("AlienAbduction_EngineOverrides init()");
            if (abductedPlayer) {
                _abductedPlayerID = abductedPlayer;
            }
            trace("*************** AlienAbduction_EngineOverrides  - _abductedPlayerID : " + _abductedPlayerID);
            defaultMovePlayer = _global.getCurrentEngine().movePlayer;
            defaultSendPlayerMove = _global.getCurrentEngine().sendPlayerMove;
            defaultUpdatePlayerPosition = _global.getCurrentEngine().updatePlayerPosition;
            defaultUpdatePlayerFrame = _global.getCurrentEngine().updatePlayerPosition;
        }
        function sendPlayerMove(x, y, is_trigger, frame) {
            var _local_2 = _global.getCurrentShell();
            var _local_3 = _global.getCurrentEngine();
            var _local_4 = _global.getCurrentShell().getMyPlayerId();
            trace("ENGINE_OVERRIDE:sendPlayerMove - _abductedPlayerID :" + _abductedPlayerID);
            trace("ENGINE_OVERRIDE:sendPlayerMove - player_id :" + _local_4);
            if (_local_4 == _abductedPlayerID) {
                trace("****ABDUCTION CODE sendPlayerMove*********************************");
                trace("******************************************************************");
                return(undefined);
            }
            trace("****NOT ABDUCTION CODE --- ENGINE:sendPlayerMove()");
            if (!_local_3.isMovementEnabled()) {
                return(undefined);
            }
            trace("\nSHELL: " + _local_2);
            trace("SHELL._localLoginServerData: " + _local_2._localLoginServerData);
            if (_local_2._localLoginServerData.autoLogin) {
                _local_2.sendAS2Clicked(_local_3.MOVE_CLICKED);
            }
            _local_4 = _local_2.getMyPlayerId();
            var _local_7 = _local_3.getPlayerMovieClip(_local_4);
            trace("player_id: " + _local_4);
            trace("mc: " + _local_7);
            if (_local_2.isPlayerJumping(_local_4) || (_local_2.localPlayerIsJumping)) {
                return(undefined);
            }
            if (_local_2.isPlayerJumping(_local_4) || (_local_2.localPlayerIsJumping)) {
                return(undefined);
            }
            var _local_9 = Math.round(_local_7._x);
            var _local_8 = Math.round(_local_7._y);
            trace("start_x: " + _local_9);
            trace("start_y: " + _local_8);
            var _local_11 = _local_3.findPlayerPath(_local_4, x, y);
            var _local_5 = _local_11.x;
            var _local_6 = _local_11.y;
            trace("target_x: " + _local_5);
            trace("target_y: " + _local_6);
            var _local_10 = _local_3.findDistance(_local_9, _local_8, _local_5, _local_6);
            trace("distance: " + _local_10);
            if (_local_10 > 10) {
                _local_3.setPlayerAction("move");
                _local_3.movePlayer(_local_4, _local_5, _local_6, is_trigger, frame);
                _local_2.sendPlayerMove(_local_5, _local_6);
            } else if (frame != undefined) {
                _local_2.sendPlayerFrame(frame);
            } else {
                trace("ENGINE:ERROR:Less than minimum distance for movement");
            }
        }
        function movePlayer(player_id, target_x, target_y, is_trigger, frame) {
            var SHELL = _global.getCurrentShell();
            var ENGINE = _global.getCurrentEngine();
            trace("ENGINE_OVERRIDE:movePlayer - _abductedPlayerID :" + _abductedPlayerID);
            trace("ENGINE_OVERRIDE:movePlayer - player_id :" + player_id);
            if (player_id == _abductedPlayerID) {
                var _local_2 = _global.getCurrentEngine().getPlayerMovieClip(player_id);
                var _local_12 = _local_2._x;
                var _local_11 = _local_2._y;
                _local_2._x = _local_12;
                _local_2._y = _local_11;
                trace("****ABDUCTION CODE movePlayer*************************************");
                trace("******************************************************************");
                trace("!!!ENGINE_OVERRIDE -- movePlayer x : " + _local_2._x);
                trace("!!!ENGINE_OVERRIDE -- movePlayer y : " + _local_2._y);
                return(undefined);
            }
            trace("****NOT ABDUCTION CODE --- ENGINE:movePlayer: " + player_id);
            if (SHELL.isPlayerJumping(player_id)) {
                return(undefined);
            }
            var mc = ENGINE.getPlayerMovieClip(player_id);
            var _local_4 = SHELL.getPlayerObjectById(player_id);
            _local_4.hasNotMovedSince = -1;
            mc.cacheAsBitmap = false;
            mc.debug_mc.clear();
            if (!mc.is_ready) {
                ENGINE.updatePlayerPosition(player_id, target_x, target_y);
                return(undefined);
            }
            var start_x = Math.round(mc._x);
            var start_y = Math.round(mc._y);
            var _local_6 = ENGINE.findDistance(start_x, start_y, target_x, target_y);
            if (_global.getCurrentShell().playerModel.isPlayerStealthModerator() && (_global.getCurrentShell().playerModel.isMyPlayer(player_id))) {
                var duration = (_local_6 / 32);
            } else {
                var duration = ((_local_6 / 4) * (100 / _local_4.avatarVO.attributes.spriteSpeed));
            }
            var _local_13 = ENGINE.findAngle(start_x, start_y, target_x, target_y);
            var d = ENGINE.findDirection(_local_13);
            var change_x = (target_x - start_x);
            var change_y = (target_y - start_y);
            if (is_trigger == undefined) {
                is_trigger = true;
            }
            var _local_7 = ENGINE.getRoomMovieClip();
            var easeFunction = _local_7.easeMethod;
            if (easeFunction == undefined) {
                easeFunction = ENGINE.mathLinearTween;
            }
            if (_local_4.avatarVO.attributes.isFloating) {
                easeFunction = ENGINE.mathEaseFloat;
            }
            var _local_14 = mc.is_moving;
            mc.is_moving = true;
            mc.lastMoveDirection = d;
            var _local_3;
            if (easeFunction == ENGINE.mathEaseFloat) {
                _local_3 = d;
            } else {
                _local_3 = d + ENGINE.MAX_STANDING_FRAME;
                if (_local_7.invertedPenguins) {
                    _local_3 = _local_3 + 4;
                    if (_local_3 > ENGINE.MAX_WALKING_FRAME) {
                        var _local_10 = ENGINE.MAX_STANDING_FRAME + (_local_3 - ENGINE.MAX_WALKING_FRAME);
                        _local_3 = _local_10;
                    }
                }
            }
            ENGINE.updatePlayerFrame(player_id, _local_3);
            var t = 0;
            ENGINE.movingPlayers["p" + player_id] = mc;
            mc.updateMCPosition = function () {
                t++;
                if ((mc.is_moving && (t < duration)) && (((mc.frame >= ENGINE.MIN_WALKING_FRAME) && (mc.frame <= ENGINE.MAX_WALKING_FRAME)) || (easeFunction == ENGINE.mathEaseFloat))) {
                    var _local_3;
                    var _local_2;
                    if (easeFunction == ENGINE.mathEaseFloat) {
                        var _local_1 = easeFunction(t, start_x, target_x, start_y, target_y, duration);
                        _local_3 = _local_1.x;
                        _local_2 = _local_1.y;
                    } else {
                        _local_3 = Math.round(easeFunction(t, start_x, change_x, duration));
                        _local_2 = Math.round(easeFunction(t, start_y, change_y, duration));
                    }
                    ENGINE.updatePlayerPosition(player_id, _local_3, _local_2);
                } else if (mc.is_moving && (t >= duration)) {
                    mc.is_moving = false;
                    ENGINE.updatePlayerFrame(player_id, d);
                    SHELL.sendPlayerMoveDone(player_id);
                    delete ENGINE.movingPlayers["p" + player_id];
                    if (SHELL.isMyPlayer(player_id)) {
                        var _local_4 = false;
                        ENGINE.playerMoved.dispatch();
                        ENGINE.setPlayerAction("wait");
                        if (is_trigger && (ENGINE.isMouseActive())) {
                            ENGINE.checkTrigger(mc);
                        }
                        if (frame != undefined) {
                            ENGINE.sendPlayerFrame(frame);
                        }
                    }
                }
            };
            if (!_local_14) {
                SHELL.updateListeners(SHELL.PLAYER_MOVE_START, _local_4);
            }
        }
        function updatePlayerPosition(player_id, x, y, ignoreBlockLayer) {
            trace("!!!ENGINE_OVERRIDE : updatePlayerPosition : " + player_id);
            trace("!!!ENGINE_OVERRIDE : updatePlayerPosition : " + player_id);
            var _local_9 = _global.getCurrentShell();
            var _local_4 = _global.getCurrentEngine();
            trace("ENGINE_OVERRIDE:updatePlayerPosition - _abductedPlayerID :" + _abductedPlayerID);
            trace("ENGINE_OVERRIDE:updatePlayerPosition - player_id :" + player_id);
            if (player_id == _abductedPlayerID) {
                var _local_8 = _global.getCurrentEngine().getPlayerMovieClip(player_id);
                var _local_14 = _local_8._x;
                var _local_13 = _local_8._y;
                _local_8._x = _local_14;
                _local_8._y = _local_13;
                trace("****ABDUCTION CODE updatePlayerPosition***************************");
                trace("******************************************************************");
                return(undefined);
            }
            var _local_3 = _local_4.getPlayerMovieClip(player_id);
            var _local_11 = _local_4.getBalloonMovieClip(player_id);
            var _local_10 = _local_4.getNicknameMovieClip(player_id);
            var _local_7 = _local_9.getPlayerObjectById(player_id);
            if ((ignoreBlockLayer == undefined) || (!ignoreBlockLayer)) {
                x = _local_4.getValidXPosition(x);
                y = _local_4.getValidYPosition(y);
            }
            _local_3._x = x;
            _local_3._y = y;
            _local_11._x = x + _local_7.avatarVO.speechBubbleOffsetX;
            _local_11._y = y + _local_7.avatarVO.speechBubbleOffsetY;
            if (_local_3.scaleTopOffsetY != undefined) {
                _local_11._y = _local_11._y + _local_3.scaleTopOffsetY;
            }
            _local_10._x = x;
            _local_10._y = y + _local_7.avatarVO.nicknameOffsetY;
            if (_local_3.scaleBottomOffsetY != undefined) {
                _local_10._y = _local_10._y + _local_3.scaleBottomOffsetY;
            }
            _local_4.updatePlayerDepth(_local_3, _local_3.depth_id);
            if (_local_9.isMyPlayer(player_id)) {
                _local_4.player_x = x;
                _local_4.player_y = y;
                var _local_12 = _local_9.getMyPlayerObject();
                _local_12.x = x;
                _local_12.y = y;
            }
            _local_7.x = x;
            _local_7.y = y;
        }
        static var CLASS_NAME = "AlienAbduction_EngineOverrides";
        var _overrides = com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides;
    }
