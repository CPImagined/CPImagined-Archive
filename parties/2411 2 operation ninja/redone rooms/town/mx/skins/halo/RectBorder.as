    class mx.skins.halo.RectBorder extends mx.skins.RectBorder
    {
        var offset, getStyle, borderStyleName, __borderMetrics, className, borderColorName, backgroundColorName, shadowColorName, highlightColorName, buttonColorName, __get__width, __get__height, clear, _color, drawRoundRect, beginFill, drawRect, endFill;
        function RectBorder () {
            super();
        }
        function init(Void) {
            borderWidths["default"] = 3;
            super.init();
        }
        function getBorderMetrics(Void) {
            if (offset == undefined) {
                var _local_3 = getStyle(borderStyleName);
                offset = borderWidths[_local_3];
            }
            if ((getStyle(borderStyleName) == "default") || (getStyle(borderStyleName) == "alert")) {
                __borderMetrics = {left:3, top:1, right:3, bottom:3};
                return(__borderMetrics);
            }
            return(super.getBorderMetrics());
        }
        function drawBorder(Void) {
            var _local_6 = _global.styles[className];
            if (_local_6 == undefined) {
                _local_6 = _global.styles.RectBorder;
            }
            var _local_5 = getStyle(borderStyleName);
            var _local_7 = getStyle(borderColorName);
            if (_local_7 == undefined) {
                _local_7 = _local_6[borderColorName];
            }
            var _local_8 = getStyle(backgroundColorName);
            if (_local_8 == undefined) {
                _local_8 = _local_6[backgroundColorName];
            }
            var _local_16 = getStyle("backgroundImage");
            if (_local_5 != "none") {
                var _local_14 = getStyle(shadowColorName);
                if (_local_14 == undefined) {
                    _local_14 = _local_6[shadowColorName];
                }
                var _local_13 = getStyle(highlightColorName);
                if (_local_13 == undefined) {
                    _local_13 = _local_6[highlightColorName];
                }
                var _local_12 = getStyle(buttonColorName);
                if (_local_12 == undefined) {
                    _local_12 = _local_6[buttonColorName];
                }
                var _local_11 = getStyle(borderCapColorName);
                if (_local_11 == undefined) {
                    _local_11 = _local_6[borderCapColorName];
                }
                var _local_10 = getStyle(shadowCapColorName);
                if (_local_10 == undefined) {
                    _local_10 = _local_6[shadowCapColorName];
                }
            }
            offset = borderWidths[_local_5];
            var _local_9 = offset;
            var _local_3 = __get__width();
            var _local_4 = __get__height();
            this.clear();
            _color = undefined;
            if (_local_5 == "none") {
            } else if (_local_5 == "inset") {
                _color = colorList;
                draw3dBorder(_local_11, _local_12, _local_7, _local_13, _local_14, _local_10);
            } else if (_local_5 == "outset") {
                _color = colorList;
                draw3dBorder(_local_11, _local_7, _local_12, _local_14, _local_13, _local_10);
            } else if (_local_5 == "alert") {
                var _local_15 = getStyle("themeColor");
                drawRoundRect(0, 5, _local_3, _local_4 - 5, 5, 6184542, 10);
                drawRoundRect(1, 4, _local_3 - 2, _local_4 - 5, 4, [6184542, 6184542], 10, 0, "radial");
                drawRoundRect(2, 0, _local_3 - 4, _local_4 - 2, 3, [0, 14342874], 100, 0, "radial");
                drawRoundRect(2, 0, _local_3 - 4, _local_4 - 2, 3, _local_15, 50);
                drawRoundRect(3, 1, _local_3 - 6, _local_4 - 4, 2, 16777215, 100);
            } else if (_local_5 == "default") {
                drawRoundRect(0, 5, _local_3, _local_4 - 5, {tl:5, tr:5, br:0, bl:0}, 6184542, 10);
                drawRoundRect(1, 4, _local_3 - 2, _local_4 - 5, {tl:4, tr:4, br:0, bl:0}, [6184542, 6184542], 10, 0, "radial");
                drawRoundRect(2, 0, _local_3 - 4, _local_4 - 2, {tl:3, tr:3, br:0, bl:0}, [12897484, 11844796], 100, 0, "radial");
                drawRoundRect(3, 1, _local_3 - 6, _local_4 - 4, {tl:2, tr:2, br:0, bl:0}, 16777215, 100);
            } else if (_local_5 == "dropDown") {
                drawRoundRect(0, 0, _local_3 + 1, _local_4, {tl:4, tr:0, br:0, bl:4}, [13290186, 7895160], 100, -10, "linear");
                drawRoundRect(1, 1, _local_3 - 1, _local_4 - 2, {tl:3, tr:0, br:0, bl:3}, 16777215, 100);
            } else if (_local_5 == "menuBorder") {
                var _local_15 = getStyle("themeColor");
                drawRoundRect(4, 4, _local_3 - 2, _local_4 - 3, 0, [6184542, 6184542], 10, 0, "radial");
                drawRoundRect(4, 4, _local_3 - 1, _local_4 - 2, 0, 6184542, 10);
                drawRoundRect(0, 0, _local_3 + 1, _local_4, 0, [0, 14342874], 100, 250, "linear");
                drawRoundRect(0, 0, _local_3 + 1, _local_4, 0, _local_15, 50);
                drawRoundRect(2, 2, _local_3 - 3, _local_4 - 4, 0, 16777215, 100);
            } else if (_local_5 == "comboNonEdit") {
            } else {
                this.beginFill(_local_7);
                drawRect(0, 0, _local_3, _local_4);
                drawRect(1, 1, _local_3 - 1, _local_4 - 1);
                this.endFill();
                _color = borderColorName;
            }
            if (_local_8 != undefined) {
                this.beginFill(_local_8);
                drawRect(_local_9, _local_9, __get__width() - _local_9, __get__height() - _local_9);
                this.endFill();
            }
        }
        function draw3dBorder(c1, c2, c3, c4, c5, c6) {
            var _local_3 = __get__width();
            var _local_2 = __get__height();
            this.beginFill(c1);
            drawRect(0, 0, _local_3, _local_2);
            drawRect(1, 0, _local_3 - 1, _local_2);
            this.endFill();
            this.beginFill(c2);
            drawRect(1, 0, _local_3 - 1, 1);
            this.endFill();
            this.beginFill(c3);
            drawRect(1, _local_2 - 1, _local_3 - 1, _local_2);
            this.endFill();
            this.beginFill(c4);
            drawRect(1, 1, _local_3 - 1, 2);
            this.endFill();
            this.beginFill(c5);
            drawRect(1, _local_2 - 2, _local_3 - 1, _local_2 - 1);
            this.endFill();
            this.beginFill(c6);
            drawRect(1, 2, _local_3 - 1, _local_2 - 2);
            drawRect(2, 2, _local_3 - 2, _local_2 - 2);
            this.endFill();
        }
        static function classConstruct() {
            mx.core.ext.UIObjectExtensions.Extensions();
            _global.styles.rectBorderClass = mx.skins.halo.RectBorder;
            _global.skinRegistry.RectBorder = true;
            return(true);
        }
        static var symbolName = "RectBorder";
        static var symbolOwner = mx.skins.halo.RectBorder;
        static var version = "2.0.2.127";
        var borderCapColorName = "borderCapColor";
        var shadowCapColorName = "shadowCapColor";
        var colorList = {highlightColor:0, borderColor:0, buttonColor:0, shadowColor:0, borderCapColor:0, shadowCapColor:0};
        var borderWidths = {none:0, solid:1, inset:2, outset:2, alert:3, dropDown:2, menuBorder:2, comboNonEdit:2};
        static var classConstructed = classConstruct();
        static var UIObjectExtensionsDependency = mx.core.ext.UIObjectExtensions;
    }
