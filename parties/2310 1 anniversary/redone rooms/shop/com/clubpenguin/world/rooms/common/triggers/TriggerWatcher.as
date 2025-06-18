//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.triggers.TriggerWatcher
    {
        var _areaMC, _SHELL, _ENGINE, _gridWidth, _gridHeight, _xOffset, _yOffset, _targetGrid, _triggerList;
        function TriggerWatcher (stageMC, shell) {
            if (!stageMC) {
            }
            _areaMC = stageMC.createEmptyMovieClip("targetWatcher", stageMC.getNextHighestDepth());
            _areaMC._x = (_areaMC._y = 0);
            _areaMC.beginFill(7837952, 0);
            _areaMC.moveTo(0, 0);
            _areaMC.lineTo(STAGE_WIDTH, 0);
            _areaMC.lineTo(STAGE_WIDTH, STAGE_HEIGHT);
            _areaMC.lineTo(0, STAGE_HEIGHT);
            _areaMC.lineTo(0, 0);
            _areaMC.endFill();
            _areaMC._visible = false;
            _SHELL = shell;
            _ENGINE = _global.getCurrentEngine();
            _gridWidth = Math.ceil(Math.floor(_areaMC._width) / GRID_SIZE);
            _gridHeight = Math.ceil(Math.floor(_areaMC._height) / GRID_SIZE);
            _xOffset = _areaMC._x;
            _yOffset = _areaMC._y;
            _targetGrid = [];
            _triggerList = [];
            var _local_4 = 0;
            while (_local_4 < _gridHeight) {
                var _local_3 = 0;
                while (_local_3 < _gridWidth) {
                    _targetGrid.push(null);
                    _local_3++;
                }
                _local_4++;
            }
        }
        function addTrigger(triggerToAdd) {
            _triggerList.push(triggerToAdd);
            var _local_10 = triggerToAdd.getBounds(_areaMC);
            var _local_9 = Math.floor(Math.floor(_local_10.xMin) / GRID_SIZE);
            var _local_7 = Math.floor(Math.floor(_local_10.yMin) / GRID_SIZE);
            var _local_8 = Math.floor(Math.floor(_local_10.xMax) / GRID_SIZE);
            var _local_6 = Math.floor(Math.floor(_local_10.yMax) / GRID_SIZE);
            var _local_3 = _local_9;
            while (_local_3 <= _local_8) {
                if (!_targetGrid[_local_3]) {
                    _targetGrid[_local_3] = [];
                }
                var _local_2 = _local_7;
                while (_local_2 <= _local_6) {
                    if (!_targetGrid[_local_3][_local_2]) {
                        var _local_4 = new com.clubpenguin.world.rooms.common.triggers.GridTile(_xOffset + (_local_3 * GRID_SIZE), _yOffset + (_local_2 * GRID_SIZE), GRID_SIZE, GRID_SIZE);
                        _targetGrid[_local_3][_local_2] = _local_4;
                        _local_4.addTrigger(triggerToAdd);
                    } else {
                        _targetGrid[_local_3][_local_2].addTrigger(triggerToAdd);
                    }
                    _local_2++;
                }
                _local_3++;
            }
        }
        function checkAllPlayers() {
            var _local_5 = _SHELL.getPlayerList();
            var _local_2 = 0;
            while (_local_2 < _triggerList.length) {
                _triggerList[_local_2].beginSnapshot();
                _local_2++;
            }
            var _local_4 = 0;
            while (_local_4 < _local_5.length) {
                checkTriggers(_local_5[_local_4]);
                _local_4++;
            }
            var _local_3 = 0;
            while (_local_3 < _triggerList.length) {
                _triggerList[_local_3].endSnapshot();
                _local_3++;
            }
        }
        function checkTriggers(object) {
            var _local_2 = _ENGINE.getPlayerMovieClip(object.player_id);
            var _local_4 = Math.floor(_local_2._x / GRID_SIZE);
            var _local_3 = Math.floor(_local_2._y / GRID_SIZE);
            if (_targetGrid[_local_4][_local_3]) {
                return(_targetGrid[_local_4][_local_3].hitTest(object, _local_2));
            }
        }
        function toString() {
            var _local_4 = [];
            var _local_3 = 0;
            while (_local_3 < _targetGrid.length) {
                var _local_2 = 0;
                while (_local_2 < _targetGrid[_local_3].length) {
                    if (_targetGrid[_local_3][_local_2]) {
                        _targetGrid[_local_3][_local_2].draw(_areaMC);
                    }
                    _local_2++;
                }
                _local_3++;
            }
            return("");
        }
        static var GRID_SIZE = 20;
        static var STAGE_WIDTH = 760;
        static var STAGE_HEIGHT = 480;
    }
