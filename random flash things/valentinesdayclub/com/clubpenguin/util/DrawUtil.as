class com.clubpenguin.util.DrawUtil
{
    function DrawUtil()
    {
    } // End of the function
    static function fillRect(clip, rect, color, alpha)
    {
        com.clubpenguin.util.DrawUtil.drawRect(clip, rect, color, alpha);
    } // End of the function
    static function drawRect(clip, rect, fillColor, fillAlpha, thickness, strokeColor, strokeAlpha)
    {
        clip.clear();
        if (thickness != null && strokeColor != null && strokeAlpha != null)
        {
            trace ("drawing the stroke");
            clip.lineStyle(thickness, strokeColor, strokeAlpha);
        } // end if
        if (fillColor != null && fillAlpha != null)
        {
            clip.beginFill(fillColor, fillAlpha);
        } // end if
        clip.moveTo(rect.left, rect.top);
        clip.lineTo(rect.right, rect.top);
        clip.lineTo(rect.right, rect.bottom);
        clip.lineTo(rect.left, rect.bottom);
        clip.lineTo(rect.left, rect.top);
        clip.endFill();
    } // End of the function
    static function setStyle(canvas, fillColor, lineColor, lineThickness, fillAlpha, scaleMode)
    {
        if (lineColor)
        {
            lineThickness = lineThickness || 0;
            scaleMode = scaleMode == undefined ? ("none") : (scaleMode);
            canvas.lineStyle(lineThickness, lineColor, 100, true, scaleMode, "round", "miter", 1);
        } // end if
        if (fillColor)
        {
            fillAlpha = fillAlpha == undefined ? (100) : (fillAlpha);
            canvas.beginFill(fillColor, fillAlpha);
        } // end if
    } // End of the function
    static function drawRoundedRectangle(canvas, rect, r, fillColor, lineColor, lineThickness)
    {
        com.clubpenguin.util.DrawUtil.setStyle(canvas, fillColor, lineColor, lineThickness);
        var _loc2 = rect.x;
        var _loc1 = rect.y;
        var _loc6 = rect.width;
        var _loc5 = rect.height;
        canvas.moveTo(_loc2, _loc1 + r);
        canvas.curveTo(_loc2, _loc1, _loc2 + r, _loc1);
        canvas.lineTo(_loc2 + _loc6 - r, _loc1);
        canvas.curveTo(_loc2 + _loc6, _loc1, _loc2 + _loc6, _loc1 + r);
        canvas.lineTo(_loc2 + _loc6, _loc1 + _loc5 - r);
        canvas.curveTo(_loc2 + _loc6, _loc1 + _loc5, _loc2 + _loc6 - r, _loc1 + _loc5);
        canvas.lineTo(_loc2 + r, _loc1 + _loc5);
        canvas.curveTo(_loc2, _loc1 + _loc5, _loc2, _loc1 + _loc5 - r);
        canvas.lineTo(_loc2, _loc1 + r);
        canvas.endFill();
    } // End of the function
    static function drawCircle(canvas, origin, radius, fillColor, lineColor, lineThickness)
    {
        com.clubpenguin.util.DrawUtil.drawEllipse(canvas, new flash.geom.Rectangle(origin.x, origin.y, radius * 2, radius * 2), fillColor, lineColor, lineThickness, 100, "none");
    } // End of the function
    static function drawRing(canvas, rect, fillColor, lineColor, lineThickness)
    {
        com.clubpenguin.util.DrawUtil.drawEllipse(canvas, rect, fillColor, lineColor, lineThickness, 0, "normal");
    } // End of the function
    static function drawEllipse(canvas, rect, fillColor, lineColor, lineThickness, fillAlpha, scaleMode)
    {
        var _loc2 = rect.x;
        var _loc1 = rect.y;
        var _loc8 = rect.width;
        var _loc3 = _loc8 / 2;
        var _loc7 = rect.height;
        var _loc4 = _loc7 / 2;
        com.clubpenguin.util.DrawUtil.setStyle(canvas, fillColor, lineColor, lineThickness, fillAlpha, scaleMode);
        canvas.moveTo(_loc2 + _loc3, _loc1);
        canvas.curveTo(_loc3 + _loc2, com.clubpenguin.util.DrawUtil.TAN_PI_8 * _loc4 + _loc1, com.clubpenguin.util.DrawUtil.SIN_PI_4 * _loc3 + _loc2, com.clubpenguin.util.DrawUtil.SIN_PI_4 * _loc4 + _loc1);
        canvas.curveTo(com.clubpenguin.util.DrawUtil.TAN_PI_8 * _loc3 + _loc2, _loc4 + _loc1, _loc2, _loc4 + _loc1);
        canvas.curveTo(-com.clubpenguin.util.DrawUtil.TAN_PI_8 * _loc3 + _loc2, _loc4 + _loc1, -com.clubpenguin.util.DrawUtil.SIN_PI_4 * _loc3 + _loc2, com.clubpenguin.util.DrawUtil.SIN_PI_4 * _loc4 + _loc1);
        canvas.curveTo(-_loc3 + _loc2, com.clubpenguin.util.DrawUtil.TAN_PI_8 * _loc4 + _loc1, -_loc3 + _loc2, _loc1);
        canvas.curveTo(-_loc3 + _loc2, -com.clubpenguin.util.DrawUtil.TAN_PI_8 * _loc4 + _loc1, -com.clubpenguin.util.DrawUtil.SIN_PI_4 * _loc3 + _loc2, -com.clubpenguin.util.DrawUtil.SIN_PI_4 * _loc4 + _loc1);
        canvas.curveTo(-com.clubpenguin.util.DrawUtil.TAN_PI_8 * _loc3 + _loc2, -_loc4 + _loc1, _loc2, -_loc4 + _loc1);
        canvas.curveTo(com.clubpenguin.util.DrawUtil.TAN_PI_8 * _loc3 + _loc2, -_loc4 + _loc1, com.clubpenguin.util.DrawUtil.SIN_PI_4 * _loc3 + _loc2, -com.clubpenguin.util.DrawUtil.SIN_PI_4 * _loc4 + _loc1);
        canvas.curveTo(_loc3 + _loc2, -com.clubpenguin.util.DrawUtil.TAN_PI_8 * _loc4 + _loc1, _loc3 + _loc2, _loc1);
        canvas.endFill();
    } // End of the function
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
    } // End of the function
    static function drawPolygon(canvas, points, fillColor, lineColor, lineThickness)
    {
        if (points.length <= 2)
        {
            return;
        } // end if
        com.clubpenguin.util.DrawUtil.setStyle(canvas, fillColor, lineColor, lineThickness);
        canvas.moveTo(points[0].x, points[0].y);
        for (var _loc1 = 1; _loc1 < points.length; ++_loc1)
        {
            canvas.lineTo(points[_loc1].x, points[_loc1].y);
        } // end of for
        canvas.lineTo(points[0].x, points[0].y);
        canvas.endFill();
    } // End of the function
    static var RED = 16711680;
    static var ORANGE = 16753920;
    static var YELLOW = 16776960;
    static var GREEN = 65280;
    static var BLUE = 255;
    static var PURPLE = 16711935;
    static var TAN_PI_8 = 0.414214;
    static var SIN_PI_4 = 0.707107;
} // End of Class
