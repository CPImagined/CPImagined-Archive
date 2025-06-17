class com.clubpenguin.engine.puffles.emote.PuffleEmoteView
{
    var _puffleID, emoteDone, emoteLoadFailed, _emoticonView, emote, onEnterFrame;
    function PuffleEmoteView(puffleID)
    {
        _puffleID = puffleID;
        emoteDone = new org.osflash.signals.Signal(Number);
        emoteLoadFailed = new org.osflash.signals.Signal(Number);
    } // End of the function
    function loadEmoticon(puffleClip, emotePath)
    {
        _emoticonView = puffleClip[com.clubpenguin.engine.puffles.emote.PuffleEmoteView.EMOTICON_CONTAINER];
        _emoticonLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _emoticonLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadEmoticon));
        _emoticonLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadErrorEmoticon));
        _emoticonLoader.loadClip(emotePath, _emoticonView, "PuffleEmote.as loadEmoticon()");
    } // End of the function
    function removeEmoticon()
    {
        if (_emoticonLoader && _emoticonView.emote)
        {
            _emoticonLoader.unloadClip(_emoticonView.emote);
        } // end if
        emoteDone.dispatch(_puffleID);
    } // End of the function
    function onLoadEmoticon(event)
    {
        this.removeLoadListeners();
        var scope = this;
        _emoticonView.onEnterFrame = function ()
        {
            if (emote._currentframe >= emote._totalframes)
            {
                onEnterFrame = null;
                scope.removeEmoticon();
            } // end if
        };
    } // End of the function
    function onLoadErrorEmoticon(event)
    {
        for (var _loc3 in event)
        {
        } // end of for...in
        this.removeLoadListeners();
        emoteLoadFailed.dispatch(_puffleID);
    } // End of the function
    function removeLoadListeners()
    {
        _emoticonLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadEmoticon));
        _emoticonLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadErrorEmoticon));
    } // End of the function
    static var EMOTICON_CONTAINER = "emoticon_container";
    var _emoticonLoader = null;
} // End of Class
