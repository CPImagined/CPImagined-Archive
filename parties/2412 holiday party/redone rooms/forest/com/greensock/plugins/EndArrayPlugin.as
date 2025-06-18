//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.plugins.EndArrayPlugin extends com.greensock.plugins.TweenPlugin
    {
        var propName, overwriteProps, _info, _a, round, __get__changeFactor;
        function EndArrayPlugin () {
            super();
            propName = "endArray";
            overwriteProps = ["endArray"];
            _info = [];
        }
        function onInitTween(target, value, tween) {
            if ((!(target instanceof Array)) || (!(value instanceof Array))) {
                return(false);
            }
            init([target][0], [value][0]);
            return(true);
        }
        function init(start, end) {
            _a = start;
            var i = end.length;
            while (i--) {
                if ((start[i] != end[i]) && (start[i] != undefined)) {
                    _info[_info.length] = new com.greensock.plugins.helpers.ArrayTweenInfo(i, _a[i], end[i] - _a[i]);
                }
            }
        }
        function set changeFactor(n) {
            var i = _info.length;
            var ti;
            if (round) {
                while (i--) {
                    ti = _info[i];
                    _a[ti.index] = Math.round(ti.start + (ti.change * n));
                }
            } else {
                while (i--) {
                    ti = _info[i];
                    _a[ti.index] = ti.start + (ti.change * n);
                }
            }
            //return(__get__changeFactor());
        }
        static var API = 1;
    }
