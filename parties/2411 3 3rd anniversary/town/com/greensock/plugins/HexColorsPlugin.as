    class com.greensock.plugins.HexColorsPlugin extends com.greensock.plugins.TweenPlugin
    {
        var propName, overwriteProps, _colors, __get__changeFactor;
        function HexColorsPlugin () {
            super();
            propName = "hexColors";
            overwriteProps = [];
            _colors = [];
        }
        function onInitTween(target, value, tween) {
            for (var _local_4 in value) {
                initColor(target, _local_4, Number(target[_local_4]), Number(value[_local_4]));
            }
            return(true);
        }
        function initColor(target, propName, start, end) {
            if (start != end) {
                var _local_3 = start >> 16;
                var _local_5 = (start >> 8) & 255;
                var _local_2 = start & 255;
                _colors[_colors.length] = [target, propName, _local_3, (end >> 16) - _local_3, _local_5, ((end >> 8) & 255) - _local_5, _local_2, (end & 255) - _local_2];
                overwriteProps[overwriteProps.length] = propName;
            }
        }
        function killProps(lookup) {
            var _local_3 = _colors.length;
            while (_local_3--) {
                if (lookup[_colors[_local_3][1]] != undefined) {
                    _colors.splice(_local_3, 1);
                }
            }
            super.killProps(lookup);
        }
        function set changeFactor(n) {
            var _local_4 = _colors.length;
            var _local_2;
            while (_local_4--) {
                _local_2 = _colors[_local_4];
                _local_2[0][_local_2[1]] = (((_local_2[2] + (n * _local_2[3])) << 16) | ((_local_2[4] + (n * _local_2[5])) << 8)) | (_local_2[6] + (n * _local_2[7]));
            }
            //return(__get__changeFactor());
        }
        static var API = 1;
    }
