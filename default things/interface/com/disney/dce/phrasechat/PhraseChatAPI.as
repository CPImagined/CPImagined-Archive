//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.disney.dce.phrasechat.PhraseChatAPI
    {
        var phraseChatHostUrl;
        function PhraseChatAPI (pcURL) {
            phraseChatHostUrl = pcURL;
            com.disney.dce.phrasechat.PhraseRequest.setPhraseChatHostURL(phraseChatHostUrl);
            com.disney.dce.phrasechat.SuggestionRequest.setPhraseChatHostURL(phraseChatHostUrl);
            com.disney.dce.phrasechat.SuggestPhraseRequest.setPhraseChatHostURL(phraseChatHostUrl);
        }
        function getSuggestionsForPhrase(words, language, callback, errorCallback, callbackObject) {
            var _local_1 = new com.disney.dce.phrasechat.SuggestionRequest(words, language, callback, errorCallback, callbackObject);
            _local_1.init();
        }
        function suggestPhrase(words, language) {
            var _local_1 = new com.disney.dce.phrasechat.SuggestPhraseRequest(words, language);
            _local_1.init();
        }
        function getPhrase(playerId, phraseId, language, callback) {
            var _local_1 = new com.disney.dce.phrasechat.PhraseRequest(playerId, phraseId, language, callback);
            _local_1.getPhrase();
        }
        function notifyPhraseUsed(phraseId, language) {
            var _local_2 = new LoadVars();
            _local_2.load((((phraseChatHostUrl + "/") + language) + "/phrase/") + phraseId);
        }
        function addListener(type, func, scope) {
            if ((type == undefined) || (func == undefined)) {
                return(false);
            }
            var _local_2 = getListenersArray(type);
            var _local_3 = getListenerIndex(_local_2, func);
            if (_local_3 == -1) {
                _local_2.push({func:func, scope:scope});
                return(true);
            }
            return(false);
        }
        function removeListener(type, func) {
            var _local_2 = getListenersArray(type);
            var _local_3 = getListenerIndex(_local_2, func);
            if (_local_3 != -1) {
                _local_2.splice(_local_3, 1);
                return(true);
            }
            return(false);
        }
        function getListenerIndex(array, func) {
            var _local_2 = array.length;
            var _local_1 = 0;
            while (_local_1 < _local_2) {
                if (array[_local_1].func == func) {
                    return(_local_1);
                }
                _local_1++;
            }
            return(-1);
        }
        function updateListeners(type, obj) {
            var _local_3 = getListenersArray(type);
            var _local_5 = _local_3.length;
            if (_local_5 < 1) {
                return(false);
            }
            var _local_2 = 0;
            while (_local_2 < _local_5) {
                (_local_3[_local_2].scope ? (_local_3[_local_2].func.call(_local_3[_local_2].scope, obj)) : (_local_3[_local_2].func(obj)));
                _local_2++;
            }
            return(true);
        }
        function getListenersArray(type) {
            if (listenersByType[type] == undefined) {
                listenersByType[type] = new Array();
            }
            return(listenersByType[type]);
        }
        static var SUGGESTED_PHRASES = "suggestedPhrases";
        var listenersByType = new Object();
    }
