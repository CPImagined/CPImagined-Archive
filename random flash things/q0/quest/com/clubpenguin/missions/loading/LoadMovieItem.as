//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.missions.loading.LoadMovieItem
    {
        var _id, _url, _container, _listener, _mcl, dispatchEvent;
        function LoadMovieItem ($id, $url, $container) {
            _id = $id;
            _url = $url;
            _container = $container;
            mx.events.EventDispatcher.initialize(this);
            _listener = {};
            _listener.onLoadInit = com.clubpenguin.util.Delegate.create(this, onLoadInit);
            _listener.onLoadProgress = com.clubpenguin.util.Delegate.create(this, onLoadProgress);
            _mcl = new MovieClipLoader();
            _mcl.addListener(_listener);
        }
        function start() {
            _mcl.loadClip(_url, _container);
        }
        function onLoadInit($target) {
            dispatchEvent(new com.clubpenguin.missions.loading.LoadMovieItemEvent(com.clubpenguin.missions.loading.LoadMovieItemEvent.COMPLETE, this));
        }
        function onLoadProgress($target, $bytesLoaded, $bytesTotal) {
            _loaded = $bytesLoaded;
            _total = $bytesTotal;
            dispatchEvent(new com.clubpenguin.missions.loading.LoadMovieItemEvent(com.clubpenguin.missions.loading.LoadMovieItemEvent.PROGRESS, this));
        }
        function get id() {
            return(_id);
        }
        function get percentLoaded() {
            var _local_2 = _loaded / _total;
            if (_local_2) {
                return(_local_2);
            } else {
                return(0);
            }
        }
        var _loaded = 0;
        var _total = 0;
    }
