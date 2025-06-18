//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.weathereffects.effect.RainEffectGenerator
    {
        var _wem, _elementHolder;
        function RainEffectGenerator (wem) {
            _wem = wem;
            _maxHeight = wem.rainAnimationHeight;
            _elementSpeed = wem.rainAnimationSpeed;
            _elementAmount = wem.rainAmount;
            _elementShrinkSize = wem.rainShrinkSize;
            _elementDelayTime = wem.rainDelayTime;
            _elementRotation = wem.rainRotation;
            setMovieClips();
        }
        function setMovieClips() {
            _elementHolder = _wem.getBackogrundMC().weatherEffects_mc.waterEffect;
        }
        function startEffect() {
            if (_running) {
                return(undefined);
            }
            _running = true;
            var _local_2 = 0;
            while (_local_2 < _elementAmount) {
                setupElement(_local_2);
                _local_2++;
            }
        }
        function stopEffect() {
            _running = false;
        }
        function setupElement(index) {
            var _local_2 = _elementHolder.attachMovie(_elementArtMc, "r" + index, index + 200);
            _local_2.index = index;
            beginEffect(_local_2, this);
        }
        function beginEffect(me, effect) {
            if (!effect._running) {
                me.removeMovieClip();
                return(undefined);
            }
            var _local_4 = effect._elementSpeed;
            var _local_5 = Math.random() * effect._elementDelayTime;
            me._y = 0;
            me._x = int(Math.random() * effect._maxWidth);
            me._rotation = effect._elementRotation;
            me._alpha = 100;
            me._yscale = 100;
            me._xscale = 100;
            var _local_3 = new Array();
            _local_3.push(me);
            _local_3.push(effect);
            com.greensock.TweenMax.to(me, _local_4, {_y:effect._maxHeight, _x:me._x + (effect._maxHeight / 2), _yscale:effect._elementShrinkSize, _xscale:effect._elementShrinkSize, delay:_local_5, ease:com.greensock.easing.Linear.easeOut, onComplete:effect.beginEffect, onCompleteParams:_local_3});
        }
        static var CLASS_NAME = "[RainEffectGenerator] ";
        var _elementArtMc = "WeatherFX_01_Water_Sprite";
        var _maxWidth = Stage.width;
        var _maxHeight = 85;
        var _running = false;
        var _elementSpeed = 0.5;
        var _elementAmount = 25;
        var _elementShrinkSize = 25;
        var _elementDelayTime = 2;
        var _elementRotation = -26;
    }
