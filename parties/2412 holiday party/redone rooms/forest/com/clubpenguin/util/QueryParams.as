//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.QueryParams
    {
        function QueryParams () {
        }
        static function getQueryParams(testingQueryString) {
            var queryStringToProcess;
            if (testingQueryString) {
                queryStringToProcess = testingQueryString;
            } else {
                queryStringToProcess = String(flash.external.ExternalInterface.call("parent.window.location.search.substring", 1));
            }
            var params = {};
            var allParams = queryStringToProcess.split("&");
            var i = 0;
            var index = -1;
            while (i < allParams.length) {
                var keyValuePair = allParams[i];
                if (((index = keyValuePair.indexOf("="))) > 0) {
                    var paramKey = keyValuePair.substring(0, index);
                    paramKey.toLowerCase();
                    var paramValue = keyValuePair.substring(index + 1);
                    params[paramKey] = paramValue;
                }
                i++;
            }
            return(params);
        }
    }
