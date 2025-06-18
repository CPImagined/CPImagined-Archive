//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.fieldop.FieldOp
    {
        function FieldOp () {
        }
        static function getFieldOpFromObject(rawFieldOp) {
            var _local_1 = new com.clubpenguin.fieldop.FieldOp();
            _local_1.roomID = parseInt(rawFieldOp.room_id);
            _local_1.x = parseInt(rawFieldOp.x_pos);
            _local_1.y = parseInt(rawFieldOp.y_pos);
            _local_1.gameName = rawFieldOp.game_id;
            _local_1.description = rawFieldOp.description;
            _local_1.task = rawFieldOp.task;
            _local_1.victoryMascotID = rawFieldOp.mascot_id;
            _local_1.victoryMessage = rawFieldOp.end_message;
            _local_1.hit = new flash.geom.Rectangle(_local_1.x - (WIDTH / 2), _local_1.y - (HEIGHT / 2), WIDTH, HEIGHT);
            return(_local_1);
        }
        static var WIDTH = 70;
        static var HEIGHT = 70;
    }
