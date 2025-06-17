class com.clubpenguin.world.rooms.common.triggers.GridTile extends flash.geom.Rectangle
{
    var _triggers, top, left, right, bottom, x, y, width, height;
    function GridTile(x, y, w, h)
    {
        super(x, y, w, h);
        _triggers = [];
    } // End of the function
    function addTrigger(triggerToAdd)
    {
        _triggers.push(triggerToAdd);
    } // End of the function
    function hitTest(object, mc)
    {
        for (var _loc2 = _triggers.length - 1; _loc2 >= 0; --_loc2)
        {
            _triggers[_loc2].hitTest(object, mc);
        } // end of for
    } // End of the function
    function reset()
    {
        _triggers = [];
    } // End of the function
    function isEmpty()
    {
        return (_triggers.length <= 0);
    } // End of the function
    function drawRed(mc)
    {
        mc.lineStyle(1, 0, 10);
        mc.beginFill(16711680, 20);
        mc.moveTo(left, top);
        mc.lineTo(right, top);
        mc.lineTo(right, bottom);
        mc.lineTo(left, bottom);
        mc.lineTo(left, top);
        mc.endFill();
    } // End of the function
    function draw(mc)
    {
        trace ("GridTile.draw");
        mc.lineStyle(1, 0, 10);
        mc.beginFill(65280, 20);
        mc.moveTo(left, top);
        mc.lineTo(right, top);
        mc.lineTo(right, bottom);
        mc.lineTo(left, bottom);
        mc.lineTo(left, top);
        mc.endFill();
    } // End of the function
    function toString()
    {
        return (x + ":" + y + ":" + width + ":" + height);
    } // End of the function
} // End of Class
