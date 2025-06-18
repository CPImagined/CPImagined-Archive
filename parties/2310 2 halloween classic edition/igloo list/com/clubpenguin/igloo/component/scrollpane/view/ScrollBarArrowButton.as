//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.igloo.component.scrollpane.view.ScrollBarArrowButton
    {
        var canvasMC, _style;
        function ScrollBarArrowButton (mc, isFlipped, style) {
            canvasMC = mc;
            this.isFlipped = isFlipped;
            _style = style;
            canvasMC.onRollOver = com.clubpenguin.util.Delegate.create(this, onRollover);
            canvasMC.onRollOut = com.clubpenguin.util.Delegate.create(this, onRollout);
            canvasMC.onPress = com.clubpenguin.util.Delegate.create(this, onButtonPress);
            canvasMC.onRelease = com.clubpenguin.util.Delegate.create(this, onButtonRelease);
            canvasMC.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, onButtonRelease);
            draw(_style.buttonLineColorDefault, _style.buttonFillColorDefault);
        }
        function onRollout() {
            draw(_style.buttonLineColorDefault, _style.buttonFillColorDefault);
        }
        function onRollover() {
            draw(_style.buttonLineColorOver, _style.buttonFillColorOver);
        }
        function onButtonPress() {
            draw(_style.buttonLineColorDown, _style.buttonFillColorDown);
        }
        function onButtonRelease() {
            draw(_style.buttonLineColorDefault, _style.buttonFillColorDefault);
        }
        function getWidth() {
            return(_style.scrollBarSize);
        }
        function getHeight() {
            return(_style.scrollBarSize);
        }
        function draw(lineColor, fillColor) {
            canvasMC.clear();
            drawButtonBG(lineColor, fillColor);
            if (isFlipped) {
                drawRightArrow(lineColor, lineColor);
            } else {
                drawLeftArrow(lineColor, lineColor);
            }
        }
        function drawRightArrow(lineColor, fillColor) {
            var _local_4 = (getWidth() - arrowWidth) / 2;
            var _local_5 = (getHeight() - arrowHeight) / 2;
            var _local_3 = new flash.geom.Point(1, 0);
            var _local_2 = {x:(_local_4 + _local_3.x) + xOffset, y:(_local_5 + _local_3.y) + yOffset};
            var _local_6 = [_local_2, {x:_local_2.x, y:_local_2.y + arrowHeight}, {x:_local_2.x + arrowWidth, y:_local_2.y + (arrowHeight / 2)}];
            com.clubpenguin.util.DrawUtil.drawPolygon(canvasMC, _local_6, lineColor, fillColor);
        }
        function drawLeftArrow(lineColor, fillColor) {
            var _local_4 = (getWidth() - arrowWidth) / 2;
            var _local_5 = (getHeight() - arrowHeight) / 2;
            var _local_3 = new flash.geom.Point(-1, 0);
            var _local_2 = {x:((_local_4 + _local_3.x) + xOffset) + arrowWidth, y:(_local_5 + _local_3.y) + yOffset};
            var _local_6 = [_local_2, {x:_local_2.x, y:_local_2.y + arrowHeight}, {x:_local_2.x - arrowWidth, y:_local_2.y + (arrowHeight / 2)}];
            com.clubpenguin.util.DrawUtil.drawPolygon(canvasMC, _local_6, lineColor, fillColor);
        }
        function drawButtonBG(lineColor, fillColor) {
            var _local_3 = _style.buttonLineThickness;
            var _local_2 = new flash.geom.Point(xOffset + (getWidth() / 2), xOffset + (getWidth() / 2));
            com.clubpenguin.util.DrawUtil.drawCircle(canvasMC, _local_2, getWidth() / 2, lineColor);
            com.clubpenguin.util.DrawUtil.drawCircle(canvasMC, _local_2, (getWidth() - (_local_3 * 2)) / 2, fillColor);
        }
        static var LEFT_ARROW = true;
        static var RIGHT_ARROW = false;
        var arrowWidth = 6;
        var arrowHeight = 7;
        var xOffset = 0;
        var yOffset = 0;
        var isFlipped = RIGHT_ARROW;
    }
