//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.lib.data.compression.Compressor
    {
        function Compressor () {
        }
        static function compress(_arg_2) {
            var _local_3 = "";
            var _local_1 = 0;
            while (_local_1 < _arg_2.numEntries) {
                if ((_arg_2.getData(_local_1) != undefined) && (_arg_2.getData(_local_1) != null)) {
                    _local_3 = _local_3 + _arg_2.getData(_local_1).compress();
                }
                _local_1++;
            }
            trace((("After Compression:\n" + _local_3) + "\nTotal Length: ") + _local_3.length);
            return(_local_3);
        }
        static function decompress(_arg_1) {
            trace((("Before Decompression:\n" + _arg_1) + "\nTotal Length: ") + _arg_1.length);
            var _local_4 = new com.clubpenguin.lib.data.compression.DataSet();
            var _local_3;
            var _local_6;
            var _local_2;
            var _local_5;
            _local_5 = _arg_1.length + 2;
            while ((_arg_1.length > 0) && (_arg_1.length != _local_5)) {
                _local_2 = new com.clubpenguin.lib.data.compression.manifest.ManifestEntry(_arg_1.charAt(0));
                _local_6 = _arg_1.substr(1, _local_2.size - 1);
                switch (_local_2.type) {
                    case com.clubpenguin.lib.data.compression.type.CInt16.TYPE_ID : 
                        _local_3 = new com.clubpenguin.lib.data.compression.type.CInt16(0, _local_2);
                        trace("TypeInt " + _arg_1.length);
                        break;
                    case com.clubpenguin.lib.data.compression.type.CBool.TYPE_ID : 
                        _local_3 = new com.clubpenguin.lib.data.compression.type.CBool(0, _local_2);
                        trace("TypeBool");
                        break;
                    case com.clubpenguin.lib.data.compression.type.CFloat.TYPE_ID : 
                        _local_3 = new com.clubpenguin.lib.data.compression.type.CFloat(0, _local_2);
                        trace("TypeFloat");
                        break;
                    case com.clubpenguin.lib.data.compression.type.CString.TYPE_ID : 
                        _local_3 = new com.clubpenguin.lib.data.compression.type.CString(null, _local_2);
                        trace("TypeString");
                        break;
                    default : 
                        trace("[ERROR] Unknown type id:" + _local_2.type);
                        return(_local_4);
                }
                _local_3.decompress(_local_6);
                _local_4.setData(_local_3);
                _local_5 = _arg_1.length;
                _arg_1 = _arg_1.substring(_local_2.size, _arg_1.length);
            }
            if (_arg_1.length != 0) {
                trace((("!!!!!!!!!!!!!!!!!!!!!!!!!**********************!!!!!!!!!!!!!!!!!!! data fail in decompress(): manifesttype" + _local_2.type) + " at cdatalength ") + _arg_1.length);
            }
            trace("All data decompressed ok!");
            return(_local_4);
        }
    }
