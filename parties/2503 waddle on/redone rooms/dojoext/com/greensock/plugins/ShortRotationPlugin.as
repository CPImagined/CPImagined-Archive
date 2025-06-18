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
            var _local_4 = Boolean(value.useRadians == true);
            for (var _local_5 in value) {
                if (_local_5 != "useRadians") {
                    initRotation(target, _local_5, target[_local_5], ((typeof(value[_local_5]) == "number") ? (Number(value[_local_5])) : (target[_local_5] + Number(value[_local_5]))), _local_4);
                }
            }
            return(true);
        }
        function initRotation(target, propName, start, end, useRadians) {
            var _local_3 = (useRadians ? (Math.PI*2) : 360);
            var _local_2 = (end - start) % _local_3;
            if (_local_2 != (_local_2 % (_local_3 / 2))) {
                _local_2 = ((_local_2 < 0) ? (_local_2 + _local_3) : (_local_2 - _local_3));
            }
            addTween(target, propName, start, start + _local_2, propName);
            overwriteProps[overwriteProps.length] = propName;
        }
        static var API = 1;
    }
