class com.clubpenguin.engine.avatar.transformation.AvatarExpirationTimer
{
    var _intervalID, _expired, _cancelled, _startTime, _duration, __get__cancelled, __get__expired;
    function AvatarExpirationTimer(duration)
    {
        _intervalID = setInterval(this, "onExpired", duration);
        _expired = new org.osflash.signals.Signal();
        _cancelled = new org.osflash.signals.Signal();
        _startTime = getTimer();
        _duration = duration;
    } // End of the function
    function onExpired()
    {
        _expired.dispatch();
        stop ();
    } // End of the function
    function stop()
    {
        clearInterval(_intervalID);
        _expired.removeAll();
        _cancelled.dispatch();
        _cancelled.removeAll();
    } // End of the function
    function get expired()
    {
        return (_expired);
    } // End of the function
    function get cancelled()
    {
        return (_cancelled);
    } // End of the function
    function getMillisecondsRemaining()
    {
        var _loc2 = getTimer() - _startTime;
        return (_duration - _loc2);
    } // End of the function
    function getSecondsRemaining()
    {
        return (this.getMillisecondsRemaining() / 1000);
    } // End of the function
    function getMinutesRemaining()
    {
        return (this.getMillisecondsRemaining() / 1000 / 60);
    } // End of the function
    function getDuration()
    {
        return (_duration);
    } // End of the function
} // End of Class
