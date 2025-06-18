dynamic class com.clubpenguin.puffleavatar.PuffleAvatarHat
{
    static var HAT_FOREGROUND: String = "hatForeground_mc";
    static var HAT_BACKGROUND: String = "hatBackground_mc";
    static var PUFFLE_HATS_URL_LOCATION: String = "puffle/hats/room/";
    var _assetLoader;
    var _assetURL;
    var _hatBackgroundReference;
    var _hatForegroundReference;
    var _isAssetLoaded;
    var _puffleModel;
    var _puffleReference;
    var hatLoadCompleteSignal;

    function PuffleAvatarHat()
    {
        this.hatLoadCompleteSignal = new org.osflash.signals.Signal();
    }

    function init(puffleReference, puffleModel)
    {
        this._puffleReference = puffleReference;
        this._puffleModel = puffleModel;
        com.clubpenguin.util.Log.info("[PuffleAvatarHat] init()");
        this._isAssetLoaded = false;
        this._hatForegroundReference = this._puffleReference[com.clubpenguin.puffleavatar.PuffleAvatarHat.HAT_FOREGROUND];
        this._hatBackgroundReference = this._puffleReference[com.clubpenguin.puffleavatar.PuffleAvatarHat.HAT_BACKGROUND];
        this._assetURL = _global.getCurrentShell().getGlobalContentPath() + com.clubpenguin.puffleavatar.PuffleAvatarHat.PUFFLE_HATS_URL_LOCATION + this._puffleModel.hat.getAS2AssetPath();
        this.loadHatForegroundAsset();
    }

    function hide()
    {
        this._hatForegroundReference._visible = false;
        this._hatBackgroundReference._visible = false;
    }

    function show()
    {
        this._hatForegroundReference._visible = true;
        this._hatBackgroundReference._visible = true;
    }

    function loadHatForegroundAsset()
    {
        var __reg2 = this._assetURL + "_hat_front.swf";
        this._assetLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        this._assetLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, this.onLoadForegroundHatInit));
        this._assetLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, this.onLoadAssetError));
        this._assetLoader.loadClip(__reg2, this._hatForegroundReference, "PuffleAvatar.as loadPuffleAsset()");
    }

    function onLoadForegroundHatInit()
    {
        this._assetLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, this.onLoadForegroundHatInit));
        this._hatForegroundReference.gotoAndStop(this._puffleReference._currentframe);
        this.loadHatBackgroundAsset();
    }

    function loadHatBackgroundAsset()
    {
        var __reg2 = this._assetURL + "_hat_back.swf";
        this._assetLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        this._assetLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, this.onLoadBackgroundInit));
        this._assetLoader.loadClip(__reg2, this._hatBackgroundReference, "PuffleAvatar.as loadPuffleAsset()");
    }

    function onLoadBackgroundInit()
    {
        this._assetLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, this.onLoadBackgroundInit));
        this._assetLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, this.onLoadAssetError));
        this._hatBackgroundReference.gotoAndStop(this._puffleReference._currentframe);
        this.hatLoadCompleteSignal.dispatch();
        this._isAssetLoaded = true;
    }

    function onLoadAssetError(event)
    {
        com.clubpenguin.util.Log.error("[PuffleAvatarHat] onLoadAssetError " + event.__get__data().toString());
        this._assetLoader = null;
        this.destroy();
    }

    function update()
    {
        if (this._isAssetLoaded) 
        {
            var __reg2 = this._puffleReference._currentframe;
            if (__reg2 != this._hatForegroundReference._currentframe) 
            {
                this._hatForegroundReference.gotoAndStop(__reg2);
                this._hatBackgroundReference.gotoAndStop(__reg2);
            }
        }
    }

    function destroy()
    {
        this._puffleReference = null;
        this._hatForegroundReference = null;
        this._hatBackgroundReference = null;
    }

}
