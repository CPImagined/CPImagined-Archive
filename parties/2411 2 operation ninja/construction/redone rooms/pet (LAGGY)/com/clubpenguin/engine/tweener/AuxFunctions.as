//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.tweener.AuxFunctions
    {
        function AuxFunctions () {
        }
        static function numberToR(_arg_1) {
            return((_arg_1 & 16711680) >> 16);
        }
        static function numberToG(_arg_1) {
            return((_arg_1 & 65280) >> 8);
        }
        static function numberToB(_arg_1) {
            return(_arg_1 & 255);
        }
        static function isInArray(_arg_4, _arg_3) {
            var _local_2 = _arg_3.length;
            var _local_1 = 0;
            while (_local_1 < _local_2) {
                if (_arg_3[_local_1] == _arg_4) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        static function getObjectLength(_arg_3) {
            var _local_1 = 0;
            for (var _local_2 in _arg_3) {
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
