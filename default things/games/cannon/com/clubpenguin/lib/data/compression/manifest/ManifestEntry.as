//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.lib.data.compression.manifest.ManifestEntry
    {
        var nullChars;
        function ManifestEntry (_arg_2) {
            nullChars = new Array(true, true, true, true);
            if (_arg_2 != undefined) {
                deserialize(_arg_2);
            }
        }
        function serialize() {
            var _local_3 = 0;
            var _local_2 = 0;
            while (_local_2 < nullChars.length) {
                _local_3 = _local_3 | (Boolean(nullChars[_local_2]) ? (1 << _local_2) : 0);
                _local_2++;
            }
            _local_3 = _local_3 | (type << 4);
            _local_3 = _local_3 | (size << 8);
            return(String.fromCharCode(_local_3));
        }
        function deserialize(_arg_4) {
            var _local_3 = _arg_4.charCodeAt(0);
            var _local_2 = 0;
            while (_local_2 < nullChars.length) {
                nullChars[_local_2] = (((_local_3 >>> _local_2) & (com.clubpenguin.lib.data.compression.manifest.ManifestMasks.NULL_MASK == 1)) ? true : false);
                _local_2++;
            }
            _type = (_local_3 >>> 4) & com.clubpenguin.lib.data.compression.manifest.ManifestMasks.TYPE_MASK;
            _size = (_local_3 >>> 8) & com.clubpenguin.lib.data.compression.manifest.ManifestMasks.SIZE_MASK;
        }
        function isNull(_arg_2) {
            return(Boolean(nullChars[_arg_2]));
        }
        function setNull(_arg_3, _arg_2) {
            nullChars[_arg_3] = _arg_2;
        }
        function get type() {
            return(_type);
        }
        function set type(_arg_2) {
            _type = _arg_2;
            //return(type);
        }
        function get size() {
            return(_size);
        }
        function set size(_arg_2) {
            _size = _arg_2;
            //return(size);
        }
        function toString() {
            return(((((("[ManifestEntry type:" + _type) + " size:") + _size) + " nullChars:") + nullChars) + "]");
        }
        var _type = 1;
        var _size = 2;
    }
