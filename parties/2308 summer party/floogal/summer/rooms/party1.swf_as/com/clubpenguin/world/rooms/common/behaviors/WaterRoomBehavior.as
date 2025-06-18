dynamic class com.clubpenguin.world.rooms.common.behaviors.WaterRoomBehavior extends com.clubpenguin.world.rooms.common.behaviors.RoomBehavior implements com.clubpenguin.world.rooms.common.behaviors.IRoomBehavior
{
    static var WATER_ANIMATION_PATH: String = "w.puffle.sprite.splash";
    static var WATER_SPLASH_EFFECT: String = "waterSplashEffect";
    var _ENGINE;
    var _SHELL;
    var _isShowStatsBarWidget;
    var _loader;
    var _onAnimationCompleteDelegate;
    var _playerId;
    var _puffleModel;

    function WaterRoomBehavior()
    {
        super();
        this._ENGINE = _global.getCurrentEngine();
    }

    function destroy()
    {
        super.destroy();
        this._loader.removeEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, this._onAnimationCompleteDelegate);
    }

    function applyEffect(playerID)
    {
        this._playerId = playerID;
        this._puffleModel = this._SHELL.getPlayerObjectById(playerID).attachedPuffle;
        if (this._puffleModel) 
        {
            var __reg3 = this._ENGINE.puffleAvatarController.getPuffleAvatar(this._puffleModel.id).splashCount;
            if (__reg3 < 1) 
            {
                this._ENGINE.puffleAvatarController.getPuffleAvatar(this._puffleModel.id).splashCount = __reg3 + 1;
                this._loader = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(playerID, this._puffleModel.id, this._SHELL, this._ENGINE, true);
                this._onAnimationCompleteDelegate = com.clubpenguin.util.Delegate.create(this, this.onAnimationCompleted);
                this._loader.addEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, this._onAnimationCompleteDelegate);
                var __reg5 = this._puffleModel.color;
                var __reg2 = this._SHELL.getPath(com.clubpenguin.world.rooms.common.behaviors.WaterRoomBehavior.WATER_ANIMATION_PATH);
                __reg2 = this._puffleModel.getFormattedAssetURL(__reg2);
                this._loader.playPuffleAnimation(__reg2);
                if (this._SHELL.isMyPlayer(this._playerId)) 
                {
                    com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.SPLASH_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_STATION);
                }
            }
        }
    }

    function onAnimationCompleted(event)
    {
        if (this._isShowStatsBarWidget && this._SHELL.isMyPlayer(event.playerID)) 
        {
            var __reg3 = this._SHELL.getMyPlayerObject().attachedPuffle.id;
            _global.getCurrentEngine().puffleAvatarController.displayPuffleWidget(__reg3, "statsBarWidget", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_ITEM_ID);
        }
        this._SHELL.updateListeners(this._SHELL.ROOM_EFFECT_COMPLETE, {playerId: event.playerID, effectType: com.clubpenguin.world.rooms.common.behaviors.WaterRoomBehavior.WATER_SPLASH_EFFECT});
        this.destroy();
    }

}
