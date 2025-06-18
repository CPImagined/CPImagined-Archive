//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.Cinematic
    {
        var _SHELL, _ENGINE, nextRoom, nextRoomX, nextRoomY, currentPlayerAnchor, otherPlayersAnchor, _roomChangeID, _intervalID, _prevAnchorSelfPosX, _prevAnchorSelfPosY, _prevAnchorOtherPosX, _prevAnchorOtherPosY, playerList, currentPlayer;
        function Cinematic (roomChangeDelay, newRoom, newRoomX, newRoomY, hidePenguinSelf, hidePenguinOthers, hideNameSelf, hideNameOthers, hideSpeechSelf, hideSpeechOthers, anchorPlayerSelf, anchorPlayerOthers) {
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            nextRoom = newRoom;
            nextRoomX = newRoomX;
            nextRoomY = newRoomY;
            currentPlayerAnchor = anchorPlayerSelf;
            otherPlayersAnchor = anchorPlayerOthers;
            _SHELL.quietAirtower();
            sortPlayers();
            clearInterval(_roomChangeID);
            _roomChangeID = setInterval(roomChangeHandler, roomChangeDelay, this);
            if (hidePenguinSelf) {
                hideCurrentPenguin();
            }
            if (hidePenguinOthers) {
                hideOtherPenguins();
            }
            if (hideNameSelf) {
                hideCurrentPlayerName();
            }
            if (hideNameOthers) {
                hideOtherPlayersNames();
            }
            if (hideSpeechSelf) {
                hideCurrentPlayerSpeech();
            }
            if (hideSpeechOthers) {
                hideOtherPlayersSpeech();
            }
            if ((anchorPlayerSelf != undefined) || (anchorPlayerOthers != undefined)) {
                clearInterval(_intervalID);
                _intervalID = setInterval(intervalHandler, _intervalDelay, this);
                if (anchorPlayerSelf != undefined) {
                    _prevAnchorSelfPosX = anchorPlayerSelf._x;
                    _prevAnchorSelfPosY = anchorPlayerSelf._y;
                }
                if (anchorPlayerOthers != undefined) {
                    _prevAnchorOtherPosX = anchorPlayerOthers._x;
                    _prevAnchorOtherPosY = anchorPlayerOthers._y;
                }
            }
        }
        function sortPlayers() {
            playerList = _SHELL.getPlayerList();
            var _local_2 = 0;
            while (_local_2 < playerList.length) {
                if (playerList[_local_2].player_id != _SHELL.getMyPlayerId()) {
                    otherPlayers.push(_SHELL.getPlayerObjectById(playerList[_local_2].player_id));
                } else {
                    currentPlayer = _SHELL.getPlayerObjectById(playerList[_local_2].player_id);
                }
                _local_2++;
            }
        }
        function roomChangeHandler(_this) {
            clearInterval(_this._roomChangeID);
            clearInterval(_this._intervalID);
            _this._SHELL.enableAirtower();
            _this._ENGINE.sendJoinRoom(_this.nextRoom, _this.nextRoomX, _this.nextRoomY);
        }
        function hideCurrentPenguin() {
            _ENGINE.getPlayerMovieClip(currentPlayer.player_id)._visible = false;
        }
        function hideOtherPenguins() {
            var _local_2 = 0;
            while (_local_2 < otherPlayers.length) {
                _ENGINE.getPlayerMovieClip(otherPlayers[_local_2].player_id)._visible = false;
                _local_2++;
            }
        }
        function hideCurrentPlayerName() {
            _ENGINE.getNicknameMovieClip(currentPlayer.player_id)._visible = false;
        }
        function hideOtherPlayersNames() {
            var _local_2 = 0;
            while (_local_2 < otherPlayers.length) {
                _ENGINE.getNicknameMovieClip(otherPlayers[_local_2].player_id)._visible = false;
                _local_2++;
            }
        }
        function hideCurrentPlayerSpeech() {
            _ENGINE.getBalloonMovieClip(currentPlayer.player_id)._visible = false;
        }
        function hideOtherPlayersSpeech() {
            var _local_2 = 0;
            while (_local_2 < otherPlayers.length) {
                _ENGINE.getBalloonMovieClip(otherPlayers[_local_2].player_id)._visible = false;
                _local_2++;
            }
        }
        function intervalHandler(_this) {
            if (_this.currentPlayerAnchor != undefined) {
                var _local_5 = _ENGINE.getPlayerMovieClip(_this.currentPlayer.player_id);
                if (_this._prevAnchorSelfPosX != _this.currentPlayerAnchor._x) {
                    _this.playerClip._x = _this.playerClip._x - (_this._prevAnchorSelfPosX - _this.currentPlayerAnchor._x);
                    _this._prevAnchorSelfPosX = _this.currentPlayerAnchor._x;
                }
                if (_this._prevAnchorSelfPosY != _this.currentPlayerAnchor._y) {
                    _this.playerClip._y = _this.playerClip._y - (_this._prevAnchorSelfPosY - _this.currentPlayerAnchor._y);
                    _this._prevAnchorSelfPosY = _this.currentPlayerAnchor._y;
                }
            }
            if (_this.otherPlayersAnchor != undefined) {
                if (_this._prevAnchorOtherPosX != _this.otherPlayersAnchor._x) {
                    var _local_4 = 0;
                    while (_local_4 < _this.otherPlayers.length) {
                        var _local_5 = _ENGINE.getPlayerMovieClip(_this.otherPlayers[_local_4].player_id);
                        _this.playerClip._x = _this.playerClip._x - (_this._prevAnchorOtherPosX - _this.otherPlayersAnchor._x);
                        _local_4++;
                    }
                    _this._prevAnchorOtherPosX = _this.otherPlayersAnchor._x;
                }
                if (_this._prevAnchorOtherPosY != _this.otherPlayersAnchor._y) {
                    var _local_3 = 0;
                    while (_local_3 < otherPlayers.length) {
                        var _local_5 = _ENGINE.getPlayerMovieClip(_this.otherPlayers[_local_3].player_id);
                        _this.playerClip._y = _this.playerClip._y - (_this._prevAnchorOtherPosY - _this.otherPlayersAnchor._y);
                        _local_3++;
                    }
                    _this._prevAnchorOtherPosY = _this.otherPlayersAnchor._y;
                }
            }
        }
        var _intervalDelay = 40;
        var otherPlayers = [];
    }
