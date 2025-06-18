//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.disney.dce.phrasechat.SuggestPhraseRequest
    {
        static var phraseChatHostUrl;
        var words, language, httpStatusCode;
        function SuggestPhraseRequest (w, l) {
            words = w;
            language = l;
            httpStatusCode = -1;
        }
        static function setPhraseChatHostURL(pcURL) {
            phraseChatHostUrl = pcURL;
        }
        function init() {
            var _local_2 = new LoadVars();
            _local_2.onData = com.clubpenguin.util.Delegate.create(this, handleSuggestPhrase);
            _local_2.onHTTPStatus = com.clubpenguin.util.Delegate.create(this, handleSuggestPhraseHTTPStatus);
            _local_2.addRequestHeader("Accept", "application/json");
            _local_2.load((((phraseChatHostUrl + "/") + language) + "/suggest?phrase=") + escape(words));
        }
        function handleSuggestPhrase(jsonData) {
            if (((httpStatusCode == 0) || (httpStatusCode == 200)) && (jsonData != undefined)) {
            }
        }
        function handleSuggestPhraseHTTPStatus(httpStatus) {
            httpStatusCode = httpStatus;
        }
    }
