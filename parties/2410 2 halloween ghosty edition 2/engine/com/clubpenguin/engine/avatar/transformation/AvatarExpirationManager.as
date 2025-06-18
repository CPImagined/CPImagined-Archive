//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.avatar.transformation.AvatarExpirationManager
    {
        var _SHELL, _ENGINE, _expirationTimer, _delayedTransformation;
        function AvatarExpirationManager () {
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
        }
        function addExpirationTimer(durationInSeconds) {
            stopExpirationTimer();
            _expirationTimer = new com.clubpenguin.engine.avatar.transformation.AvatarExpirationTimer(durationInSeconds * 1000);
            _expirationTimer.expired.addOnce(expireTimer, this);
        }
        function stopExpirationTimer() {
            if (_expirationTimer != null) {
                _expirationTimer.stop();
                _expirationTimer = null;
            }
        }
        function expireTimer() {
            if (!_transformationsDelayed) {
                _ENGINE.avatarManager.transformationManager.sendTransformPlayer(_SHELL.getMyPlayerObject(), 0);
            } else {
                _delayedTransformation = com.clubpenguin.util.Delegate.create(this, expireTimer);
            }
        }
        function delayTransformations() {
            _transformationsDelayed = true;
        }
        function doDelayedTransformations() {
            _transformationsDelayed = false;
            if (_delayedTransformation != null) {
                _delayedTransformation();
                _delayedTransformation = null;
            }
        }
        function get expirationTimer() {
            return(_expirationTimer);
        }
        function get isActive() {
            return(_expirationTimer != null);
        }
        var _transformationsDelayed = false;
    }
