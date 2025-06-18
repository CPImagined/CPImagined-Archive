//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.triggers.GridTile extends flash.geom.Rectangle
    {
        var _triggers, left, top, right, bottom, height, width, y, x;
        function GridTile (x, y, w, h) {
            super(x, y, w, h);
            _triggers = [];
        }
        function addTrigger(triggerToAdd) {
            _triggers.push(triggerToAdd);
        }
        function hitTest(object, mc) {
            var _local_2 = _triggers.length - 1;
            while (_local_2 >= 0) {
                _triggers[_local_2].hitTest(object, mc);
                _local_2--;
            }
        }
        function reset() {
            _triggers = [];
        }
        function isEmpty() {
            return(_triggers.length <= 0);
        }
        function drawRed(mc) {
            mc.lineStyle(1, 0, 10);
            mc.beginFill(16711680, 20);
            mc.moveTo(left, top);
            mc.lineTo(right, top);
            mc.lineTo(right, bottom);
            mc.lineTo(left, bottom);
            mc.lineTo(left, top);
            mc.endFill();
        }
        function draw(mc) {
            mc.lineStyle(1, 0, 10);
            mc.beginFill(65280, 20);
            mc.moveTo(left, top);
            mc.lineTo(right, top);
            mc.lineTo(right, bottom);
            mc.lineTo(left, bottom);
            mc.lineTo(left, top);
            mc.endFill();
        }
        function toString() {
            return((((((x + ":") + y) + ":") + width) + ":") + height);
        }
    }
