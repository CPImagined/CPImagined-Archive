//Created by Action Script Viewer - https://www.buraks.com/asv
    class mx.skins.RectBorder extends mx.skins.Border
    {
        var __width, __height, offset, __borderMetrics;
        function RectBorder () {
            super();
        }
        function get width() {
            return(__width);
        }
        function get height() {
            return(__height);
        }
        function init(Void) {
            super.init();
        }
        function draw(Void) {
            this.size();
        }
        function getBorderMetrics(Void) {
            var _local_2 = offset;
            if (__borderMetrics == undefined) {
                __borderMetrics = {left:_local_2, top:_local_2, right:_local_2, bottom:_local_2};
            } else {
                __borderMetrics.left = _local_2;
                __borderMetrics.top = _local_2;
                __borderMetrics.right = _local_2;
                __borderMetrics.bottom = _local_2;
            }
            return(__borderMetrics);
        }
        function get borderMetrics() {
            return(getBorderMetrics());
        }
        function drawBorder(Void) {
        }
        function size(Void) {
            drawBorder();
        }
        function setColor(Void) {
            drawBorder();
        }
        static var symbolName = "RectBorder";
        static var symbolOwner = mx.skins.RectBorder;
        static var version = "2.0.2.127";
        var className = "RectBorder";
        var borderStyleName = "borderStyle";
        var borderColorName = "borderColor";
        var shadowColorName = "shadowColor";
        var highlightColorName = "highlightColor";
        var buttonColorName = "buttonColor";
        var backgroundColorName = "backgroundColor";
    }
