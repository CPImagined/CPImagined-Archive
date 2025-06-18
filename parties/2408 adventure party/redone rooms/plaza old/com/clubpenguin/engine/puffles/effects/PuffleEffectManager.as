//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.effects.PuffleEffectManager
    {
        var _SHELL, _frontEffectClip, _effectURL, _backEffectClip;
        function PuffleEffectManager () {
            _SHELL = _global.getCurrentShell();
        }
        function createEffectInstance(effect, puffleClip, depth) {
            var _local_5 = effect.getLayeringType();
            switch (_local_5) {
                case com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.HAS_FRONT_ASSET : 
                    _frontEffectClip = puffleClip.effectForeground_mc.createEmptyMovieClip("_frontEffectClip", depth);
                    _effectURL = _SHELL.getPath(effect.getAssetPath());
                    loadEffectClip(_frontEffectClip, _effectURL);
                    break;
                case com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.HAS_BACK_ASSET : 
                    _backEffectClip = puffleClip.effectBackground_mc.createEmptyMovieClip("_backEffectClip", depth);
                    _effectURL = _SHELL.getPath(effect.getAssetPath());
                    loadEffectClip(_backEffectClip, _effectURL);
                    break;
                case com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.HAS_BOTH_ASSETS : 
                    _frontEffectClip = puffleClip.effectForeground_mc.createEmptyMovieClip("_frontEffectClip", depth);
                    _effectURL = _SHELL.getPath(effect.getAssetPath());
                    _effectURL = com.clubpenguin.util.StringUtils.replaceString("%location%", FRONT, _effectURL);
                    loadEffectClip(_frontEffectClip, _effectURL);
                    _backEffectClip = puffleClip.effectBackground_mc.createEmptyMovieClip("_backEffectClip", depth);
                    _effectURL = _SHELL.getPath(effect.getAssetPath());
                    _effectURL = com.clubpenguin.util.StringUtils.replaceString("%location%", BACK, _effectURL);
                    loadEffectClip(_backEffectClip);
                    break;
            }
        }
        function loadEffectClip(effectClip) {
            var _local_2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _local_2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onEffectLoaded, effectClip));
            _local_2.loadClip(_effectURL, effectClip, "PuffleEffectManager createEffectInstance()");
        }
        function removeEffectInstance(effectClip) {
            _frontEffectClip.removeMovieClip();
            _frontEffectClip = null;
            _backEffectClip.removeMovieClip();
            _backEffectClip = null;
        }
        function onEffectLoaded(event, effectClip) {
            com.clubpenguin.util.Log.debug("PuffleEffectManager onEffectLoaded");
            var scope = this;
            effectClip.onEnterFrame = function () {
                if (effectClip._currentframe == effectClip._totalframes) {
                    scope._SHELL.updateListeners(scope._SHELL.PUFFLE_EFFECT_ANIMATION_COMPLETE);
                    effectClip.onEnterFrame = null;
                }
            };
        }
        static var FRONT = "front";
        static var BACK = "back";
    }
