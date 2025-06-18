//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.GameQueueWidget
    {
        var _widget, _SHELL, _INTERFACE, _ENGINE, _roomId, _AIRTOWER, __get__isFireGame, __get__isWaterGame, _waddleID, _gameLaunched, _gameTimer, _sequence;
        function GameQueueWidget (widget) {
            _widget = widget;
            _widget._visible = false;
            _widget._x = 300;
            _widget._y = 400;
            enableButtons();
            _SHELL = _global.getCurrentShell();
            _INTERFACE = _global.getCurrentInterface();
            _ENGINE = _global.getCurrentEngine();
            _roomId = _SHELL.getCurrentServerRoomId();
            _AIRTOWER = _global.getCurrentAirtower();
            _isOpen = true;
            _SHELL.setIsGameQueWidgetOpen(_isOpen);
            addAirtowerListeners();
        }
        function set isFireGame(isFireGame) {
            _isFireGame = isFireGame;
            //return(__get__isFireGame());
        }
        function set isWaterGame(isWaterGame) {
            _isWaterGame = isWaterGame;
            //return(__get__isWaterGame());
        }
        function enableButtons() {
            _widget.close_btn.onRelease = com.clubpenguin.util.Delegate.create(this, cleanup);
            _widget.background_mc.onPress = com.clubpenguin.util.Delegate.create(this, dragWidget);
            _widget.background_mc.onRelease = com.clubpenguin.util.Delegate.create(this, stopDragWidget);
        }
        function disableButtons() {
            delete _widget.close_btn.onRelease;
            delete _widget.background_mc.onPress;
            delete _widget.background_mc.onRelease;
        }
        function dragWidget() {
            _widget.startDrag();
        }
        function stopDragWidget() {
            _widget.stopDrag();
        }
        function sendJoinGameQueueMessage(queueId, numOfPlayers, fromIgloo) {
            _waddleID = queueId;
            _isFromIgloo = fromIgloo;
            if (_isFromIgloo) {
                _INTERFACE.disableEditIglooButton();
                _SHELL.setJoinGameFromIgloo(true, _SHELL.getCurrentRoomId() - 1000);
            }
            _AIRTOWER.send(_AIRTOWER.GAME_EXT, _AIRTOWER.GET_WADDLE_CJ, [String(_waddleID)], "str", _SHELL.getCurrentServerRoomId());
            if (numOfPlayers != null) {
                _numOfPlayers = numOfPlayers;
            }
            initWidget();
            initTimer(10);
            sendJoinGameQueue(queueId);
        }
        function initWidget() {
            _gameLaunched = false;
            _widget._visible = true;
            _widget._x = 300;
            _widget._y = 400;
            _widget.gotoAndStop(_numOfPlayers - 1);
            var _local_2 = new Color(_widget.player1_mc.bodyColor_mc);
            _local_2.setRGB(_SHELL.getMyPlayerHex());
            _widget.loadingArrows1_mc._visible = false;
            _widget.name1_mc.name_txt.text = _SHELL.getMyPlayerNickname();
        }
        function initTimer(delay) {
            _gameTimer = new com.clubpenguin.util.GameTimer(_widget.timer);
            _gameTimer.setTime(delay);
        }
        function cleanup() {
            if (!_gameLaunched) {
                _SHELL.setJoinGameFromIgloo(false, "");
            }
            _INTERFACE.enableEditIglooButton();
            _ENGINE.startMouse();
            _ENGINE.movePlayerToWaddleDone();
            sendLeaveMatchMaking();
            removeAirtowerListeners();
            _SHELL.showTriggers();
            _INTERFACE.setWidgetsActive(false);
            _widget._visible = false;
            disableButtons();
            _widget._parent.gotoAndStop(2);
            _sequence.cancel();
            _numOfPlayers = 0;
            _isOpen = false;
            _SHELL.setIsGameQueWidgetOpen(_isOpen);
            _widget.removeMovieClip();
        }
        function addAirtowerListeners() {
            _AIRTOWER.addListener(MESSAGE_TICK_MM, handleTickMatchMaking, this);
            _AIRTOWER.addListener(MESSAGE_START_CARD, handleStartCard, this);
            _AIRTOWER.addListener(MESSAGE_UPDATE_WADDLE, handleUpdateWaddle, this);
            _AIRTOWER.addListener(MESSAGE_GET_WADDLE_CJ, handleGetWaddle, this);
        }
        function removeAirtowerListeners() {
            _AIRTOWER.removeListener(MESSAGE_TICK_MM, handleTickMatchMaking, this);
            _AIRTOWER.removeListener(MESSAGE_START_CARD, handleStartCard, this);
            _AIRTOWER.removeListener(MESSAGE_UPDATE_WADDLE, handleUpdateWaddle, this);
            _AIRTOWER.removeListener(MESSAGE_GET_WADDLE_CJ, handleGetWaddle, this);
        }
        function sendJoinGameQueue(queueId) {
            _AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_JOIN_MM, [queueId], SERVER_SIDE_MESSAGE_TYPE, _roomId);
        }
        function sendLeaveMatchMaking() {
            _AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_LEAVE_MM, [], SERVER_SIDE_MESSAGE_TYPE, _roomId);
        }
        function handleTickMatchMaking(networkData) {
            networkData.shift();
            var _local_7 = parseInt(networkData.shift());
            var _local_9 = parseInt(networkData.shift());
            _gameTimer.setCurrentTime(_local_9);
            var _local_10 = false;
            var _local_5 = new Array();
            while (true) {
                var _local_4 = networkData.shift();
                if (_local_4 != null) {
                    _local_5.push(_local_4.split("|"));
                } else {
                    break;
                }
            }
            _widget.gotoAndStop(_local_7);
            var _local_2 = 0;
            while (_local_2 < _local_7) {
                var _local_3 = ("" + (_local_2 + 1)) + "_mc";
                _widget["name" + _local_3].name_txt.text = _local_5[_local_2][0];
                var _local_6 = new Color(_widget["player" + _local_3].bodyColor_mc);
                _local_6.setRGB(_SHELL.getPlayerHexFromId(_local_5[_local_2][1]));
                _local_2++;
            }
        }
        function handleGetWaddle(networkData) {
            _AIRTOWER.removeListener(MESSAGE_GET_WADDLE_CJ, handleGetWaddle, this);
            networkData.shift();
            var _local_3 = new Array();
            var _local_2 = 0;
            while (_local_2 < networkData.length) {
                var _local_5 = networkData[_local_2];
                var _local_7 = _SHELL.getPlayerObjectById(_local_5);
                _local_3.push(_local_7);
                _local_2++;
            }
            _local_2 = 0;
            while (_local_2 < _local_3.length) {
                var _local_4 = ("" + (_local_2 + 2)) + "_mc";
                _widget["name" + _local_4].name_txt.text = _local_3[_local_2].nickname;
                _widget["loadingArrows" + _local_4]._visible = false;
                var _local_6 = new Color(_widget["player" + _local_4].bodyColor_mc);
                _local_6.setRGB(_SHELL.getPlayerHexFromId(_local_3[_local_2].colour_id));
                _local_2++;
            }
        }
        function handleUpdateWaddle(networkData) {
            var _local_10 = Number(networkData.shift());
            if (_local_10 != _waddleID) {
                return(undefined);
            }
            var _local_3 = Number(networkData.shift());
            var _local_7 = _local_3;
            if (_local_3 == 0) {
                _local_3 = 1;
            }
            var _local_9 = networkData.shift();
            if (_local_9 == _SHELL.getMyPlayerNickname()) {
                return(undefined);
            }
            var _local_5 = Number(networkData.shift());
            var _local_4 = _SHELL.getPlayerObjectById(_local_5);
            if (isNaN(_local_5) || (_local_5 == undefined)) {
                if ((_ENGINE.active_seat_id == 2) && (_local_7 == 1)) {
                    var _local_2 = "3_mc";
                    _widget["name" + _local_2].name_txt.text = "";
                    _widget["loadingArrows" + _local_2]._visible = true;
                    return(undefined);
                } else {
                    var _local_2 = ("" + (_local_3 + 1)) + "_mc";
                    _widget["name" + _local_2].name_txt.text = "";
                    _widget["loadingArrows" + _local_2]._visible = true;
                    return(undefined);
                }
            }
            if (_local_5 == _SHELL.getMyPlayerId()) {
                return(undefined);
            } else {
                if ((_ENGINE.active_seat_id == 2) && (_local_7 == 1)) {
                    var _local_2 = "3_mc";
                } else {
                    var _local_2 = ("" + (_local_3 + 1)) + "_mc";
                }
                _widget["name" + _local_2].name_txt.text = _local_4.nickname;
                _widget["player" + _local_2].bodyColor_mc;
                _widget["loadingArrows" + _local_2]._visible = false;
                var _local_8 = new Color(_widget["player" + _local_2].bodyColor_mc);
                _local_8.setRGB(_SHELL.getPlayerHexFromId(_local_4.colour_id));
            }
        }
        function handleStartCard(networkData) {
            var _local_12 = networkData.slice(0);
            var _local_8 = new Array(_local_12[0], _local_12[1], _local_12[3], _local_12[4]);
            networkData.shift();
            networkData.shift();
            networkData.shift();
            networkData.shift();
            networkData.shift();
            networkData.shift();
            networkData.shift();
            networkData.shift();
            networkData.shift();
            if (_numOfPlayers == 3) {
                networkData.shift();
                networkData.shift();
            } else if (_numOfPlayers == 4) {
                networkData.shift();
                networkData.shift();
                networkData.shift();
                networkData.shift();
            }
            var _local_2 = new Array();
            var _local_13 = 0;
            var _local_10 = 0;
            while (_local_10 < _numOfPlayers) {
                var _local_5 = networkData.shift();
                var _local_7 = _SHELL.getPlayerObjectById(_local_5);
                _local_2.push(_local_7);
                _local_10++;
            }
            _local_10 = 0;
            while (_local_10 < _local_2.length) {
                if (_SHELL.getMyPlayerId() == _local_2[_local_10].player_id) {
                    _widget.gotoAndStop(_numOfPlayers + 2);
                    _local_10 = 0;
                    while (_local_10 < _numOfPlayers) {
                        var _local_3 = ("" + (_local_10 + 1)) + "_mc";
                        _widget["name" + _local_3].name_txt.text = _local_2[_local_10].nickname;
                        var _local_4 = new Color(_widget["player" + _local_3].bodyColor_mc);
                        _local_4.setRGB(_SHELL.getPlayerHexFromId(_local_2[_local_10].colour_id));
                        _local_10++;
                    }
                    _sequence = new com.clubpenguin.util.Sequence();
                    _sequence.addDelay(4000);
                    _gameLaunched = true;
                    _sequence.addFunction({i:_SHELL, f:"startWaddleFromWidget", p:[_local_8]});
                    _sequence.addFunction({i:this, f:"cleanup", p:[]});
                }
                _local_10++;
            }
        }
        static var SERVER_SIDE_EXTENSION_NAME = "z";
        static var SERVER_SIDE_MESSAGE_TYPE = "str";
        static var MESSAGE_START_CARD = "cjms";
        static var MESSAGE_UPDATE_WADDLE = "uw";
        static var MESSAGE_GET_WADDLE_CJ = "gwcj";
        static var MESSAGE_JOIN_MM = "jw";
        static var MESSAGE_TICK_MM = "tmm";
        static var MESSAGE_LEAVE_MM = "lw";
        var _numOfPlayers = 2;
        var _isFireGame = false;
        var _isWaterGame = false;
        var _isFromIgloo = false;
        var _isOpen = false;
    }
