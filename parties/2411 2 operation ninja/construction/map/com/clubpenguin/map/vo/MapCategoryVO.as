//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.map.vo.MapCategoryVO
    {
        var categoryId, name, triggers;
        function MapCategoryVO () {
        }
        function initFromObject(obj) {
            categoryId = obj.catid;
            name = obj.name;
            var _local_6 = -1;
            triggers = [];
            var _local_2 = 0;
            while (_local_2 < obj.items.length) {
                var _local_4 = obj.items[_local_2];
                if (_local_6 == _local_4.mapid) {
                } else {
                    _local_6 = _local_4.mapid;
                    var _local_3 = new com.clubpenguin.map.vo.MapTriggerVO();
                    _local_3.initFromObject(obj.items[_local_2]);
                    _local_3.categoryId = categoryId;
                    triggers.push(_local_3);
                }
                _local_2++;
            }
        }
    }
