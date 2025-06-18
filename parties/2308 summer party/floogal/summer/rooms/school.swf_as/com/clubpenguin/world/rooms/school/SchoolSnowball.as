dynamic class com.clubpenguin.world.rooms.school.SchoolSnowball extends MovieClip
{
    static var CLASS_NAME: String = "SchoolSnowball";
    static var ROOM_MIDPOINT: Number = 400;
    var _paper: Boolean = false;
    var _pizza: Boolean = false;
    var _x;
    var _y;

    function SchoolSnowball()
    {
        super();
        this.init();
    }

    function init()
    {
        if (this._y <= 320) 
        {
            if (this._x < com.clubpenguin.world.rooms.school.SchoolSnowball.ROOM_MIDPOINT) 
            {
                this._paper = true;
                this._pizza = false;
                return undefined;
            }
            this._paper = false;
            this._pizza = true;
        }
    }

}
