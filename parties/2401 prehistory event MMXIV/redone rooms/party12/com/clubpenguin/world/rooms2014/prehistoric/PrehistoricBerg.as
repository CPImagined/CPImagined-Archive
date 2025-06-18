//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.PrehistoricBerg extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, _minuteCheckIntervalID, _currentTime, _currentMinute, _triggerWatcherInterval, _currentSecond, _INTERFACE;
        function PrehistoricBerg (stageReference) {
            super(stageReference);
            _stage.start_x = 410;
            _stage.start_y = 290;
            _stage.customPenguinSize = 85;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            clearInterval(_minuteCheckIntervalID);
            _minuteCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, updateTime), ONE_SECOND);
            _currentTime = fetchTime();
            _currentMinute = _currentTime.getMinutes();
            updateTime();
            _stage.triggers_mc.party11_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party11", 650, 386);
            _stage.foreground_mc.partyCat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, com.clubpenguin.world.rooms.common.RoomConstants.PARTY_CATALOGUE_1);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
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
            _currentMinute = _currentTime.getMinutes();
            _currentSecond = _currentTime.getSeconds();
            if (((_currentMinute % 2) == 0) && (_currentSecond == 15)) {
                _stage.berg1_mc.shark_mc.jaw_mc.gotoAndPlay(2);
                _stage.berg1_mc.shark_mc.pupil_mc.gotoAndPlay(2);
            }
            if (_currentMinute != _currentTime.getMinutes()) {
                _currentMinute = _currentTime.getMinutes();
                _currentTime = fetchTime();
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function showContent(content) {
            _INTERFACE.showContent(content);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "PrehistoricBerg";
        var ONE_MINUTE = 60000;
        var ONE_SECOND = 1000;
    }
