    class com.clubpenguin.util.QueryParams
    {
        function QueryParams () {
        }
        static function getQueryParams(testingQueryString) {
            var _local_8;
            if (testingQueryString) {
                _local_8 = testingQueryString;
            } else {
                _local_8 = String(flash.external.ExternalInterface.call("parent.window.location.search.substring", 1));
            }
            var _local_7 = {};
            var _local_6 = _local_8.split("&");
            var _local_3 = 0;
            var _local_2 = -1;
            while (_local_3 < _local_6.length) {
                var _local_1 = _local_6[_local_3];
                _local_2 = _local_1.indexOf("=");
                if (_local_2 > 0) {
                    var _local_4 = _local_1.substring(0, _local_2);
                    _local_4.toLowerCase();
                    var _local_5 = _local_1.substring(_local_2 + 1);
                    _local_7[_local_4] = _local_5;
                }
                _local_3++;
            }
            return(_local_7);
        }
    }
