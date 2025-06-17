//Created by Action Script Viewer - https://www.buraks.com/asv
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
            var _local_2 = p_array.length;
            var _local_1 = 0;
            while (_local_1 < _local_2) {
                if (p_array[_local_1] == p_string) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        static function getObjectLength(p_object) {
            var _local_1 = 0;
            for (var _local_2 in p_object) {
                _local_1++;
            }
            return(_local_1);
        }
        static function concatObjects() {
            var _local_4 = {};
            var _local_2;
            var _local_3 = 0;
            while (_local_3 < arguments.length) {
                _local_2 = arguments[_local_3];
                for (var _local_5 in _local_2) {
                    if (_local_2[_local_5] == null) {
                        delete _local_4[_local_5];
                    } else {
                        _local_4[_local_5] = _local_2[_local_5];
                    }
                }
                _local_3++;
            }
            return(_local_4);
        }
    }
