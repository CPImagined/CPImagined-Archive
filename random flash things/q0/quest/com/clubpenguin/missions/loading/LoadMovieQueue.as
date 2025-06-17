    class com.clubpenguin.missions.loading.LoadMovieQueue extends Array
    {
        var _loadingItems, _loadedItems, length, shift, dispatchEvent;
        function LoadMovieQueue () {
            super();
            mx.events.EventDispatcher.initialize(this);
            _loadingItems = {};
            _loadedItems = {};
        }
        function push($url, $container) {
            if (($url == "") && ($url == null)) {
            }
            if (!$container) {
            }
            var _local_4 = new com.clubpenguin.missions.loading.LoadMovieItem(length + 1, $url, $container);
            super.push(_local_4);
            _totalItems++;
        }
        function start() {
            if (!_loading) {
                if (length >= THREAD_AMOUNT) {
                    while (_activeItems < THREAD_AMOUNT) {
                        startNext();
                    }
                } else {
                    var _local_2 = 0;
                    while (_local_2 < length) {
                        startNext();
                        _local_2++;
                    }
                }
            }
        }
		
		function getLength() {
			var aLength = 0;
			for(var i=0; i < this.length; i++) {
				if(this[i] != undefined) aLength++;
			}
			return aLength;
		}
		
        function get loading() {
            return(_loading);
        }
        function get complete() {
            return(_complete);
        }
        function get percentLoaded() {
            return(_loaded / _totalItems);
        }
        function startNext() {
            _loading = true;
            var _local_2 = com.clubpenguin.missions.loading.LoadMovieItem(this.shift());
			
            _local_2.start();
            _local_2.addEventListener(com.clubpenguin.missions.loading.LoadMovieItemEvent.PROGRESS, mx.utils.Delegate.create(this, onLoadItemProgress));
            _local_2.addEventListener(com.clubpenguin.missions.loading.LoadMovieItemEvent.COMPLETE, mx.utils.Delegate.create(this, onLoadItemComplete));
            _loadingItems["item" + _local_2.id] = _local_2;
            _activeItems++;
        }
        function onLoadItemProgress($event) {
            _loaded = 0;
            var _local_2;
            for (_local_2 in _loadingItems) {
                _loaded = _loaded + _loadingItems[_local_2].percentLoaded;
            }
            for (_local_2 in _loadedItems) {
                _loaded = _loaded + 1;
            }
            dispatchEvent(new com.clubpenguin.missions.loading.LoadMovieQueueEvent(com.clubpenguin.missions.loading.LoadMovieQueueEvent.PROGRESS, this));
        }
        function onLoadItemComplete($event) {
            var _local_2 = $event.target;
            _activeItems--;
            delete _loadingItems["item" + _local_2.id];
            _loadedItems["item" + _local_2.id] = _local_2;
            if (getLength() > 0) {
                startNext();
            } else if (_activeItems == 0) {
                onQueueComplete();
            }
        }
        function onQueueComplete() {
            _complete = true;
            _loading = false;
            _loaded = _totalItems;
            dispatchEvent(new com.clubpenguin.missions.loading.LoadMovieQueueEvent(com.clubpenguin.missions.loading.LoadMovieQueueEvent.COMPLETE, this));
        }
        static var THREAD_AMOUNT = 10;
        var _loading = false;
        var _complete = false;
        var _totalItems = 0;
        var _loaded = 0;
        var _activeItems = 0;
    }
