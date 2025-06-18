dynamic class com.clubpenguin.engine.puffles.emote.PuffleEmoteView
{
    static var EMOTICON_CONTAINER: String = "emoticon_container";
    var _emoticonLoader = null;
    var _emoticonView;
    var _puffleID;
    var emote;
    var emoteDone;
    var emoteLoadFailed;
    var onEnterFrame;

    function PuffleEmoteView(puffleID)
    {
        this._puffleID = puffleID;
        this.emoteDone = new org.osflash.signals.Signal(Number);
        this.emoteLoadFailed = new org.osflash.signals.Signal(Number);
    }

    function loadEmoticon(puffleClip, emotePath)
    {
        this._emoticonView = puffleClip[com.clubpenguin.engine.puffles.emote.PuffleEmoteView.EMOTICON_CONTAINER];
        this._emoticonLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        this._emoticonLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, this.onLoadEmoticon));
        this._emoticonLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, this.onLoadErrorEmoticon));
        this._emoticonLoader.loadClip(emotePath, this._emoticonView, "PuffleEmote.as loadEmoticon()");
    }

    function removeEmoticon()
    {
        if (this._emoticonLoader && this._emoticonView.emote) 
        {
            this._emoticonLoader.unloadClip(this._emoticonView.emote);
        }
        this.emoteDone.dispatch(this._puffleID);
    }

    function onLoadEmoticon(event)
    {
        this.removeLoadListeners();
        var scope = this;
        this._emoticonView.onEnterFrame = function ()
        {
            if (this.emote._currentframe >= this.emote._totalframes) 
            {
                this.onEnterFrame = null;
                scope.removeEmoticon();
            }
        }
        ;
    }

    function onLoadErrorEmoticon(event)
    {
        trace("\n");
        trace("*************************************");
        trace("*************************************");
        trace("[ERROR] ---> onLoadErrorEmoticon: " + event);
        for (var __reg3 in event) 
        {
            trace("error property: " + __reg3 + " error value: " + event[__reg3]);
        }
        trace("*************************************");
        trace("*************************************");
        this.removeLoadListeners();
        this.emoteLoadFailed.dispatch(this._puffleID);
    }

    function removeLoadListeners()
    {
        this._emoticonLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, this.onLoadEmoticon));
        this._emoticonLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, this.onLoadErrorEmoticon));
    }

}
