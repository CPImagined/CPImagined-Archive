//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation
    {
        var _stationUsesEffectMC, _effectMC, _SHELL, _ENGINE, _puffleCareQuest, _taskNumber, _effect, _careItemID, _puffleFrame, _animationLoadsExternally, _assetPath, _careSound, _stationUsesSound, _hideHat, _playerLocation, _pixelPerfect, _stationPlayers, _stationName, _stationType, _activityTimer, _puffleAnimationLoader, _soundEffect;
        function HotelCareStation (hotelCareStationVO) {
            if (hotelCareStationVO.effectRef) {
                _stationUsesEffectMC = true;
                _effectMC = hotelCareStationVO.effectRef;
            } else {
                _stationUsesEffectMC = false;
            }
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            _puffleCareQuest = _SHELL.getRainbowPuffleQuest();
            _taskNumber = hotelCareStationVO.taskEnum.taskNumber;
            _effect = hotelCareStationVO.taskEnum.effect;
            _careItemID = hotelCareStationVO.taskEnum.careItemID;
            _puffleFrame = hotelCareStationVO.puffleFrame;
            if (hotelCareStationVO.assetPath) {
                _animationLoadsExternally = true;
                _assetPath = hotelCareStationVO.assetPath;
            } else {
                _animationLoadsExternally = false;
            }
            if (hotelCareStationVO.careSound) {
                _careSound = hotelCareStationVO.careSound;
                _stationUsesSound = true;
            }
            if (hotelCareStationVO.hideHat) {
                _hideHat = hotelCareStationVO.hideHat;
            }
            if (hotelCareStationVO.playerLocation) {
                _playerLocation = hotelCareStationVO.playerLocation;
                _pixelPerfect = true;
            }
            _stationPlayers = new Array();
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, com.clubpenguin.util.Delegate.create(this, handleUpdatePlayer));
            _SHELL.addListener(_SHELL.PUFFLE_PERFORMING_TRICK, com.clubpenguin.util.Delegate.create(this, handlePufflePerformingTrick));
        }
        function stationBIInfo(stationName, stationType) {
            _stationName = stationName;
            _stationType = stationType;
        }
        function beginActivity(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                var _local_6 = _ENGINE.getPlayerMovieClip(players[_local_2]);
                var _local_8 = _SHELL.getPlayerObjectById(players[_local_2]);
                var _local_4 = _local_8.attachedPuffle.id;
                if (((_puffleCareQuest.isPuffleEquipped(players[_local_2]) && (_local_8.avatarVO.avatar_id != 1)) && (_ENGINE.puffleAvatarController.isPuffleVisible(_local_4))) && (_ENGINE.puffleAvatarController.getPuffleCanMove(_local_4))) {
                    _stationPlayers.push(Number(players[_local_2]));
                    var _local_3 = _SHELL.isMyPlayer(Number(players[_local_2]));
                    if (_pixelPerfect) {
                        _local_6._x = _playerLocation.x;
                        _local_6._y = _playerLocation.y;
                    }
                    if (_stationUsesEffectMC) {
                        if (_local_3 || (_effectMC._currentframe == 1)) {
                            _effectMC.gotoAndPlay(2);
                            if (_local_3) {
                                _effectMC.onEnterFrame = com.clubpenguin.util.Delegate.create(this, effectEnterFrameHandler, _local_6);
                            }
                        }
                    } else if (_local_3) {
                        _activityTimer = setTimeout(com.clubpenguin.util.Delegate.create(this, performActionByTime), ACTIVITY_TIME);
                    }
                    if (_animationLoadsExternally) {
                        _puffleAnimationLoader = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(players[_local_2], _local_4, _SHELL, _ENGINE);
                        var _local_7 = _SHELL.getPath(_assetPath);
                        _local_7 = _local_8.attachedPuffle.getFormattedAssetURL(_local_7);
                        _puffleAnimationLoader.playPuffleAnimation(_local_7);
                    } else {
                        _ENGINE.puffleAvatarController.setFrameUpdateEnabled(_local_4, false);
                        if (_hideHat) {
                            _ENGINE.puffleAvatarController.hideHat(_local_4);
                        }
                        _ENGINE.puffleAvatarController.updatePuffleFrame(_local_4, _puffleFrame);
                    }
                    trace("HSF _stationUsesSound = " + _stationUsesSound);
                    trace("HSF _careSound.playForRemoteClients = " + _careSound.playForRemoteClients);
                    trace("HSF isMyPlayer = " + _local_3);
                    if (_stationUsesSound && (_careSound.playForRemoteClients || (_local_3))) {
                        trace("HSF PLAY SOUND");
                        _soundEffect = new Sound(_careSound.attachRef);
                        _soundEffect.attachSound(_careSound.soundLinkage);
                        _soundEffect.start(0, 999);
                    }
                }
                if (_local_3) {
                    if ((_stationName != undefined) || (_stationType != undefined)) {
                        com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(_stationName, _stationType);
                    } else {
                        trace("ERROR: Puffle BI properties have not been set.");
                    }
                }
                _local_2++;
            }
        }
        function effectEnterFrameHandler(playerMC) {
            if (_effectMC._currentframe == _effectMC._totalframes) {
                performAction();
                delete _effectMC.onEnterFrame;
            }
        }
        function performActionByTime(timeEvent) {
            clearTimeout(_activityTimer);
            performAction();
        }
        function performAction() {
            var _local_2 = _SHELL.getMyPlayerObject().attachedPuffle.id;
            _ENGINE.puffleAvatarController.displayPuffleWidget(_local_2, "statsBarWidget", _careItemID);
            if (((_SHELL.getRoomObject().room_id == 430) || (_SHELL.getRoomObject().room_id == 431)) || (_SHELL.getRoomObject().room_id == 432)) {
                completeTask();
            } else {
                return(undefined);
            }
        }
        function completeTask() {
            if (_taskNumber == undefined) {
                return(undefined);
            }
            if (((_puffleCareQuest.currentPuffleQuestTaskIndex == (_taskNumber - 1)) && (_puffleCareQuest.isNextPuffleQuestTaskAvailable())) && (!_puffleCareQuest.isTaskComplete(_taskNumber))) {
                var _local_2 = setTimeout(showQuestUI, 1000);
            }
            _puffleCareQuest.completePuffleQuestTask(_taskNumber);
        }
        function showQuestUI() {
            _global.getCurrentInterface().showContent(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.PUFFLE_QUEST_UI);
        }
        function endActivity(players) {
            var _local_4 = 0;
            while (_local_4 < _stationPlayers.length) {
                var _local_2 = 0;
                while (_local_2 < players.length) {
                    if (Number(_stationPlayers[_local_4]) == Number(players[_local_2])) {
                        _stationPlayers.splice(_local_4, 1);
                        break;
                    }
                    _local_2++;
                }
                _local_4++;
            }
            _local_4 = 0;
            while (_local_4 < players.length) {
                if (_animationLoadsExternally) {
                    _puffleAnimationLoader.cancelAndRemoveAnimation();
                } else {
                    var _local_6 = _SHELL.getPlayerObjectById(players[_local_4]);
                    var _local_5 = _local_6.attachedPuffle.id;
                    _ENGINE.puffleAvatarController.setFrameUpdateEnabled(_local_5, true);
                    _ENGINE.puffleAvatarController.updatePuffleFrame(_local_5, _ENGINE.getPlayerMovieClip(_local_6.player_id).frame);
                    _ENGINE.puffleAvatarController.showHat(_local_5);
                }
                if (_stationUsesSound) {
                    _soundEffect.stop();
                }
                if (_SHELL.isMyPlayer(players[_local_4]) || (_stationPlayers.length == 0)) {
                    delete _effectMC.onEnterFrame;
                    _effectMC.gotoAndStop(1);
                }
                _local_4++;
            }
        }
        function handlePufflePerformingTrick(event) {
            if (event.playerId == _SHELL.getMyPlayerId()) {
                endActivity([event.playerId]);
                clearInterval(_activityTimer);
            }
        }
        function cleanStation() {
            clearTimeout(_activityTimer);
            _SHELL.removeListener(_SHELL.UPDATE_PLAYER, handleUpdatePlayer);
            _SHELL.removeListener(_SHELL.PUFFLE_PERFORMING_TRICK, com.clubpenguin.util.Delegate.create(this, handlePufflePerformingTrick));
            var _local_2 = _SHELL.getMyPlayerObject();
            if (_puffleCareQuest.isPuffleEquipped(_local_2.player_id)) {
                _ENGINE.puffleAvatarController.setFrameUpdateEnabled(_local_2.attachedPuffle.id, true);
            }
            if (_stationUsesSound) {
                _soundEffect.stop();
            }
        }
        function handleUpdatePlayer(player_ob) {
            var _local_2 = 0;
            while (_local_2 < _stationPlayers.length) {
                if ((player_ob.player_id == _stationPlayers[_local_2]) && (!_puffleCareQuest.isPuffleEquipped(player_ob.player_id))) {
                    var _local_3 = new Array();
                    _local_3.push(player_ob.player_id);
                    endActivity(_local_3);
                }
                _local_2++;
            }
        }
        static var ACTIVITY_TIME = 5000;
    }
