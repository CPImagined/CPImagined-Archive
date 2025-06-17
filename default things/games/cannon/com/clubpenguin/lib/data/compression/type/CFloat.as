//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.lib.data.compression.type.CFloat implements com.clubpenguin.lib.data.compression.type.DataType
    {
        var _manifest, _value;
        function CFloat (_arg_2, _arg_3) {
            _manifest = _arg_3;
            if (_manifest == undefined) {
                _manifest = new com.clubpenguin.lib.data.compression.manifest.ManifestEntry();
                _manifest.type = TYPE_ID;
                _manifest.size = 3;
                _manifest.setNull(2, false);
                _manifest.setNull(3, false);
            }
            _value = _arg_2;
            if (_value == undefined) {
                _value = 0;
            }
        }
        function compress() {
            var _local_3 = (_value >>> 15) & com.clubpenguin.lib.data.compression.type.TypeMasks.INT_16;
            var _local_2 = _value & com.clubpenguin.lib.data.compression.type.TypeMasks.INT_16;
            if (_local_3 == 0) {
                _manifest.setNull(0, true);
                _local_3 = 1;
            } else {
                _manifest.setNull(0, false);
            }
            if (_local_2 == 0) {
                _manifest.setNull(1, true);
                _local_2 = 1;
            } else {
                _manifest.setNull(1, false);
            }
            var _local_4 = String.fromCharCode(_local_3);
            var _local_5 = String.fromCharCode(_local_2);
            return((_manifest.serialize() + _local_4) + _local_5);
        }
        function decompress(_arg_4) {
            var _local_3 = _arg_4.charCodeAt(0);
            var _local_2 = _arg_4.charCodeAt(1);
            if (_manifest.isNull(0)) {
                _local_3 = 0;
            }
            if (_manifest.isNull(1)) {
                _local_2 = 0;
            }
            _value = _local_2 | (_local_3 << 15);
        }
        function type() {
            return(_manifest.type);
        }
        function size() {
            return(_manifest.size);
        }
        function get value() {
            return(_value);
        }
        function set value(_arg_2) {
            _value = _arg_2;
            //return(value);
        }
        static var TYPE_ID = 3;
    }
