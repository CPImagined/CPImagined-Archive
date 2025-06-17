//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.lib.data.compression.DataSet
    {
        var _entries;
        function DataSet () {
            _entries = new Array();
        }
        function get size() {
            return(_size);
        }
        function get numEntries() {
            return(_entries.length);
        }
        function getData(_arg_2) {
            return(com.clubpenguin.lib.data.compression.type.DataType(_entries[_arg_2]));
        }
        function setData(_arg_3, _arg_2) {
            _size = _size + _arg_3.size();
            if (_arg_2 == undefined) {
                _entries.push(_arg_3);
                return(undefined);
            }
            if (getData(_arg_2) != undefined) {
                _size = _size - getData(_arg_2).size();
            }
            _entries[_arg_2] = _arg_3;
        }
        function deleteEntry(_arg_3) {
            var _local_2 = getData(_arg_3);
            _entries[_arg_3] = undefined;
            return(_local_2);
        }
        function setInt16(_arg_3, _arg_2) {
            setData(new com.clubpenguin.lib.data.compression.type.CInt16(_arg_3), _arg_2);
        }
        function getInt16(_arg_2) {
            if (getData(_arg_2).type() != com.clubpenguin.lib.data.compression.type.CInt16.TYPE_ID) {
                trace((("[ERROR] Data type at index:" + _arg_2) + " is not an int16! Found type:") + getData(_arg_2).type());
                return(null);
            }
            return(com.clubpenguin.lib.data.compression.type.CInt16(getData(_arg_2)).value);
        }
        function setBool(_arg_5, _arg_3, _arg_2) {
            var _local_4;
            if (((_arg_3 == undefined) || (_arg_3 > 15)) || (_arg_3 < 0)) {
                trace("[ERROR] $boolIndex argument must be a number between or including 0 to 15, found $boolIndex:" + _arg_3);
                return(undefined);
            }
            if (_arg_2 == undefined) {
                if (getData(_entries.length - 1).type() == com.clubpenguin.lib.data.compression.type.CBool.TYPE_ID) {
                    com.clubpenguin.lib.data.compression.type.CBool(getData(_entries.length - 1)).setBoolAt(_arg_3, _arg_5);
                    return(undefined);
                }
            } else if (getData(_arg_2) != undefined) {
                if (getData(_arg_2).type() != com.clubpenguin.lib.data.compression.type.CBool.TYPE_ID) {
                    trace((("[ERROR] Data type at index:" + _arg_2) + " is not a bool! Found type:") + getData(_arg_2).type());
                    return(undefined);
                }
                com.clubpenguin.lib.data.compression.type.CBool(getData(_arg_2)).setBoolAt(_arg_3, _arg_5);
                return(undefined);
            }
            _local_4 = new com.clubpenguin.lib.data.compression.type.CBool();
            _local_4.setBoolAt(_arg_3, _arg_5);
            setData(_local_4, _arg_2);
        }
        function getBool(_arg_3, _arg_2) {
            if (((_arg_2 == undefined) || (_arg_2 > 15)) || (_arg_2 < 0)) {
                trace("[ERROR] $boolIndex argument must be a number between or including 0 to 15, found $boolIndex:" + _arg_2);
                return(null);
            }
            if (getData(_arg_3).type() != com.clubpenguin.lib.data.compression.type.CBool.TYPE_ID) {
                trace((("[ERROR] Data type at index:" + _arg_3) + " is not a bool! Found type:") + getData(_arg_3).type());
                return(null);
            }
            return(com.clubpenguin.lib.data.compression.type.CBool(getData(_arg_3)).getBoolAt(_arg_2));
        }
        function setFloat(_arg_3, _arg_2) {
            setData(new com.clubpenguin.lib.data.compression.type.CFloat(_arg_3), _arg_2);
        }
        function getFloat(_arg_2) {
            if (getData(_arg_2).type() != com.clubpenguin.lib.data.compression.type.CFloat.TYPE_ID) {
                trace((("[ERROR] Data type at index:" + _arg_2) + " is not a float! Found type:") + getData(_arg_2).type());
                return(null);
            }
            return(com.clubpenguin.lib.data.compression.type.CFloat(getData(_arg_2)).value);
        }
        function setString(_arg_3, _arg_2) {
            setData(new com.clubpenguin.lib.data.compression.type.CString(_arg_3), _arg_2);
        }
        function getString(_arg_2) {
            trace("DataSet.getString() at index: " + _arg_2);
            var _local_3;
            _local_3 = getData(_arg_2);
            trace("got data type; " + _local_3);
            var _local_4;
            _local_4 = _local_3.type();
            trace("got dataTypeID : " + _local_4);
            if (_local_4 != com.clubpenguin.lib.data.compression.type.CString.TYPE_ID) {
                trace((("[ERROR] Data type at index:" + _arg_2) + " is not a float! Found type:") + getData(_arg_2).type());
                return(null);
            }
            trace("DataSet.getString() at index: " + _arg_2);
            return(com.clubpenguin.lib.data.compression.type.CString(getData(_arg_2)).value);
        }
        var _size = 0;
    }
