//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.TargetGame
    {
        var _displayScreen, _winningMethod, _scoreScreen1, _scoreScreen2, _targetsLength, _SHELL, _now, _currentSecond, _currentMinute, _secondCheckIntervalID, _gameProgress, _currentGameMinute, _currentGameSecond, _gameState;
        function TargetGame (displayScreen, winningMethod, scoreScreen1, scoreScreen2, targetsTeam1, targetsTeam2) {
            _displayScreen = displayScreen;
            _winningMethod = winningMethod;
            _scoreScreen1 = scoreScreen1;
            _scoreScreen2 = scoreScreen2;
            _targetsTeam1 = targetsTeam1;
            _targetsTeam2 = targetsTeam2;
            _targetsLength = _targetsTeam1.length;
            _targetsUp = [false, false, false, false, false, false, false, false, false, false, false];
            _SHELL = _global.getCurrentShell();
            _now = _SHELL.getPenguinStandardTime();
            if (!_now) {
                _now = new Date();
            }
            _currentSecond = _now.getSeconds();
            _currentMinute = _now.getMinutes();
            _secondCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, updateTime), ONE_SECOND);
            setInitialState(_currentMinute, _currentSecond);
        }
        function destroy() {
            _displayScreen = null;
            _scoreScreen1 = null;
            _scoreScreen2 = null;
            delete _targetsTeam1;
            delete _targetsTeam2;
            delete _targetsUp;
            delete _now;
            clearInterval(_secondCheckIntervalID);
            _secondCheckIntervalID = null;
        }
        function handleThrow(snowball) {
            var _local_2 = 0;
            while (_local_2 < _targetsLength) {
                if (_targetsUp[_local_2]) {
                    if (checkThrow(snowball, _local_2)) {
                        return(true);
                    }
                }
                _local_2++;
            }
            return(false);
        }
        function checkThrow(snowball, index) {
            if (_targetsUp[index].hit.hitTest(snowball._x, snowball._y, true)) {
                snowball._visible = false;
                awardPoint(_targetsUp[index]);
                _targetsUp[index].gotoAndStop("hit");
                _targetsUp[index] = false;
                return(true);
            } else {
                return(false);
            }
        }
        function awardPoint(target) {
            var _local_2 = 0;
            while (_local_2 < _targetsLength) {
                if (target == _targetsTeam1[_local_2]) {
                    _team1Score = _team1Score + 1;
                    _scoreScreen1.score.text = _team1Score;
                    return(undefined);
                } else if (target == _targetsTeam2[_local_2]) {
                    _team2Score = _team2Score + 1;
                    _scoreScreen2.score.text = _team2Score;
                    return(undefined);
                }
                _local_2++;
            }
        }
        function setInitialState(minute, second) {
            var _local_2 = 0;
            while (_local_2 < _targetsLength) {
                _targetsTeam1[_local_2].gotoAndStop("park");
                _targetsTeam2[_local_2].gotoAndStop("park");
                _local_2++;
            }
            if (minute % 2) {
                if (second < GAME_START_SECOND) {
                    changeStateToPreGame();
                    return(undefined);
                } else {
                    changeStateToPlayGame();
                    _gameProgress = GAME_PLAY_TOTAL_DURATION - (second - GAME_START_SECOND);
                    if (second > GAME_STOP_SECOND) {
                        _currentGameMinute = 0;
                        _currentGameSecond = GAME_PLAY_TOTAL_DURATION - (second - GAME_START_SECOND);
                    } else {
                        _currentGameSecond = GAME_STOP_SECOND - second;
                    }
                }
            } else if (second >= GAME_STOP_SECOND) {
                changeStateToPostGame();
                return(undefined);
            } else {
                changeStateToPlayGame();
                _gameProgress = GAME_STOP_SECOND - second;
                _currentGameMinute = 0;
                _currentGameSecond = GAME_STOP_SECOND - second;
            }
            updateGameTimer();
        }
        function updateTime() {
            _now.setTime(_now.getTime() + ONE_SECOND);
            _currentSecond = _now.getSeconds();
            if (_currentMinute != _now.getMinutes()) {
                _currentMinute = _now.getMinutes();
            }
            targetGameCheckState(_currentMinute, _currentSecond);
        }
        function targetGameCheckState(minute, second) {
            if (_gameState == PLAY_GAME_STATE) {
                if (!(minute % 2)) {
                    playGameCheck(second);
                }
                updatePlayGame();
            } else if (_gameState == POST_GAME_STATE) {
                postGameCheck(second);
            } else if (_gameState == PRE_GAME_STATE) {
                preGameCheck(second);
            }
        }
        function preGameCheck(second) {
            if (second >= GAME_START_SECOND) {
                changeStateToPlayGame();
            }
        }
        function playGameCheck(second) {
            if (second >= GAME_STOP_SECOND) {
                changeStateToPostGame();
            }
        }
        function postGameCheck(second) {
            if (second <= GAME_STOP_SECOND) {
                changeStateToPreGame();
            }
        }
        function changeStateToPreGame() {
            _gameState = PRE_GAME_STATE;
            _displayScreen.gotoAndStop("preGame");
            _team1Score = 0;
            _team2Score = 0;
            _scoreScreen1.score.text = "00";
            _scoreScreen2.score.text = "00";
        }
        function changeStateToPlayGame() {
            _gameState = PLAY_GAME_STATE;
            _displayScreen.gotoAndStop("playGame");
            _gameProgress = GAME_PLAY_TOTAL_DURATION;
            _currentGameMinute = GAME_PLAY_MINUTE_DURATION;
            _currentGameSecond = GAME_PLAY_SECOND_DURATION;
        }
        function changeStateToPostGame() {
            var _local_2;
            _gameState = POST_GAME_STATE;
            if (_team1Score == _team2Score) {
                _displayScreen.gotoAndStop("postGameTie");
                _local_2 = 3;
            } else if (_team1Score > _team2Score) {
                _displayScreen.gotoAndStop("postGame1");
                _local_2 = 1;
            } else {
                _displayScreen.gotoAndStop("postGame2");
                _local_2 = 2;
            }
            _winningMethod(_local_2);
            settleTargets("down");
        }
        function updatePlayGame() {
            if (_gameState != PLAY_GAME_STATE) {
                return(undefined);
            }
            activateNextTarget();
            _gameProgress = _gameProgress - 1;
            _currentGameSecond = _currentGameSecond - 1;
            if (_currentGameSecond < 0) {
                var _local_2 = 59;
                _currentGameSecond = _local_2;
                _currentGameMinute = 0;
            }
            updateGameTimer();
        }
        function updateGameTimer() {
            if (_currentGameSecond < 10) {
                _displayScreen.time.text = (("0" + _currentGameMinute) + ":0") + _currentGameSecond;
            } else {
                _displayScreen.time.text = (("0" + _currentGameMinute) + ":") + _currentGameSecond;
            }
        }
        function settleTargets(label) {
            var _local_2 = 0;
            while (_local_2 < _targetsLength) {
                _targetsUp[_local_2].gotoAndStop(label);
                _targetsUp[_local_2] = false;
                _local_2++;
            }
        }
        function activateNextTarget() {
            var _local_4;
            var _local_5;
            var _local_3 = _gameProgress;
            var _local_2 = _gameProgress + _targetsDuration;
            while (_local_3 >= _targetsLength) {
                _local_3 = _local_3 - _targetsLength;
            }
            while (_local_2 >= _targetsLength) {
                _local_2 = _local_2 - _targetsLength;
            }
            if (_currentSecond % 2) {
                _local_4 = _targetsTeam1[_local_3];
                _local_5 = _targetsTeam1[_local_2];
            } else {
                _local_4 = _targetsTeam2[_local_3];
                _local_5 = _targetsTeam2[_local_2];
            }
            _targetsUp[_local_3] = _local_4;
            _targetsUp[_local_3].gotoAndStop("up");
            if (_targetsUp[_local_2]) {
                _targetsUp[_local_2].gotoAndStop("down");
                _targetsUp[_local_2] = false;
            }
        }
        var PRE_GAME_STATE = "pre";
        var PLAY_GAME_STATE = "play";
        var POST_GAME_STATE = "post";
        var GAME_START_SECOND = 15;
        var GAME_STOP_SECOND = 45;
        var GAME_PLAY_MINUTE_DURATION = 1;
        var GAME_PLAY_SECOND_DURATION = 30;
        var GAME_PLAY_TOTAL_DURATION = 90;
        var ONE_SECOND = 1000;
        var _team1Score = 0;
        var _team2Score = 0;
        var _targetsTeam1 = [];
        var _targetsTeam2 = [];
        var _targetsUp = [];
        var _targetsDuration = 4;
    }
