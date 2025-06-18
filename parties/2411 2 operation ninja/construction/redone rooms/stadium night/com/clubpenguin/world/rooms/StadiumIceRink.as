//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.StadiumIceRink extends com.clubpenguin.world.rooms.Stadium
    {
        var _ENGINE, _stage, _SHELL, _AIRTOWER, _GAME, _handleGameMoveDoneDelegate, _handlePlayerMoveDelegate, _handlePlayerMoveDoneDelegate, _handleGetGameDelegate, _handleGameMoveDelegate, wem, _destroyDelegate;
        function StadiumIceRink (stageReference) {
            super(stageReference);
            _stage.easeMethod = _ENGINE.mathEaseInOutQuad;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            super.init();
            _AIRTOWER = _global.getCurrentAirtower();
            _ENGINE.setRoomBallMovieClip(_stage.game_mc.puck_mc);
            _GAME = _stage.game_mc;
            _GAME.puck_mc.is_moving = false;
            _handleGameMoveDoneDelegate = com.clubpenguin.util.Delegate.create(this, handleGameMoveDone);
            _handlePlayerMoveDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerMove);
            _handlePlayerMoveDoneDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerMoveDone);
            _handleGetGameDelegate = com.clubpenguin.util.Delegate.create(this, handleGetGame);
            _handleGameMoveDelegate = com.clubpenguin.util.Delegate.create(this, handleGameMove);
            com.clubpenguin.world.rooms.common.hockey.HockeyGame.setContainer(_GAME);
            com.clubpenguin.world.rooms.common.hockey.HockeyGame.controller.puckDone = _handleGameMoveDoneDelegate;
            _SHELL.addListener(_SHELL.PLAYER_MOVE, _handlePlayerMoveDelegate);
            _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, _handlePlayerMoveDoneDelegate);
            _AIRTOWER.addListener("gz", _handleGetGameDelegate);
            _AIRTOWER.addListener("zm", _handleGameMoveDelegate);
            getGame();
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(35);
            wem.setupRainAnimationHeight(50);
            wem.setupSnowAnimationHeight(50);
            wem.setupRainAnimationSpeed(0.4);
            wem.setupSnowAnimationSpeed(0.8);
            wem.setupRainDelayTime(1.5);
            wem.setupSnowDelayTime(1.5);
            wem.startWeatherEffectCheck();
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_MOVE, _handlePlayerMoveDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, _handlePlayerMoveDoneDelegate);
            _AIRTOWER.removeListener("gz", handleGetGame);
            _AIRTOWER.removeListener("zm", handleGameMove);
            wem.destroy();
        }
        function getGame() {
            _AIRTOWER.send("z", "gz", [], "str", _SHELL.getCurrentServerRoomId());
        }
        function handleGetGame(ob) {
            var _local_4 = Number(ob[0]);
            var _local_2 = Number(ob[1]);
            var _local_3 = Number(ob[2]);
            com.clubpenguin.world.rooms.common.hockey.HockeyGame.controller.hitPuck(_local_2, _local_3, 0, 0);
        }
        function sendGameMove(x, y, speed_x, speed_y) {
            var _local_2 = _SHELL.getMyPlayerId();
            _AIRTOWER.send("z", "m", [_local_2, x, y, speed_x, speed_y], "str", _SHELL.getCurrentServerRoomId());
        }
        function handleGameMove(ob) {
            var _local_7 = Number(ob[0]);
            var _local_6 = Number(ob[1]);
            var _local_5 = Number(ob[2]);
            var _local_4 = Number(ob[3]);
            var _local_3 = Number(ob[4]);
            var _local_2 = Number(ob[5]);
            com.clubpenguin.world.rooms.common.hockey.HockeyGame.controller.hitPuck(_local_5, _local_4, _local_3, _local_2);
        }
        function handleGameMoveDone() {
            if (_GAME.puck_mc.is_moving) {
                _GAME.puck_mc.is_moving = false;
            }
        }
        function handlePlayerMove(player_ob) {
            var _local_2 = player_ob.player_id;
            if (_SHELL.isMyPlayer(_local_2)) {
                _GAME.player_mc = _ENGINE.getPlayerMovieClip(_local_2);
                _GAME.target_x = player_ob.x;
                _GAME.target_y = player_ob.y;
                _GAME.onEnterFrame = com.clubpenguin.util.Delegate.create(this, movePlayer);
            }
        }
        function handlePlayerMoveDone(player_ob) {
            var _local_2 = player_ob.player_id;
            if (_SHELL.isMyPlayer(_local_2)) {
                _GAME.onEnterFrame = undefined;
                delete _GAME.onEnterFrame;
            }
        }
        function movePlayer() {
            var _local_10 = _GAME.player_mc._x;
            var _local_9 = _GAME.player_mc._y;
            if (_GAME.puck_mc.hitTest(_local_10, _local_9, true)) {
                var _local_3 = Math.round(_GAME.puck_mc._x);
                var _local_2 = Math.round(_GAME.puck_mc._y);
                var _local_4 = _GAME.target_x - _GAME._x;
                var _local_5 = _GAME.target_y - _GAME._y;
                var _local_6 = findDistance(_local_4, _local_5, _local_3, _local_2);
                if (_local_6 > 20) {
                    _GAME.puck_mc.is_moving = true;
                    var _local_8 = Math.floor((_local_4 - _local_3) / 6);
                    var _local_7 = Math.floor((_local_5 - _local_2) / 6);
                    sendGameMove(_local_3, _local_2, _local_8, _local_7);
                    _GAME.onEnterFrame = undefined;
                    delete _GAME.onEnterFrame;
                }
            }
        }
        function findDistance(x1, y1, x2, y2) {
            var _local_2 = x2 - x1;
            var _local_1 = y2 - y1;
            return(Math.sqrt((_local_2 * _local_2) + (_local_1 * _local_1)));
        }
        static var CLASS_NAME = "StadiumIceRink";
    }
