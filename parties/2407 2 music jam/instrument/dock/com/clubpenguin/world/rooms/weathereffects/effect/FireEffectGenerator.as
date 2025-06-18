//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator
    {
        static var _tweenObjects;
        var _wem, _elementHolder;
        function FireEffectGenerator (wem) {
            trace(CLASS_NAME + "Instatiated");
            _wem = wem;
            _maxHeight = _wem.fireAnimationHeight;
            _elementAmount = _wem.fireAmount;
            _delayTime = _wem.fireDelayTime;
            _tweenObjects = [];
            setMovieClips();
        }
        function setMovieClips() {
            _elementHolder = _wem.getBackogrundMC().weatherEffects_mc.fireEffect;
        }
        function startEffect() {
            if (_running) {
                return(undefined);
            }
            trace(CLASS_NAME + ": startEffect()");
            _running = true;
            var _local_2 = 0;
            while (_local_2 < _elementAmount) {
                setupElement(_local_2);
                _local_2++;
            }
        }
        function stopEffect() {
            trace(CLASS_NAME + ": stopEffect()");
            _running = false;
            var _local_2 = 0;
            while (_local_2 < _elementAmount) {
                _tweenObjects[_local_2].repeat = 0;
                _local_2++;
            }
        }
        function setupElement(index) {
            trace(CLASS_NAME + ": setupElement()");
            var _local_2 = _elementHolder.attachMovie(_elementArtMc, "f" + index, index + 100);
            _local_2.gotoAndStop(1);
            _local_2.index = index;
            var _local_6 = Math.random() * _delayTime;
            var _local_4 = new Array();
            _local_4.push(_local_2);
            _local_4.push(this);
            _tweenObjects[index] = new com.greensock.TweenMax(_local_2, 0, {delay:_local_6, onComplete:beginEffect, onCompleteParams:_local_4});
            _tweenObjects[index].play();
        }
        function beginEffect(me, effect) {
            if (!effect._running) {
                me.removeMovieClip();
                return(undefined);
            }
            me.play();
        }
        static function onAnimDone(mc) {
            mc.gotoAndStop(1);
            var _local_2 = Math.random() * _delayTime;
            mc._y = int(Math.random() * _maxHeight);
            mc._x = 0;
            _tweenObjects[mc.index].delay = _local_2;
            _tweenObjects[mc.index].restart(true, false);
        }
        static var CLASS_NAME = "[FireEffectGenerator] ";
        var _elementArtMc = "WeatherFX_03_Fire_Sprite";
        var _maxWidth = Stage.width;
        static var _maxHeight = 55;
        var _running = false;
        var _elementAmount = 3;
        static var _delayTime = 2;
    }
