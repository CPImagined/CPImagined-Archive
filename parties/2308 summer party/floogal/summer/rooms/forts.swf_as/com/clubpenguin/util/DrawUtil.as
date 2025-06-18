dynamic class com.clubpenguin.util.DrawUtil
{
    static var RED: Number = 16711680;
    static var ORANGE: Number = 16753920;
    static var YELLOW: Number = 16776960;
    static var GREEN: Number = 65280;
    static var BLUE: Number = 255;
    static var PURPLE: Number = 16711935;
    static var TAN_PI_8: Number = 0.414213562373;
    static var SIN_PI_4: Number = 0.707106781187;

    function DrawUtil()
    {
    }

    static function fillRect(clip, rect, color, alpha)
    {
        com.clubpenguin.util.DrawUtil.drawRect(clip, rect, color, alpha);
    }

    static function drawRect(clip, rect, fillColor, fillAlpha, thickness, strokeColor, strokeAlpha)
    {
        clip.clear();
        if (thickness != null && strokeColor != null && strokeAlpha != null) 
        {
            trace("drawing the stroke");
            clip.lineStyle(thickness, strokeColor, strokeAlpha);
        }
        if (fillColor != null && fillAlpha != null) 
        {
            clip.beginFill(fillColor, fillAlpha);
        }
        clip.moveTo(rect.left, rect.top);
        clip.lineTo(rect.right, rect.top);
        clip.lineTo(rect.right, rect.bottom);
        clip.lineTo(rect.left, rect.bottom);
        clip.lineTo(rect.left, rect.top);
        clip.endFill();
    }

    static function setStyle(canvas, fillColor, lineColor, lineThickness, fillAlpha, scaleMode)
    {
        if (lineColor) 
        {
            lineThickness = lineThickness || 0;
            scaleMode = scaleMode == undefined ? "none" : scaleMode;
            canvas.lineStyle(lineThickness, lineColor, 100, true, scaleMode, "round", "miter", 1);
        }
        if (fillColor) 
        {
            fillAlpha = fillAlpha == undefined ? 100 : fillAlpha;
            canvas.beginFill(fillColor, fillAlpha);
        }
    }

    static function drawRoundedRectangle(canvas, rect, r, fillColor, lineColor, lineThickness)
    {
        com.clubpenguin.util.DrawUtil.setStyle(canvas, fillColor, lineColor, lineThickness);
        var __reg2 = rect.x;
        var __reg1 = rect.y;
        var __reg6 = rect.width;
        var __reg5 = rect.height;
        canvas.moveTo(__reg2, __reg1 + r);
        canvas.curveTo(__reg2, __reg1, __reg2 + r, __reg1);
        canvas.lineTo(__reg2 + __reg6 - r, __reg1);
        canvas.curveTo(__reg2 + __reg6, __reg1, __reg2 + __reg6, __reg1 + r);
        canvas.lineTo(__reg2 + __reg6, __reg1 + __reg5 - r);
        canvas.curveTo(__reg2 + __reg6, __reg1 + __reg5, __reg2 + __reg6 - r, __reg1 + __reg5);
        canvas.lineTo(__reg2 + r, __reg1 + __reg5);
        canvas.curveTo(__reg2, __reg1 + __reg5, __reg2, __reg1 + __reg5 - r);
        canvas.lineTo(__reg2, __reg1 + r);
        canvas.endFill();
    }

    static function drawCircle(canvas, origin, radius, fillColor, lineColor, lineThickness)
    {
        com.clubpenguin.util.DrawUtil.drawEllipse(canvas, new flash.geom.Rectangle(origin.x, origin.y, radius * 2, radius * 2), fillColor, lineColor, lineThickness, 100, "none");
    }

    static function drawRing(canvas, rect, fillColor, lineColor, lineThickness)
    {
        com.clubpenguin.util.DrawUtil.drawEllipse(canvas, rect, fillColor, lineColor, lineThickness, 0, "normal");
    }

    static function drawEllipse(canvas, rect, fillColor, lineColor, lineThickness, fillAlpha, scaleMode)
    {
        var __reg2 = rect.x;
        var __reg1 = rect.y;
        var __reg8 = rect.width;
        var __reg3 = __reg8 / 2;
        var __reg7 = rect.height;
        var __reg4 = __reg7 / 2;
        com.clubpenguin.util.DrawUtil.setStyle(canvas, fillColor, lineColor, lineThickness, fillAlpha, scaleMode);
        canvas.moveTo(__reg2 + __reg3, __reg1);
        canvas.curveTo(__reg3 + __reg2, com.clubpenguin.util.DrawUtil.TAN_PI_8 * __reg4 + __reg1, com.clubpenguin.util.DrawUtil.SIN_PI_4 * __reg3 + __reg2, com.clubpenguin.util.DrawUtil.SIN_PI_4 * __reg4 + __reg1);
        canvas.curveTo(com.clubpenguin.util.DrawUtil.TAN_PI_8 * __reg3 + __reg2, __reg4 + __reg1, __reg2, __reg4 + __reg1);
        canvas.curveTo((0 - com.clubpenguin.util.DrawUtil.TAN_PI_8) * __reg3 + __reg2, __reg4 + __reg1, (0 - com.clubpenguin.util.DrawUtil.SIN_PI_4) * __reg3 + __reg2, com.clubpenguin.util.DrawUtil.SIN_PI_4 * __reg4 + __reg1);
        canvas.curveTo(0 - __reg3 + __reg2, com.clubpenguin.util.DrawUtil.TAN_PI_8 * __reg4 + __reg1, 0 - __reg3 + __reg2, __reg1);
        canvas.curveTo(0 - __reg3 + __reg2, (0 - com.clubpenguin.util.DrawUtil.TAN_PI_8) * __reg4 + __reg1, (0 - com.clubpenguin.util.DrawUtil.SIN_PI_4) * __reg3 + __reg2, (0 - com.clubpenguin.util.DrawUtil.SIN_PI_4) * __reg4 + __reg1);
        canvas.curveTo((0 - com.clubpenguin.util.DrawUtil.TAN_PI_8) * __reg3 + __reg2, 0 - __reg4 + __reg1, __reg2, 0 - __reg4 + __reg1);
        canvas.curveTo(com.clubpenguin.util.DrawUtil.TAN_PI_8 * __reg3 + __reg2, 0 - __reg4 + __reg1, com.clubpenguin.util.DrawUtil.SIN_PI_4 * __reg3 + __reg2, (0 - com.clubpenguin.util.DrawUtil.SIN_PI_4) * __reg4 + __reg1);
        canvas.curveTo(__reg3 + __reg2, (0 - com.clubpenguin.util.DrawUtil.TAN_PI_8) * __reg4 + __reg1, __reg3 + __reg2, __reg1);
        canvas.endFill();
    }

    static function drawDonut(canvas, x1, x2, y1, y2, w1, w2, h1, h2, r1, r2, fillColor, lineColor, lineThickness)
    {
        com.clubpenguin.util.DrawUtil.setStyle(canvas, fillColor, lineColor, lineThickness);
        canvas.moveTo(x1, y1 + r1);
        canvas.curveTo(x1, y1, x1 + r1, y1);
        canvas.lineTo(x1 + w1 - r1, y1);
        canvas.curveTo(x1 + w1, y1, x1 + w1, y1 + r1);
        canvas.lineTo(x1 + w1, y1 + h1 - r1);
        canvas.curveTo(x1 + w1, y1 + h1, x1 + w1 - r1, y1 + h1);
        canvas.lineTo(x1 + r1, y1 + h1);
        canvas.curveTo(x1, y1 + h1, x1, y1 + h1 - r1);
        canvas.lineTo(x1, y1 + r1);
        canvas.moveTo(x2, y2 + r2);
        canvas.curveTo(x2, y2, x2 + r2, y2);
        canvas.lineTo(x2 + w2 - r2, y2);
        canvas.curveTo(x2 + w2, y2, x2 + w2, y2 + r2);
        canvas.lineTo(x2 + w2, y2 + h2 - r2);
        canvas.curveTo(x2 + w2, y2 + h2, x2 + w2 - r2, y2 + h2);
        canvas.lineTo(x2 + r2, y2 + h2);
        canvas.curveTo(x2, y2 + h2, x2, y2 + h2 - r2);
        canvas.lineTo(x2, y2 + r2);
        canvas.endFill();
    }

    static function drawPolygon(canvas, points, fillColor, lineColor, lineThickness)
    {
        if (points.length > 2) 
        {
            com.clubpenguin.util.DrawUtil.setStyle(canvas, fillColor, lineColor, lineThickness);
            canvas.moveTo(points[0].x, points[0].y);
            var __reg1 = 1;
            while (__reg1 < points.length) 
            {
                canvas.lineTo(points[__reg1].x, points[__reg1].y);
                ++__reg1;
            }
            canvas.lineTo(points[0].x, points[0].y);
            canvas.endFill();
        }
    }

}
