//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.disney.dce.phrasechat.SuggestionRequest
    {
        static var phraseChatHostUrl;
        var words, language, callback, errorCallback, callbackObject, httpStatusCode;
        function SuggestionRequest (w, l, cb, ecb, cbo) {
            words = w;
            language = l;
            callback = cb;
            errorCallback = ecb;
            callbackObject = cbo;
            httpStatusCode = -1;
        }
        static function setPhraseChatHostURL(pcURL) {
            phraseChatHostUrl = pcURL;
        }
        function init() {
            var _local_2 = new LoadVars();
            _local_2.onData = com.clubpenguin.util.Delegate.create(this, handleSuggestedPhrases);
            _local_2.onHTTPStatus = com.clubpenguin.util.Delegate.create(this, handleSuggestedPhraseHTTPStatus);
            _local_2.addRequestHeader("Accept", "application/json");
            _local_2.load((((phraseChatHostUrl + "/") + language) + "/search?phrase=") + escape(words));
        }
        function handleSuggestedPhrases(jsonData) {
            if ((httpStatusCode == 200) && (jsonData != undefined)) {
                var _local_3 = new com.disney.dce.JSON();
                var _local_2 = _local_3.parse(jsonData);
                callback.call(callbackObject, _local_2, words);
            } else {
                errorCallback.call(callbackObject);
            }
        }
        function handleSuggestedPhraseHTTPStatus(httpStatus) {
            httpStatusCode = httpStatus;
        }
    }
