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
            var _local_2 = end.length;
            while (_local_2--) {
                if ((start[_local_2] != end[_local_2]) && (start[_local_2] != undefined)) {
                    _info[_info.length] = new com.greensock.plugins.helpers.ArrayTweenInfo(_local_2, _a[_local_2], end[_local_2] - _a[_local_2]);
                }
            }
        }
        function set changeFactor(n) {
            var _local_3 = _info.length;
            var _local_2;
            if (round) {
                while (_local_3--) {
                    _local_2 = _info[_local_3];
                    _a[_local_2.index] = Math.round(_local_2.start + (_local_2.change * n));
                }
            } else {
                while (_local_3--) {
                    _local_2 = _info[_local_3];
                    _a[_local_2.index] = _local_2.start + (_local_2.change * n);
                }
            }
            //return(__get__changeFactor());
        }
        static var API = 1;
    }
