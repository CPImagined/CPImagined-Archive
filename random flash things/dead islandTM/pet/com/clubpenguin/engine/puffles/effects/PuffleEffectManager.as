//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.effects.PuffleEffectManager
    {
        var _SHELL, _frontEffectClip, _effectURL, _backEffectClip;
        function PuffleEffectManager () {
            _SHELL = _global.getCurrentShell();
        }
        function createEffectInstance(_arg_2, _arg_3, _arg_4) {
            var _local_5 = _arg_2.getLayeringType();
            switch (_local_5) {
                case com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.HAS_FRONT_ASSET : 
                    _frontEffectClip = _arg_3.effectForeground_mc.createEmptyMovieClip("_frontEffectClip", _arg_4);
                    _effectURL = _SHELL.getPath(_arg_2.getAssetPath());
                    loadEffectClip(_frontEffectClip, _effectURL);
                    break;
                case com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.HAS_BACK_ASSET : 
                    _backEffectClip = _arg_3.effectBackground_mc.createEmptyMovieClip("_backEffectClip", _arg_4);
                    _effectURL = _SHELL.getPath(_arg_2.getAssetPath());
                    loadEffectClip(_backEffectClip, _effectURL);
                    break;
                case com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.HAS_BOTH_ASSETS : 
                    _frontEffectClip = _arg_3.effectForeground_mc.createEmptyMovieClip("_frontEffectClip", _arg_4);
                    _effectURL = _SHELL.getPath(_arg_2.getAssetPath());
                    _effectURL = com.clubpenguin.util.StringUtils.replaceString("%location%", FRONT, _effectURL);
                    loadEffectClip(_frontEffectClip, _effectURL);
                    _backEffectClip = _arg_3.effectBackground_mc.createEmptyMovieClip("_backEffectClip", _arg_4);
                    _effectURL = _SHELL.getPath(_arg_2.getAssetPath());
                    _effectURL = com.clubpenguin.util.StringUtils.replaceString("%location%", BACK, _effectURL);
                    loadEffectClip(_backEffectClip);
            }
        }
        function loadEffectClip(_arg_3) {
            var _local_2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _local_2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onEffectLoaded, _arg_3));
            _local_2.loadClip(_effectURL, _arg_3, "PuffleEffectManager createEffectInstance()");
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
