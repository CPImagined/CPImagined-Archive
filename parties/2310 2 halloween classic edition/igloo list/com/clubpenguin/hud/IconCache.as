//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.IconCache
    {
        function IconCache () {
        }
        static function hasIcon(path) {
            var _local_1 = getBitmapData(path);
            return((_local_1 != undefined) && (_local_1 != null));
        }
        static function getBitmapData(path) {
            return(_icons[path]);
        }
        static function cacheBitmapData(icon, path) {
            addIcon(icon, path);
            cleanMemory();
        }
        static function clearCache() {
            var _local_1 = 0;
            while (_local_1 < _iconPaths.length) {
                removeIcon(_iconPaths[_local_1]);
                _local_1++;
            }
            trace(("[IconCache] cleared cache: " + (_usedMemory / 1024)) + "kb");
        }
        static function addIcon(icon, path) {
            trace(((("[IconCache] adding icon: " + path) + "  memory: ") + (_usedMemory / 1024)) + "kb");
            if (hasIcon(path)) {
                return(undefined);
            }
            _usedMemory = _usedMemory + ((icon.width * icon.height) * 4);
            _icons[path] = icon;
            _iconPaths.push(path);
        }
        static function removeIcon(path) {
            trace(((("[IconCache] removing icon: " + path) + "  memory: ") + (_usedMemory / 1024)) + "kb");
            var _local_1 = _icons[path];
            _usedMemory = _usedMemory - ((_local_1.width * _local_1.height) * 4);
            _local_1.dispose();
            _icons[path] = null;
        }
        static function cleanMemory() {
            while (_usedMemory > MAX_MEMORY) {
                var _local_1 = String(_iconPaths.shift());
                removeIcon(_local_1);
            }
        }
        static var MAX_MEMORY = 209715200;
        static var _icons = {};
        static var _iconPaths = [];
        static var _usedMemory = 0;
    }
