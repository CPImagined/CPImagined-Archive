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
        function setAvatarData(avatarId, data) {
            _avatarData[avatarId] = data;
        }
        function getAvatarData(avatarId) {
            return(_avatarData[avatarId]);
        }
        function getLocalPlayerAvatarVO() {
            return(getAvatarData(_SHELL.getMyPlayerObject().avatar_id));
        }
        function getPlayerAvatarVO(player) {
            return(getAvatarData(player.avatar_id));
        }
        function setAvatarSnowball(avatarId, snowballData) {
            var _local_2 = _avatarData[avatarId];
            if (_local_2 != undefined) {
                _local_2.snowball = snowballData;
            }
        }
        function getAvatarSnowball(avatarId) {
            return(_avatarData[avatarId].snowball);
        }
    }
