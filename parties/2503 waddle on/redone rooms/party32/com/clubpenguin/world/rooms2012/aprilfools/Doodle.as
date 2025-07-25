﻿//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.aprilfools.Doodle extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, hideRoomElements, setupNavigationButtons, _SHELL, _INTERFACE, _updatePlayerDelegate, _playerMoveDelegate, _playerMoveDoneDelegate, _addPlayerDelegate, _removePlayerDelegate, _destroyDelegate, _ENGINE;
        function Doodle (stageReference) {
            super();
            _stage = stageReference;
            hideRoomElements();
            _stage.start_x = 265;
            _stage.start_y = 300;
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.boxBtn, 225, 335)]);
            _stage.triggers_mc.boxDimension.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitPortal);
			if (!_SHELL) {
				init();
			};
        }
        function exitPortal() {
            _SHELL.sendJoinRoom("boxdimension", 630, 240);
        }
        function init() {
            _playerList = _SHELL.getPlayerList();
            startUpDoodleAttachment();
            _stage.foreground_mc.pencilAnimation.pencilBtn.onRelease = com.clubpenguin.util.Delegate.create(this, makePencilDraw);
            _stage.onEnterFrame = com.clubpenguin.util.Delegate.create(this, moveDoodles);
            _updatePlayerDelegate = com.clubpenguin.util.Delegate.create(this, handleUpdatePlayer);
            _playerMoveDelegate = com.clubpenguin.util.Delegate.create(this, handleStartMove);
            _playerMoveDoneDelegate = com.clubpenguin.util.Delegate.create(this, handleEndMove);
            _addPlayerDelegate = com.clubpenguin.util.Delegate.create(this, handleNewPlayer);
            _removePlayerDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerExit);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, _updatePlayerDelegate);
            _SHELL.addListener(_SHELL.PLAYER_MOVE, _playerMoveDelegate);
            _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, _playerMoveDoneDelegate);
            _SHELL.addListener(_SHELL.ADD_PLAYER, _addPlayerDelegate);
            _SHELL.addListener(_SHELL.REMOVE_PLAYER, _removePlayerDelegate);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
			var obj = _ENGINE.getPlayerMovieClip(_SHELL.getMyPlayerId());
			obj._alpha = 0;
			_ENGINE._puffleShouldBeDisplayed = false;
			_ENGINE.puffleAvatarController.detachPuffle(_SHELL.getPlayerObjectFromRoomById(_SHELL.getMyPlayerId()).attachedPuffle.id);
			var _local_2 = 0;
			while (_local_2 < _playerList.length) {
                var _local_3 = _playerList[_local_2].player_id;
                _ENGINE.getPlayerMovieClip(_local_3)._alpha = 0;
                _local_2++;
            };
        }
        function pressScavengerItem() {
        }
        function destroy() {
			_ENGINE._puffleShouldBeDisplayed = true;
            _stage.onEnterFrame = null;
            _stage = null;
            var _local_2 = 0;
            while (_local_2 < _playerList.length) {
                var _local_3 = "doodleClip" + _playerList[_local_2].player_id;
                destroyDoodle(_local_3);
                _local_2++;
            }
            _SHELL.removeListener(_SHELL.UPDATE_PLAYER, _updatePlayerDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_MOVE, _playerMoveDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, _playerMoveDoneDelegate);
            _SHELL.removeListener(_SHELL.ADD_PLAYER, _addPlayerDelegate);
            _SHELL.removeListener(_SHELL.REMOVE_PLAYER, _removePlayerDelegate);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            for (var _local_4 in this) {
                var _local_4 = null;
            }
        }
        function destroyDoodle(index) {
            _doodleList[index].playerObject = null;
            _doodleList[index].playerClip = null;
            removeMovieClip(_doodleList[index].doodle);
            delete _doodleList[index];
        }
        function handlePlayerExit(event) {
            var _local_2 = "doodleClip" + event;
            destroyDoodle(_local_2);
        }
        function handleUpdatePlayer(event) {
            var _local_2 = _doodleList["doodleClip" + event.player_id];
            var _local_3 = _local_2.playerObject;
            _local_2.colourFrame = fetchDoodleColourFrame(_local_3);
            _local_2.hasHat = isDoodleWearingAHat(_local_3);
			_local_2.isBuddy = _INTERFACE.isBuddy(event.player_id);
            updateDoodle(_local_2);
        }
        function handleStartMove(event) {
			var obj = _ENGINE.getPlayerMovieClip(event.player_id);
			obj._alpha = 0;
            var _local_4 = "player_id" + event.player_id;
            var _local_2 = "doodleClip" + event.player_id;
            if (_doodleList[_local_2].playerClip == undefined) {
                _doodleList[_local_2].playerClip = _ENGINE.getPlayerMovieClip(event.player_id);
            }
            _doodleList[_local_2].doodle.play();
            _movingPenguins.push(event.player_id);
            _movingPenguinsCount = _movingPenguins.length;
        }
        function handleEndMove(event) {
			var obj = _ENGINE.getPlayerMovieClip(event.player_id);
			obj._alpha = 0;
            var _local_4 = "doodleClip" + event.player_id;
            _doodleList[_local_4].doodle.gotoAndStop("park");
            var _local_2 = 0;
            while (_local_2 < _movingPenguins.length) {
                if (_movingPenguins[_local_2] == event.player_id) {
                    _movingPenguins.splice(_local_2, 1);
                }
                _local_2++;
            }
            _movingPenguinsCount = _movingPenguins.length;
        }
        function moveDoodles() {
            var _local_3 = 0;
            while (_local_3 < _movingPenguinsCount) {
                var _local_2 = "doodleClip" + _movingPenguins[_local_3];
                _doodleList[_local_2].doodle._x = _doodleList[_local_2].playerClip._x;
                _doodleList[_local_2].doodle._y = _doodleList[_local_2].playerClip._y;
                _local_3++;
            }
			var _local_2 = 0;
			while (_local_2 < _playerList.length) {
                var _local_3 = _playerList[_local_2].player_id;
                _ENGINE.getPlayerMovieClip(_local_3)._alpha = 0;
                _local_2++;
            };
        }
        function updateDoodle(doodleVO) {
            doodleVO.doodle.doodleColour.gotoAndStop(doodleVO.colourFrame);
            doodleVO.doodle.doodleHat.gotoAndStop((doodleVO.hasHat ? 1 : 0) + 1);
			if (doodleVO.isCurrentPlayer) {
				doodleVO.doodle.doodleCircle.gotoAndStop(2);
			} else if (doodleVO.isBuddy) {
				doodleVO.doodle.doodleCircle.gotoAndStop(3);
			} else {
				doodleVO.doodle.doodleCircle.gotoAndStop(1);
			};
			var _local_4 = doodleVO.playerObject.player_id;
            var _local_3 = _SHELL.getPlayerObjectFromRoomById(_local_4);
            var _local_2 = "none";
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local_3, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                _local_2 = _local_3.attachedPuffle["color"];
            };
			doodleVO.doodle.doodlePuffle.gotoAndStop(_local_2);
        }
        function startUpDoodleAttachment() {
            var _local_2 = 0;
            while (_local_2 < _playerList.length) {
                createNewDoodle(_playerList[_local_2]);
                _local_2++;
            }
        }
        function handleNewPlayer(event) {
			var obj = _ENGINE.getPlayerMovieClip(event.player_id);
			obj._alpha = 0;
			_ENGINE.puffleAvatarController.detachPuffle(_SHELL.getPlayerObjectFromRoomById(event.player_id).attachedPuffle.id);
            createNewDoodle(event);
        }
        function createNewDoodle(player) {
            var _local_9;
            var _local_4;
            var _local_5 = fetchDoodleColourFrame(player);
            var _local_6 = isDoodleWearingAHat(player);
            var _local_7 = _SHELL.isMyPlayer(player.player_id);
			var buddy = _INTERFACE.isBuddy(player.player_id);
            var _local_3 = "doodleClip" + player.player_id;
            var _local_8 = {_x:player.x, _y:player.y};
            _stage.background_mc.attachMovie("penguinDoodle", "doodleClip" + player.player_id, _stage.background_mc.getNextHighestDepth(), _local_8);
            _local_4 = _stage.background_mc["doodleClip" + player.player_id];
            _local_4.gotoAndStop("park");
            _doodleList[_local_3] = new com.clubpenguin.world.rooms.common.DoodleVO(player, _local_9, _local_4, _local_5, _local_6, _local_7, buddy);
            updateDoodle(_doodleList[_local_3]);
			var obj = _ENGINE.getPlayerMovieClip(player.player_id);
			obj._alpha = 0;
        }
        function fetchDoodleColourFrame(player) {
            return(player.colour_id);
        }
        function isDoodleWearingAHat(player) {
            if (player.head != 0) {
                return(true);
            }
            return(false);
        }
        function makePencilDraw() {
            _stage.foreground_mc.pencilAnimation.play();
        }
        static var CLASS_NAME = "Doodle";
        static var SCAVENGER_HUNT_ITEM_NUMBER = 2;
        var _playerList = [];
        var _doodleList = [];
        var _movingPenguins = [];
        var _movingPenguinsCount = 0;
    }
