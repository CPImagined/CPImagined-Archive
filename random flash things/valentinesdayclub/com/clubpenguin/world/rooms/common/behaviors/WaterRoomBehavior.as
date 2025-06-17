class com.clubpenguin.world.rooms.common.behaviors.WaterRoomBehavior extends com.clubpenguin.world.rooms.common.behaviors.RoomBehavior implements com.clubpenguin.world.rooms.common.behaviors.IRoomBehavior
{
    var _ENGINE, _onAnimationCompleteDelegate, _loader, _playerId, _SHELL, _puffleModel, _isShowStatsBarWidget;
    function WaterRoomBehavior()
    {
        super();
        _ENGINE = _global.getCurrentEngine();
    } // End of the function
    function destroy()
    {
        super.destroy();
        _loader.removeEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, _onAnimationCompleteDelegate);
    } // End of the function
    function applyEffect(playerID)
    {
        _playerId = playerID;
        _puffleModel = _SHELL.getPlayerObjectById(playerID).attachedPuffle;
        if (_puffleModel)
        {
            var _loc3 = _ENGINE.puffleAvatarController.getPuffleAvatar(_puffleModel.id).splashCount;
            if (_loc3 < 1)
            {
                _ENGINE.puffleAvatarController.getPuffleAvatar(_puffleModel.id).splashCount = _loc3 + 1;
                _loader = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(playerID, _puffleModel.id, _SHELL, _ENGINE, true);
                _onAnimationCompleteDelegate = com.clubpenguin.util.Delegate.create(this, onAnimationCompleted);
                _loader.addEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, _onAnimationCompleteDelegate);
                var _loc5 = _puffleModel.color;
                var _loc2 = _SHELL.getPath(com.clubpenguin.world.rooms.common.behaviors.WaterRoomBehavior.WATER_ANIMATION_PATH);
                _loc2 = _puffleModel.getFormattedAssetURL(_loc2);
                _loader.playPuffleAnimation(_loc2);
                if (_SHELL.isMyPlayer(_playerId))
                {
                    com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.SPLASH_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_STATION);
                } // end if
            } // end if
        } // end if
    } // End of the function
    function onAnimationCompleted(event)
    {
        if (_isShowStatsBarWidget && _SHELL.isMyPlayer(event.playerID))
        {
            var _loc3 = _SHELL.getMyPlayerObject().attachedPuffle.id;
            _global.getCurrentEngine().puffleAvatarController.displayPuffleWidget(_loc3, "statsBarWidget", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_ITEM_ID);
        } // end if
        _SHELL.updateListeners(_SHELL.ROOM_EFFECT_COMPLETE, {playerId: event.playerID, effectType: com.clubpenguin.world.rooms.common.behaviors.WaterRoomBehavior.WATER_SPLASH_EFFECT});
        this.destroy();
    } // End of the function
    static var WATER_ANIMATION_PATH = "w.puffle.sprite.splash";
    static var WATER_SPLASH_EFFECT = "waterSplashEffect";
} // End of Class
