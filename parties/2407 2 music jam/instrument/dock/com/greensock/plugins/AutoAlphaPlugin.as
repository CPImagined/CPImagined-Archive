//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.plugins.AutoAlphaPlugin extends com.greensock.plugins.VisiblePlugin
    {
        var propName, overwriteProps, _target, addTween, _ignoreVisible, updateTweens, __get__changeFactor;
        function AutoAlphaPlugin () {
            super();
            propName = "autoAlpha";
            overwriteProps = ["_alpha", "_visible"];
        }
        function onInitTween(target, value, tween) {
            _target = target;
            addTween(target, "_alpha", target._alpha, value, "_alpha");
            return(true);
        }
        function killProps(lookup) {
            super.killProps(lookup);
            _ignoreVisible = Boolean(lookup._visible != undefined);
        }
        function set changeFactor(n) {
            updateTweens(n);
            if (!_ignoreVisible) {
                _target._visible = Boolean(_target._alpha != 0);
            }
            //return(__get__changeFactor());
        }
        static var API = 1;
    }
