//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.emote.PuffleEmoteView
    {
        var _puffleID, emoteDone, emoteLoadFailed, _emoticonView;
        function PuffleEmoteView (puffleID) {
            _puffleID = puffleID;
            emoteDone = new org.osflash.signals.Signal(Number);
            emoteLoadFailed = new org.osflash.signals.Signal(Number);
        }
        function loadEmoticon(puffleClip, emotePath) {
            _emoticonView = puffleClip[EMOTICON_CONTAINER];
            _emoticonLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _emoticonLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadEmoticon));
            _emoticonLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadErrorEmoticon));
            _emoticonLoader.loadClip(emotePath, _emoticonView, "PuffleEmote.as loadEmoticon()");
        }
        function removeEmoticon() {
            if (_emoticonLoader && (_emoticonView.emote)) {
                _emoticonLoader.unloadClip(_emoticonView.emote);
            }
            emoteDone.dispatch(_puffleID);
        }
        function onLoadEmoticon(event) {
            removeLoadListeners();
            var scope = this;
            _emoticonView.onEnterFrame = function () {
                if (this.emote._currentframe >= this.emote._totalframes) {
                    this.onEnterFrame = null;
                    scope.removeEmoticon();
                }
            };
        }
        function onLoadErrorEmoticon(event) {
            for (var _local_3 in event) {
            }
            removeLoadListeners();
            emoteLoadFailed.dispatch(_puffleID);
        }
        function removeLoadListeners() {
            _emoticonLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadEmoticon));
            _emoticonLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadErrorEmoticon));
        }
        static var EMOTICON_CONTAINER = "emoticon_container";
        var _emoticonLoader = null;
    }
