class com.clubpenguin.world.rooms2014.school.snowballs.Party2Snowball extends MovieClip
{
    var _x;
    function Party2Snowball()
    {
        super();
        trace (com.clubpenguin.world.rooms2014.school.snowballs.Party2Snowball.CLASS_NAME + "()");
        this.init();
    } // End of the function
    function init()
    {
        trace (com.clubpenguin.world.rooms2014.school.snowballs.Party2Snowball.CLASS_NAME + ": init()");
        if (_x < com.clubpenguin.world.rooms2014.school.snowballs.Party2Snowball.ROOM_MIDPOINT)
        {
            _paper1 = false;
            _paint_lime = false;
            _paint_aqua = false;
            _paint_pink = false;
            _paint_blue = false;
            this.showRandomPaint();
        }
        else
        {
            _paper1 = true;
            _paint_lime = false;
            _paint_aqua = false;
            _paint_pink = false;
            _paint_blue = false;
        } // end else if
    } // End of the function
    function showRandomPaint()
    {
        var _loc2 = this.getRandom(1, 3);
        switch (_loc2)
        {
            case 1:
            {
                _paint_lime = true;
                break;
            } 
            case 2:
            {
                _paint_aqua = true;
                break;
            } 
            case 3:
            {
                _paint_pink = true;
                break;
            } 
        } // End of switch
    } // End of the function
    function getRandom(min, max)
    {
        return (Math.floor(Math.random() * (max - min + 1)) + min);
    } // End of the function
    static var CLASS_NAME = "SchoolSnowball";
    static var ROOM_MIDPOINT = 400;
    var _paper1 = false;
    var _paint_blue = false;
    var _paint_pink = false;
    var _paint_aqua = false;
    var _paint_lime = false;
} // End of Class
