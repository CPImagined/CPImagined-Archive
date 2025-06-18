//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.medieval.Dock extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _PARTY, _SHELL, setupNavigationButtons, _INTERFACE, _triggerWatcher, _talkingTreeTrigger1, _talkingTreeTrigger2, _roomUpdateInterval, _playerTalkDelegate, _opcodeJournal, _ENGINE;
        function Dock (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 400;
            _stage.start_y = 200;
            _stage.isSmallPenguin = true;
        }
        function init() {
			_PARTY = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            trace(CLASS_NAME + ": init()");
            if (_PARTY.getTaskComplete(7)) {
                setToDragonDefeatedState();
            }
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boat_mc.art_mc.boat_btn, 138, 380), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.buttonTree1, _stage.triggers_mc.triggerTree1._x, _stage.triggers_mc.triggerTree1._y), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.buttonTree2, _stage.triggers_mc.triggerTree2._x, _stage.triggers_mc.triggerTree2._y)]);
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 625, 360);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 184, 320);
            _stage.triggers_mc.boat_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinGame, "hydro");
            if (true) {
                if (_PARTY.getTaskComplete(7) || !_PARTY.getTaskComplete(3) || _PARTY.getTaskComplete(4)) {
                    _stage.lightbeam_mc.gotoAndStop(2);
                    _stage.slingshot_mc.gotoAndStop(2);
                } else {
                    _stage.slingshot_mc.slingshot_btn.onRelease = com.clubpenguin.util.Delegate.create(this, pickUpScavengerHuntItem);
                }
            } else {
                _stage.slingshot_mc.gotoAndStop(3);
                _stage.lightbeam_mc.gotoAndStop(2);
            }
            _stage.boat_mc.art_mc.boat_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showHydroHopperHint);
            _stage.boat_mc.art_mc.boat_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideHint);
            _stage.interface_mc.dock_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showDockCatalog);
            _stage.dock_cat_obj_mc.dock_cat_obj_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showDockCatalog);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _talkingTreeTrigger1 = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.triggerTree1);
            _talkingTreeTrigger1.playersAdded.add(com.clubpenguin.util.Delegate.create(this, onPlayerOverTree, _talkingTreeTrigger1));
            _talkingTreeTrigger1.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, onPlayerLeaveTree, _talkingTreeTrigger1));
            _talkingTreeTrigger2 = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.triggerTree2);
            _talkingTreeTrigger2.playersAdded.add(com.clubpenguin.util.Delegate.create(this, onPlayerOverTree, _talkingTreeTrigger2));
            _talkingTreeTrigger2.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, onPlayerLeaveTree, _talkingTreeTrigger2));
            _triggerWatcher.addTrigger(_talkingTreeTrigger1);
            _triggerWatcher.addTrigger(_talkingTreeTrigger2);
            clearInterval(_roomUpdateInterval);
            _roomUpdateInterval = setInterval(this, "update", 40);
            _playerTalkDelegate = com.clubpenguin.util.Delegate.create(this, handleTalk);
            _SHELL.addListener(_SHELL.SENDING_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_SAFE_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_LINE_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_QUICK_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_TOUR_GUIDE_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_MASCOT_MESSAGE, _playerTalkDelegate);
            _SHELL.addListener(_SHELL.SEND_JOKE, _playerTalkDelegate);
            _opcodeJournal = new com.clubpenguin.world.rooms2012.medieval.OpcodeJournal();
            _opcodeJournal.init(_SHELL.getMyPlayerId());
            _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.medieval.OpcodeJournal.TINY_PENGUIN_IN_DOCK);
        }
        function setToDragonDefeatedState() {
            _stage.bannerLeft_mc.gotoAndStop(2);
            _stage.bannerRight_mc.gotoAndStop(2);
            _stage.background_mc.mountain_mc.gotoAndStop(2);
        }
        function update() {
            _triggerWatcher.checkAllPlayers();
        }
        function onPlayerLeaveTree(playerList, trigger) {
            var _local_2 = 0;
            while (_local_2 < playerList.length) {
                _ENGINE.getNicknameMovieClip(playerList[_local_2])._visible = true;
                _local_2++;
            }
            if (trigger == _talkingTreeTrigger1) {
                _stage.headLeft_mc.eyes_mc.gotoAndStop("closeEyes");
            } else {
                _stage.headRight_mc.eyes_mc.gotoAndStop("closeEyes");
            }
        }
        function onPlayerOverTree(playerList, trigger) {
            var _local_2 = 0;
            while (_local_2 < playerList.length) {
                _ENGINE.getNicknameMovieClip(playerList[_local_2])._visible = false;
                _local_2++;
            }
            if (trigger == _talkingTreeTrigger1) {
                _stage.headLeft_mc.eyes_mc.gotoAndStop("openEyes");
            } else {
                _stage.headRight_mc.eyes_mc.gotoAndStop("openEyes");
            }
        }
        function handleTalk(event) {
            trace(CLASS_NAME + " handleTalk()");
            var _local_2 = _SHELL.getPlayerObjectById(event.player_id);
            if (_stage.triggers_mc.triggerTree1.hitTest(_local_2.x, _local_2.y)) {
                _stage.headLeft_mc.beak_mc.gotoAndPlay(2);
            } else if (_stage.triggers_mc.triggerTree2.hitTest(_local_2.x, _local_2.y)) {
                _stage.headRight_mc.beak_mc.gotoAndPlay(2);
            }
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function joinGame(gameName) {
            _ENGINE.sendJoinGame(gameName, true);
        }
        function pickUpScavengerHuntItem() {
            if (!_PARTY.getTaskComplete(4)) {
                _stage.lightbeam_mc.gotoAndStop(2);
                _stage.slingshot_mc.gotoAndStop(2);
                _PARTY.setTaskComplete(4);
            }
        }
        function showHydroHopperHint() {
            _INTERFACE.showHint(_stage.boat_mc, "hydro_hint");
        }
        function hideHint() {
            _INTERFACE.closeHint();
        }
        function showDockCatalog() {
            _INTERFACE.showContent("dock_catalogue");
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.SENDING_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_SAFE_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_LINE_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_QUICK_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_TOUR_GUIDE_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_MASCOT_MESSAGE, _playerTalkDelegate);
            _SHELL.removeListener(_SHELL.SEND_JOKE, _playerTalkDelegate);
            clearInterval(_roomUpdateInterval);
        }
        static var CLASS_NAME = "Dock";
    }
