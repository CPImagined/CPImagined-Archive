//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides
    {
        static var _abductedPlayerID;
        var isInit, defaultMovePlayer, defaultSendPlayerMove, defaultUpdatePlayerPosition, defaultUpdatePlayerFrame;
        function AlienAbduction_EngineOverrides () {
        }
        function init(abductedPlayer) {
            if (isInit) {
                return(undefined);
            }
            isInit = true;
            if (abductedPlayer) {
                _abductedPlayerID = abductedPlayer;
            }
            defaultMovePlayer = _global.getCurrentEngine().movePlayer;
            defaultSendPlayerMove = _global.getCurrentEngine().sendPlayerMove;
            defaultUpdatePlayerPosition = _global.getCurrentEngine().updatePlayerPosition;
            defaultUpdatePlayerFrame = _global.getCurrentEngine().updatePlayerPosition;
        }
        function sendPlayerMove(x, y, is_trigger, frame) {
            var SHELL = _global.getCurrentShell();
            var ENGINE = _global.getCurrentEngine();
            var player_id = _global.getCurrentShell().getMyPlayerId();
            if (player_id == _abductedPlayerID) {
                return(undefined);
            }
            if (!ENGINE.isMovementEnabled()) {
                return(undefined);
            }
            if (SHELL._localLoginServerData.autoLogin) {
                SHELL.sendAS2Clicked(ENGINE.MOVE_CLICKED);
            }
            var player_id = SHELL.getMyPlayerId();
            var mc = ENGINE.getPlayerMovieClip(player_id);
            if (SHELL.isPlayerJumping(player_id) || (SHELL.localPlayerIsJumping)) {
                return(undefined);
            }
            if (SHELL.isPlayerJumping(player_id) || (SHELL.localPlayerIsJumping)) {
                return(undefined);
            }
            var start_x = Math.round(mc._x);
            var start_y = Math.round(mc._y);
            var path_ob = ENGINE.findPlayerPath(player_id, x, y);
            var target_x = path_ob.x;
            var target_y = path_ob.y;
            var distance = ENGINE.findDistance(start_x, start_y, target_x, target_y);
            if (distance > 10) {
                ENGINE.setPlayerAction("move");
                ENGINE.movePlayer(player_id, target_x, target_y, is_trigger, frame);
                SHELL.sendPlayerMove(target_x, target_y);
            } else if (frame != undefined) {
                SHELL.sendPlayerFrame(frame);
                return;
            }
        }
        function movePlayer(player_id, target_x, target_y, is_trigger, frame) {
            var SHELL = _global.getCurrentShell();
            var ENGINE = _global.getCurrentEngine();
            if (player_id == _abductedPlayerID) {
                var penguin_mc = _global.getCurrentEngine().getPlayerMovieClip(player_id);
                var xPos = penguin_mc._x;
                var yPos = penguin_mc._y;
                penguin_mc._x = xPos;
                penguin_mc._y = yPos;
                return(undefined);
            }
            if (SHELL.isPlayerJumping(player_id)) {
                return(undefined);
            }
            var mc = ENGINE.getPlayerMovieClip(player_id);
            var playerObject = SHELL.getPlayerObjectById(player_id);
            playerObject.hasNotMovedSince = -1;
            mc.cacheAsBitmap = false;
            mc.debug_mc.clear();
            if (!mc.is_ready) {
                ENGINE.updatePlayerPosition(player_id, target_x, target_y);
                return(undefined);
            }
            var start_x = Math.round(mc._x);
            var start_y = Math.round(mc._y);
            var distance = ENGINE.findDistance(start_x, start_y, target_x, target_y);
            if (_global.getCurrentShell().playerModel.isPlayerStealthModerator() && (_global.getCurrentShell().playerModel.isMyPlayer(player_id))) {
                var duration = (distance / 32);
            } else {
                var duration = ((distance / 4) * (100 / playerObject.avatarVO.attributes.spriteSpeed));
            }
            var a = ENGINE.findAngle(start_x, start_y, target_x, target_y);
            var d = ENGINE.findDirection(a);
            var change_x = (target_x - start_x);
            var change_y = (target_y - start_y);
            if (is_trigger == undefined) {
                is_trigger = true;
            }
            var room_mc = ENGINE.getRoomMovieClip();
            var easeFunction = room_mc.easeMethod;
            if (easeFunction == undefined) {
                easeFunction = ENGINE.mathLinearTween;
            }
            if (playerObject.avatarVO.attributes.isFloating) {
                easeFunction = ENGINE.mathEaseFloat;
            }
            var isAlreadyMoving = mc.is_moving;
            mc.is_moving = true;
            mc.lastMoveDirection = d;
            var newFrame;
            if (easeFunction == ENGINE.mathEaseFloat) {
                newFrame = d;
            } else {
                newFrame = d + ENGINE.MAX_STANDING_FRAME;
                if (room_mc.invertedPenguins) {
                    newFrame = newFrame + 4;
                    if (newFrame > ENGINE.MAX_WALKING_FRAME) {
                        var invertedFrame = (ENGINE.MAX_STANDING_FRAME + (newFrame - ENGINE.MAX_WALKING_FRAME));
                        newFrame = invertedFrame;
                    }
                }
            }
            ENGINE.updatePlayerFrame(player_id, newFrame);
            var t = 0;
            ENGINE.movingPlayers["p" + player_id] = mc;
            mc.updateMCPosition = function () {
                t++;
                if ((mc.is_moving && (t < duration)) && (((mc.frame >= ENGINE.MIN_WALKING_FRAME) && (mc.frame <= ENGINE.MAX_WALKING_FRAME)) || (easeFunction == ENGINE.mathEaseFloat))) {
                    var x;
                    var y;
                    if (easeFunction == ENGINE.mathEaseFloat) {
                        var location = easeFunction(t, start_x, target_x, start_y, target_y, duration);
                        x = location.x;
                        y = location.y;
                    } else {
                        x = Math.round(easeFunction(t, start_x, change_x, duration));
                        y = Math.round(easeFunction(t, start_y, change_y, duration));
                    }
                    ENGINE.updatePlayerPosition(player_id, x, y);
                } else if (mc.is_moving && (t >= duration)) {
                    mc.is_moving = false;
                    ENGINE.updatePlayerFrame(player_id, d);
                    SHELL.sendPlayerMoveDone(player_id);
                    delete ENGINE.movingPlayers["p" + player_id];
                    if (SHELL.isMyPlayer(player_id)) {
                        var playerHitTrigger = false;
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
            if (!isAlreadyMoving) {
                SHELL.updateListeners(SHELL.PLAYER_MOVE_START, playerObject);
            }
        }
        function updatePlayerPosition(player_id, x, y, ignoreBlockLayer) {
            var SHELL = _global.getCurrentShell();
            var ENGINE = _global.getCurrentEngine();
            if (player_id == _abductedPlayerID) {
                var penguin_mc = _global.getCurrentEngine().getPlayerMovieClip(player_id);
                var xPos = penguin_mc._x;
                var yPos = penguin_mc._y;
                penguin_mc._x = xPos;
                penguin_mc._y = yPos;
                return(undefined);
            }
            var player_mc = ENGINE.getPlayerMovieClip(player_id);
            var balloon_mc = ENGINE.getBalloonMovieClip(player_id);
            var nickname_mc = ENGINE.getNicknameMovieClip(player_id);
            var playerObject = SHELL.getPlayerObjectById(player_id);
            if ((ignoreBlockLayer == undefined) || (!ignoreBlockLayer)) {
                x = ENGINE.getValidXPosition(x);
                y = ENGINE.getValidYPosition(y);
            }
            player_mc._x = x;
            player_mc._y = y;
            balloon_mc._x = x + playerObject.avatarVO.speechBubbleOffsetX;
            balloon_mc._y = y + playerObject.avatarVO.speechBubbleOffsetY;
            if (player_mc.scaleTopOffsetY != undefined) {
                balloon_mc._y = balloon_mc._y + player_mc.scaleTopOffsetY;
            }
            nickname_mc._x = x;
            nickname_mc._y = y + playerObject.avatarVO.nicknameOffsetY;
            if (player_mc.scaleBottomOffsetY != undefined) {
                nickname_mc._y = nickname_mc._y + player_mc.scaleBottomOffsetY;
            }
            ENGINE.updatePlayerDepth(player_mc, player_mc.depth_id);
            if (SHELL.isMyPlayer(player_id)) {
                ENGINE.player_x = x;
                ENGINE.player_y = y;
                var myPlayer = SHELL.getMyPlayerObject();
                myPlayer.x = x;
                myPlayer.y = y;
            }
            playerObject.x = x;
            playerObject.y = y;
        }
        static var CLASS_NAME = "AlienAbduction_EngineOverrides";
        var _overrides = com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides;
    }
