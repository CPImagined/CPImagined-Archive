//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.base.ClubPenguinTimes extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, _destroyDelegate, _SHELL, _triggerWatcher, _chairTrigger1, _chairTrigger2, setupNavigationButtons, _triggerWatcherInterval, _opcodeJournal, _printingPressSFX, _INTERFACE, _ENGINE;
        function ClubPenguinTimes (stageReference) {
            super(stageReference);
            _stage.start_x = 630;
            _stage.start_y = 280;
        }
        function init() {
            localize([_stage.background_mc.mancala_btn_states, _stage.interface_mc, _stage.background_mc.titleframe_mc.arttext_mc, _stage.background_mc.timeslogo_mc.timestext_mc, _stage.bulletin_mc.wantedtext_mc]);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.coffee_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "coffee", 635, 315);
            _stage.triggers_mc.table100_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinTable, 100);
            _stage.triggers_mc.table101_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinTable, 101);
            _stage.triggers_mc.table103_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinTable, 103);
            _stage.triggers_mc.table104_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinTable, 104);
            _chairTrigger1 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.chairTrigger1_mc);
            _chairTrigger1.playersAdded.add(com.clubpenguin.util.Delegate.create(this, validateSeatTriggers));
            _chairTrigger1.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, validateSeatTriggers));
            _chairTrigger2 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.chairTrigger2_mc);
            _chairTrigger2.playersAdded.add(com.clubpenguin.util.Delegate.create(this, validateSeatTriggers));
            _chairTrigger2.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, validateSeatTriggers));
            _triggerWatcher.addTrigger(_chairTrigger1);
            _triggerWatcher.addTrigger(_chairTrigger2);
            _stage.background_mc.mancala_btn_states.mancala_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showMancala);
            _stage.bookshelf_mc.book1_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "library");
            _stage.interface_mc.book2_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "library");
            _stage.background_mc.artframes_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "art_wall");
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.door_btn, 631, 206)]);
            var _local_2 = [100, 101, 103, 104];
            _stage.table100_mc.seat_frames = [24, 20];
            _stage.table101_mc.seat_frames = [24, 20];
            _stage.table103_mc.seat_frames = [24, 20];
            _stage.table104_mc.seat_frames = [24, 20];
            setupTable(_stage.table100_mc);
            setupTable(_stage.table101_mc);
            setupTable(_stage.table103_mc);
            setupTable(_stage.table104_mc);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _opcodeJournal = new com.clubpenguin.world.rooms2012.superhero.OpcodeJournal();
            _opcodeJournal.init(_SHELL.getMyPlayerId());
            _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.superhero.OpcodeJournal.PLAYER_ENTERS_THE_CLUB_PENGUIN_TIMES_ROOM);
            _printingPressSFX = new Sound(_stage.newsPaperMachine_mc);
            _printingPressSFX.attachSound("sfx_printingPress");
        }
		function showMancala() {
			showContent("mancala_help");
		}
        function validateSeatTriggers(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                var _local_4 = _chairTrigger1.getAllPlayers().length > 0;
                var _local_5 = _chairTrigger2.getAllPlayers().length > 0;
                if (_local_4 || (_local_5 && (_stage.newsPaperMachine_mc._currentFrame == 1))) {
                    if (players[_local_2] == _SHELL.getMyPlayerId()) {
                        _printingPressSFX.start(0, 99);
                    }
                    _stage.newsPaperMachine_mc.newsPapers_mc.gotoAndPlay(2);
                    _stage.newsPaperMachine_mc.newspaperMachineSquiggle_mc.gotoAndPlay(2);
                } else {
                    if (players[_local_2] == _SHELL.getMyPlayerId()) {
                        _printingPressSFX.stop();
                    }
                    _stage.newsPaperMachine_mc.newsPapers_mc.gotoAndStop(1);
                    _stage.newsPaperMachine_mc.newspaperMachineSquiggle_mc.gotoAndStop(1);
                }
                _local_2++;
            }
        }
        function setupTable(mc) {
            mc.game_btn.onRelease = com.clubpenguin.util.Delegate.create(this, clickTable, mc);
            mc.game_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showTableHint, mc);
            mc.game_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideTableHint, mc);
        }
        function hideTableHint(mc) {
            _INTERFACE.closeHint();
            mc.game_mc.gotoAndStop(1);
        }
        function showTableHint(mc) {
            _INTERFACE.showHint(mc, "mancala_hint");
            mc.game_mc.gotoAndStop(2);
        }
        function clickTable(mc) {
            var _local_4 = Math.round(mc._x);
            var _local_3 = Math.round(mc._y);
            _ENGINE.sendPlayerMove(_local_4, _local_3);
        }
        function showContent(content) {
            _INTERFACE.showContent(content);
        }
        function joinTable(tableNum) {
            _ENGINE.sendJoinTable("mancala", tableNum, true);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "ClubPenguinTimes";
    }
