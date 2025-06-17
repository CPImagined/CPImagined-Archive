class com.clubpenguin.engine.avatar.transformation.AvatarExpirationManager
{
    var _SHELL, _ENGINE, _expirationTimer, _delayedTransformation, __get__expirationTimer, __get__isActive;
    function AvatarExpirationManager()
    {
        _SHELL = _global.getCurrentShell();
        _ENGINE = _global.getCurrentEngine();
    } // End of the function
    function addExpirationTimer(durationInSeconds)
    {
        this.stopExpirationTimer();
        _expirationTimer = new com.clubpenguin.engine.avatar.transformation.AvatarExpirationTimer(durationInSeconds * 1000);
        _expirationTimer.__get__expired().addOnce(expireTimer, this);
    } // End of the function
    function stopExpirationTimer()
    {
        if (_expirationTimer != null)
        {
            _expirationTimer.stop();
            _expirationTimer = null;
        } // end if
    } // End of the function
    function expireTimer() {
        if (!_transformationsDelayed) {
            _ENGINE.avatarManager.transformationManager.sendTransformPlayer(0);
        } else {
            _delayedTransformation = com.clubpenguin.util.Delegate.create(this, expireTimer);
        }
    }//thanks newcp
    function delayTransformations()
    {
        _transformationsDelayed = true;
    } // End of the function
    function doDelayedTransformations()
    {
        _transformationsDelayed = false;
        if (_delayedTransformation != null)
        {
            this._delayedTransformation();
            _delayedTransformation = null;
        } // end if
    } // End of the function
    function get expirationTimer()
    {
        return (_expirationTimer);
    } // End of the function
    function get isActive()
    {
        return (_expirationTimer != null);
    } // End of the function
    var _transformationsDelayed = false;
} // End of Class
