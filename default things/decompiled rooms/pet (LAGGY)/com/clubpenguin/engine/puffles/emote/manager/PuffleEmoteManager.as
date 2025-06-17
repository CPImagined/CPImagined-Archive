//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.emote.manager.PuffleEmoteManager
    {
        var _shell, _puffleIDToEmoteMap;
        function PuffleEmoteManager (_arg_2) {
            _shell = _arg_2;
            _puffleIDToEmoteMap = new Object();
            _shell.addListener(_shell.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, handleRoomDestroyed));
        }
        function showEmote(_arg_2, _arg_4, _arg_3, _arg_5) {
            if (!puffleEmoteMapExist(_arg_2)) {
                _puffleIDToEmoteMap[_arg_2] = new Object();
                _puffleIDToEmoteMap[_arg_2].emoteState = _arg_3;
                _puffleIDToEmoteMap[_arg_2].emoteView = new com.clubpenguin.engine.puffles.emote.PuffleEmoteView(_arg_2);
                _puffleIDToEmoteMap[_arg_2].puffleClip = _arg_4;
                _puffleIDToEmoteMap[_arg_2].emoteView.emoteDone.addOnce(onEmoteDone, this);
                _puffleIDToEmoteMap[_arg_2].emoteView.emoteLoadFailed.addOnce(onEmoteLoadFailed, this);
                _puffleIDToEmoteMap[_arg_2].emoteView.loadEmoticon(_arg_4, _arg_5);
            } else if (((_puffleIDToEmoteMap[_arg_2].emoteState == _arg_3) || (_arg_3 == com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.TRICKS_EMOTE_STATE)) || (_arg_3 == com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.CARE_EMOTE_STATE)) {
                _puffleIDToEmoteMap[_arg_2].emoteState = _arg_3;
                _puffleIDToEmoteMap[_arg_2].pendingEmoteToLoad = _arg_5;
                _puffleIDToEmoteMap[_arg_2].puffleClip = _arg_4;
                _puffleIDToEmoteMap[_arg_2].emoteView.removeEmoticon();
            }
        }
        function removeEmote(_arg_2) {
            if (puffleEmoteMapExist(_arg_2)) {
                _puffleIDToEmoteMap[_arg_2].emoteView.removeEmoticon();
                _puffleIDToEmoteMap[_arg_2] = null;
            }
        }
        function onEmoteDone(_arg_2) {
            if ((_puffleIDToEmoteMap[_arg_2].pendingEmoteToLoad != undefined) && (_puffleIDToEmoteMap[_arg_2].pendingEmoteToLoad != null)) {
                _puffleIDToEmoteMap[_arg_2].emoteView.emoteDone.addOnce(onEmoteDone, this);
                _puffleIDToEmoteMap[_arg_2].emoteView.emoteLoadFailed.addOnce(onEmoteLoadFailed, this);
                _puffleIDToEmoteMap[_arg_2].emoteView.loadEmoticon(_puffleIDToEmoteMap[_arg_2].puffleClip, _puffleIDToEmoteMap[_arg_2].pendingEmoteToLoad);
                _puffleIDToEmoteMap[_arg_2].pendingEmoteToLoad = null;
            } else {
                cleanup(_arg_2);
            }
        }
        function onEmoteLoadFailed(_arg_2) {
            cleanup(_arg_2);
        }
        function puffleEmoteMapExist(_arg_2) {
            return((_puffleIDToEmoteMap[_arg_2] != undefined) && (_puffleIDToEmoteMap[_arg_2] != null));
        }
        function handleRoomDestroyed() {
            for (var _local_2 in _puffleIDToEmoteMap) {
                cleanup(_local_2);
            }
        }
        function cleanup(_arg_2) {
            _puffleIDToEmoteMap[_arg_2].emoteView = null;
            _puffleIDToEmoteMap[_arg_2].puffleClip = null;
            _puffleIDToEmoteMap[_arg_2] = null;
        }
    }
