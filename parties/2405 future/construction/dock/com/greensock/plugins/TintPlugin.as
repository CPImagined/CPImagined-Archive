//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.plugins.TintPlugin extends com.greensock.plugins.TweenPlugin
    {
        var propName, overwriteProps, _color, _tweens, __get__changeFactor;
        function TintPlugin () {
            super();
            propName = "tint";
            overwriteProps = ["tint"];
        }
        function onInitTween(target, value, tween) {
            if ((typeof(target) != "movieclip") && (!(target instanceof TextField))) {
                return(false);
            }
            var _local_2 = ((tween.vars._alpha != undefined) ? (tween.vars._alpha) : (((tween.vars.autoAlpha != undefined) ? (tween.vars.autoAlpha) : (target._alpha))));
            var _local_4 = Number(value);
            var _local_6 = (((value == null) || (tween.vars.removeTint == true)) ? ({rb:0, gb:0, bb:0, ab:0, ra:_local_2, ga:_local_2, ba:_local_2, aa:_local_2}) : ({rb:_local_4 >> 16, gb:(_local_4 >> 8) & 255, bb:_local_4 & 255, ra:0, ga:0, ba:0, aa:_local_2}));
            init(target, _local_6);
            return(true);
        }
        function init(target, end) {
            _color = new Color(target);
            var _local_3 = _color.getTransform();
            var _local_6;
            var _local_2;
            for (_local_2 in end) {
                if (_local_3[_local_2] != end[_local_2]) {
                    _tweens[_tweens.length] = new com.greensock.core.PropTween(_local_3, _local_2, _local_3[_local_2], end[_local_2] - _local_3[_local_2], "tint", false);
                }
            }
        }
        function set changeFactor(n) {
            var _local_4 = _color.getTransform();
            var _local_3 = _tweens.length;
            var _local_2;
            while (_local_3--) {
                _local_2 = _tweens[_local_3];
                _local_4[_local_2.property] = _local_2.start + (_local_2.change * n);
            }
            _color.setTransform(_local_4);
            //return(__get__changeFactor());
        }
        static var API = 1;
    }
