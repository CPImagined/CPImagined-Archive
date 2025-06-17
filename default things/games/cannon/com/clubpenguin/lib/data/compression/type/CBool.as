//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.lib.data.compression.type.CBool extends com.clubpenguin.lib.data.compression.type.CInt16
    {
        var _manifest, _value;
        function CBool (_arg_3, _arg_4) {
            super(_arg_3, _arg_4);
            _manifest.type = TYPE_ID;
        }
        function decompress(_arg_3) {
            if (_manifest.size == 3) {
                var _local_2 = String(com.clubpenguin.lib.data.compression.type.SpecialTypes.specialTypes[_arg_3.charCodeAt(0) - 1]);
                _arg_3 = _local_2;
            }
            if (_manifest.isNull(0)) {
                _value = 0;
            } else {
                _value = _arg_3.charCodeAt(0);
            }
        }
        function getBoolAt(_arg_2) {
            return((((_value >>> _arg_2) & true) ? true : false));
        }
        function setBoolAt(_arg_2, _arg_3) {
            if (_arg_3) {
                _value = _value | (1 << _arg_2);
            } else {
                _value = _value & (com.clubpenguin.lib.data.compression.type.TypeMasks.INT_16 ^ (1 << _arg_2));
            }
        }
        static var TYPE_ID = 2;
    }
