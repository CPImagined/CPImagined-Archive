//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.igloo.util.HybridMovieClipLoaderQueue
    {
        var _priority, _queue;
        function HybridMovieClipLoaderQueue (priority) {
            _priority = priority;
            if ((_priority == undefined) || ((_priority != PRIORITY_NEWEST) && (_priority != PRIORITY_OLDEST))) {
                _priority = PRIORITY_OLDEST;
            }
            _queue = [];
        }
        function enqueue(loader, url, holder) {
            _queue[_priority]({loader:loader, url:url, holder:holder});
            checkLoadNext();
        }
        function checkLoadNext() {
            while ((_activeLoads < MAX_LOADS) && (_queue.length > 0)) {
                this.load(_queue.shift());
            }
        }
        function load(loadObj) {
            _activeLoads = _activeLoads + 1;
            var _local_2 = loadObj.loader;
            _local_2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadComplete));
            _local_2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadComplete));
            _local_2.loadClip(loadObj.url, loadObj.holder);
        }
        function onLoadComplete(event) {
            _activeLoads = _activeLoads - 1;
            if (_activeLoads < 0) {
                _activeLoads = 0;
            }
            checkLoadNext();
        }
        function clear() {
            _activeLoads = 0;
            _queue = [];
        }
        static var PRIORITY_NEWEST = "unshift";
        static var PRIORITY_OLDEST = "push";
        static var MAX_LOADS = 8;
        var _activeLoads = 0;
    }
