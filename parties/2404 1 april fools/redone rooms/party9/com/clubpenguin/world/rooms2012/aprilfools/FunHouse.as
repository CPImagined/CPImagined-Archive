//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.aprilfools.FunHouse extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, hideRoomElements, localize, setupNavigationButtons, _ENGINE, _currentPlayerID, _SHELL, _opcodeJournal, _triggerWatcher, _pressureChamberRight, _pressureChamberLeft, _puffleExitDoor, _statueTalkG, _statueTalkAuntArctic, _statueTalkRockhopper, _roomUpdateInterval, _playerTalkDelegate, _sequencer, _INTERFACE, _destroyDelegate;
        function FunHouse (stageReference) {
            super();
            _stage = stageReference;
            hideRoomElements();
            _stage.start_x = 380;
            _stage.start_y = 208;
            localize([_stage.background_mc.exitSign, _stage.item1, _stage.item2]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair1, 420, 236), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair2, 476, 235), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair3, 477, 257), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair4, 418, 260), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.buttonTransport1, 103, 404), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.buttonTransport2, 516, 151), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.buttonGary, 575, 215), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.buttonAunt, 623, 250), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.buttonRockhopper, 675, 290), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.item1.freeItemButton, 250, 180), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.item2.freeItemButton, 470, 434)]);
            _stage.triggers_mc.triggerExit.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit);
            _stage.triggers_mc.triggerFree1.triggerFunction = com.clubpenguin.util.Delegate.create(this, getFreeItem, 4339);
            _stage.triggers_mc.triggerFree2.triggerFunction = com.clubpenguin.util.Delegate.create(this, getFreeItem, 6111);
            _stage.chair1.useHandCursor = false;
            _stage.chair2.useHandCursor = false;
            _stage.chair3.useHandCursor = false;
            _stage.chair4.useHandCursor = false;
            _stage.buttonGary.useHandCursor = false;
            _stage.buttonAunt.useHandCursor = false;
            _stage.buttonRockhopper.useHandCursor = false;
            _stage.buttonTransport1.useHandCursor = false;
            _stage.buttonTransport2.useHandCursor = false;
        }
        function exit() {
            _ENGINE.sendJoinRoom("boxdimension", 517, 171);
        }
        function init() {
            trace("FunHouse init()");
            _currentPlayerID = _SHELL.getMyPlayerId();
            _opcodeJournal.init(_currentPlayerID);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _pressureChamberRight = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.triggerChamberRight);
            _pressureChamberRight.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playersAddedToGrowChamber));
            _pressureChamberRight.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, playersRemovedFromGrowChamber));
            _pressureChamberLeft = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.triggerChamberLeft);
            _pressureChamberLeft.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playersAddedToShrinkChamber));
            _pressureChamberLeft.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, playersRemovedFromShrinkChamber));
            _puffleExitDoor = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.triggerMouthOpenClose);
            _puffleExitDoor.playersAdded.add(com.clubpenguin.util.Delegate.create(this, exitDoorOpen));
            _puffleExitDoor.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, exitDoorClose));
            _statueTalkG = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.triggerGary);
            _statueTalkG.playersAdded.add(com.clubpenguin.util.Delegate.create(this, onPlayerOverStatue));
            _statueTalkG.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, onPlayerLeaveStatue));
            _statueTalkAuntArctic = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.triggerAunt);
            _statueTalkAuntArctic.playersAdded.add(com.clubpenguin.util.Delegate.create(this, onPlayerOverStatue));
            _statueTalkAuntArctic.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, onPlayerLeaveStatue));
            _statueTalkRockhopper = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.triggerRockhopper);
            _statueTalkRockhopper.playersAdded.add(com.clubpenguin.util.Delegate.create(this, onPlayerOverStatue));
            _statueTalkRockhopper.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, onPlayerLeaveStatue));
            _triggerWatcher.addTrigger(_pressureChamberRight);
            _triggerWatcher.addTrigger(_pressureChamberLeft);
            _triggerWatcher.addTrigger(_puffleExitDoor);
            _triggerWatcher.addTrigger(_statueTalkG);
            _triggerWatcher.addTrigger(_statueTalkAuntArctic);
            _triggerWatcher.addTrigger(_statueTalkRockhopper);
            clearInterval(_roomUpdateInterval);
            _roomUpdateInterval = setInterval(this, "update", 100);
            _playerTalkDelegate = com.clubpenguin.util.Delegate.create(this, handleTalk);
            _SHELL.addListener(_SHELL.SENDING_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_SAFE_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_LINE_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_QUICK_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_TOUR_GUIDE_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_MASCOT_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_JOKE, _playerTalkDelegate);
            _sequencer = new com.clubpenguin.world.rooms2012.common.sequencer.Sequencer(com.clubpenguin.world.rooms2012.common.sequencer.PulseGenerator.FRAME_BASED, _stage);
            _stage.background_mc.footLights.purple.onRelease = com.clubpenguin.util.Delegate.create(this, onConfettiCanonButtonClick, 1);
            _stage.background_mc.footLights.pink.onRelease = com.clubpenguin.util.Delegate.create(this, onConfettiCanonButtonClick, 2);
            _stage.background_mc.footLights.red.onRelease = com.clubpenguin.util.Delegate.create(this, onConfettiCanonButtonClick, 3);
            _stage.background_mc.footLights.orange.onRelease = com.clubpenguin.util.Delegate.create(this, onConfettiCanonButtonClick, 4);
            _stage.background_mc.footLights.yellow.onRelease = com.clubpenguin.util.Delegate.create(this, onConfettiCanonButtonClick, 5);
            _stage.confettiCanonBtn6.onRelease = com.clubpenguin.util.Delegate.create(this, onConfettiCanonButtonClick, 6);
        }
        function onPlayerOverStatue(playerList) {
            var _local_2 = 0;
            while (_local_2 < playerList.length) {
                _ENGINE.getNicknameMovieClip(playerList[_local_2])._visible = false;
                _local_2++;
            }
        }
        function onPlayerLeaveStatue(playerList) {
            var _local_2 = 0;
            while (_local_2 < playerList.length) {
                _ENGINE.getNicknameMovieClip(playerList[_local_2])._visible = true;
                _local_2++;
            }
        }
        function exitDoorClose() {
            _stage.puffleExit.gotoAndStop("close");
        }
        function exitDoorOpen() {
            _stage.puffleExit.gotoAndStop("open");
        }
        function onConfettiCanonButtonClick(sequenceNum) {
            switch (sequenceNum) {
                case 1 : 
                    _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "cannonFirePattern1", 1);
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon1, "gotoAndStop", ["play"]));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon2, "gotoAndStop", ["play"]));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon3, "gotoAndStop", ["play"], 0.4));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon4, "gotoAndStop", ["play"], 0.8));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon5, "gotoAndStop", ["play"], 0.8));
                    _sequencer.endSequence();
                    break;
                case 2 : 
                    _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "cannonFirePattern2", 1);
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon1, "gotoAndStop", ["play"], 0.8));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon2, "gotoAndStop", ["play"], 0.8));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon3, "gotoAndStop", ["play"], 0.4));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon4, "gotoAndStop", ["play"]));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon5, "gotoAndStop", ["play"]));
                    _sequencer.endSequence();
                    break;
                case 3 : 
                    _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "cannonFirePattern3", 1);
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon1, "gotoAndStop", ["play"]));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon2, "gotoAndStop", ["play"], 0.4));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon3, "gotoAndStop", ["play"], 1.6));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon4, "gotoAndStop", ["play"], 0.8));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon5, "gotoAndStop", ["play"], 1.2));
                    _sequencer.endSequence();
                    break;
                case 4 : 
                    _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "cannonFirePattern4", 1);
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon1, "gotoAndStop", ["play"]));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon2, "gotoAndStop", ["play"], 0.4));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon3, "gotoAndStop", ["play"], 1.6));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon4, "gotoAndStop", ["play"], 0.8));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon5, "gotoAndStop", ["play"], 1.2));
                    _sequencer.endSequence();
                    break;
                case 5 : 
                    _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "cannonFirePattern5", 1);
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon1, "gotoAndStop", ["play"]));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon2, "gotoAndStop", ["play"], 0.4));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon3, "gotoAndStop", ["play"], 0.8));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon4, "gotoAndStop", ["play"], 1.2));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon5, "gotoAndStop", ["play"], 1.6));
                    _sequencer.endSequence();
                    break;
                case 6 : 
                    _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "cannonFireAll", 1);
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon1, "gotoAndStop", ["play"]));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon2, "gotoAndStop", ["play"]));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon3, "gotoAndStop", ["play"], 0.2));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon4, "gotoAndStop", ["play"]));
                    _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_stage.canon5, "gotoAndStop", ["play"]));
                    _sequencer.endSequence();
                    break;
            }
            _sequencer.start();
        }
        function playersRemovedFromShrinkChamber(players) {
            var _local_3;
            var _local_2 = 0;
            while (_local_2 < players.length) {
                _local_3 = _ENGINE.getPlayerMovieClip(players[_local_2]);
                _local_3._xscale = (_local_3._yscale = 100);
                _local_2++;
            }
            trace("FunHouse playersRemovedFromShrinkChamber()");
        }
        function playersAddedToShrinkChamber(players) {
            trace("FunHouse playersAddedToShrinkChamber()");
            var _local_3;
            var _local_2 = 0;
            while (_local_2 < players.length) {
                _local_3 = _ENGINE.getPlayerMovieClip(players[_local_2]);
                _local_3._xscale = (_local_3._yscale = 50);
                _local_2++;
            }
        }
        function playersRemovedFromGrowChamber(players) {
            var _local_3;
            var _local_2 = 0;
            while (_local_2 < players.length) {
                _local_3 = _ENGINE.getPlayerMovieClip(players[_local_2]);
                _local_3._xscale = (_local_3._yscale = 100);
                _local_2++;
            }
            trace("FunHouse playersRemovedFromGrowChamber()");
        }
        function playersAddedToGrowChamber(players) {
            var _local_3;
            var _local_2 = 0;
            while (_local_2 < players.length) {
                _local_3 = _ENGINE.getPlayerMovieClip(players[_local_2]);
                _local_3._xscale = (_local_3._yscale = 200);
                _local_2++;
            }
            trace("FunHouse playersAddedToGrowChamber()");
        }
        function update() {
            _triggerWatcher.checkAllPlayers();
        }
        function handleThrow(ball) {
            trace(CLASS_NAME + ": handleThrow()");
        }
        function getFreeItem(itemID) {
            _INTERFACE.buyInventory(itemID);
        }
        function handleTalk(event) {
            trace(CLASS_NAME + " handleTalk()");
            var _local_2 = _SHELL.getPlayerObjectById(event.player_id);
            if (_stage.triggers_mc.triggerGary.hitTest(_local_2.x, _local_2.y)) {
                _stage.gary.gotoAndStop(2);
            } else if (_stage.triggers_mc.triggerAunt.hitTest(_local_2.x, _local_2.y)) {
                _stage.auntArtic.gotoAndStop(2);
            } else if (_stage.triggers_mc.triggerRockhopper.hitTest(_local_2.x, _local_2.y)) {
                _stage.rockhopper.gotoAndStop(2);
            }
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.SEND_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SENDING_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_SAFE_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_LINE_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_QUICK_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_TOUR_GUIDE_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_MASCOT_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_JOKE, _playerTalkDelegate);
            _sequencer.clear();
            clearInterval(_roomUpdateInterval);
        }
        static var CLASS_NAME = "FunHouse";
    }
