//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.model.vo.PlayerVO implements com.clubpenguin.util.IVO
    {
        var player_id;
        function PlayerVO () {
        }
        function destroy() {
        }
        function isReadyToBeBitmapCached() {
            return((hasNotMovedSince > 0) && ((getTimer() - hasNotMovedSince) > 3000));
        }
        function setIsBitmapCacheable(isCacheable) {
            if (isCacheable && (hasNotMovedSince == -1)) {
                hasNotMovedSince = getTimer();
            } else if (!isCacheable) {
                hasNotMovedSince = -1;
            }
        }
        function getID() {
            return(String(player_id));
        }
        function update(vo) {
            for (var _local_3 in vo) {
                this[_local_3] = vo[_local_3];
            }
        }
        function toString() {
            var _local_2 = "\n*** PlayerVO ***\n";
            for (var _local_3 in this) {
                _local_2 = _local_2 + (((_local_3 + " : ") + this[_local_3]) + " | ");
            }
            _local_2 = _local_2 + "\n****************\n";
            return(_local_2);
        }
        function equals(vo) {
            if (this === vo) {
                return(true);
            }
            return(false);
        }
        var hasNotMovedSince = -1;
        var lastFrame = -1;
    }
