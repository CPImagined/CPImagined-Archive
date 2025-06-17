class com.clubpenguin.engine.puffles.pufflegoldberrystation.controller.PuffleGoldBerryStationController
{
    var _SHELL, _ENGINE, _INTERFACE, _handleRoomDestroyedDelegate, _playerId;
    function PuffleGoldBerryStationController(shellMC, engineMC, interfaceMC)
    {
        _SHELL = shellMC;
        _ENGINE = engineMC;
        _INTERFACE = interfaceMC;
        _handleRoomDestroyedDelegate = com.clubpenguin.util.Delegate.create(this, handleRoomDestroyed);
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, _handleRoomDestroyedDelegate);
    } // End of the function
    function destroy()
    {
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _handleRoomDestroyedDelegate);
    } // End of the function
    function onPuffleGoldBerryStationFeed(playerId, puffleId)
    {
        var _loc2 = _SHELL.getPlayerObjectById(playerId);
        if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_loc2, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE) && _ENGINE.puffleAvatarController.isPuffleVisible(puffleId) && _SHELL.getCurrentRoomId() == com.clubpenguin.engine.puffles.pufflegoldberrystation.controller.PuffleGoldBerryStationController.PET_SHOP_ID)
        {
            if (_SHELL.isMyPlayer(playerId))
            {
                _SHELL.sendAS3DisablePuffleTricksHUD();
            } // end if
            _playerId = playerId;
            var _loc7 = _ENGINE.getPlayerMovieClip(playerId);
            var _loc5 = new com.clubpenguin.engine.puffles.pufflegoldberrystation.view.PuffleGoldBerryStationView(_loc7, playerId, puffleId, _SHELL, _ENGINE);
            var _loc3 = _SHELL.getPath(com.clubpenguin.engine.puffles.pufflegoldberrystation.controller.PuffleGoldBerryStationController.EATING_ANIMATION_URL);
            _loc3 = _loc2.attachedPuffle.getFormattedAssetURL(_loc3);
            var _loc6 = new Object();
            _loc6.playerId = _loc2.player_id;
            _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, _loc6);
            _loc5.onEatGoldBerryAnimationCompleteSignal.addOnce(onEatGoldBerryAnimationDone, this);
            _loc5.playEatAnimation(_loc3);
        } // end if
    } // End of the function
    function onEatGoldBerryAnimationDone(payloadObject)
    {
        var _loc3 = new Object();
        _loc3.playerId = payloadObject.playerVO.player_id;
        _SHELL.updateListeners(_SHELL.ENABLE_PUFFLE_DIG_SEARCH_EMOTE, _loc3);
        _SHELL.puffleManager.setPuffleState(payloadObject.playerVO.player_id, com.clubpenguin.engine.puffles.pufflegoldberrystation.controller.PuffleGoldBerryStationController.GOLDEN_STATE, payloadObject.puffleId);
        this.enableDigSearchAndTricksHUD();
        if (!_INTERFACE.isGoldNuggetsHUDVisible() && _SHELL.isMyPlayer(payloadObject.playerVO.player_id))
        {
            var _loc4 = payloadObject.playerVO.currencies[_SHELL.CURRENCY_TYPE_GOLD_NUGGETS];
            var _loc5 = true;
            var _loc6 = _loc4 == 0;
            _INTERFACE.showGoldNuggetsHUD(_loc5, _loc6);
        } // end if
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
    function sendPuffleGoldBerryStationBI()
    {
    } // End of the function
    static var GOLDEN_STATE = 1;
    static var PET_SHOP_ID = 310;
    static var EATING_ANIMATION_URL = "w.puffle.sprite.eat";
} // End of Class
