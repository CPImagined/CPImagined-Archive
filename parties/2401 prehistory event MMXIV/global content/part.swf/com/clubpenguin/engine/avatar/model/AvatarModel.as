
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.engine.avatar.model.AvatarModel
    {
        var _SHELL, _avatarData, _snowballHitChecks;
        function AvatarModel () {
            _SHELL = _global.getCurrentShell();
            _avatarData = {};
            _snowballHitChecks = {};
        }
        function setSnowballHitCheck(_arg_2, _arg_3) {
            _snowballHitChecks[_arg_2.__get__symbolName()] = _arg_3;
        }
        function getSnowballHitCheck(_arg_2) {
            return(_snowballHitChecks[_arg_2.__get__symbolName()]);
        }
        function setAvatarTemplate(_arg_2, _arg_3) {
            _arg_3.avatar_id = _arg_2;
            _avatarData[_arg_2] = _arg_3;
        }
        function getAvatarTemplate(_arg_2) {
            return(_avatarData[_arg_2]);
        }
        function createAvatarFromTemplate(_arg_2) {
            if (_avatarData[_arg_2] != null) {
                return(_avatarData[_arg_2].clone());
            } else {
                return(_avatarData[com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID].clone());
            }
        }
    }
