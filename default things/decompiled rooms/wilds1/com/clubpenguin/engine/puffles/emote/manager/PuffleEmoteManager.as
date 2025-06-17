//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.emote.manager.PuffleEmoteManager
    {
        var _shell, _puffleIDToEmoteMap;
        function PuffleEmoteManager (shell) {
            _shell = shell;
            _puffleIDToEmoteMap = new Object();
            _shell.addListener(_shell.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, handleRoomDestroyed));
        }
        function showEmote(puffleID, puffleClip, newEmoteState, emotePath) {
            if (!puffleEmoteMapExist(puffleID)) {
                _puffleIDToEmoteMap[puffleID] = new Object();
                _puffleIDToEmoteMap[puffleID].emoteState = newEmoteState;
                _puffleIDToEmoteMap[puffleID].emoteView = new com.clubpenguin.engine.puffles.emote.PuffleEmoteView(puffleID);
                _puffleIDToEmoteMap[puffleID].puffleClip = puffleClip;
                _puffleIDToEmoteMap[puffleID].emoteView.emoteDone.addOnce(onEmoteDone, this);
                _puffleIDToEmoteMap[puffleID].emoteView.emoteLoadFailed.addOnce(onEmoteLoadFailed, this);
                _puffleIDToEmoteMap[puffleID].emoteView.loadEmoticon(puffleClip, emotePath);
            } else if (((_puffleIDToEmoteMap[puffleID].emoteState == newEmoteState) || (newEmoteState == com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.TRICKS_EMOTE_STATE)) || (newEmoteState == com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.CARE_EMOTE_STATE)) {
                _puffleIDToEmoteMap[puffleID].emoteState = newEmoteState;
                _puffleIDToEmoteMap[puffleID].pendingEmoteToLoad = emotePath;
                _puffleIDToEmoteMap[puffleID].puffleClip = puffleClip;
                _puffleIDToEmoteMap[puffleID].emoteView.removeEmoticon();
            }
        }
        function removeEmote(puffleID) {
            if (puffleEmoteMapExist(puffleID)) {
                _puffleIDToEmoteMap[puffleID].emoteView.removeEmoticon();
                _puffleIDToEmoteMap[puffleID] = null;
            }
        }
        function onEmoteDone(puffleID) {
            if ((_puffleIDToEmoteMap[puffleID].pendingEmoteToLoad != undefined) && (_puffleIDToEmoteMap[puffleID].pendingEmoteToLoad != null)) {
                _puffleIDToEmoteMap[puffleID].emoteView.emoteDone.addOnce(onEmoteDone, this);
                _puffleIDToEmoteMap[puffleID].emoteView.emoteLoadFailed.addOnce(onEmoteLoadFailed, this);
                _puffleIDToEmoteMap[puffleID].emoteView.loadEmoticon(_puffleIDToEmoteMap[puffleID].puffleClip, _puffleIDToEmoteMap[puffleID].pendingEmoteToLoad);
                _puffleIDToEmoteMap[puffleID].pendingEmoteToLoad = null;
            } else {
                cleanup(puffleID);
            }
        }
        function onEmoteLoadFailed(puffleID) {
            cleanup(puffleID);
        }
        function puffleEmoteMapExist(puffleID) {
            return((_puffleIDToEmoteMap[puffleID] != undefined) && (_puffleIDToEmoteMap[puffleID] != null));
        }
        function handleRoomDestroyed() {
            for (var _local_2 in _puffleIDToEmoteMap) {
                cleanup(_local_2);
            }
        }
        function cleanup(puffleID) {
            _puffleIDToEmoteMap[puffleID].emoteView = null;
            _puffleIDToEmoteMap[puffleID].puffleClip = null;
            _puffleIDToEmoteMap[puffleID] = null;
        }
    }
