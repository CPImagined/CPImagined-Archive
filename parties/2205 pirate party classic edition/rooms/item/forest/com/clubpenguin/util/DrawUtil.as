//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.DrawUtil
    {
        function DrawUtil () {
        }
        static function fillRect(clip, rect, color, alpha) {
            drawRect(clip, rect, color, alpha);
        }
        static function drawRect(clip, rect, fillColor, fillAlpha, thickness, strokeColor, strokeAlpha) {
            clip.clear();
            if (((thickness != null) && (strokeColor != null)) && (strokeAlpha != null)) {
                clip.lineStyle(thickness, strokeColor, strokeAlpha);
            }
            if ((fillColor != null) && (fillAlpha != null)) {
                clip.beginFill(fillColor, fillAlpha);
            }
            clip.moveTo(rect.left, rect.top);
            clip.lineTo(rect.right, rect.top);
            clip.lineTo(rect.right, rect.bottom);
            clip.lineTo(rect.left, rect.bottom);
            clip.lineTo(rect.left, rect.top);
            clip.endFill();
        }
        static function setStyle(canvas, fillColor, lineColor, lineThickness, fillAlpha, scaleMode) {
            if (lineColor) {
                lineThickness = lineThickness || 0;
                scaleMode = ((scaleMode == undefined) ? "none" : (scaleMode));
                canvas.lineStyle(lineThickness, lineColor, 100, true, scaleMode, "round", "miter", 1);
            }
            if (fillColor) {
                fillAlpha = ((fillAlpha == undefined) ? 100 : (fillAlpha));
                canvas.beginFill(fillColor, fillAlpha);
            }
        }
        static function drawRoundedRectangle(canvas, rect, r, fillColor, lineColor, lineThickness) {
            setStyle(canvas, fillColor, lineColor, lineThickness);
            var _local_2 = rect.x;
            var _local_1 = rect.y;
            var _local_6 = rect.width;
            var _local_5 = rect.height;
            canvas.moveTo(_local_2, _local_1 + r);
            canvas.curveTo(_local_2, _local_1, _local_2 + r, _local_1);
            canvas.lineTo((_local_2 + _local_6) - r, _local_1);
            canvas.curveTo(_local_2 + _local_6, _local_1, _local_2 + _local_6, _local_1 + r);
            canvas.lineTo(_local_2 + _local_6, (_local_1 + _local_5) - r);
            canvas.curveTo(_local_2 + _local_6, _local_1 + _local_5, (_local_2 + _local_6) - r, _local_1 + _local_5);
            canvas.lineTo(_local_2 + r, _local_1 + _local_5);
            canvas.curveTo(_local_2, _local_1 + _local_5, _local_2, (_local_1 + _local_5) - r);
            canvas.lineTo(_local_2, _local_1 + r);
            canvas.endFill();
        }
        static function drawCircle(canvas, origin, radius, fillColor, lineColor, lineThickness) {
            drawEllipse(canvas, new flash.geom.Rectangle(origin.x, origin.y, radius * 2, radius * 2), fillColor, lineColor, lineThickness, 100, "none");
        }
        static function drawRing(canvas, rect, fillColor, lineColor, lineThickness) {
            drawEllipse(canvas, rect, fillColor, lineColor, lineThickness, 0, "normal");
        }
        static function drawEllipse(canvas, rect, fillColor, lineColor, lineThickness, fillAlpha, scaleMode) {
            var _local_2 = rect.x;
            var _local_1 = rect.y;
            var _local_8 = rect.width;
            var _local_3 = _local_8 / 2;
            var _local_7 = rect.height;
            var _local_4 = _local_7 / 2;
            setStyle(canvas, fillColor, lineColor, lineThickness, fillAlpha, scaleMode);
            canvas.moveTo(_local_2 + _local_3, _local_1);
            canvas.curveTo(_local_3 + _local_2, (TAN_PI_8 * _local_4) + _local_1, (SIN_PI_4 * _local_3) + _local_2, (SIN_PI_4 * _local_4) + _local_1);
            canvas.curveTo((TAN_PI_8 * _local_3) + _local_2, _local_4 + _local_1, _local_2, _local_4 + _local_1);
            canvas.curveTo(((-TAN_PI_8) * _local_3) + _local_2, _local_4 + _local_1, ((-SIN_PI_4) * _local_3) + _local_2, (SIN_PI_4 * _local_4) + _local_1);
            canvas.curveTo((-_local_3) + _local_2, (TAN_PI_8 * _local_4) + _local_1, (-_local_3) + _local_2, _local_1);
            canvas.curveTo((-_local_3) + _local_2, ((-TAN_PI_8) * _local_4) + _local_1, ((-SIN_PI_4) * _local_3) + _local_2, ((-SIN_PI_4) * _local_4) + _local_1);
            canvas.curveTo(((-TAN_PI_8) * _local_3) + _local_2, (-_local_4) + _local_1, _local_2, (-_local_4) + _local_1);
            canvas.curveTo((TAN_PI_8 * _local_3) + _local_2, (-_local_4) + _local_1, (SIN_PI_4 * _local_3) + _local_2, ((-SIN_PI_4) * _local_4) + _local_1);
            canvas.curveTo(_local_3 + _local_2, ((-TAN_PI_8) * _local_4) + _local_1, _local_3 + _local_2, _local_1);
            canvas.endFill();
        }
        static function drawDonut(canvas, x1, x2, y1, y2, w1, w2, h1, h2, r1, r2, fillColor, lineColor, lineThickness) {
            setStyle(canvas, fillColor, lineColor, lineThickness);
            canvas.moveTo(x1, y1 + r1);
            canvas.curveTo(x1, y1, x1 + r1, y1);
            canvas.lineTo((x1 + w1) - r1, y1);
            canvas.curveTo(x1 + w1, y1, x1 + w1, y1 + r1);
            canvas.lineTo(x1 + w1, (y1 + h1) - r1);
            canvas.curveTo(x1 + w1, y1 + h1, (x1 + w1) - r1, y1 + h1);
            canvas.lineTo(x1 + r1, y1 + h1);
            canvas.curveTo(x1, y1 + h1, x1, (y1 + h1) - r1);
            canvas.lineTo(x1, y1 + r1);
            canvas.moveTo(x2, y2 + r2);
            canvas.curveTo(x2, y2, x2 + r2, y2);
            canvas.lineTo((x2 + w2) - r2, y2);
            canvas.curveTo(x2 + w2, y2, x2 + w2, y2 + r2);
            canvas.lineTo(x2 + w2, (y2 + h2) - r2);
            canvas.curveTo(x2 + w2, y2 + h2, (x2 + w2) - r2, y2 + h2);
            canvas.lineTo(x2 + r2, y2 + h2);
            canvas.curveTo(x2, y2 + h2, x2, (y2 + h2) - r2);
            canvas.lineTo(x2, y2 + r2);
            canvas.endFill();
        }
        static function drawPolygon(canvas, points, fillColor, lineColor, lineThickness) {
            if (points.length <= 2) {
                return(undefined);
            }
            setStyle(canvas, fillColor, lineColor, lineThickness);
            canvas.moveTo(points[0].x, points[0].y);
            var _local_1 = 1;
            while (_local_1 < points.length) {
                canvas.lineTo(points[_local_1].x, points[_local_1].y);
                _local_1++;
            }
            canvas.lineTo(points[0].x, points[0].y);
            canvas.endFill();
        }
        static var RED = 16711680;
        static var ORANGE = 16753920;
        static var YELLOW = 16776960;
        static var GREEN = 65280;
        static var BLUE = 255;
        static var PURPLE = 16711935;
        static var TAN_PI_8 = 0.414213562373095;
        static var SIN_PI_4 = 0.707106781186547;
    }
