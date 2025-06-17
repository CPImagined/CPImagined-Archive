//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.emote.manager.PuffleTricksEmoteManager
    {
        var _shell, _engine, _puffleEmoteManager;
        function PuffleTricksEmoteManager (shell, engine, puffleEmoteManager) {
            _shell = shell;
            _engine = engine;
            _puffleEmoteManager = puffleEmoteManager;
        }
        function showEmote(trickEmote) {
            var _local_2 = _shell.getMyPlayerObject();
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local_2, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                var _local_3 = _engine.puffleAvatarController.getPuffleClip(_local_2.attachedPuffle.id);
                var _local_4;
                switch (trickEmote) {
                    case com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.TRICK_EMOTE_DIG_FAIL : 
                        _local_4 = com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.DIG_TRICK_FAIL_EMOTICON_PATH;
                        break;
                    default : 
                        return(undefined);
                }
                _puffleEmoteManager.showEmote(_local_2.attachedPuffle.id, _local_3, com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.TRICKS_EMOTE_STATE, _shell.getPath(_local_4));
            }
        }
    }
