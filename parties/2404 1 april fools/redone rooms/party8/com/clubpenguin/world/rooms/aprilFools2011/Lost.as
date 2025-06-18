//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.aprilFools2011.Lost extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, hideRoomElements, setupNavigationButtons, showContent, opcodeJournal, _SHELL, _currentPlayerClip, _ENGINE, _playerMoveDelegate, _playerTalkDelegate, _addRemovePlayerDelegate, _roomDestroyedDelegate, _now, _pianoTriggersLength, _flowerTriggersLength, _playerListLength;
        function Lost (stageReference) {
            super();
            _stage = stageReference;
            hideRoomElements();
            _stage.start_x = 660;
            _stage.start_y = 110;
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.boxBtn, 635, 80), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.headRight["button"], 500, 220), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.headLeft["button"], 220, 210), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.clock["button"], 130, 110)]);
            _stage.headRight["button"].useHandCursor = false;
            _stage.headLeft["button"].useHandCursor = false;
            _stage.clock["button"].useHandCursor = false;
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.locker.lockerBtn, true, "fools_locker", "")]);
            _stage.triggers_mc.boxDimension.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitRoom);
            opcodeJournal = new com.clubpenguin.world.rooms.aprilFools2011.OpcodeJournal();
        }
        function exitRoom() {
            _SHELL.sendJoinRoom("boxdimension", 240, 345);
        }
        function init() {
            var _local_2 = _SHELL.getMyPlayerObject();
            _currentPlayerClip = _ENGINE.getPlayerMovieClip(_local_2.player_id);
            var _local_3 = _SHELL.getMyPlayerId();
            opcodeJournal.init(_local_3);
            opcodeJournal.sendOpcodeLostDimensionEnterRoom();
            setupClock();
            definePianoTriggersAndClips();
            defineFlowerTriggersAndClips();
            _stage.locker.lockerStartBtn.onPress = function () {
                this._parent.play();
            };
            handleAddRemovePlayer();
            _stage.onEnterFrame = com.clubpenguin.util.Delegate.create(this, frameCheck);
            _playerMoveDelegate = com.clubpenguin.util.Delegate.create(this, handleStartMove);
            _playerTalkDelegate = com.clubpenguin.util.Delegate.create(this, handleTalk);
            _addRemovePlayerDelegate = com.clubpenguin.util.Delegate.create(this, handleAddRemovePlayer);
            _roomDestroyedDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.PLAYER_MOVE, _playerMoveDelegate);
            _SHELL.addListener(_SHELL.SENDING_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_SAFE_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_LINE_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_QUICK_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_TOUR_GUIDE_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_MASCOT_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_JOKE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.ADD_PLAYER, _addRemovePlayerDelegate);
            _SHELL.addListener(_SHELL.REMOVE_PLAYER, _addRemovePlayerDelegate);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _roomDestroyedDelegate);
        }
        function destroy() {
            _stage.onEnterFrame = null;
            _stage = null;
            _SHELL.removeListener(_SHELL.PLAYER_MOVE, _playerMoveDelegate);
            _SHELL.removeListener(_SHELL.SEND_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SENDING_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_SAFE_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_LINE_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_QUICK_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_TOUR_GUIDE_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_MASCOT_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_JOKE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.ADD_PLAYER, _addRemovePlayerDelegate);
            _SHELL.removeListener(_SHELL.REMOVE_PLAYER, _addRemovePlayerDelegate);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _roomDestroyedDelegate);
        }
        function setupClock() {
            _now = _SHELL.getPenguinStandardTime();
            var _local_3 = _now.getSeconds();
            var _local_2 = Math.floor(_stage.clock.clock.hourHand._totalframes * (_local_3 / 60));
            _stage.clock.clock.hourHand.gotoAndPlay(_local_2);
            _stage.clock.clock.minuteHand.gotoAndPlay(_local_2);
            _stage.clock.clockDoor.gotoAndPlay(_local_2);
        }
        function definePianoTriggersAndClips() {
            var _local_2 = 1;
            while (_local_2 <= PIANO_TRIGGERS_AMOUNT) {
                _pianoTriggers.push(_stage.triggers_mc["piano" + _local_2]);
                _local_2++;
            }
            _pianoTriggersLength = _pianoTriggers.length;
            _pianoTriggerClips = [_stage.pianoBridge.pianoKey1, _stage.pianoBridge.pianoKey2, _stage.pianoBridge.pianoKey3, _stage.pianoBridge.pianoKey4, _stage.pianoBridge.pianoKey5, _stage.pianoBridge.pianoKey6, _stage.pianoBridge.pianoKey7, _stage.pianoBridge.pianoKey8];
        }
        function defineFlowerTriggersAndClips() {
            var _local_2 = 1;
            while (_local_2 <= FLOWER_TRIGGERS_AMOUNT) {
                _flowerTriggers.push(_stage.triggers_mc["flowerGroup" + _local_2]);
                _local_2++;
            }
            _flowerTriggersLength = _flowerTriggers.length;
            _flowerTriggerClips = [[_stage.flower75, _stage.flower9, _stage.flower8], [_stage.flower85, _stage.flower86, _stage.flower7], [_stage.flower1, _stage.flower99], [_stage.flower2, _stage.flower108, _stage.flower109], [_stage.flower3], [_stage.flower4, _stage.flower63, _stage.flower120], [_stage.flower64, _stage.flower121], [_stage.flower5, _stage.flower110, _stage.flower61, _stage.flower62], [_stage.flower40, _stage.flower41, _stage.flower100], [_stage.flower6, _stage.flower27, _stage.flower98], [_stage.flower10, _stage.flower76, _stage.flower77], [_stage.flower26, _stage.flower83, _stage.flower84], [_stage.flower11, _stage.flower14, _stage.flower79], [_stage.flower12, _stage.flower13, _stage.flower78], [_stage.flower28, _stage.flower87, _stage.flower97], [_stage.flower25, _stage.flower88, _stage.flower89], [_stage.flower15, _stage.flower17, _stage.flower82], [_stage.flower16, _stage.flower80, _stage.flower81], [_stage.flower18, _stage.flower19, _stage.flower91], [_stage.flower20, _stage.flower24, _stage.flower90], [_stage.flower21, _stage.flower22, _stage.flower92], [_stage.flower23, _stage.flower33, _stage.flower101], [_stage.flower32, _stage.flower93, _stage.flower94], [_stage.flower31, _stage.flower37, _stage.flower95], [_stage.flower38, _stage.flower39, _stage.flower106], [_stage.flower42, _stage.flower43, _stage.flower107], [_stage.flower35, _stage.flower36, _stage.flower45, _stage.flower105], [_stage.flower34, _stage.flower102, _stage.flower104], [_stage.flower46, _stage.flower47], [_stage.flower48], [_stage.flower49, _stage.flower114, _stage.flower115], [_stage.flower50, _stage.flower51, _stage.flower118], [_stage.flower44, _stage.flower56, _stage.flower112, _stage.flower113], [_stage.flower59, _stage.flower60, _stage.flower111], [_stage.flower58, _stage.flower65, _stage.flower119], [_stage.flower57, _stage.flower130], [_stage.flower54, _stage.flower55, _stage.flower129], [_stage.flower52, _stage.flower116, _stage.flower117, _stage.flower128], [_stage.flower53, _stage.flower126, _stage.flower127], [_stage.flower68, _stage.flower69, _stage.flower125], [_stage.flower70, _stage.flower71, _stage.flower72, _stage.flower122], [_stage.flower66, _stage.flower67, _stage.flower131], [_stage.flower74, _stage.flower123], [_stage.flower73, _stage.flower124]];
        }
        function handleTalk(event) {
            var _local_2 = _SHELL.getPlayerObjectById(event.player_id);
            if (_stage.triggers_mc.hitHeadLeft.hitTest(_local_2.x, _local_2.y)) {
                _stage.headLeft.beak.play();
                opcodeJournal.sendOpcodeLostDimensionSpeech();
            } else if (_stage.triggers_mc.hitHeadRight.hitTest(_local_2.x, _local_2.y)) {
                _stage.headRight.beak.play();
                opcodeJournal.sendOpcodeLostDimensionSpeech();
            }
        }
        function handleStartMove(event) {
            if (isMyPlayer(event)) {
                var _local_4 = 50;
                var _local_5 = 280;
                var _local_2 = 600;
                if ((event.y > _local_5) && (event.x < _local_2)) {
                    animateBoxIfAtFrame(1);
                } else if (event.x > _local_2) {
                    animateBoxIfAtFrame(_local_4);
                }
            }
        }
        function isMyPlayer(player) {
            if (player.player_id == _SHELL.getMyPlayerId()) {
                return(true);
            }
            return(false);
        }
        function handleAddRemovePlayer() {
            _playerList = _SHELL.getPlayerList();
            _playerListLength = _playerList.length;
        }
        function animateBoxIfAtFrame(frame) {
            if (_stage.background_mc.boxBtn._currentframe == frame) {
                _stage.background_mc.boxBtn.play();
            }
        }
        function frameCheck() {
            var _local_3 = 0;
            while (_local_3 < _pianoTriggersLength) {
                if (isTriggerPressedAll(_pianoTriggers[_local_3])) {
                    _pianoTriggerClips[_local_3].gotoAndStop("down");
                } else {
                    _pianoTriggerClips[_local_3].gotoAndStop("up");
                }
                _local_3++;
            }
            var _local_4 = 0;
            while (_local_4 < _flowerTriggersLength) {
                if (isTriggerPressed(_flowerTriggers[_local_4], _currentPlayerClip)) {
                    var _local_2 = 0;
                    while (_local_2 < _flowerTriggerClips.length) {
                        _flowerTriggerClips[_local_4][_local_2].play();
                        _local_2++;
                    }
                }
                _local_4++;
            }
        }
        function isTriggerPressedAll(trigger) {
            var _local_2 = 0;
            while (_local_2 < _playerListLength) {
                var _local_3 = _ENGINE.getPlayerMovieClip(_playerList[_local_2].player_id);
                if (isTriggerPressed(trigger, _local_3)) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function isTriggerPressed(trigger, playerClip) {
            if (playerClip._y > HIGHEST_PRACTICAL_Y) {
                if (trigger.hitTest(playerClip._x, playerClip._y, true)) {
                    return(true);
                }
            }
            return(false);
        }
        var PIANO_TRIGGERS_AMOUNT = 8;
        var FLOWER_TRIGGERS_AMOUNT = 45;
        var HIGHEST_PRACTICAL_Y = 325;
        var _playerList = [];
        var _pianoTriggers = [];
        var _pianoTriggerClips = [];
        var _flowerTriggers = [];
        var _flowerTriggerClips = [];
    }
