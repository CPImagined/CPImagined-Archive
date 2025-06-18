//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.medieval.DragonAnimationController
    {
        var _SHELL, _timeOffsetMinutes, _timeOffsetSeconds, _animations, _secondCheckIntervalID, _currentTime, _currentMinute, _currentSecond;
        function DragonAnimationController (shell, timeOffsetMinutes, timeOffsetSeconds, animations) {
            _SHELL = shell;
            _timeOffsetMinutes = timeOffsetMinutes;
            _timeOffsetSeconds = timeOffsetSeconds;
            _animations = animations;
            init();
        }
        function playAnimations() {
            var _local_2 = 0;
            while (_local_2 < _animations.length) {
                _animations[_local_2].gotoAndPlay(1);
                _local_2++;
            }
        }
        function stopAnimations() {
            var _local_2 = 0;
            while (_local_2 < _animations.length) {
                _animations[_local_2].gotoAndStop(1);
                _local_2++;
            }
        }
        function init() {
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
            if (_currentMinute != _currentTime.getMinutes()) {
                _currentMinute = _currentTime.getMinutes();
                _currentTime = fetchTime();
            }
            checkForEvent();
        }
        function checkForEvent() {
            if (((_currentMinute % 15) == _timeOffsetMinutes) && (_currentSecond == _timeOffsetSeconds)) {
                playAnimations();
            }
        }
        var ONE_SECOND = 1000;
    }
