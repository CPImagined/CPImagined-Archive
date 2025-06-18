//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.SyncedInterval
    {
        var _shell, _secondCheckIntervalID, _currentTime, _currentMinute, signal, _currentSecond;
        function SyncedInterval (delayInMinutes, offsetInMinutes) {
            _shell = _global.getCurrentShell();
            _delayInMinutes = delayInMinutes;
            if (offsetInMinutes != null) {
                _offsetInMinutes = offsetInMinutes;
            }
            init();
        }
        function init() {
            _secondCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, updateTime), ONE_SECOND);
            _currentTime = fetchTime();
            _currentMinute = _currentTime.getMinutes();
            updateTime();
            signal = new org.osflash.signals.Signal();
        }
        function fetchTime() {
            if (_shell == undefined) {
                return(new Date());
            } else {
                return(_shell.getPenguinStandardTime());
            }
        }
        function updateTime() {
            _currentTime.setTime(_currentTime.getTime() + ONE_SECOND);
            _currentSecond = _currentTime.getSeconds();
            if ((_currentMinute != _currentTime.getMinutes()) && (_currentSecond <= 1)) {
                _currentMinute = _currentTime.getMinutes();
                _currentTime = fetchTime();
                if (((_currentMinute + _offsetInMinutes) % _delayInMinutes) == 0) {
                    signal.dispatch();
                }
            }
        }
        function destroy() {
            signal.removeAll();
            clearInterval(_secondCheckIntervalID);
        }
        var ONE_SECOND = 1000;
        var _delayInMinutes = 5;
        var _offsetInMinutes = 0;
    }
