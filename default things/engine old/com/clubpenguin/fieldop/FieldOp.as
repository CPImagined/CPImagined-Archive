class com.clubpenguin.fieldop.FieldOp
{
    function FieldOp()
    {
    } // End of the function
    static function getFieldOpFromObject(rawFieldOp)
    {
        var _loc1 = new com.clubpenguin.fieldop.FieldOp();
        _loc1.roomID = parseInt(rawFieldOp.room_id);
        _loc1.x = parseInt(rawFieldOp.x_pos);
        _loc1.y = parseInt(rawFieldOp.y_pos);
        _loc1.gameName = rawFieldOp.game_id;
        _loc1.description = rawFieldOp.description;
        _loc1.task = rawFieldOp.task;
        _loc1.victoryMascotID = rawFieldOp.mascot_id;
        _loc1.victoryMessage = rawFieldOp.end_message;
        _loc1.hit = new flash.geom.Rectangle(_loc1.x - com.clubpenguin.fieldop.FieldOp.WIDTH / 2, _loc1.y - com.clubpenguin.fieldop.FieldOp.HEIGHT / 2, com.clubpenguin.fieldop.FieldOp.WIDTH, com.clubpenguin.fieldop.FieldOp.HEIGHT);
        return (_loc1);
    } // End of the function
    static var WIDTH = 70;
    static var HEIGHT = 70;
} // End of Class
