//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.ShellGame
    {
        var _awardStamp, _fireOnComplete, _promptHolder, _shellElements, _shellButtons, _itemAfterCompletion, _SHELL, _now, _currentSecond, _currentMinute, _cycleSecond, _currentGemCycle, _currentGemToFindCycle, _handlePlayerMoveDelegate, _destroyDelegate, _secondCheckIntervalID, _playerSelected;
        function ShellGame (awardStamp, fireOnComplete, promptHolder, shellElements, shellButtons, itemAfterCompletion) {
            trace(CLASS_NAME + "()");
            _awardStamp = awardStamp;
            _fireOnComplete = fireOnComplete;
            _promptHolder = promptHolder;
            _shellElements = shellElements;
            _shellButtons = shellButtons;
            _itemAfterCompletion = itemAfterCompletion;
            if ((((((!_awardStamp) || (!_fireOnComplete)) || (!_promptHolder)) || (!_shellElements)) || (!_shellButtons)) || (!_itemAfterCompletion)) {
                trace("ERROR: INPUT UNDEFINED");
                trace("\t_awardStamp: " + _awardStamp);
                trace("\t_fireOnComplete: " + _fireOnComplete);
                trace("\t_promptHolder: " + _promptHolder);
                trace("\t_shellElements: " + _shellElements);
                trace("\t_shellButtons: " + _shellButtons);
            }
            _SHELL = _global.getCurrentShell();
            _now = _SHELL.getPenguinStandardTime();
            if (!_now) {
                _now = new Date();
            }
            _currentSecond = _now.getSeconds();
            _currentMinute = _now.getMinutes();
            _cycleSecond = findCycleSecond(_currentSecond);
            _currentGemCycle = findCurrentGemCycle(_currentSecond, _currentMinute);
            _currentGemToFindCycle = findCurrentGemToFindCycle(_currentSecond, _currentMinute);
            _handlePlayerMoveDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerMove);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.PLAYER_MOVE, _handlePlayerMoveDelegate);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            init();
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            clearInterval(_secondCheckIntervalID);
            _secondCheckIntervalID = null;
            _SHELL.removeListener(_SHELL.PLAYER_MOVE, _handlePlayerMoveDelegate);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _shellElements.gems.gotoAndStop(_currentGemCycle + 1);
            _promptHolder.lang.prompt.progressBar.gotoAndPlay(_cycleSecond * 24);
            _secondCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, updateTime), ONE_SECOND);
            if (_SHELL.isItemInMyInventory(_itemAfterCompletion)) {
                _gameBeaten = true;
                gameCompleted();
            }
        }
        function findCurrentGemCycle(seconds, minutes) {
            var _local_2 = 0;
            if (minutes % 2) {
                while (seconds >= CYCLE_LIMIT) {
                    _local_2 = _local_2 + 1;
                    seconds = seconds - CYCLE_LIMIT;
                }
            } else {
                _local_2 = 3;
                while (seconds >= CYCLE_LIMIT) {
                    _local_2 = _local_2 + 1;
                    seconds = seconds - CYCLE_LIMIT;
                }
            }
            return(_local_2);
        }
        function findCurrentGemToFindCycle(seconds, minutes) {
            var _local_2 = 0;
            if ((minutes % 3) == 2) {
                while (seconds > CYCLE_LIMIT) {
                    _local_2 = _local_2 + 1;
                    seconds = seconds - CYCLE_LIMIT;
                }
            } else if ((minutes % 3) == 1) {
                _local_2 = 3;
                while (seconds > CYCLE_LIMIT) {
                    _local_2 = _local_2 + 1;
                    seconds = seconds - CYCLE_LIMIT;
                }
            } else {
                _local_2 = 6;
                while (seconds > CYCLE_LIMIT) {
                    _local_2 = _local_2 + 1;
                    seconds = seconds - CYCLE_LIMIT;
                }
            }
            return(_local_2);
        }
        function updateTime() {
            trace(CLASS_NAME + ": updateTime()");
            _now.setTime(_now.getTime() + ONE_SECOND);
            _currentSecond = _now.getSeconds();
            _cycleSecond = findCycleSecond(_currentSecond);
            if (_currentMinute != _now.getMinutes()) {
                _currentMinute = _now.getMinutes();
            }
            if (_cycleState == PRE_GAME_STATE) {
                if (_cycleSecond == CYCLE_START) {
                    newCycle();
                }
            } else {
                switch (_cycleSecond) {
                    case CYCLE_START : 
                        newCycle();
                        break;
                    case CYCLE_LOWER : 
                        lowerCycle();
                        break;
                    case CYCLE_HIDE : 
                        hideCycle();
                        break;
                    case CYCLE_MID : 
                        midCycle();
                        break;
                    case CYCLE_END : 
                        endCycle();
                        break;
                }
            }
        }
        function findCycleSecond(seconds) {
            while (seconds >= CYCLE_LIMIT) {
                seconds = seconds - CYCLE_LIMIT;
            }
            return(seconds);
        }
        function newCycle() {
            trace(CLASS_NAME + ": newCycle()");
            _cycleState = WATCH_STATE;
            if (_currentGemCycle == GEM_CYCLE_LIMIT) {
                _currentGemCycle = 0;
            } else {
                _currentGemCycle = _currentGemCycle + 1;
            }
            if (_currentGemToFindCycle == GEM_TO_FIND_CYCLE_LIMIT) {
                _currentGemToFindCycle = 0;
            } else {
                _currentGemToFindCycle = _currentGemToFindCycle + 1;
            }
            if (_playerScore == 3) {
                while (_playerScore > 0) {
                    _promptHolder["correct" + _playerScore].gotoAndStop("park");
                    _playerScore--;
                }
            }
            trace("Now Shuffle...");
            switch (_playerScore) {
                case 0 : 
                    trace("\t...slowly");
                    _shellElements.gotoAndStop("slow" + _currentGemCycle);
                    break;
                case 1 : 
                    trace("\t...medium");
                    _shellElements.gotoAndStop("mid" + _currentGemCycle);
                    break;
                default : 
                    trace("\t...fast");
                    _shellElements.gotoAndStop("fast" + _currentGemCycle);
                    break;
            }
            _promptHolder.lang.prompt.gotoAndPlay("watch");
            _shellElements.highlight.gotoAndStop("park");
        }
        function lowerCycle() {
            trace(CLASS_NAME + ": lowerCycle()");
            _shellElements.cups.lower.play();
        }
        function hideCycle() {
            trace(CLASS_NAME + ": hideCycle()");
            _shellElements.gems.gotoAndStop("park");
            if ((_currentGemCycle == CYCLE_START) && (_SHELL)) {
                _now = _SHELL.getPenguinStandardTime();
            }
        }
        function midCycle() {
            trace(CLASS_NAME + ": midCycle()");
            var _local_2 = _gemToFindSequence[_currentGemToFindCycle];
            _cycleState = FIND_STATE;
            _promptHolder.lang.prompt.gotoAndPlay(_local_2);
            switch (_playerSelected) {
                case GEM_LEFT : 
                    _shellElements.highlight.gotoAndStop("left");
                    break;
                case GEM_CENTER : 
                    _shellElements.highlight.gotoAndStop("center");
                    break;
                case GEM_RIGHT : 
                    _shellElements.highlight.gotoAndStop("right");
                    break;
                default : 
                    _shellElements.highlight.gotoAndStop("park");
                    break;
            }
            _shellButtons.gotoAndStop("on");
        }
        function endCycle() {
            trace(CLASS_NAME + ": endCycle()");
            _cycleState = REVEAL_STATE;
            if (isPlayerSelectionCorrect()) {
                awardPoint();
            } else {
                _promptHolder.lang.prompt.gotoAndPlay("showIncorrect");
            }
            _shellElements.gems.gotoAndStop(_currentGemCycle + 1);
            _shellElements.gotoAndStop("start");
            _shellButtons.gotoAndStop("park");
        }
        function isPlayerSelectionCorrect() {
            trace(CLASS_NAME + ": playerSelectedCorrectly()");
            var _local_2 = _gemsSequence[_currentGemCycle][_playerSelected];
            var _local_3 = _gemToFindSequence[_currentGemToFindCycle];
            if (_local_2 == _local_3) {
                return(true);
            }
            return(false);
        }
        function awardPoint() {
            trace(CLASS_NAME + ": awardPoint()");
            if (_playerScore < 3) {
                _playerScore = _playerScore + 1;
                if ((_playerScore == 3) && (!_gameBeaten)) {
                    gameCompleted();
                    _gameBeaten = true;
                }
            }
            _promptHolder.lang.prompt.gotoAndPlay("showCorrect");
            _promptHolder["correct" + _playerScore].gotoAndStop("on");
        }
        function gameCompleted() {
            trace(CLASS_NAME + ": gameCompleted()");
            if (_awardStamp) {
                _SHELL.stampEarned(PUZZLE_SOLVER_STAMP_ID);
            }
            _fireOnComplete();
        }
        function handlePlayerMove(player) {
            trace(CLASS_NAME + ": handlePlayerMove()");
            if (!_SHELL.isMyPlayer(player.player_id)) {
                return(undefined);
            }
            if (_shellElements.stages.hitTest(player.x, player.y)) {
                if (_shellElements.stages.left.hitTest(player.x, player.y)) {
                    _playerSelected = GEM_LEFT;
                    if (_cycleState == FIND_STATE) {
                        _shellElements.highlight.gotoAndStop("left");
                    }
                } else if (_shellElements.stages.center.hitTest(player.x, player.y)) {
                    _playerSelected = GEM_CENTER;
                    if (_cycleState == FIND_STATE) {
                        _shellElements.highlight.gotoAndStop("center");
                    }
                } else if (_shellElements.stages.right.hitTest(player.x, player.y)) {
                    _playerSelected = GEM_RIGHT;
                    if (_cycleState == FIND_STATE) {
                        _shellElements.highlight.gotoAndStop("right");
                    }
                }
            } else {
                _playerSelected = null;
                _shellElements.highlight.gotoAndStop("park");
            }
        }
        static var CLASS_NAME = "ShellGame";
        static var PUZZLE_SOLVER_STAMP_ID = 183;
        static var CYCLE_LIMIT = 20;
        static var GEM_CYCLE_LIMIT = 5;
        static var GEM_TO_FIND_CYCLE_LIMIT = 8;
        static var CYCLE_START = 0;
        static var CYCLE_LOWER = 1;
        static var CYCLE_HIDE = 2;
        static var CYCLE_MID = 9;
        static var CYCLE_END = 16;
        static var GEM_LEFT = 0;
        static var GEM_CENTER = 1;
        static var GEM_RIGHT = 2;
        static var ONE_SECOND = 1000;
        static var PRE_GAME_STATE = "preGameState";
        static var WATCH_STATE = "watchState";
        static var FIND_STATE = "findState";
        static var REVEAL_STATE = "revealState";
        var _cycleState = PRE_GAME_STATE;
        var _gameBeaten = false;
        var _previousTimer = 0;
        var _redGem = "red";
        var _yellowGem = "yellow";
        var _blueGem = "blue";
        var _gemsSequence = [[com.clubpenguin.world.rooms.common.ShellGame.prototype._redGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._yellowGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._blueGem], [com.clubpenguin.world.rooms.common.ShellGame.prototype._yellowGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._redGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._blueGem], [com.clubpenguin.world.rooms.common.ShellGame.prototype._yellowGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._blueGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._redGem], [com.clubpenguin.world.rooms.common.ShellGame.prototype._redGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._blueGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._yellowGem], [com.clubpenguin.world.rooms.common.ShellGame.prototype._blueGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._redGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._yellowGem], [com.clubpenguin.world.rooms.common.ShellGame.prototype._redGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._blueGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._yellowGem]];
        var _gemToFindSequence = [com.clubpenguin.world.rooms.common.ShellGame.prototype._redGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._yellowGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._blueGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._yellowGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._yellowGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._blueGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._redGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._redGem, com.clubpenguin.world.rooms.common.ShellGame.prototype._blueGem];
        var _playerScore = 0;
    }
