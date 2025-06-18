//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.avatar.model.AvatarModel
    {
        var _SHELL, _avatarData, _snowballHitChecks;
        function AvatarModel () {
            _SHELL = _global.getCurrentShell();
            _avatarData = {};
            _snowballHitChecks = {};
        }
        function setSnowballHitCheck(avatarEnum, snowballHitCheck) {
            _snowballHitChecks[avatarEnum.symbolName] = snowballHitCheck;
        }
        function getSnowballHitCheck(avatarEnum) {
            return(_snowballHitChecks[avatarEnum.symbolName]);
        }
        function setAvatarTemplate(avatarId, data) {
            data.avatar_id = avatarId;
            _avatarData[avatarId] = data;
        }
        function getAvatarTemplate(avatarId) {
            return(_avatarData[avatarId]);
        }
        function createAvatarFromTemplate(avatarId) {
            if (_avatarData[avatarId] != null) {
                return(_avatarData[avatarId].clone());
            } else {
                return(_avatarData[com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID].clone());
            }
        }
    }
