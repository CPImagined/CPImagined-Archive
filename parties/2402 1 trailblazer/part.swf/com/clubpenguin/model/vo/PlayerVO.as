
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.model.vo.PlayerVO implements com.clubpenguin.util.IVO
    {
        var avatarVO, player_id, nickname;
        function PlayerVO () {
        }
        function get avatar_id() {
            return(avatarVO.avatar_id);
        }
        function set avatar_id(value) {
            //return(avatar_id);
        }
        function destroy() {
        }
        function isReadyToBeBitmapCached() {
            return((hasNotMovedSince > 0) && ((getTimer() - hasNotMovedSince) > 3000));
        }
        function setIsBitmapCacheable(_arg_2) {
            if (_arg_2 && (hasNotMovedSince == -1)) {
                hasNotMovedSince = getTimer();
            } else if (!_arg_2) {
                hasNotMovedSince = -1;
            }
        }
        function getID() {
            return(String(player_id));
        }
        function update(_arg_2) {
            for (var _local_3 in _arg_2) {
                this[_local_3] = _arg_2[_local_3];
            }
        }
        function toString() {
            return(((((("PlayerVO{player_id:" + player_id) + ", nickname:") + nickname) + ", avatar_id:") + avatarVO.avatar_id) + "}");
        }
        function toDetailedString() {
            var _local_2 = "\n*** PlayerVO ***\n";
            for (var _local_3 in this) {
                _local_2 = _local_2 + (((_local_3 + " : ") + this[_local_3]) + " | ");
            }
            _local_2 = _local_2 + "\n****************\n";
            return(_local_2);
        }
        function equals(_arg_2) {
            if (this === _arg_2) {
                return(true);
            }
            return(false);
        }
        var hasNotMovedSince = -1;
        var lastFrame = -1;
    }
