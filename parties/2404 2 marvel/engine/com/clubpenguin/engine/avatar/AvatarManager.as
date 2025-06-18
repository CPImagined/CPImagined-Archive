//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.avatar.AvatarManager
    {
        var _SHELL, _ENGINE, _expirationManager, _effectManager, _transformationManager, _avatarModel;
        function AvatarManager () {
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
        }
        function init() {
            _expirationManager = new com.clubpenguin.engine.avatar.transformation.AvatarExpirationManager();
            _effectManager = new com.clubpenguin.engine.avatar.effect.AvatarEffectManager();
            _transformationManager = new com.clubpenguin.engine.avatar.transformation.AvatarTransformationManager();
            _avatarModel = new com.clubpenguin.engine.avatar.model.AvatarModel();
            com.clubpenguin.engine.avatar.AvatarConfig.initialize(_avatarModel);
        }
        function get model() {
            return(_avatarModel);
        }
        function get expirationManager() {
            return(_expirationManager);
        }
        function get expirationTimer() {
            return(_expirationManager.expirationTimer);
        }
        function get effectManager() {
            return(_effectManager);
        }
        function get transformationManager() {
            return(_transformationManager);
        }
    }
