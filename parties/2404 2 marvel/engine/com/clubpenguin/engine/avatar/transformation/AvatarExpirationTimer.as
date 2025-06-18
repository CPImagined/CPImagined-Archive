//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.avatar.transformation.AvatarExpirationTimer
    {
        var _intervalID, _expired, _cancelled, _startTime, _duration;
        function AvatarExpirationTimer (duration) {
            _intervalID = setInterval(this, "onExpired", duration);
            _expired = new org.osflash.signals.Signal();
            _cancelled = new org.osflash.signals.Signal();
            _startTime = getTimer();
            _duration = duration;
        }
        function onExpired() {
            _expired.dispatch();
            stop();
        }
        function stop() {
            clearInterval(_intervalID);
            _expired.removeAll();
            _cancelled.dispatch();
            _cancelled.removeAll();
        }
        function get expired() {
            return(_expired);
        }
        function get cancelled() {
            return(_cancelled);
        }
        function getMillisecondsRemaining() {
            var _local_2 = getTimer() - _startTime;
            return(_duration - _local_2);
        }
        function getSecondsRemaining() {
            return(getMillisecondsRemaining() / 1000);
        }
        function getMinutesRemaining() {
            return((getMillisecondsRemaining() / 1000) / 60);
        }
        function getDuration() {
            return(_duration);
        }
    }
