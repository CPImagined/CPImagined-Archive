//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.puffleavatar.PuffleAvatarHat
    {
        var hatLoadCompleteSignal, _puffleReference, _puffleModel, _isAssetLoaded, _hatForegroundReference, _hatBackgroundReference, _assetURL, _assetLoader;
        function PuffleAvatarHat () {
            hatLoadCompleteSignal = new org.osflash.signals.Signal();
        }
        function init(_arg_3, _arg_4) {
            _puffleReference = _arg_3;
            _puffleModel = _arg_4;
            com.clubpenguin.util.Log.info("[PuffleAvatarHat] init()");
            _isAssetLoaded = false;
            _hatForegroundReference = _puffleReference[HAT_FOREGROUND];
            _hatBackgroundReference = _puffleReference[HAT_BACKGROUND];
            _assetURL = (_global.getCurrentShell().getGlobalContentPath() + PUFFLE_HATS_URL_LOCATION) + _puffleModel.hat.getAS2AssetPath();
            loadHatForegroundAsset();
        }
        function hide() {
            _hatForegroundReference._visible = false;
            _hatBackgroundReference._visible = false;
        }
        function show() {
            _hatForegroundReference._visible = true;
            _hatBackgroundReference._visible = true;
        }
        function loadHatForegroundAsset() {
            var _local_2 = _assetURL + "_hat_front.swf";
            _assetLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _assetLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadForegroundHatInit));
            _assetLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadAssetError));
            _assetLoader.loadClip(_local_2, _hatForegroundReference, "PuffleAvatar.as loadPuffleAsset()");
        }
        function onLoadForegroundHatInit() {
            _assetLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadForegroundHatInit));
            _hatForegroundReference.gotoAndStop(_puffleReference._currentframe);
            loadHatBackgroundAsset();
        }
        function loadHatBackgroundAsset() {
            var _local_2 = _assetURL + "_hat_back.swf";
            _assetLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _assetLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadBackgroundInit));
            _assetLoader.loadClip(_local_2, _hatBackgroundReference, "PuffleAvatar.as loadPuffleAsset()");
        }
        function onLoadBackgroundInit() {
            _assetLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadBackgroundInit));
            _assetLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadAssetError));
            _hatBackgroundReference.gotoAndStop(_puffleReference._currentframe);
            hatLoadCompleteSignal.dispatch();
            _isAssetLoaded = true;
        }
        function onLoadAssetError(_arg_2) {
            com.clubpenguin.util.Log.error("[PuffleAvatarHat] onLoadAssetError " + _arg_2.data.toString());
            _assetLoader = null;
            destroy();
        }
        function update() {
            if (_isAssetLoaded) {
                var _local_2 = _puffleReference._currentframe;
                if (_local_2 != _hatForegroundReference._currentframe) {
                    _hatForegroundReference.gotoAndStop(_local_2);
                    _hatBackgroundReference.gotoAndStop(_local_2);
                }
            }
        }
        function destroy() {
            _puffleReference = null;
            _hatForegroundReference = null;
            _hatBackgroundReference = null;
        }
        static var HAT_FOREGROUND = "hatForeground_mc";
        static var HAT_BACKGROUND = "hatBackground_mc";
        static var PUFFLE_HATS_URL_LOCATION = "puffle/hats/room/";
    }
