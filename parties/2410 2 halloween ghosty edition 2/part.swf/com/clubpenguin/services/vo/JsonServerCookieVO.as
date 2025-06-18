
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.services.vo.JsonServerCookieVO extends com.clubpenguin.services.vo.ServerCookieVO
    {
        var deserialized, _jsonObject;
        function JsonServerCookieVO (_arg_3) {
            super(_arg_3);
            deserialized = new org.osflash.signals.Signal();
            _jsonObject = new Object();
        }
        function destroy() {
            super.destroy();
        }
        function isInitialized() {
            return(_jsonObject != null);
        }
        function update(_arg_2) {
            deserialize(com.clubpenguin.services.vo.JsonServerCookieVO(_arg_2).serialize());
        }
        function toString() {
            return(("[JsonServerCookie:" + serialize()) + "]");
        }
        function serialize() {
            return(com.clubpenguin.util.JSONParser.stringify(_jsonObject));
        }
        function deserialize(_arg_4) {
            if ((_arg_4 == undefined) || (_arg_4.length == 0)) {
                _jsonObject = new Object();
            } else {
                var _local_2 = com.clubpenguin.util.JSONParser.parse(_arg_4);
                if (_jsonObject == null) {
                    _jsonObject = new Object();
                }
                for (var _local_3 in _local_2) {
                    _jsonObject[_local_3] = _local_2[_local_3];
                }
            }
            deserialized.dispatch();
        }
    }
