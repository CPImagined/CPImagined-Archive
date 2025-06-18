dynamic class com.clubpenguin.engine.puffles.emote.manager.PuffleEmoteManager
{
    var _puffleIDToEmoteMap;
    var _shell;

    function PuffleEmoteManager(shell)
    {
        this._shell = shell;
        this._puffleIDToEmoteMap = new Object();
        this._shell.addListener(this._shell.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, this.handleRoomDestroyed));
    }

    function showEmote(puffleID, puffleClip, newEmoteState, emotePath)
    {
        if (!this.puffleEmoteMapExist(puffleID)) 
        {
            this._puffleIDToEmoteMap[puffleID] = new Object();
            this._puffleIDToEmoteMap[puffleID].emoteState = newEmoteState;
            this._puffleIDToEmoteMap[puffleID].emoteView = new com.clubpenguin.engine.puffles.emote.PuffleEmoteView(puffleID);
            this._puffleIDToEmoteMap[puffleID].puffleClip = puffleClip;
            this._puffleIDToEmoteMap[puffleID].emoteView.emoteDone.addOnce(this.onEmoteDone, this);
            this._puffleIDToEmoteMap[puffleID].emoteView.emoteLoadFailed.addOnce(this.onEmoteLoadFailed, this);
            this._puffleIDToEmoteMap[puffleID].emoteView.loadEmoticon(puffleClip, emotePath);
            return;
        }
        if (this._puffleIDToEmoteMap[puffleID].emoteState == newEmoteState || newEmoteState == com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.TRICKS_EMOTE_STATE || newEmoteState == com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.CARE_EMOTE_STATE) 
        {
            this._puffleIDToEmoteMap[puffleID].emoteState = newEmoteState;
            this._puffleIDToEmoteMap[puffleID].pendingEmoteToLoad = emotePath;
            this._puffleIDToEmoteMap[puffleID].puffleClip = puffleClip;
            this._puffleIDToEmoteMap[puffleID].emoteView.removeEmoticon();
        }
    }

    function removeEmote(puffleID)
    {
        if (this.puffleEmoteMapExist(puffleID)) 
        {
            this._puffleIDToEmoteMap[puffleID].emoteView.removeEmoticon();
            this._puffleIDToEmoteMap[puffleID] = null;
        }
    }

    function onEmoteDone(puffleID)
    {
        if (this._puffleIDToEmoteMap[puffleID].pendingEmoteToLoad != undefined && this._puffleIDToEmoteMap[puffleID].pendingEmoteToLoad != null) 
        {
            this._puffleIDToEmoteMap[puffleID].emoteView.emoteDone.addOnce(this.onEmoteDone, this);
            this._puffleIDToEmoteMap[puffleID].emoteView.emoteLoadFailed.addOnce(this.onEmoteLoadFailed, this);
            this._puffleIDToEmoteMap[puffleID].emoteView.loadEmoticon(this._puffleIDToEmoteMap[puffleID].puffleClip, this._puffleIDToEmoteMap[puffleID].pendingEmoteToLoad);
            this._puffleIDToEmoteMap[puffleID].pendingEmoteToLoad = null;
            return;
        }
        this.cleanup(puffleID);
    }

    function onEmoteLoadFailed(puffleID)
    {
        this.cleanup(puffleID);
    }

    function puffleEmoteMapExist(puffleID)
    {
        return this._puffleIDToEmoteMap[puffleID] != undefined && this._puffleIDToEmoteMap[puffleID] != null;
    }

    function handleRoomDestroyed()
    {
        for (var __reg2 in this._puffleIDToEmoteMap) 
        {
            this.cleanup(__reg2);
        }
    }

    function cleanup(puffleID)
    {
        this._puffleIDToEmoteMap[puffleID].emoteView = null;
        this._puffleIDToEmoteMap[puffleID].puffleClip = null;
        this._puffleIDToEmoteMap[puffleID] = null;
    }

}
