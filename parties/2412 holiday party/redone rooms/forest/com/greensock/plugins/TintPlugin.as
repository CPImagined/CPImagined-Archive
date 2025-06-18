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
            var alpha = ((tween.vars._alpha != undefined) ? (tween.vars._alpha) : (((tween.vars.autoAlpha != undefined) ? (tween.vars.autoAlpha) : (target._alpha))));
            var n = Number(value);
            var end = (((value == null) || (tween.vars.removeTint == true)) ? ({rb:0, gb:0, bb:0, ab:0, ra:alpha, ga:alpha, ba:alpha, aa:alpha}) : ({rb:n >> 16, gb:(n >> 8) & 255, bb:n & 255, ra:0, ga:0, ba:0, aa:alpha}));
            init(target, end);
            return(true);
        }
        function init(target, end) {
            _color = new Color(target);
            var ct = _color.getTransform();
            var i;
            var p;
            for (p in end) {
                if (ct[p] != end[p]) {
                    _tweens[_tweens.length] = new com.greensock.core.PropTween(ct, p, ct[p], end[p] - ct[p], "tint", false);
                }
            }
        }
        function set changeFactor(n) {
            var ct = _color.getTransform();
            var i = _tweens.length;
            var pt;
            while (i--) {
                pt = _tweens[i];
                ct[pt.property] = pt.start + (pt.change * n);
            }
            _color.setTransform(ct);
            //return(__get__changeFactor());
        }
        static var API = 1;
    }
