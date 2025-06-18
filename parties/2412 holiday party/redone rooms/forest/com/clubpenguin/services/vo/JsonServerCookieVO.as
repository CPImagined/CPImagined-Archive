//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.services.vo.JsonServerCookieVO extends com.clubpenguin.services.vo.ServerCookieVO
    {
        var deserialized, _jsonObject;
        function JsonServerCookieVO (cookieId) {
            super(cookieId);
            deserialized = new org.osflash.signals.Signal();
            _jsonObject = new Object();
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
            if ((data == undefined) || (data.length == 0)) {
                _jsonObject = new Object();
            } else {
                var newObject = com.clubpenguin.util.JSONParser.parse(data);
                if (_jsonObject == null) {
                    _jsonObject = new Object();
                }
                for (var key in newObject) {
                    _jsonObject[key] = newObject[key];
                }
            }
            deserialized.dispatch();
        }
    }
