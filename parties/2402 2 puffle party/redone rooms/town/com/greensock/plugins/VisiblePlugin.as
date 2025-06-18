//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.plugins.VisiblePlugin extends com.greensock.plugins.TweenPlugin
    {
        var propName, overwriteProps, _target, _tween, _initVal, _visible, __get__changeFactor;
        function VisiblePlugin () {
            super();
            propName = "_visible";
            overwriteProps = ["_visible"];
        }
        function onInitTween(target, value, tween) {
            _target = target;
            _tween = tween;
            _initVal = Boolean(_target._visible);
            _visible = Boolean(value);
            return(true);
        }
        function set changeFactor(n) {
            if ((n == 1) && ((_tween.cachedDuration == _tween.cachedTime) || (_tween.cachedTime == 0))) {
                _target._visible = _visible;
            } else {
                _target._visible = _initVal;
            }
            //return(__get__changeFactor());
        }
        static var API = 1;
    }
