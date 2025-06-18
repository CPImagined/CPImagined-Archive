//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2025.time.minigame.TilesPuzzle
    {
        var _view, _isRotating;
        function TilesPuzzle (stageReference) {
            _view = stageReference;
            init();
        }
        function init() {
            _view.background_complete._visible = false;
            configureTiles();
        }
        function configureTiles() {
            var _local_2 = 0;
            while (_local_2 < TOTAL_TILES) {
                var _local_3;
                if (GAME_INDEX == 0) {
                    _local_3 = _view["tile_a_" + _local_2];
                } else {
                    _local_3 = _view["tile_b_" + _local_2];
                }
                _local_3.gotoAndStop(1);
                var _local_4 = startLayoutMatrix["_" + GAME_INDEX]["t" + _local_2];
                _local_3._rotation = _local_3._rotation + _local_4;
                _local_2++;
            }
            enableTiles();
        }
        function enableTiles() {
            var _local_2 = 0;
            while (_local_2 < TOTAL_TILES) {
                var _local_3;
                if (GAME_INDEX == 0) {
                    _local_3 = _view["tile_a_" + _local_2];
                } else {
                    _local_3 = _view["tile_b_" + _local_2];
                }
                _local_3.onRelease = com.clubpenguin.util.Delegate.create(this, tileClickHandler, _local_3);
                _local_2++;
            }
        }
        function tileClickHandler(mc) {
            if (_isRotating) {
                return(undefined);
            }
            _isRotating = true;
            var _local_5 = Math.floor(Math.random() * 2);
            var _local_2 = new Sound(_view);
            _local_2.attachSound("sfx_pipeSpin_" + _local_5);
            _local_2.start();
            var _local_4 = mc._rotation + 90;
            com.greensock.TweenMax.to(mc, 0.35, {_rotation:_local_4, onComplete:tileAnimationComplete, onCompleteParams:[mc], onCompleteScope:this});
        }
        function tileAnimationComplete(mc) {
            checkSolution();
            _isRotating = false;
        }
        function checkSolution() {
            var _local_4 = [];
            var _local_3 = 0;
            while (_local_3 < TOTAL_TILES) {
                var _local_2;
                if (GAME_INDEX == 0) {
                    _local_2 = _view["tile_a_" + _local_3];
                } else {
                    _local_2 = _view["tile_b_" + _local_3];
                }
                if (solutionsMatrix["_" + GAME_INDEX].hasOwnProperty("t" + _local_3)) {
                    if (((((_local_2._rotation == solutionsMatrix["_" + GAME_INDEX]["t" + _local_3]) || ((_local_2._rotation == 0) && (solutionsMatrix["_" + GAME_INDEX]["t" + _local_3] == HORIZONTAL_PIPE))) || ((_local_2._rotation == 180) && (solutionsMatrix["_" + GAME_INDEX]["t" + _local_3] == HORIZONTAL_PIPE))) || ((_local_2._rotation == 90) && (solutionsMatrix["_" + GAME_INDEX]["t" + _local_3] == VERTICAL_PIPE))) || ((_local_2._rotation == -90) && (solutionsMatrix["_" + GAME_INDEX]["t" + _local_3] == VERTICAL_PIPE))) {
                        _local_4.push(_local_2);
                    }
                }
                _local_3++;
            }
            var _local_5 = objectLength(solutionsMatrix["_" + GAME_INDEX]);
            if (_local_4.length < _local_5) {
                return(undefined);
            }
            _local_3 = 0;
            while (_local_3 < _local_5) {
                _local_4[_local_3].gotoAndStop(2);
                _local_3++;
            }
            if (GAME_INDEX == 0) {
                GAME_INDEX = 1;
                disableGame1();
                configureTiles();
            } else {
                _view.background_complete._visible = true;
                _view.background_complete.battery_container.battery_mc.gotoAndPlay(2);
                setTimeout(com.clubpenguin.util.Delegate.create(this, gameOver, true), 4000);
            }
        }
        function disableGame1() {
            var _local_2 = 0;
            while (_local_2 < TOTAL_TILES) {
                var _local_3 = _view["tile_a_" + _local_2];
                _local_3.onRelease = null;
                _local_2++;
            }
        }
        function gameOver(isWon) {
            _global.getCurrentParty().BaseParty.CURRENT_PARTY.setTaskComplete(3);
			_global.getCurrentEngine().getRoomMovieClip().activateTimer();
			_global.getCurrentInterface().closeContent();
        }
        function objectLength(myObject) {
            var _local_1 = 0;
            for (var _local_2 in myObject) {
                _local_1++;
            }
            return(_local_1);
        }
        var TOTAL_TILES = 15;
        var GAME_INDEX = 0;
        var HORIZONTAL_PIPE = 1000;
        var VERTICAL_PIPE = 2000;
        var startLayoutMatrix = {_0:{t0:0, t1:180, t2:0, t3:-90, t4:90, t5:0, t6:180, t7:90, t8:-90, t9:0, t10:-90, t11:0, t12:90, t13:90, t14:0}, _1:{t0:180, t1:0, t2:0, t3:90, t4:0, t5:0, t6:0, t7:0, t8:180, t9:90, t10:90, t11:0, t12:90, t13:90, t14:0}};
        var solutionsMatrix = {_0:{t3:0, t4:HORIZONTAL_PIPE, t5:HORIZONTAL_PIPE, t6:-90, t7:HORIZONTAL_PIPE, t8:90, t9:HORIZONTAL_PIPE, t10:90, t11:VERTICAL_PIPE, t13:-90, t14:180}, _1:{t0:0, t1:90, t3:180, t4:VERTICAL_PIPE, t7:VERTICAL_PIPE, t8:0, t9:0, t10:180, t11:VERTICAL_PIPE, t12:-90, t13:HORIZONTAL_PIPE, t14:180}};
    }
