class com.clubpenguin.engine.puffles.emote.manager.PuffleTricksEmoteManager
{
    var _shell, _engine, _puffleEmoteManager;
    function PuffleTricksEmoteManager(shell, engine, puffleEmoteManager)
    {
        _shell = shell;
        _engine = engine;
        _puffleEmoteManager = puffleEmoteManager;
    } // End of the function
    function showEmote(trickEmote)
    {
        var _loc2 = _shell.getMyPlayerObject();
        if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_loc2, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE))
        {
            var _loc3 = _engine.puffleAvatarController.getPuffleClip(_loc2.attachedPuffle.id);
            var _loc4;
            switch (trickEmote)
            {
                case com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.TRICK_EMOTE_DIG_FAIL:
                {
                    _loc4 = com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.DIG_TRICK_FAIL_EMOTICON_PATH;
                    break;
                } 
                default:
                {
                    return;
                } 
            } // End of switch
            _puffleEmoteManager.showEmote(_loc2.attachedPuffle.id, _loc3, com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.TRICKS_EMOTE_STATE, _shell.getPath(_loc4));
        } // end if
    } // End of the function
} // End of Class
