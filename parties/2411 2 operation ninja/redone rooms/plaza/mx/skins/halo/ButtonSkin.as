    class mx.skins.halo.ButtonSkin extends mx.skins.RectBorder
    {
        var __get__width, __get__height, getStyle, _parent, clear, drawRoundRect, __get__x, __get__y;
        function ButtonSkin () {
            super();
        }
        function init() {
            super.init();
        }
        function size() {
            drawHaloRect(__get__width(), __get__height());
        }
        function drawHaloRect(w, h) {
            var _local_6 = getStyle("borderStyle");
            var _local_4 = getStyle("themeColor");
            var _local_5 = _parent.emphasized;
            this.clear();
            switch (_local_6) {
                case "falseup" : 
                    if (_local_5) {
                        drawRoundRect(__get__x(), __get__y(), w, h, 5, 9542041, 100);
                        drawRoundRect(__get__x(), __get__y(), w, h, 5, _local_4, 75);
                        drawRoundRect(__get__x() + 1, __get__y() + 1, w - 2, h - 2, 4, [3355443, 16777215], 85, 0, "radial");
                        drawRoundRect(__get__x() + 2, __get__y() + 2, w - 4, h - 4, 3, [0, 14342874], 100, 0, "radial");
                        drawRoundRect(__get__x() + 2, __get__y() + 2, w - 4, h - 4, 3, _local_4, 75);
                        drawRoundRect(__get__x() + 3, __get__y() + 3, w - 6, h - 6, 2, 16777215, 100);
                        drawRoundRect(__get__x() + 3, __get__y() + 4, w - 6, h - 7, 2, 16316664, 100);
                    } else {
                        drawRoundRect(0, 0, w, h, 5, 9542041, 100);
                        drawRoundRect(1, 1, w - 2, h - 2, 4, [13291985, 16250871], 100, 0, "radial");
                        drawRoundRect(2, 2, w - 4, h - 4, 3, [9542041, 13818586], 100, 0, "radial");
                        drawRoundRect(3, 3, w - 6, h - 6, 2, 16777215, 100);
                        drawRoundRect(3, 4, w - 6, h - 7, 2, 16316664, 100);
                    }
                    break;
                case "falsedown" : 
                    drawRoundRect(__get__x(), __get__y(), w, h, 5, 9542041, 100);
                    drawRoundRect(__get__x() + 1, __get__y() + 1, w - 2, h - 2, 4, [3355443, 16579836], 100, 0, "radial");
                    drawRoundRect(__get__x() + 1, __get__y() + 1, w - 2, h - 2, 4, _local_4, 50);
                    drawRoundRect(__get__x() + 2, __get__y() + 2, w - 4, h - 4, 3, [0, 14342874], 100, 0, "radial");
                    drawRoundRect(__get__x(), __get__y(), w, h, 5, _local_4, 40);
                    drawRoundRect(__get__x() + 3, __get__y() + 3, w - 6, h - 6, 2, 16777215, 100);
                    drawRoundRect(__get__x() + 3, __get__y() + 4, w - 6, h - 7, 2, _local_4, 20);
                    break;
                case "falserollover" : 
                    drawRoundRect(__get__x(), __get__y(), w, h, 5, 9542041, 100);
                    drawRoundRect(__get__x(), __get__y(), w, h, 5, _local_4, 50);
                    drawRoundRect(__get__x() + 1, __get__y() + 1, w - 2, h - 2, 4, [3355443, 16777215], 100, 0, "radial");
                    drawRoundRect(__get__x() + 2, __get__y() + 2, w - 4, h - 4, 3, [0, 14342874], 100, 0, "radial");
                    drawRoundRect(__get__x() + 2, __get__y() + 2, w - 4, h - 4, 3, _local_4, 50);
                    drawRoundRect(__get__x() + 3, __get__y() + 3, w - 6, h - 6, 2, 16777215, 100);
                    drawRoundRect(__get__x() + 3, __get__y() + 4, w - 6, h - 7, 2, 16316664, 100);
                    break;
                case "falsedisabled" : 
                    drawRoundRect(0, 0, w, h, 5, 13159628, 100);
                    drawRoundRect(1, 1, w - 2, h - 2, 4, 15921906, 100);
                    drawRoundRect(2, 2, w - 4, h - 4, 3, 13949401, 100);
                    drawRoundRect(3, 3, w - 6, h - 6, 2, 15921906, 100);
                    break;
                case "trueup" : 
                    drawRoundRect(__get__x(), __get__y(), w, h, 5, 10066329, 100);
                    drawRoundRect(__get__x() + 1, __get__y() + 1, w - 2, h - 2, 4, [3355443, 16579836], 100, 0, "radial");
                    drawRoundRect(__get__x() + 1, __get__y() + 1, w - 2, h - 2, 4, _local_4, 50);
                    drawRoundRect(__get__x() + 2, __get__y() + 2, w - 4, h - 4, 3, [0, 14342874], 100, 0, "radial");
                    drawRoundRect(__get__x(), __get__y(), w, h, 5, _local_4, 40);
                    drawRoundRect(__get__x() + 3, __get__y() + 3, w - 6, h - 6, 2, 16777215, 100);
                    drawRoundRect(__get__x() + 3, __get__y() + 4, w - 6, h - 7, 2, 16250871, 100);
                    break;
                case "truedown" : 
                    drawRoundRect(__get__x(), __get__y(), w, h, 5, 10066329, 100);
                    drawRoundRect(__get__x() + 1, __get__y() + 1, w - 2, h - 2, 4, [3355443, 16579836], 100, 0, "radial");
                    drawRoundRect(__get__x() + 1, __get__y() + 1, w - 2, h - 2, 4, _local_4, 50);
                    drawRoundRect(__get__x() + 2, __get__y() + 2, w - 4, h - 4, 3, [0, 14342874], 100, 0, "radial");
                    drawRoundRect(__get__x(), __get__y(), w, h, 5, _local_4, 40);
                    drawRoundRect(__get__x() + 3, __get__y() + 3, w - 6, h - 6, 2, 16777215, 100);
                    drawRoundRect(__get__x() + 3, __get__y() + 4, w - 6, h - 7, 2, _local_4, 20);
                    break;
                case "truerollover" : 
                    drawRoundRect(__get__x(), __get__y(), w, h, 5, 9542041, 100);
                    drawRoundRect(__get__x(), __get__y(), w, h, 5, _local_4, 50);
                    drawRoundRect(__get__x() + 1, __get__y() + 1, w - 2, h - 2, 4, [3355443, 16777215], 100, 0, "radial");
                    drawRoundRect(__get__x() + 1, __get__y() + 1, w - 2, h - 2, 4, _local_4, 40);
                    drawRoundRect(__get__x() + 2, __get__y() + 2, w - 4, h - 4, 3, [0, 14342874], 100, 0, "radial");
                    drawRoundRect(__get__x() + 2, __get__y() + 2, w - 4, h - 4, 3, _local_4, 40);
                    drawRoundRect(__get__x() + 3, __get__y() + 3, w - 6, h - 6, 2, 16777215, 100);
                    drawRoundRect(__get__x() + 3, __get__y() + 4, w - 6, h - 7, 2, 16316664, 100);
                    break;
                case "truedisabled" : 
                    drawRoundRect(0, 0, w, h, 5, 13159628, 100);
                    drawRoundRect(1, 1, w - 2, h - 2, 4, 15921906, 100);
                    drawRoundRect(2, 2, w - 4, h - 4, 3, 13949401, 100);
                    drawRoundRect(3, 3, w - 6, h - 6, 2, 15921906, 100);
            }
        }
        static function classConstruct() {
            mx.core.ext.UIObjectExtensions.Extensions();
            _global.skinRegistry.ButtonSkin = true;
            return(true);
        }
        static var symbolName = "ButtonSkin";
        static var symbolOwner = mx.skins.halo.ButtonSkin;
        var className = "ButtonSkin";
        var backgroundColorName = "buttonColor";
        static var classConstructed = classConstruct();
        static var UIObjectExtensionsDependency = mx.core.ext.UIObjectExtensions;
    }
