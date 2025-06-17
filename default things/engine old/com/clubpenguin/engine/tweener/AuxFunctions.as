
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.engine.tweener.AuxFunctions
    {
        function AuxFunctions () {
        }
        static function numberToR(p_num) {
            return((p_num & 16711680) >> 16);
        }
        static function numberToG(p_num) {
            return((p_num & 65280) >> 8);
        }
        static function numberToB(p_num) {
            return(p_num & 255);
        }
        static function isInArray(p_string, p_array) {
            var _local2 = p_array.length;
            var _local1 = 0;
            while (_local1 < _local2) {
                if (p_array[_local1] == p_string) {
                    return(true);
                }
                _local1++;
            }
            return(false);
        }
        static function getObjectLength(p_object) {
            var _local1 = 0;
            for (var _local2 in p_object) {
                _local1++;
            }
            return(_local1);
        }
        static function concatObjects() {
            var _local4 = {};
            var _local2;
            var _local3 = 0;
            while (_local3 < arguments.length) {
                _local2 = arguments[_local3];
                for (var _local5 in _local2) {
                    if (_local2[_local5] == null) {
                        delete _local4[_local5];
                    } else {
                        _local4[_local5] = _local2[_local5];
                    }
                }
                _local3++;
            }
            return(_local4);
        }
    }
