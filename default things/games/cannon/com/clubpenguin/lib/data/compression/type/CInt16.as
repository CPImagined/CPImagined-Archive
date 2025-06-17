//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.lib.data.compression.type.CInt16 implements com.clubpenguin.lib.data.compression.type.DataType
    {
        var _manifest, _value;
        function CInt16 (_arg_2, _arg_3) {
            _manifest = _arg_3;
            if (_manifest == undefined) {
                _manifest = new com.clubpenguin.lib.data.compression.manifest.ManifestEntry();
                _manifest.setNull(1, false);
                _manifest.setNull(2, false);
                _manifest.setNull(3, false);
            }
            _value = _arg_2;
            if (_value == undefined) {
                _value = 0;
            }
        }
        function compress() {
            var _local_3;
            if (_value == 0) {
                _manifest.setNull(0, true);
                _local_3 = String.fromCharCode(1);
            } else {
                _manifest.setNull(0, false);
                _local_3 = String.fromCharCode(_value & com.clubpenguin.lib.data.compression.type.TypeMasks.INT_16);
                var _local_2 = 0;
                while (_local_2 < com.clubpenguin.lib.data.compression.type.SpecialTypes.specialTypes.length) {
                    if (_local_3 == String(com.clubpenguin.lib.data.compression.type.SpecialTypes.specialTypes[_local_2])) {
                        _local_3 = String.fromCharCode(_local_2 + 1) + String.fromCharCode(_local_2 + 1);
                        _manifest.size = 3;
                        break;
                    }
                    _manifest.size = 2;
                    _local_2++;
                }
            }
            return(_manifest.serialize() + _local_3);
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
                if ((_value >>> 15) == 1) {
                    _value = _value | com.clubpenguin.lib.data.compression.type.TypeMasks.UPPER_INT32;
                }
            }
        }
        function set value(_arg_2) {
            _value = _arg_2;
            //return(value);
        }
        function get value() {
            return(_value);
        }
        function size() {
            return(_manifest.size);
        }
        function type() {
            return(_manifest.type);
        }
        static var TYPE_ID = 1;
    }
