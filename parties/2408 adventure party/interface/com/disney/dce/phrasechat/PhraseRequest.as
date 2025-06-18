//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.disney.dce.phrasechat.PhraseRequest
    {
        static var phraseChatHostUrl;
        var playerId, phraseId, language, callback;
        function PhraseRequest (playerId, phraseId, language, callback) {
            this.playerId = playerId;
            this.phraseId = phraseId;
            this.language = language;
            this.callback = callback;
        }
        static function setPhraseChatHostURL(pcURL) {
            phraseChatHostUrl = pcURL;
        }
        function getPhrase() {
            var _local_2 = new LoadVars();
            _local_2.onData = com.clubpenguin.util.Delegate.create(this, handlePhraseRetrieval);
            _local_2.load((((phraseChatHostUrl + "/") + language) + "/phrase/") + escape(phraseId));
        }
        function handlePhraseRetrieval(jsonData) {
            if (jsonData == undefined) {
                return(undefined);
            }
            var _local_2 = new com.disney.dce.JSON();
            var _local_3 = _local_2.parse(jsonData);
            callback(playerId, phraseId, language, _local_3.result.data.phrase);
        }
    }
