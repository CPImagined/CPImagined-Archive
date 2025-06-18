//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.plugins.ShortRotationPlugin extends com.greensock.plugins.TweenPlugin
    {
        var propName, overwriteProps, addTween;
        function ShortRotationPlugin () {
            super();
            propName = "shortRotation";
            overwriteProps = [];
        }
        function onInitTween(target, value, tween) {
            if (typeof(value) == "number") {
                return(false);
            }
            var useRadians = Boolean(value.useRadians == true);
            for (var p in value) {
                if (p != "useRadians") {
                    initRotation(target, p, target[p], ((typeof(value[p]) == "number") ? (Number(value[p])) : (target[p] + Number(value[p]))), useRadians);
                }
            }
            return(true);
        }
        function initRotation(target, propName, start, end, useRadians) {
            var cap = (useRadians ? (Math.PI*2) : 360);
            var dif = ((end - start) % cap);
            if (dif != (dif % (cap / 2))) {
                dif = ((dif < 0) ? (dif + cap) : (dif - cap));
            }
            addTween(target, propName, start, start + dif, propName);
            overwriteProps[overwriteProps.length] = propName;
        }
        static var API = 1;
    }
