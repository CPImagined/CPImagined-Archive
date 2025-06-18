//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.igloo.component.renderer.IconLoader
    {
        static var _instance;
        function IconLoader () {
        }
        static function getInstance() {
            if (_instance == null) {
                _instance = new com.clubpenguin.igloo.component.renderer.IconLoader();
            }
            return(_instance);
        }
        function clearInProgressLoads() {
            _inProgressLoads = {};
        }
        function getIcon(url, holder, loadQueue, loadedHandler) {
            if (((url == undefined) || (holder == undefined)) || (loadQueue == undefined)) {
                return(undefined);
            }
            if (com.clubpenguin.hud.IconCache.hasIcon(url)) {
                holder.removeMovieClip();
                loadedHandler.dispatch(true, url, com.clubpenguin.hud.IconCache.getBitmapData(url));
            } else {
                var _local_3 = {};
                _local_3.url = url;
                _local_3.holder = holder;
                _local_3.loadQueue = loadQueue;
                _local_3.handler = loadedHandler;
                if (_inProgressLoads[url] == undefined) {
                    _inProgressLoads[url] = new Array();
                    var _local_4 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
                    _local_4.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit, url, holder, _local_4));
                    _local_4.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadError, url, holder, _local_4));
                    loadQueue.enqueue(_local_4, url, holder);
                }
                _inProgressLoads[url].push(_local_3);
            }
        }
        function onLoadError(event, loadedURL, holder, loader) {
            loader.unloadClip(holder);
            holder.removeMovieClip();
            var _local_3 = _inProgressLoads[loadedURL];
            var _local_2 = 0;
            while (_local_2 < _local_3.length) {
                _local_3[_local_2].holder.removeMovieClip();
                _local_3[_local_2].handler.dispatch(false, loadedURL, new flash.display.BitmapData());
                _local_2++;
            }
        }
        function onLoadInit(event, loadedURL, holder, loader) {
            var _local_6 = event.target;
            if (_local_6) {
                var _local_7 = new flash.geom.Matrix();
                var _local_8 = new flash.geom.Matrix();
                _local_7.translate((_local_6._width / 2) + 3, (_local_6._height / 2) + 3);
                _local_8.scale(2, 2);
                _local_7.concat(_local_8);
                var _local_4 = new flash.display.BitmapData((_local_6._width * 2) + 12, (_local_6._height * 2) + 12, true, 0);
                _local_4.draw(_local_6, _local_7);
                com.clubpenguin.hud.IconCache.cacheBitmapData(_local_4, loadedURL);
                loader.unloadClip(holder);
                holder.removeMovieClip();
                var _local_3 = _inProgressLoads[loadedURL];
                var _local_2 = 0;
                while (_local_2 < _local_3.length) {
                    _local_3[_local_2].holder.removeMovieClip();
                    _local_3[_local_2].handler.dispatch(true, loadedURL, _local_4);
                    _local_2++;
                }
            }
            _inProgressLoads[loadedURL] = null;
        }
        var _inProgressLoads = {};
    }
