//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.lib.data.compression.type.CString implements com.clubpenguin.lib.data.compression.type.DataType
    {
        var _value, _manifest;
        function CString (_arg_2, _arg_3) {
            _value = _arg_2;
            if (_value == undefined) {
                _value = "";
            }
            _manifest = _arg_3;
            if (_manifest == undefined) {
                _manifest = new com.clubpenguin.lib.data.compression.manifest.ManifestEntry();
                _manifest.type = TYPE_ID;
                _manifest.size = _value.length;
                _manifest.setNull(0, false);
                _manifest.setNull(1, false);
                _manifest.setNull(2, false);
                _manifest.setNull(3, false);
            }
        }
        function compress() {
            var _local_3 = _value;
            var _local_4;
            var _local_2 = 0;
            while (_local_2 < com.clubpenguin.lib.data.compression.type.SpecialTypes.specialTypes.length) {
                if (_local_3.indexOf(com.clubpenguin.lib.data.compression.type.SpecialTypes.specialTypes[_local_2], 0) != -1) {
                    _local_4 = String.fromCharCode(_local_2 + 1) + String.fromCharCode(_local_2 + 1);
                    _local_3.split(com.clubpenguin.lib.data.compression.type.SpecialTypes.specialTypes[_local_2]).join(_local_4);
                }
                _local_2++;
            }
            _manifest.size = _local_3.length + 1;
            return(_manifest.serialize() + _local_3);
        }
        function decompress(_arg_4) {
            var _local_3;
            var _local_2 = 0;
            while (_local_2 < com.clubpenguin.lib.data.compression.type.SpecialTypes.specialTypes.length) {
                _local_3 = String.fromCharCode(_local_2 + 1) + String.fromCharCode(_local_2 + 1);
                if (_arg_4.indexOf(_local_3, 0) != -1) {
                    _arg_4.split(_local_3).join(com.clubpenguin.lib.data.compression.type.SpecialTypes.specialTypes[_local_2]);
                }
                _local_2++;
            }
            _value = _arg_4;
            _manifest.size = _value.length + 1;
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
        static var TYPE_ID = 4;
    }
