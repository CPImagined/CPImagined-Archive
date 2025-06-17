class com.clubpenguin.engine.puffles.effects.PuffleEffectManager
{
    var _SHELL, _frontEffectClip, _effectURL, _backEffectClip;
    function PuffleEffectManager()
    {
        _SHELL = _global.getCurrentShell();
    } // End of the function
    function createEffectInstance(effect, puffleClip, depth)
    {
        var _loc5 = effect.getLayeringType();
        switch (_loc5)
        {
            case com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.HAS_FRONT_ASSET:
            {
                _frontEffectClip = puffleClip.effectForeground_mc.createEmptyMovieClip("_frontEffectClip", depth);
                _effectURL = _SHELL.getPath(effect.getAssetPath());
                this.loadEffectClip(_frontEffectClip, _effectURL);
                break;
            } 
            case com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.HAS_BACK_ASSET:
            {
                _backEffectClip = puffleClip.effectBackground_mc.createEmptyMovieClip("_backEffectClip", depth);
                _effectURL = _SHELL.getPath(effect.getAssetPath());
                this.loadEffectClip(_backEffectClip, _effectURL);
                break;
            } 
            case com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.HAS_BOTH_ASSETS:
            {
                _frontEffectClip = puffleClip.effectForeground_mc.createEmptyMovieClip("_frontEffectClip", depth);
                _effectURL = _SHELL.getPath(effect.getAssetPath());
                _effectURL = com.clubpenguin.util.StringUtils.replaceString("%location%", com.clubpenguin.engine.puffles.effects.PuffleEffectManager.FRONT, _effectURL);
                this.loadEffectClip(_frontEffectClip, _effectURL);
                _backEffectClip = puffleClip.effectBackground_mc.createEmptyMovieClip("_backEffectClip", depth);
                _effectURL = _SHELL.getPath(effect.getAssetPath());
                _effectURL = com.clubpenguin.util.StringUtils.replaceString("%location%", com.clubpenguin.engine.puffles.effects.PuffleEffectManager.BACK, _effectURL);
                this.loadEffectClip(_backEffectClip);
                break;
            } 
        } // End of switch
    } // End of the function
    function loadEffectClip(effectClip)
    {
        var _loc2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onEffectLoaded, effectClip));
        _loc2.loadClip(_effectURL, effectClip, "PuffleEffectManager createEffectInstance()");
    } // End of the function
    function removeEffectInstance(effectClip)
    {
        _frontEffectClip.removeMovieClip();
        _frontEffectClip = null;
        _backEffectClip.removeMovieClip();
        _backEffectClip = null;
    } // End of the function
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
            } // end if
        };
    } // End of the function
    static var FRONT = "front";
    static var BACK = "back";
} // End of Class
