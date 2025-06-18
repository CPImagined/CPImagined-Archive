//Created by Action Script Viewer - https://www.buraks.com/asv
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
            for (var p in value) {
                initColor(target, p, Number(target[p]), Number(value[p]));
            }
            return(true);
        }
        function initColor(target, propName, start, end) {
            if (start != end) {
                var r = (start >> 16);
                var g = ((start >> 8) & 255);
                var b = (start & 255);
                _colors[_colors.length] = [target, propName, r, (end >> 16) - r, g, ((end >> 8) & 255) - g, b, (end & 255) - b];
                overwriteProps[overwriteProps.length] = propName;
            }
        }
        function killProps(lookup) {
            var i = _colors.length;
            while (i--) {
                if (lookup[_colors[i][1]] != undefined) {
                    _colors.splice(i, 1);
                }
            }
            super.killProps(lookup);
        }
        function set changeFactor(n) {
            var i = _colors.length;
            var a;
            while (i--) {
                a = _colors[i];
                a[0][a[1]] = (((a[2] + (n * a[3])) << 16) | ((a[4] + (n * a[5])) << 8)) | (a[6] + (n * a[7]));
            }
            //return(__get__changeFactor());
        }
        static var API = 1;
    }
