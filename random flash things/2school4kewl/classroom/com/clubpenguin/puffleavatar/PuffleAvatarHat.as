class com.clubpenguin.puffleavatar.PuffleAvatarHat
{
    var hatLoadCompleteSignal, _puffleReference, _puffleModel, _isAssetLoaded, _hatForegroundReference, _hatBackgroundReference, _assetURL, _assetLoader;
    function PuffleAvatarHat()
    {
        hatLoadCompleteSignal = new org.osflash.signals.Signal();
    } // End of the function
    function init(puffleReference, puffleModel)
    {
        _puffleReference = puffleReference;
        _puffleModel = puffleModel;
        com.clubpenguin.util.Log.info("[PuffleAvatarHat] init()");
        _isAssetLoaded = false;
        _hatForegroundReference = _puffleReference[com.clubpenguin.puffleavatar.PuffleAvatarHat.HAT_FOREGROUND];
        _hatBackgroundReference = _puffleReference[com.clubpenguin.puffleavatar.PuffleAvatarHat.HAT_BACKGROUND];
        _assetURL = _global.getCurrentShell().getGlobalContentPath() + com.clubpenguin.puffleavatar.PuffleAvatarHat.PUFFLE_HATS_URL_LOCATION + _puffleModel.hat.getAS2AssetPath();
        this.loadHatForegroundAsset();
    } // End of the function
    function hide()
    {
        _hatForegroundReference._visible = false;
        _hatBackgroundReference._visible = false;
    } // End of the function
    function show()
    {
        _hatForegroundReference._visible = true;
        _hatBackgroundReference._visible = true;
    } // End of the function
    function loadHatForegroundAsset()
    {
        var _loc2 = _assetURL + "_hat_front.swf";
        _assetLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _assetLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadForegroundHatInit));
        _assetLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadAssetError));
        _assetLoader.loadClip(_loc2, _hatForegroundReference, "PuffleAvatar.as loadPuffleAsset()");
    } // End of the function
    function onLoadForegroundHatInit()
    {
        _assetLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadForegroundHatInit));
        _hatForegroundReference.gotoAndStop(_puffleReference._currentframe);
        this.loadHatBackgroundAsset();
    } // End of the function
    function loadHatBackgroundAsset()
    {
        var _loc2 = _assetURL + "_hat_back.swf";
        _assetLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _assetLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadBackgroundInit));
        _assetLoader.loadClip(_loc2, _hatBackgroundReference, "PuffleAvatar.as loadPuffleAsset()");
    } // End of the function
    function onLoadBackgroundInit()
    {
        _assetLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadBackgroundInit));
        _assetLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadAssetError));
        _hatBackgroundReference.gotoAndStop(_puffleReference._currentframe);
        hatLoadCompleteSignal.dispatch();
        _isAssetLoaded = true;
    } // End of the function
    function onLoadAssetError(event)
    {
        com.clubpenguin.util.Log.error("[PuffleAvatarHat] onLoadAssetError " + event.__get__data().toString());
        _assetLoader = null;
        this.destroy();
    } // End of the function
    function update()
    {
        if (_isAssetLoaded)
        {
            var _loc2 = _puffleReference._currentframe;
            if (_loc2 != _hatForegroundReference._currentframe)
            {
                _hatForegroundReference.gotoAndStop(_loc2);
                _hatBackgroundReference.gotoAndStop(_loc2);
            } // end if
        } // end if
    } // End of the function
    function destroy()
    {
        _puffleReference = null;
        _hatForegroundReference = null;
        _hatBackgroundReference = null;
    } // End of the function
    static var HAT_FOREGROUND = "hatForeground_mc";
    static var HAT_BACKGROUND = "hatBackground_mc";
    static var PUFFLE_HATS_URL_LOCATION = "puffle/hats/room/";
} // End of Class
