class com.clubpenguin.engine.pathfinding.Waypoint extends flash.geom.Point
{
    var _mc, x, y, __get__used, __get__active, __set__active, __set__used;
    function Waypoint(mc)
    {
        super();
        if (mc == undefined)
        {
            return;
        } // end if
        _mc = mc;
        x = Math.round(_mc._x);
        y = Math.round(_mc._y);
        _mc.gotoAndStop(com.clubpenguin.engine.pathfinding.Waypoint.PARK_LABEL);
    } // End of the function
    function set used(value)
    {
        _used = value;
        //return (this.used());
        null;
    } // End of the function
    function get used()
    {
        return (_used);
    } // End of the function
    function set active(value)
    {
        _active = value;
        //return (this.active());
        null;
    } // End of the function
    function get active()
    {
        return (_active);
    } // End of the function
    static var PARK_LABEL = "park";
    var _active = true;
    var _used = false;
} // End of Class
