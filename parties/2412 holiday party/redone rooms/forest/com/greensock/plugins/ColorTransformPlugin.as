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
            var color = new Color(target);
            var end = color.getTransform();
            if (value.redMultiplier != undefined) {
                end.ra = value.redMultiplier * 100;
            }
            if (value.greenMultiplier != undefined) {
                end.ga = value.greenMultiplier * 100;
            }
            if (value.blueMultiplier != undefined) {
                end.ba = value.blueMultiplier * 100;
            }
            if (value.alphaMultiplier != undefined) {
                end.aa = value.alphaMultiplier * 100;
            }
            if (value.redOffset != undefined) {
                end.rb = value.redOffset;
            }
            if (value.greenOffset != undefined) {
                end.gb = value.greenOffset;
            }
            if (value.blueOffset != undefined) {
                end.bb = value.blueOffset;
            }
            if (value.alphaOffset != undefined) {
                end.ab = value.alphaOffset;
            }
            if ((!isNaN(value.tint)) || (!isNaN(value["color"]))) {
                var tint = ((!isNaN(value.tint)) ? (value.tint) : (value["color"]));
                if (tint != null) {
                    end.rb = Number(tint) >> 16;
                    end.gb = (Number(tint) >> 8) & 255;
                    end.bb = Number(tint) & 255;
                    end.ra = 0;
                    end.ga = 0;
                    end.ba = 0;
                }
            }
            if (!isNaN(value.tintAmount)) {
                var ratio = (value.tintAmount / (1 - (((end.ra + end.ga) + end.ba) / 300)));
                end.rb = end.rb * ratio;
                end.gb = end.gb * ratio;
                end.bb = end.bb * ratio;
                end.ra = (end.ga = (end.ba = (1 - value.tintAmount) * 100));
            } else if (!isNaN(value.exposure)) {
                end.rb = (end.gb = (end.bb = 255 * (value.exposure - 1)));
                end.ra = (end.ga = (end.ba = 100));
            } else if (!isNaN(value.brightness)) {
                end.rb = (end.gb = (end.bb = Math.max(0, (value.brightness - 1) * 255)));
                end.ra = (end.ga = (end.ba = (1 - Math.abs(value.brightness - 1)) * 100));
            }
            if ((tween.vars._alpha != undefined) && (value.alphaMultiplier == undefined)) {
                end.aa = tween.vars._alpha;
                tween.killVars({_alpha:1});
            }
            init(target, end);
            return(true);
        }
        static var API = 1;
    }
