//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.automated.vo.PartyJSON_Parser implements com.clubpenguin.util.ISerializable
    {
        var deserialized, _jsonObject;
        function PartyJSON_Parser () {
            deserialized = new org.osflash.signals.Signal();
            _jsonObject = new Object();
        }
        function jsonObject() {
            return(_jsonObject);
        }
        function serialize() {
            return(com.clubpenguin.util.JSONParser.stringify(_jsonObject));
        }
        function deserialize(data) {
            if ((data == undefined) || (data.length == 0)) {
                _jsonObject = new Object();
            } else {
                var _local_2 = com.clubpenguin.util.JSONParser.parse(data);
                if (_jsonObject == null) {
                    _jsonObject = new Object();
                }
                for (var _local_3 in _local_2) {
                    _jsonObject[_local_3] = _local_2[_local_3];
                }
            }
            deserialized.dispatch(_jsonObject);
        }
    }
