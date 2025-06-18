//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.superhero.SnowballHitCheck implements com.clubpenguin.engine.projectiles.ISnowballHitCheck
    {
        function SnowballHitCheck () {
        }
        function hitCheck(snowballInfo) {
            trace("SUPERHERO hitCheck enter " + snowballInfo);
            var _local_12 = _global.getCurrentShell();
            var _local_7 = _global.getCurrentEngine();
            var _local_8 = _local_12.getPlayerList();
            var _local_6 = snowballInfo.snowballMC;
            var _local_10 = new Array();
            var _local_11 = new Array();
            var _local_13;
            var _local_16 = -1;
            trace("SUPERHERO SnowballHitStateConstant.playerSnowballHitCheck");
            trace((("SUPERHERO snowballInfo.player_id: " + snowballInfo.player_id) + " SHELL.isMyPlayer(snowballInfo.player_id): ") + _local_12.isMyPlayer(snowballInfo.player_id));
            if (_local_12.isMyPlayer(snowballInfo.player_id)) {
                _local_7.setPlayerAction("wait");
            }
            if (!_local_6._visible) {
                return(undefined);
            }
            for (var _local_14 in _local_8) {
                var _local_3 = _local_8[_local_14];
                var _local_18 = _local_7.getPlayerMovieClip(_local_3.player_id);
                var _local_5 = _local_18.hitTest(snowballInfo.x, snowballInfo.y, true);
                if (com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.instance.isRobotEquipped(_local_3.player_id)) {
                    if (_local_18.hand_mc.hitTest(snowballInfo.x, snowballInfo.y, true)) {
                        _local_11.push(_local_3);
                    }
                }
                trace((("SUPERHERO player_id: " + _local_3.player_id) + " isPlayerHit: ") + _local_5);
                if (_local_5) {
                    _local_10.push(_local_3);
                }
            }
            if (_local_10.length > 0) {
                _local_10.sortOn("y", [Array.NUMERIC | Array.DESCENDING]);
                var _local_9 = _local_10[0];
                var _local_19 = _local_7.getPlayerMovieClip(_local_9.player_id);
                trace((("SUPERHERO hitPlayerObj.player_id: " + _local_9.player_id) + "mascot_id: ") + _local_9.mascot_id);
                trace("SUPERHERO isLocalPlayer: " + _local_12.isMyPlayer(_local_9.player_id));
                trace("SUPERHERO isMoving: " + com.clubpenguin.world.rooms.common.triggers.PlayerAction.isMoving(_local_9.player_id));
                if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isMoving(_local_9.player_id)) {
                    _local_13 = com.clubpenguin.engine.projectiles.SnowballHitStateConstant.BOUNCE;
                } else {
                    _local_16 = _local_9.player_id;
                    _local_13 = com.clubpenguin.engine.projectiles.SnowballHitStateConstant.HIT;
                    var _local_15 = _local_7.getPlayerMovieClip(_local_16);
                    trace("JC distance between snowball and penguin " + Math.abs(_local_9.x - _local_6._x));
                    trace("JC width of hit penguin" + _local_15.art_mc._width);
                    if ((Math.abs(_local_9.x - _local_6._x) <= _local_15.art_mc._width) && (Math.abs(_local_9.y - _local_6._y) <= _local_15.art_mc._height)) {
                        trace("SnowballHitCheck - Penguin hit");
                        _local_6._x = _local_9.x;
                        _local_6._y = _local_9.y;
                    }
                    if (_local_6.getDepth() < _local_19.getDepth()) {
                        _local_6.swapDepths(_local_19);
                    }
                    if ((snowballInfo.snowballType != com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL) && (_local_11.length > 0)) {
                        trace("SnowballHitCheck - robot hit");
                        _local_10.sortOn("y", [Array.NUMERIC | Array.DESCENDING]);
                        var _local_21 = _local_11[0];
                        var _local_17 = _local_21.player_id;
                        trace("JC: The player who threw the snowball is " + snowballInfo.player_id);
                        trace("JC: The hit player's robot ID is " + _local_17);
                        com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.instance.handleRobotSnowballHit(snowballInfo.player_id, _local_17, com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.ROBOT_HIT_FRAME);
                    }
                }
            } else {
                trace("this was a miss");
                _local_13 = com.clubpenguin.engine.projectiles.SnowballHitStateConstant.MISS;
            }
            trace("SUPERHERO snowballState: " + _local_13);
            if (_local_6._totalFrames == 4) {
                _local_6.gotoAndStop(_local_13);
            } else {
                _local_6.gotoAndStop(2);
            }
            trace("should the snowball return to the player " + snowballInfo.snowballType.returnsToPlayer);
            trace("playerX " + _local_7.getPlayerMovieClip(snowballInfo.player_id)._x);
            trace("playerY " + _local_7.getPlayerMovieClip(snowballInfo.player_id)._y);
            trace("snowballX " + _local_6._x);
            trace("snowballY " + _local_6._y);
            var _local_23 = _local_6._x - _local_7.getPlayerMovieClip(snowballInfo.player_id)._x;
            var _local_22 = _local_7.getPlayerMovieClip(snowballInfo.player_id)._y - _local_6._y;
            if (snowballInfo.snowballType.returnsToPlayer) {
                var _local_18 = _local_7.getPlayerMovieClip(snowballInfo.player_id);
                var _local_20 = _local_7.getNicknameMovieClip(snowballInfo.player_id);
                if (snowballInfo.snowballType.playerInvisible) {
                    if (isTeleportationPowerGlove(snowballInfo.player_id)) {
                        _local_6.onEnterFrame = com.clubpenguin.util.Delegate.create(this, trackAnimation, _local_6, _local_18, _local_20);
                    } else {
                        _local_18._visible = true;
                    }
                }
            }
            return(_local_16);
        }
        function isTeleportationPowerGlove(player_id) {
            var _local_3 = _global.getCurrentShell().getPlayerObjectById(player_id);
            var _local_2 = _local_3.hand;
            return(((_local_2 == com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.TELEPORT_POWERGLOVE_ID) ? true : false));
        }
        function trackAnimation(snowballMC, playerMC, playerNicknameMC) {
            if (snowballMC.art._currentframe == 40) {
                snowballMC.art._x = playerMC._x - snowballMC._x;
                snowballMC.art._y = (playerMC._y - snowballMC._y) - (playerMC._height / 2);
                playerMC._visible = true;
                playerNicknameMC._visible = true;
                delete snowballMC.onEnterFrame;
            }
        }
    }
