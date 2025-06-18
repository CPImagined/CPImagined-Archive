//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.music.DayNightCycle extends MovieClip
    {
        var _SHELL, _destroyDelegate, _minuteCheckIntervalID, _currentTime, _currentMinute, gotoAndStop, _currentSecond, gotoAndPlay;
        function DayNightCycle () {
            super();
            _SHELL = _global.getCurrentShell();
            init();
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            clearInterval(_minuteCheckIntervalID);
            _minuteCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, updateTime), ONE_SECOND);
            _currentTime = fetchTime();
            _currentMinute = _currentTime.getMinutes();
            updateTime();
            configureSkyState();
        }
        function configureSkyState() {
            _currentMinute = _currentTime.getMinutes();
            if ((((_currentMinute >= 0) && (_currentMinute < 5)) || ((_currentMinute >= 20) && (_currentMinute < 25))) || ((_currentMinute >= 40) && (_currentMinute < 45))) {
                this.gotoAndStop("state_1");
            }
            if ((((_currentMinute >= 5) && (_currentMinute < 10)) || ((_currentMinute >= 25) && (_currentMinute < 30))) || ((_currentMinute >= 45) && (_currentMinute < 50))) {
                this.gotoAndStop("state_2");
            }
            if ((((_currentMinute >= 10) && (_currentMinute < 15)) || ((_currentMinute >= 30) && (_currentMinute < 35))) || ((_currentMinute >= 50) && (_currentMinute < 55))) {
                this.gotoAndStop("state_3");
            }
            if ((((_currentMinute >= 15) && (_currentMinute < 20)) || ((_currentMinute >= 35) && (_currentMinute < 40))) || ((_currentMinute >= 55) && (_currentMinute < 60))) {
                this.gotoAndStop("state_4");
            }
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
            _currentMinute = _currentTime.getMinutes();
            if ((((_currentMinute == 5) || (_currentMinute == 25)) || (_currentMinute == 45)) && (_currentSecond == 0)) {
                this.gotoAndPlay("transition_1");
            }
            if ((((_currentMinute == 10) || (_currentMinute == 30)) || (_currentMinute == 50)) && (_currentSecond == 0)) {
                this.gotoAndPlay("transition_2");
            }
            if ((((_currentMinute == 15) || (_currentMinute == 35)) || (_currentMinute == 55)) && (_currentSecond == 0)) {
                this.gotoAndPlay("transition_3");
            }
            if ((((_currentMinute == 20) || (_currentMinute == 40)) || (_currentMinute == 60)) && (_currentSecond == 0)) {
                this.gotoAndPlay("transition_4");
            }
            if (_currentMinute != _currentTime.getMinutes()) {
                _currentMinute = _currentTime.getMinutes();
                _currentTime = fetchTime();
            }
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            clearInterval(_minuteCheckIntervalID);
        }
        var ONE_MINUTE = 60000;
        var ONE_SECOND = 1000;
    }
