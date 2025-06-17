//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.math.AaronsPhysics
    {
        function AaronsPhysics () {
        }
        static function findAngle(_arg_7, _arg_6, _arg_5, _arg_8) {
            var _local_1;
            var _local_4 = _arg_5 - _arg_7;
            var _local_2 = _arg_8 - _arg_6;
            var _local_3 = Math.atan2(_local_2, _local_4);
            _local_1 = Math.round((_local_3 / Math.PI) * 180);
            return(_local_1);
        }
        static function findAngleBetweenPoints(_arg_5, _arg_4) {
            var _local_2;
            var _local_1;
            var _local_3;
            _local_1 = _arg_4.subtract(_arg_5);
            _local_3 = Math.atan2(_local_1.y, _local_1.x);
            _local_2 = Math.round((_local_3 / Math.PI) * 180);
            return(_local_2);
        }
        static function findDistance(_arg_5, _arg_4, _arg_3, _arg_6) {
            var _local_2 = Math.round(_arg_3 - _arg_5);
            var _local_1 = Math.round(_arg_6 - _arg_4);
            return(Math.round(Math.sqrt((_local_2 * _local_2) + (_local_1 * _local_1))));
        }
        static function findMotionXFromAngle(_arg_1, _arg_2) {
            return(Math.cos(_arg_1 * (Math.PI/180)) * _arg_2);
        }
        static function findMotionYFromAngle(_arg_1, _arg_2) {
            return(Math.sin(_arg_1 * (Math.PI/180)) * _arg_2);
        }
        static function findAngleFromMotion(_arg_3, _arg_2) {
            var _local_1 = Math.atan2(_arg_2, _arg_3);
            return(Math.round((_local_1 / Math.PI) * 180));
        }
        static function findPositionXAfterParentRotation(_arg_5, _arg_4, _arg_6, $parentY, _arg_7) {
            var _local_1 = findAngle(0, 0, _arg_5, _arg_4);
            var _local_3 = findDistance(0, 0, _arg_5, _arg_4);
            _local_1 = _local_1 + _arg_7;
            var _local_2 = findMotionXFromAngle(_local_1, _local_3);
            return(_arg_6 + _local_2);
        }
        static function findPositionYAfterParentRotation(_arg_5, _arg_4, $parentX, _arg_7, _arg_6) {
            var _local_1 = findAngle(0, 0, _arg_5, _arg_4);
            var _local_3 = findDistance(0, 0, _arg_5, _arg_4);
            _local_1 = _local_1 + _arg_6;
            var _local_2 = findMotionYFromAngle(_local_1, _local_3);
            return(_arg_7 + _local_2);
        }
    }
