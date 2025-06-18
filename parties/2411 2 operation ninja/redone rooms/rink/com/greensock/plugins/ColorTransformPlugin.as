//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.plugins.ColorTransformPlugin extends com.greensock.plugins.TintPlugin
    {
        var propName, init;
        function ColorTransformPlugin () {
            super();
            propName = "colorTransform";
        }
        function onInitTween(target, value, tween) {
            if ((typeof(target) != "movieclip") && (!(target instanceof TextField))) {
                return(false);
            }
            var _local_7 = new Color(target);
            var _local_2 = _local_7.getTransform();
            if (value.redMultiplier != undefined) {
                _local_2.ra = value.redMultiplier * 100;
            }
            if (value.greenMultiplier != undefined) {
                _local_2.ga = value.greenMultiplier * 100;
            }
            if (value.blueMultiplier != undefined) {
                _local_2.ba = value.blueMultiplier * 100;
            }
            if (value.alphaMultiplier != undefined) {
                _local_2.aa = value.alphaMultiplier * 100;
            }
            if (value.redOffset != undefined) {
                _local_2.rb = value.redOffset;
            }
            if (value.greenOffset != undefined) {
                _local_2.gb = value.greenOffset;
            }
            if (value.blueOffset != undefined) {
                _local_2.bb = value.blueOffset;
            }
            if (value.alphaOffset != undefined) {
                _local_2.ab = value.alphaOffset;
            }
            if ((!isNaN(value.tint)) || (!isNaN(value["color"]))) {
                var _local_4 = ((!isNaN(value.tint)) ? (value.tint) : (value["color"]));
                if (_local_4 != null) {
                    _local_2.rb = Number(_local_4) >> 16;
                    _local_2.gb = (Number(_local_4) >> 8) & 255;
                    _local_2.bb = Number(_local_4) & 255;
                    _local_2.ra = 0;
                    _local_2.ga = 0;
                    _local_2.ba = 0;
                }
            }
            if (!isNaN(value.tintAmount)) {
                var _local_5 = value.tintAmount / (1 - (((_local_2.ra + _local_2.ga) + _local_2.ba) / 300));
                _local_2.rb = _local_2.rb * _local_5;
                _local_2.gb = _local_2.gb * _local_5;
                _local_2.bb = _local_2.bb * _local_5;
                _local_2.ra = (_local_2.ga = (_local_2.ba = (1 - value.tintAmount) * 100));
            } else if (!isNaN(value.exposure)) {
                _local_2.rb = (_local_2.gb = (_local_2.bb = 255 * (value.exposure - 1)));
                _local_2.ra = (_local_2.ga = (_local_2.ba = 100));
            } else if (!isNaN(value.brightness)) {
                _local_2.rb = (_local_2.gb = (_local_2.bb = Math.max(0, (value.brightness - 1) * 255)));
                _local_2.ra = (_local_2.ga = (_local_2.ba = (1 - Math.abs(value.brightness - 1)) * 100));
            }
            if ((tween.vars._alpha != undefined) && (value.alphaMultiplier == undefined)) {
                _local_2.aa = tween.vars._alpha;
                tween.killVars({_alpha:1});
            }
            init(target, _local_2);
            return(true);
        }
        static var API = 1;
    }
