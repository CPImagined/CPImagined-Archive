//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.services.vo.JsonServerCookieVO extends com.clubpenguin.services.vo.ServerCookieVO
    {
        var deserialzed, _jsonObject;
        function JsonServerCookieVO (cookieId) {
            super(cookieId);
            deserialzed = new org.osflash.signals.Signal();
        }
        function destroy() {
            super.destroy();
        }
        function isInitialized() {
            return(_jsonObject != null);
        }
        function update(vo) {
            deserialize(com.clubpenguin.services.vo.JsonServerCookieVO(vo).serialize());
        }
        function toString() {
            return(("[JsonServerCookie:" + serialize()) + "]");
        }
        function serialize() {
            return(com.clubpenguin.util.JSONParser.stringify(_jsonObject));
        }
        function deserialize(data) {
            var _local_2 = com.clubpenguin.util.JSONParser.parse(data);
            if (_jsonObject == null) {
                _jsonObject = {};
            }
            for (var _local_3 in _local_2) {
                _jsonObject[_local_3] = _local_2[_local_3];
            }
            deserialzed.dispatch();
        }
    }
