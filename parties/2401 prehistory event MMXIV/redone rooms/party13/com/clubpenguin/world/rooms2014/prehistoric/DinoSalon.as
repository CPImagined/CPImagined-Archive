//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.DinoSalon extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, _destroyDelegate, _triggerWatcher, _triggerWatcherInterval, _hangers1, _hangers2, _hangers3, _fan1, _fan2, setupNavigationButtons, _roomUpdateInterval;
        function DinoSalon (stageReference) {
            super(stageReference);
            _stage.start_x = 508;
            _stage.start_y = 235;
            if (!_SHELL) {
                init();
            }
            localize([_stage.background_mc.mineSign_mc, _stage.cpuEntrance_mc.cpuText_mc]);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function configureTriggers() {
            _stage.triggers_mc.party3_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 390, 380);
            _hangers1 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.hangers1trigger_mc);
            _hangers1.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playHangers1));
            _hangers1.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopHangers1));
            _triggerWatcher.addTrigger(_hangers1);
            _hangers2 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.hangers2trigger_mc);
            _hangers2.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playHangers2));
            _hangers2.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopHangers2));
            _triggerWatcher.addTrigger(_hangers2);
            _hangers3 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.hangers3trigger_mc);
            _hangers3.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playHangers3));
            _hangers3.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopHangers3));
            _triggerWatcher.addTrigger(_hangers3);
            _fan1 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.chairTrigger1_mc);
            _fan1.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playHood1));
            _fan1.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopHood1));
            _triggerWatcher.addTrigger(_fan1);
            _fan2 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.chairTrigger2_mc);
            _fan2.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playHood2));
            _fan2.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopHood2));
            _triggerWatcher.addTrigger(_fan2);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.hangers1_btn, 530, 400), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.hangers2_btn, 595, 388), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.hangers3_btn, 647, 380), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.fan1_btn, 65, 266), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.fan2_btn, 110, 224), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair1_btn, 277, 400), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair2_btn, 157, 380), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.exit_btn, 530, 142)]);
            _stage.hangers1_btn.useHandCursor = false;
            _stage.hangers2_btn.useHandCursor = false;
            _stage.hangers3_btn.useHandCursor = false;
            _stage.fan1_btn.useHandCursor = false;
            _stage.fan2_btn.useHandCursor = false;
            _stage.chair1_btn.useHandCursor = false;
            _stage.chair2_btn.useHandCursor = false;
            _stage.chair3_btn.useHandCursor = false;
        }
        function configureRoomElements() {
        }
        function playHangers1() {
            if ((_stage.foreground_mc.hangers1_mc._currentframe == 1) && ((_hangers1.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _hangers1.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) > 0)) {
                _stage.foreground_mc.hangers1_mc.gotoAndPlay(2);
            }
        }
        function stopHangers1() {
            if ((_stage.foreground_mc.hangers1_mc._currentframe == 11) && ((_hangers1.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _hangers1.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) < 1)) {
                _stage.foreground_mc.hangers1_mc.gotoAndPlay(12);
            }
        }
        function playHangers2() {
            if ((_stage.foreground_mc.hangers2_mc._currentframe == 1) && ((_hangers2.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _hangers2.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) > 0)) {
                _stage.foreground_mc.hangers2_mc.gotoAndPlay(2);
            }
        }
        function stopHangers2() {
            if ((_stage.foreground_mc.hangers2_mc._currentframe == 12) && ((_hangers2.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _hangers2.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) < 1)) {
                _stage.foreground_mc.hangers2_mc.gotoAndPlay(13);
            }
        }
        function playHangers3() {
            if ((_stage.foreground_mc.hangers3_mc._currentframe == 1) && ((_hangers3.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _hangers3.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) > 0)) {
                _stage.foreground_mc.hangers3_mc.gotoAndPlay(2);
            }
        }
        function stopHangers3() {
            if ((_stage.foreground_mc.hangers3_mc._currentframe == 12) && ((_hangers3.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _hangers3.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) < 1)) {
                _stage.foreground_mc.hangers3_mc.gotoAndPlay(13);
            }
        }
        function playHood1() {
            if ((_stage.hood1_mc._currentframe == 1) && ((_fan1.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _fan1.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) > 0)) {
                _stage.hood1_mc.gotoAndPlay(2);
            }
        }
        function stopHood1() {
            if ((_stage.hood1_mc._currentframe == 10) && ((_fan1.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _fan1.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) < 1)) {
                _stage.hood1_mc.gotoAndPlay(11);
            }
        }
        function playHood2() {
            if ((_stage.hood2_mc._currentframe == 1) && ((_fan2.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _fan2.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) > 0)) {
                _stage.hood2_mc.gotoAndPlay(2);
            }
        }
        function stopHood2() {
            if ((_stage.hood2_mc._currentframe == 10) && ((_fan2.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _fan2.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) < 1)) {
                _stage.hood2_mc.gotoAndPlay(11);
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_roomUpdateInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "DinoSalon";
    }
