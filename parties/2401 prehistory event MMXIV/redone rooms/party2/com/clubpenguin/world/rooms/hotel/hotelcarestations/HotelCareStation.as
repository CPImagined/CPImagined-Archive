//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation extends MovieClip
    {
        var _stationUsesEffectMC, _effectMC, _SHELL, _ENGINE, _puffleCareQuest, _taskNumber, _effect, _careItemID, _puffleFrame, _animationLoadsExternally, _assetPath, _careSound, _stationUsesSound, _stationPlayers, _stationName, _stationType, _activityTimer, _soundEffect;
        function HotelCareStation (effectRef, taskEnum, puffleFrame, assetPath, careSound) {
            super();
            if (effectRef) {
                _stationUsesEffectMC = true;
                _effectMC = effectRef;
            } else {
                _stationUsesEffectMC = false;
            }
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            _puffleCareQuest = _SHELL.getRainbowPuffleQuest();
            _taskNumber = taskEnum.taskNumber;
            _effect = taskEnum.effect;
            _careItemID = taskEnum.careItemID;
            _puffleFrame = puffleFrame;
            if (assetPath) {
                _animationLoadsExternally = true;
                _assetPath = assetPath;
            } else {
                _animationLoadsExternally = false;
            }
            if (careSound) {
                _careSound = careSound;
                _stationUsesSound = true;
            }
            _stationPlayers = new Array();
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, com.clubpenguin.util.Delegate.create(this, handleUpdatePlayer));
        }
        function stationBIInfo(stationName, stationType) {
            _stationName = stationName;
            _stationType = stationType;
        }
        function beginActivity(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                var _local_8 = _ENGINE.getPlayerMovieClip(players[_local_2]);
                var _local_7 = _SHELL.getPlayerObjectById(players[_local_2]);
                var _local_4 = _local_7.attachedPuffle.id;
                if ((_puffleCareQuest.isPuffleEquipped(players[_local_2]) && (_ENGINE.puffleAvatarController.isPuffleVisible(_local_4))) && (_local_7.avatarVO.avatar_id != 1)) {
                    _stationPlayers.push(Number(players[_local_2]));
                    var _local_5 = _SHELL.isMyPlayer(Number(players[_local_2]));
                    if (_stationUsesEffectMC) {
                        if (_local_5 || (_effectMC._currentframe == 1)) {
                            _effectMC.gotoAndPlay(2);
                            if (_local_5) {
                                _effectMC.onEnterFrame = com.clubpenguin.util.Delegate.create(this, effectEnterFrameHandler, _local_8);
                            }
                        }
                    } else if (_local_5) {
                        _activityTimer = setTimeout(com.clubpenguin.util.Delegate.create(this, performAction), ACTIVITY_TIME);
                    }
                    if (_animationLoadsExternally) {
                        var _local_9 = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(players[_local_2], _local_4, _SHELL, _ENGINE);
                        var _local_6 = _SHELL.getPath(_assetPath);
                        _local_6 = _local_7.attachedPuffle.getFormattedAssetURL(_local_6);
                        _local_9.playPuffleAnimation(_local_6);
                    } else {
                        _ENGINE.puffleAvatarController.setFrameUpdateEnabled(_local_4, false);
                        _ENGINE.puffleAvatarController.hideHat(_local_4);
                        _ENGINE.puffleAvatarController.updatePuffleFrame(_local_4, _puffleFrame);
                    }
                    if (_stationUsesSound) {
                        _soundEffect = new Sound(_careSound.attachRef);
                        _soundEffect.attachSound(_careSound.soundLinkage);
                        _soundEffect.start(0, 999);
                    }
                }
                if (_local_5) {
                    if ((_stationName != undefined) || (_stationType != undefined)) {
                        com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(_stationName, _stationType);
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
                var _local_6 = _SHELL.getPlayerObjectById(players[_local_4]);
                var _local_5 = _local_6.attachedPuffle.id;
                _ENGINE.puffleAvatarController.setFrameUpdateEnabled(_local_5, true);
                _ENGINE.puffleAvatarController.updatePuffleFrame(_local_5, _ENGINE.getPlayerMovieClip(_local_6.player_id).frame);
                _ENGINE.puffleAvatarController.showHat(_local_5);
                if (_stationUsesSound) {
                    _soundEffect.stop();
                }
                if (_SHELL.isMyPlayer(players[_local_4]) || (_stationPlayers.length == 0)) {
                    delete _effectMC.onEnterFrame;
                    clearTimeout(_activityTimer);
                    _effectMC.gotoAndStop(1);
                }
                _local_4++;
            }
        }
        function cleanStation() {
            _SHELL.removeListener(_SHELL.UPDATE_PLAYER, handleUpdatePlayer);
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
