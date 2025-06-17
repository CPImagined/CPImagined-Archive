class com.clubpenguin.engine.puffles.pufflecarestations.controller.PuffleCareStationController
{
    var _SHELL, _ENGINE, _handleRoomDestroyedDelegate, _playerId;
    function PuffleCareStationController(shellMC, engineMC)
    {
        _SHELL = shellMC;
        _ENGINE = engineMC;
        _handleRoomDestroyedDelegate = com.clubpenguin.util.Delegate.create(this, handleRoomDestroyed);
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, _handleRoomDestroyedDelegate);
    } // End of the function
    function destroy()
    {
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _handleRoomDestroyedDelegate);
    } // End of the function
    function onPuffleCareStationFeed(playerId, puffleItemID)
    {
        var _loc2 = _SHELL.getPlayerObjectById(playerId);
        if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_loc2, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE) && _ENGINE.puffleAvatarController.isPuffleVisible(_loc2.attachedPuffle.id))
        {
            if (_SHELL.getCurrentRoomId() == com.clubpenguin.engine.puffles.pufflecarestations.controller.PuffleCareStationController.PIZZA_ROOM || _SHELL.getCurrentRoomId() == com.clubpenguin.engine.puffles.pufflecarestations.controller.PuffleCareStationController.PARTY_PIZZA)
            {
                if (_SHELL.isMyPlayer(playerId))
                {
                    _SHELL.sendAS3DisablePuffleTricksHUD();
                } // end if
                _playerId = playerId;
                var _loc7 = _ENGINE.getPlayerMovieClip(playerId);
                var _loc4 = new com.clubpenguin.engine.puffles.pufflecarestations.view.PuffleCareStationView(_loc7, _loc2.player_id);
                var _loc3 = _SHELL.getPath(com.clubpenguin.engine.puffles.pufflecarestations.controller.PuffleCareStationController.EATING_ANIMATION_URL);
                _loc3 = _loc2.attachedPuffle.getFormattedAssetURL(_loc3);
            } // end if
            var _loc5 = new Object();
            _loc5.playerId = _loc2.player_id;
            _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, _loc5);
            _loc4.onEatAnimationCompleteSignal.addOnce(onEatAnimationDone, this);
            _loc4.playEatAnimation(_loc3, puffleItemID);
        } // end if
    } // End of the function
    function onPuffleFullStatsAnimation(playerId)
    {
        var _loc2 = new com.clubpenguin.engine.puffles.animations.FullStatsAnimation(_SHELL, _ENGINE);
        _loc2.playFullStatsAnimation(playerId);
    } // End of the function
    function enableDigSearchAndTricksHUD()
    {
        var _loc2 = new Object();
        _loc2.playerId = _playerId;
        _SHELL.updateListeners(_SHELL.ENABLE_PUFFLE_DIG_SEARCH_EMOTE, _loc2);
        if (_SHELL.isMyPlayer(_playerId))
        {
            _SHELL.sendAS3EnablePuffleTricksHUD();
        } // end if
    } // End of the function
    function handleRoomDestroyed()
    {
        this.enableDigSearchAndTricksHUD();
    } // End of the function
    function onEatAnimationDone()
    {
        this.enableDigSearchAndTricksHUD();
    } // End of the function
    static var EATING_ANIMATION_URL = "w.puffle.sprite.eat";
    static var PLAY_SHORT = "_short.swf";
    static var PIZZA_ROOM = 330;
    static var PARTY_PIZZA = 864;
} // End of Class
