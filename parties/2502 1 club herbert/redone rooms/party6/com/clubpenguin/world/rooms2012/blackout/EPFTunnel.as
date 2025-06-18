//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.blackout.EPFTunnel extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, _triggerWatcher, setupNavigationButtons, _triggerWatcherInterval, _secondCheckIntervalID, _currentTime, _currentMinute, _currentSecond;
        function EPFTunnel (stageReference) {
            super(stageReference);
            _stage.start_x = 300;
            _stage.start_y = 400;
            _stage.customPenguinSize = 115;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.vault_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 0, 0);
            _stage.triggers_mc.undergroundEPF_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party7", 254, 265);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.vault_mc.vault_btn, 185, 110), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.undergroundEPF_mc.undergroundEPF_btn, 686, 265)]);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _secondCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, updateTime), ONE_SECOND);
            _currentTime = fetchTime();
            _currentMinute = _currentTime.getMinutes();
            updateTime();
        }
        function fetchTime() {
            if (_SHELL == undefined) {
                return(new Date());
            } else {
                return(_SHELL.getPenguinStandardTime());
            }
        }
        function updateTime() {
            _currentTime.setTime(_currentTime.getTime() + ONE_SECOND);
            _currentSecond = _currentTime.getSeconds();
            if ((_currentSecond == 5) || (_currentSecond == 35)) {
                _stage.rock.crabAnimation.gotoAndPlay(2);
            }
            if (_currentMinute != _currentTime.getMinutes()) {
                _currentMinute = _currentTime.getMinutes();
                _currentTime = fetchTime();
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "EPFTunnel";
        var ONE_SECOND = 1000;
    }
