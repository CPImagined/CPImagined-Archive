//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.endgame.model.StampListModel
    {
        var _shell, _stampIds, _stamps;
        function StampListModel (shell, stampIds) {
            _shell = shell;
            _stampIds = stampIds;
            var _local_6 = _shell.getStampManager();
            var _local_5 = stampIds.length;
            _stamps = [];
            var _local_2 = 0;
            while (_local_2 < _local_5) {
                var _local_3 = _local_6.getStampBookItem(stampIds[_local_2], com.clubpenguin.stamps.StampBookItemType.STAMP.value);
                _stamps.push(_local_3);
                _local_2++;
            }
        }
        function get shell() {
            return(_shell);
        }
        function get stampIds() {
            return(_stampIds);
        }
        function getStamps() {
            return(_stamps);
        }
    }
