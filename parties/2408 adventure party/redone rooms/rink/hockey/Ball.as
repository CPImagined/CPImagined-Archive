//Created by Action Script Viewer - https://www.buraks.com/asv
    class hockey.Ball
    {
        var pos, vel, sprite;
        function Ball (x_p, y_p, r_p) {
            pos = new com.robertpenner.Vector(x_p, y_p);
            if (r_p) {
                r = r_p;
            }
            vel = new com.robertpenner.Vector(0, 0);
        }
        function draw() {
            if (!sprite) {
            }
            sprite._x = pos.x;
            sprite._y = pos.y;
        }
        function erase() {
            sprite.removeMovieClip();
            sprite = null;
        }
        static function drawOval(mc, x, y, rx, ry) {
            mc.moveTo(x + rx, y);
            mc.curveTo(rx + x, (0.4142 * ry) + y, (0.7071 * rx) + x, (0.7071 * ry) + y);
            mc.curveTo((0.4142 * rx) + x, ry + y, x, ry + y);
            mc.curveTo((-0.4142 * rx) + x, ry + y, (-0.7071 * rx) + x, (0.7071 * ry) + y);
            mc.curveTo((-rx) + x, (0.4142 * ry) + y, (-rx) + x, y);
            mc.curveTo((-rx) + x, (-0.4142 * ry) + y, (-0.7071 * rx) + x, (-0.7071 * ry) + y);
            mc.curveTo((-0.4142 * rx) + x, (-ry) + y, x, (-ry) + y);
            mc.curveTo((0.4142 * rx) + x, (-ry) + y, (0.7071 * rx) + x, (-0.7071 * ry) + y);
            mc.curveTo(rx + x, (-0.4142 * ry) + y, rx + x, y);
        }
        static function drawCircle(mc, x, y, r) {
            drawOval(mc, x, y, r, r);
        }
        static function drawCircleFilled(mc, x, y, r, color, alpha) {
            if (color == undefined) {
                color = 0;
            }
            if (alpha == undefined) {
                alpha = 100;
            }
            mc.beginFill(color, alpha);
            drawCircle(mc, x, y, r);
            mc.endFill();
        }
        function toString() {
            return((((((("[Ball (" + pos.x) + ", ") + pos.y) + ")") + " r:") + r) + "]");
        }
        static var PUCK_RADIUS = 8;
        var r = PUCK_RADIUS;
    }
