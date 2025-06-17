class com.clubpenguin.engine.puffles.emote.manager.DigSearchEmoteManager
{
    var _SHELL, _ENGINE, _isPuffleDigSearchEmoteEnabled, _autoReenable, _myPlayerObject;
    function DigSearchEmoteManager()
    {
        _SHELL = _global.getCurrentShell();
        _ENGINE = _global.getCurrentEngine();
        _isPuffleDigSearchEmoteEnabled = true;
        _autoReenable = true;
        _myPlayerObject = _SHELL.getMyPlayerObject();
        _SHELL.addListener(_SHELL.ENABLE_PUFFLE_DIG_SEARCH_EMOTE, com.clubpenguin.util.Delegate.create(this, onEnablePuffleDigSearchEmote));
        _SHELL.addListener(_SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, com.clubpenguin.util.Delegate.create(this, onDisablePuffleDigSearchEmote));
    } // End of the function
    function destroy()
    {
        _SHELL.removeListener(_SHELL.ENABLE_PUFFLE_DIG_SEARCH_EMOTE, com.clubpenguin.util.Delegate.create(this, onEnablePuffleDigSearchEmote));
        _SHELL.removeListener(_SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, com.clubpenguin.util.Delegate.create(this, onDisablePuffleDigSearchEmote));
    } // End of the function
    function displayPuffleEmote(playerObject)
    {
        if (!_SHELL.isMyPlayer(playerObject.player_id))
        {
            return;
        } // end if
        if (playerObject.isUsingSlide)
        {
            return;
        } // end if
        if (_isPuffleDigSearchEmoteEnabled && _ENGINE.puffleAvatarController.isPuffleVisible(playerObject.attachedPuffle.id))
        {
            var _loc5 = _ENGINE.puffleAvatarController.getPuffleClip(playerObject.attachedPuffle.id);
            if (_global.getCurrentRoom().roomEnvironmentManager.checkHitTestWithEnvironmentMC(_loc5))
            {
                return;
            } // end if
            var _loc7 = _SHELL.randBetween(1, 100);
            if (_loc7 <= com.clubpenguin.engine.puffles.emote.manager.DigSearchEmoteManager.RANDOM_PERCENTAGE_FOR_SHOWING_EMOTE)
            {
                var _loc4 = com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.DIG_SEARCH_EMOTICON_PATH;
                if (playerObject.attachedPuffle.getPuffleState() == 1)
                {
                    _loc4 = com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.GOLD_NUGGET_SEARCH_EMOTICON_PATH;
                } // end if
                var _loc8 = _SHELL.getPath(_loc4);
                _ENGINE.puffleEmoteManager.showEmote(playerObject.attachedPuffle.id, _loc5, com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.DIG_SEARCH_EMOTE_STATE, _loc8);
            } // end if
        }
        else if (_autoReenable)
        {
            var _loc6 = new Object();
            _loc6.playerId = playerObject.player_id;
            this.onEnablePuffleDigSearchEmote(_loc6);
        } // end else if
    } // End of the function
    function onEnablePuffleDigSearchEmote(data)
    {
        com.clubpenguin.util.Log.debug("onEnablePuffleDigSearchEmote()");
        if (!_SHELL.isMyPlayer(data.playerId))
        {
            return;
        } // end if
        if (data.autoReenable != undefined && data.autoReenable != null)
        {
            _autoReenable = data.autoReenable;
        } // end if
        if (_autoReenable)
        {
            _isPuffleDigSearchEmoteEnabled = true;
        } // end if
    } // End of the function
    function onDisablePuffleDigSearchEmote(data)
    {
        com.clubpenguin.util.Log.debug("onDisablePuffleDigSearchEmote()");
        if (!_SHELL.isMyPlayer(data.playerId))
        {
            return;
        } // end if
        if (data.autoReenable != undefined && data.autoReenable != null)
        {
            _autoReenable = data.autoReenable;
        } // end if
        _isPuffleDigSearchEmoteEnabled = false;
        if (!com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_myPlayerObject, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE))
        {
            _ENGINE.puffleEmoteManager.removeEmote(_myPlayerObject.attachedPuffle.id);
        } // end if
    } // End of the function
    static var RANDOM_PERCENTAGE_FOR_SHOWING_EMOTE = 25;
} // End of Class
