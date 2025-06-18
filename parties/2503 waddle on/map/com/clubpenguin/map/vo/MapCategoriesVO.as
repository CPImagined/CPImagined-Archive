//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.map.vo.MapCategoriesVO
    {
        var categories;
        function MapCategoriesVO () {
        }
        function MapTriggersVO() {
        }
        function initFromObject(obj) {
            categories = [];
            var _local_2 = 0;
            while (_local_2 < obj.categories.length) {
                var _local_3 = new com.clubpenguin.map.vo.MapCategoryVO();
                _local_3.initFromObject(obj.categories[_local_2]);
                categories.push(_local_3);
                _local_2++;
            }
        }
        function getCategoryById(id) {
            var _local_2 = 0;
            while (_local_2 < categories.length) {
                if (categories[_local_2].categoryId == id) {
                    return(categories[_local_2]);
                }
                _local_2++;
            }
            return(null);
        }
        function getTriggerByMapId(categoryId, mapId) {
            var _local_3 = getCategoryById(categoryId);
            if (_local_3 == null) {
                return(null);
            }
            var _local_2 = 0;
            while (_local_2 < _local_3.triggers.length) {
                if (_local_3.triggers[_local_2].mapId == mapId) {
                    return(_local_3.triggers[_local_2]);
                }
                _local_2++;
            }
            return(null);
        }
        function getTriggerByTriggerId(categoryId, triggerId) {
            var _local_3 = getCategoryById(categoryId);
            if (_local_3 == null) {
                return(null);
            }
            var _local_2 = 0;
            while (_local_2 < _local_3.triggers.length) {
                if (_local_3.triggers[_local_2].triggerId == triggerId) {
                    return(_local_3.triggers[_local_2]);
                }
                _local_2++;
            }
            return(null);
        }
        function getTriggerByTriggerName(triggerName) {
            var _local_4 = 0;
            while (_local_4 < categories.length) {
                var _local_3 = categories[_local_4];
                var _local_2 = 0;
                while (_local_2 < _local_3.triggers.length) {
                    if (_local_3.triggers[_local_2].trigger == triggerName) {
                        return(_local_3.triggers[_local_2]);
                    }
                    _local_2++;
                }
                _local_4++;
            }
            return(null);
        }
        static var CATEGORY_NONE_ID = 0;
        static var CATEGORY_GAMES_ID = 1;
        static var CATEGORY_PETS_ID = 3;
        static var CATEGORY_SHOPPING_ID = 2;
        static var CATEGORY_PLACES_ID = 4;
    }
