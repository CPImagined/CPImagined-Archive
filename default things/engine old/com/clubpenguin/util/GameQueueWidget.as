class com.clubpenguin.util.GameQueueWidget
{
    var _widget, _SHELL, _INTERFACE, _ENGINE, _roomId, _AIRTOWER, __get__isFireGame, __get__isWaterGame, _waddleID, _gameLaunched, _gameTimer, _sequence, __set__isFireGame, __set__isWaterGame;
    function GameQueueWidget(widget)
    {
        _widget = widget;
        _widget._visible = false;
        _widget._x = 300;
        _widget._y = 400;
        this.enableButtons();
        _SHELL = _global.getCurrentShell();
        _INTERFACE = _global.getCurrentInterface();
        _ENGINE = _global.getCurrentEngine();
        _roomId = _SHELL.getCurrentServerRoomId();
        _AIRTOWER = _global.getCurrentAirtower();
        _isOpen = true;
        _SHELL.setIsGameQueWidgetOpen(_isOpen);
        this.addAirtowerListeners();
    } // End of the function
    function set isFireGame(isFireGame)
    {
        _isFireGame = isFireGame;
        //return (this.isFireGame());
        null;
    } // End of the function
    function set isWaterGame(isWaterGame)
    {
        _isWaterGame = isWaterGame;
        //return (this.isWaterGame());
        null;
    } // End of the function
    function enableButtons()
    {
        _widget.close_btn.onRelease = com.clubpenguin.util.Delegate.create(this, cleanup);
        _widget.background_mc.onPress = com.clubpenguin.util.Delegate.create(this, dragWidget);
        _widget.background_mc.onRelease = com.clubpenguin.util.Delegate.create(this, stopDragWidget);
    } // End of the function
    function disableButtons()
    {
        delete _widget.close_btn.onRelease;
        delete _widget.background_mc.onPress;
        delete _widget.background_mc.onRelease;
    } // End of the function
    function dragWidget()
    {
        _widget.startDrag();
    } // End of the function
    function stopDragWidget()
    {
        _widget.stopDrag();
    } // End of the function
    function sendJoinGameQueueMessage(queueId, numOfPlayers, fromIgloo)
    {
        _waddleID = queueId;
        _isFromIgloo = fromIgloo;
        if (_isFromIgloo)
        {
            _INTERFACE.disableEditIglooButton();
            _SHELL.setJoinGameFromIgloo(true, _SHELL.getCurrentRoomId() - 1000);
        } // end if
        _AIRTOWER.send(_AIRTOWER.GAME_EXT, _AIRTOWER.GET_WADDLE_CJ, [String(_waddleID)], "str", _SHELL.getCurrentServerRoomId());
        if (numOfPlayers != null)
        {
            _numOfPlayers = numOfPlayers;
        } // end if
        this.initWidget();
        this.initTimer(10);
        this.sendJoinGameQueue(queueId);
    } // End of the function
    function initWidget()
    {
        _gameLaunched = false;
        _widget._visible = true;
        _widget._x = 300;
        _widget._y = 400;
        _widget.gotoAndStop(_numOfPlayers - 1);
        var _loc2 = new Color(_widget.player1_mc.bodyColor_mc);
        _loc2.setRGB(_SHELL.getMyPlayerHex());
        _widget.loadingArrows1_mc._visible = false;
        _widget.name1_mc.name_txt.text = _SHELL.getMyPlayerNickname();
    } // End of the function
    function initTimer(delay)
    {
        _gameTimer = new com.clubpenguin.util.GameTimer(_widget.timer);
        _gameTimer.setTime(delay);
    } // End of the function
    function cleanup()
    {
        if (!_gameLaunched)
        {
            _SHELL.setJoinGameFromIgloo(false, "");
        } // end if
        _INTERFACE.enableEditIglooButton();
        _ENGINE.startMouse();
        _ENGINE.movePlayerToWaddleDone();
        this.sendLeaveMatchMaking();
        this.removeAirtowerListeners();
        _SHELL.showTriggers();
        _INTERFACE.setWidgetsActive(false);
        _widget._visible = false;
        this.disableButtons();
        _widget._parent.gotoAndStop(2);
        _sequence.cancel();
        _numOfPlayers = 0;
        _isOpen = false;
        _SHELL.setIsGameQueWidgetOpen(_isOpen);
        _widget.removeMovieClip();
    } // End of the function
    function addAirtowerListeners()
    {
        _AIRTOWER.addListener(com.clubpenguin.util.GameQueueWidget.MESSAGE_TICK_MM, handleTickMatchMaking, this);
        _AIRTOWER.addListener(com.clubpenguin.util.GameQueueWidget.MESSAGE_START_CARD, handleStartCard, this);
        _AIRTOWER.addListener(com.clubpenguin.util.GameQueueWidget.MESSAGE_UPDATE_WADDLE, handleUpdateWaddle, this);
        _AIRTOWER.addListener(com.clubpenguin.util.GameQueueWidget.MESSAGE_GET_WADDLE_CJ, handleGetWaddle, this);
    } // End of the function
    function removeAirtowerListeners()
    {
        _AIRTOWER.removeListener(com.clubpenguin.util.GameQueueWidget.MESSAGE_TICK_MM, handleTickMatchMaking, this);
        _AIRTOWER.removeListener(com.clubpenguin.util.GameQueueWidget.MESSAGE_START_CARD, handleStartCard, this);
        _AIRTOWER.removeListener(com.clubpenguin.util.GameQueueWidget.MESSAGE_UPDATE_WADDLE, handleUpdateWaddle, this);
        _AIRTOWER.removeListener(com.clubpenguin.util.GameQueueWidget.MESSAGE_GET_WADDLE_CJ, handleGetWaddle, this);
    } // End of the function
    function sendJoinGameQueue(queueId)
    {
        _AIRTOWER.send(com.clubpenguin.util.GameQueueWidget.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.util.GameQueueWidget.MESSAGE_JOIN_MM, [queueId], com.clubpenguin.util.GameQueueWidget.SERVER_SIDE_MESSAGE_TYPE, _roomId);
    } // End of the function
    function sendLeaveMatchMaking()
    {
        _AIRTOWER.send(com.clubpenguin.util.GameQueueWidget.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.util.GameQueueWidget.MESSAGE_LEAVE_MM, [], com.clubpenguin.util.GameQueueWidget.SERVER_SIDE_MESSAGE_TYPE, _roomId);
    } // End of the function
    function handleTickMatchMaking(networkData)
    {
        networkData.shift();
        var _loc7 = parseInt(networkData.shift());
        var _loc9 = parseInt(networkData.shift());
        _gameTimer.setCurrentTime(_loc9);
        var _loc10 = false;
        var _loc5 = new Array();
        while (true)
        {
            var _loc4 = networkData.shift();
            if (_loc4 != null)
            {
                _loc5.push(_loc4.split("|"));
                continue;
            } // end if
            break;
        } // end while
        _widget.gotoAndStop(_loc7);
        for (var _loc2 = 0; _loc2 < _loc7; ++_loc2)
        {
            var _loc3 = "" + (_loc2 + 1) + "_mc";
            _widget["name" + _loc3].name_txt.text = _loc5[_loc2][0];
            var _loc6 = new Color(_widget["player" + _loc3].bodyColor_mc);
            _loc6.setRGB(_SHELL.getPlayerHexFromId(_loc5[_loc2][1]));
        } // end of for
    } // End of the function
    function handleGetWaddle(networkData)
    {
        _AIRTOWER.removeListener(com.clubpenguin.util.GameQueueWidget.MESSAGE_GET_WADDLE_CJ, handleGetWaddle, this);
        networkData.shift();
        var _loc3 = new Array();
        for (var _loc2 = 0; _loc2 < networkData.length; ++_loc2)
        {
            var _loc5 = networkData[_loc2];
            var _loc7 = _SHELL.getPlayerObjectById(_loc5);
            _loc3.push(_loc7);
        } // end of for
        for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
        {
            var _loc4 = "" + (_loc2 + 2) + "_mc";
            _widget["name" + _loc4].name_txt.text = _loc3[_loc2].nickname;
            _widget["loadingArrows" + _loc4]._visible = false;
            var _loc6 = new Color(_widget["player" + _loc4].bodyColor_mc);
            _loc6.setRGB(_SHELL.getPlayerHexFromId(_loc3[_loc2].colour_id));
        } // end of for
    } // End of the function
    function handleUpdateWaddle(networkData)
    {
        var _loc10 = Number(networkData.shift());
        if (_loc10 != _waddleID)
        {
            return;
        } // end if
        var _loc3 = Number(networkData.shift());
        var _loc7 = _loc3;
        if (_loc3 == 0)
        {
            _loc3 = 1;
        } // end if
        var _loc9 = networkData.shift();
        if (_loc9 == _SHELL.getMyPlayerNickname())
        {
            return;
        } // end if
        var _loc5 = Number(networkData.shift());
        var _loc4 = _SHELL.getPlayerObjectById(_loc5);
        if (isNaN(_loc5) || _loc5 == undefined)
        {
            if (_ENGINE.active_seat_id == 2 && _loc7 == 1)
            {
                var _loc2 = "3_mc";
                _widget["name" + _loc2].name_txt.text = "";
                _widget["loadingArrows" + _loc2]._visible = true;
                return;
            }
            else
            {
                _loc2 = "" + (_loc3 + 1) + "_mc";
                _widget["name" + _loc2].name_txt.text = "";
                _widget["loadingArrows" + _loc2]._visible = true;
                return;
            } // end if
        } // end else if
        if (_loc5 == _SHELL.getMyPlayerId())
        {
            return;
        }
        else
        {
            if (_ENGINE.active_seat_id == 2 && _loc7 == 1)
            {
                _loc2 = "3_mc";
            }
            else
            {
                _loc2 = "" + (_loc3 + 1) + "_mc";
            } // end else if
            _widget["name" + _loc2].name_txt.text = _loc4.nickname;
            _widget["player" + _loc2].bodyColor_mc;
            _widget["loadingArrows" + _loc2]._visible = false;
            var _loc8 = new Color(_widget["player" + _loc2].bodyColor_mc);
            _loc8.setRGB(_SHELL.getPlayerHexFromId(_loc4.colour_id));
        } // end else if
    } // End of the function
    function handleStartCard(networkData)
    {
        var _loc12 = networkData.slice(0);
        var _loc8 = new Array(_loc12[0], _loc12[1], _loc12[3], _loc12[4]);
        networkData.shift();
        networkData.shift();
        networkData.shift();
        networkData.shift();
        networkData.shift();
        networkData.shift();
        networkData.shift();
        networkData.shift();
        networkData.shift();
        if (_numOfPlayers == 3)
        {
            networkData.shift();
            networkData.shift();
        }
        else if (_numOfPlayers == 4)
        {
            networkData.shift();
            networkData.shift();
            networkData.shift();
            networkData.shift();
        } // end else if
        var _loc2 = new Array();
        var _loc13 = 0;
        for (var _loc10 = 0; _loc10 < _numOfPlayers; ++_loc10)
        {
            var _loc5 = networkData.shift();
            var _loc7 = _SHELL.getPlayerObjectById(_loc5);
            _loc2.push(_loc7);
        } // end of for
        for (var _loc10 = 0; _loc10 < _loc2.length; ++_loc10)
        {
            if (_SHELL.getMyPlayerId() == _loc2[_loc10].player_id)
            {
                _widget.gotoAndStop(_numOfPlayers + 2);
                for (var _loc10 = 0; _loc10 < _numOfPlayers; ++_loc10)
                {
                    var _loc3 = "" + (_loc10 + 1) + "_mc";
                    _widget["name" + _loc3].name_txt.text = _loc2[_loc10].nickname;
                    var _loc4 = new Color(_widget["player" + _loc3].bodyColor_mc);
                    _loc4.setRGB(_SHELL.getPlayerHexFromId(_loc2[_loc10].colour_id));
                } // end of for
                _sequence = new com.clubpenguin.util.Sequence();
                _sequence.addDelay(4000);
                _gameLaunched = true;
                _sequence.addFunction({i: _SHELL, f: "startWaddleFromWidget", p: [_loc8]});
                _sequence.addFunction({i: this, f: "cleanup", p: []});
            } // end if
        } // end of for
    } // End of the function
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
} // End of Class
