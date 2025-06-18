dynamic class com.clubpenguin.engine.puffles.effects.PuffleEffectManager
{
    static var FRONT: String = "front";
    static var BACK: String = "back";
    var _SHELL;
    var _backEffectClip;
    var _effectURL;
    var _frontEffectClip;

    function PuffleEffectManager()
    {
        this._SHELL = _global.getCurrentShell();
    }

    function createEffectInstance(effect, puffleClip, depth)
    {
        var __reg5 = effect.getLayeringType();
        if ((__reg0 = __reg5) === com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.HAS_FRONT_ASSET) 
        {
            this._frontEffectClip = puffleClip.effectForeground_mc.createEmptyMovieClip("_frontEffectClip", depth);
            this._effectURL = this._SHELL.getPath(effect.getAssetPath());
            this.loadEffectClip(this._frontEffectClip, this._effectURL);
            return;
        }
        else if (__reg0 === com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.HAS_BACK_ASSET) 
        {
            this._backEffectClip = puffleClip.effectBackground_mc.createEmptyMovieClip("_backEffectClip", depth);
            this._effectURL = this._SHELL.getPath(effect.getAssetPath());
            this.loadEffectClip(this._backEffectClip, this._effectURL);
            return;
        }
        else if (__reg0 !== com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.HAS_BOTH_ASSETS) 
        {
            return;
        }
        this._frontEffectClip = puffleClip.effectForeground_mc.createEmptyMovieClip("_frontEffectClip", depth);
        this._effectURL = this._SHELL.getPath(effect.getAssetPath());
        this._effectURL = com.clubpenguin.util.StringUtils.replaceString("%location%", com.clubpenguin.engine.puffles.effects.PuffleEffectManager.FRONT, this._effectURL);
        this.loadEffectClip(this._frontEffectClip, this._effectURL);
        this._backEffectClip = puffleClip.effectBackground_mc.createEmptyMovieClip("_backEffectClip", depth);
        this._effectURL = this._SHELL.getPath(effect.getAssetPath());
        this._effectURL = com.clubpenguin.util.StringUtils.replaceString("%location%", com.clubpenguin.engine.puffles.effects.PuffleEffectManager.BACK, this._effectURL);
        this.loadEffectClip(this._backEffectClip);
        return;
    }

    function loadEffectClip(effectClip)
    {
        var __reg2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        __reg2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, this.onEffectLoaded, effectClip));
        __reg2.loadClip(this._effectURL, effectClip, "PuffleEffectManager createEffectInstance()");
    }

    function removeEffectInstance(effectClip)
    {
        this._frontEffectClip.removeMovieClip();
        this._frontEffectClip = null;
        this._backEffectClip.removeMovieClip();
        this._backEffectClip = null;
    }

    function onEffectLoaded(event, effectClip)
    {
        com.clubpenguin.util.Log.debug("PuffleEffectManager onEffectLoaded");
        var scope = this;
        effectClip.onEnterFrame = function ()
        {
            if (effectClip._currentframe == effectClip._totalframes) 
            {
                scope._SHELL.updateListeners(scope._SHELL.PUFFLE_EFFECT_ANIMATION_COMPLETE);
                effectClip.onEnterFrame = null;
            }
        }
        ;
    }

}
