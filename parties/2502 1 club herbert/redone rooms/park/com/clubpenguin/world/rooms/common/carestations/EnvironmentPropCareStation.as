//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.carestations.EnvironmentPropCareStation
    {
        var _SHELL, _ENGINE, _taskNumber, _effect, _careItemID, _assetPath, _propRef, _playerLocation, _isShowStatsBarWidget, _stationPlayers, _loaderMap, _onAnimationLoadedDelegate, _onAnimationCompleteDelegate, _stationName, _stationType, _nonLocalPuffleId;
        function EnvironmentPropCareStation (taskEnum, assetPath, propRef, playerLocation) {
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            _taskNumber = taskEnum.taskNumber;
            _effect = taskEnum.effect;
            _careItemID = taskEnum.careItemID;
            _assetPath = assetPath;
            _propRef = propRef;
            _playerLocation = playerLocation;
            _isShowStatsBarWidget = true;
            _stationPlayers = new Array();
            _loaderMap = new Object();
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, com.clubpenguin.util.Delegate.create(this, handleUpdatePlayer));
            _SHELL.addListener(_SHELL.PUFFLE_PERFORMING_TRICK, com.clubpenguin.util.Delegate.create(this, handlePufflePerformingTrick));
            _onAnimationLoadedDelegate = com.clubpenguin.util.Delegate.create(this, onAnimationLoaded);
            _onAnimationCompleteDelegate = com.clubpenguin.util.Delegate.create(this, onAnimationComplete);
        }
        function stationBIInfo(stationName, stationType) {
            _stationName = stationName;
            _stationType = stationType;
        }
        function beginActivity(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                var _local_5 = _SHELL.getPlayerObjectById(players[_local_2]);
                var _local_3 = _local_5.attachedPuffle.id;
                if (((com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local_5, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE) && (_local_5.avatarVO.avatar_id != 1)) && (_ENGINE.puffleAvatarController.isPuffleVisible(_local_3))) && (_ENGINE.puffleAvatarController.getPuffleCanMove(_local_3))) {
                    var _local_9 = _ENGINE.getPlayerMovieClip(players[_local_2]);
                    _stationPlayers.push(Number(players[_local_2]));
                    var _local_7 = _SHELL.isMyPlayer(Number(players[_local_2]));
                    if ((_stationPlayers.length == 1) || (_local_7)) {
                        if (!_local_7) {
                            _nonLocalPuffleId = _local_3;
                        } else if (_nonLocalPuffleId > 0) {
                            removeNonLocalPuffleAnimation();
                        }
                        _local_9._x = _playerLocation.x;
                        _local_9._y = _playerLocation.y;
                        var _local_6 = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(players[_local_2], _local_3, _SHELL, _ENGINE, true);
                        _loaderMap[_local_3] = _local_6;
                        var _local_8 = _SHELL.getPath(_assetPath);
                        _local_8 = _local_5.attachedPuffle.getFormattedAssetURL(_local_8);
                        _local_6.playPuffleAnimation(_local_8);
                        _local_6.addEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_LOADED_EVENT, _onAnimationLoadedDelegate);
                        _local_6.addEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, _onAnimationCompleteDelegate);
                    }
                }
                if (_local_7) {
                    if ((_stationName != undefined) || (_stationType != undefined)) {
                        com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(_stationName, _stationType);
                    }
                }
                _local_2++;
            }
        }
        function removeNonLocalPuffleAnimation() {
            com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(_loaderMap[_nonLocalPuffleId]).cancelAndRemoveAnimation();
            _loaderMap[_nonLocalPuffleId] = null;
            _nonLocalPuffleId = null;
        }
        function onAnimationLoaded(event) {
            _loaderMap[event.puffleID].removeEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_LOADED_EVENT, _onAnimationLoadedDelegate);
            _propRef._visible = false;
        }
        function onAnimationComplete(event) {
            _loaderMap[event.puffleID].removeEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, _onAnimationCompleteDelegate);
            _propRef._visible = true;
            endActivity([event.playerID]);
            if (_isShowStatsBarWidget && (_SHELL.isMyPlayer(Number(event.playerID)))) {
                performAction();
            }
        }
        function performAction() {
            var _local_2 = _SHELL.getMyPlayerObject().attachedPuffle.id;
            _ENGINE.puffleAvatarController.displayPuffleWidget(_local_2, "statsBarWidget", _careItemID);
        }
        function endActivity(players) {
            var _local_3 = 0;
            while (_local_3 < _stationPlayers.length) {
                var _local_2 = 0;
                while (_local_2 < players.length) {
                    if (Number(_stationPlayers[_local_3]) == Number(players[_local_2])) {
                        _stationPlayers.splice(_local_3, 1);
                        break;
                    }
                    _local_2++;
                }
                _local_3++;
            }
        }
        function handlePufflePerformingTrick(event) {
            if (event.playerId == _SHELL.getMyPlayerId()) {
                _isShowStatsBarWidget = false;
                _loaderMap[event.puffleId].cancelAndRemoveAnimation();
                endActivity([event.playerId]);
            }
        }
        function cleanStation() {
            for (var _local_2 in _loaderMap) {
                _loaderMap[_local_2].removeEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_LOADED_EVENT, _onAnimationLoadedDelegate);
                _loaderMap[_local_2].removeEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, _onAnimationCompleteDelegate);
                _loaderMap[_local_2] = null;
            }
            _loaderMap = null;
            _nonLocalPuffleId = null;
            _SHELL.removeListener(_SHELL.UPDATE_PLAYER, handleUpdatePlayer);
            _SHELL.removeListener(_SHELL.PUFFLE_PERFORMING_TRICK, com.clubpenguin.util.Delegate.create(this, handlePufflePerformingTrick));
        }
        function handleUpdatePlayer(player_ob) {
            var _local_2 = 0;
            while (_local_2 < _stationPlayers.length) {
                if ((player_ob.player_id == _stationPlayers[_local_2]) && (!com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(player_ob, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE))) {
                    var _local_3 = new Array();
                    _local_3.push(player_ob.player_id);
                    endActivity(_local_3);
                }
                _local_2++;
            }
        }
    }
