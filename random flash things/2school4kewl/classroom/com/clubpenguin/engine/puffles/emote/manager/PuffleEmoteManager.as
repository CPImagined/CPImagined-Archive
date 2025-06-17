class com.clubpenguin.engine.puffles.emote.manager.PuffleEmoteManager
{
    var _shell, _puffleIDToEmoteMap;
    function PuffleEmoteManager(shell)
    {
        _shell = shell;
        _puffleIDToEmoteMap = new Object();
        _shell.addListener(_shell.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, handleRoomDestroyed));
    } // End of the function
    function showEmote(puffleID, puffleClip, newEmoteState, emotePath)
    {
        if (!this.puffleEmoteMapExist(puffleID))
        {
            _puffleIDToEmoteMap[puffleID] = new Object();
            _puffleIDToEmoteMap[puffleID].emoteState = newEmoteState;
            _puffleIDToEmoteMap[puffleID].emoteView = new com.clubpenguin.engine.puffles.emote.PuffleEmoteView(puffleID);
            _puffleIDToEmoteMap[puffleID].puffleClip = puffleClip;
            _puffleIDToEmoteMap[puffleID].emoteView.emoteDone.addOnce(onEmoteDone, this);
            _puffleIDToEmoteMap[puffleID].emoteView.emoteLoadFailed.addOnce(onEmoteLoadFailed, this);
            _puffleIDToEmoteMap[puffleID].emoteView.loadEmoticon(puffleClip, emotePath);
        }
        else if (_puffleIDToEmoteMap[puffleID].emoteState == newEmoteState || newEmoteState == com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.TRICKS_EMOTE_STATE || newEmoteState == com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.CARE_EMOTE_STATE)
        {
            _puffleIDToEmoteMap[puffleID].emoteState = newEmoteState;
            _puffleIDToEmoteMap[puffleID].pendingEmoteToLoad = emotePath;
            _puffleIDToEmoteMap[puffleID].puffleClip = puffleClip;
            _puffleIDToEmoteMap[puffleID].emoteView.removeEmoticon();
        } // end else if
    } // End of the function
    function removeEmote(puffleID)
    {
        if (this.puffleEmoteMapExist(puffleID))
        {
            _puffleIDToEmoteMap[puffleID].emoteView.removeEmoticon();
            _puffleIDToEmoteMap[puffleID] = null;
        } // end if
    } // End of the function
    function onEmoteDone(puffleID)
    {
        if (_puffleIDToEmoteMap[puffleID].pendingEmoteToLoad != undefined && _puffleIDToEmoteMap[puffleID].pendingEmoteToLoad != null)
        {
            _puffleIDToEmoteMap[puffleID].emoteView.emoteDone.addOnce(onEmoteDone, this);
            _puffleIDToEmoteMap[puffleID].emoteView.emoteLoadFailed.addOnce(onEmoteLoadFailed, this);
            _puffleIDToEmoteMap[puffleID].emoteView.loadEmoticon(_puffleIDToEmoteMap[puffleID].puffleClip, _puffleIDToEmoteMap[puffleID].pendingEmoteToLoad);
            _puffleIDToEmoteMap[puffleID].pendingEmoteToLoad = null;
        }
        else
        {
            this.cleanup(puffleID);
        } // end else if
    } // End of the function
    function onEmoteLoadFailed(puffleID)
    {
        this.cleanup(puffleID);
    } // End of the function
    function puffleEmoteMapExist(puffleID)
    {
        return (_puffleIDToEmoteMap[puffleID] != undefined && _puffleIDToEmoteMap[puffleID] != null);
    } // End of the function
    function handleRoomDestroyed()
    {
        for (var _loc2 in _puffleIDToEmoteMap)
        {
            this.cleanup(_loc2);
        } // end of for...in
    } // End of the function
    function cleanup(puffleID)
    {
        _puffleIDToEmoteMap[puffleID].emoteView = null;
        _puffleIDToEmoteMap[puffleID].puffleClip = null;
        _puffleIDToEmoteMap[puffleID] = null;
    } // End of the function
} // End of Class
