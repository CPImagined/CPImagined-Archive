    class com.clubpenguin.world.rooms.common.behaviors.WaterRoomBehavior extends com.clubpenguin.world.rooms.common.behaviors.RoomBehavior implements com.clubpenguin.world.rooms.common.behaviors.IRoomBehavior
    {
        var _ENGINE, _loader, _onAnimationCompleteDelegate, _playerId, _puffleModel, _SHELL, _isShowStatsBarWidget;
        function WaterRoomBehavior () {
            super();
            _ENGINE = _global.getCurrentEngine();
        }
        function destroy() {
            super.destroy();
            _loader.removeEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, _onAnimationCompleteDelegate);
        }
        function applyEffect(playerID) {
            _playerId = playerID;
            _puffleModel = _SHELL.getPlayerObjectById(playerID).attachedPuffle;
            if (_puffleModel) {
                var _local_3 = _ENGINE.puffleAvatarController.getPuffleAvatar(_puffleModel.id).splashCount;
                if (_local_3 < 1) {
                    _ENGINE.puffleAvatarController.getPuffleAvatar(_puffleModel.id).splashCount = _local_3 + 1;
                    _loader = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(playerID, _puffleModel.id, _SHELL, _ENGINE, true);
                    _onAnimationCompleteDelegate = com.clubpenguin.util.Delegate.create(this, onAnimationCompleted);
                    _loader.addEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, _onAnimationCompleteDelegate);
                    var _local_5 = _puffleModel["color"];
                    var _local_2 = _SHELL.getPath(WATER_ANIMATION_PATH);
                    _local_2 = _puffleModel.getFormattedAssetURL(_local_2);
                    _loader.playPuffleAnimation(_local_2);
                    if (_SHELL.isMyPlayer(_playerId)) {
                        com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.SPLASH_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_STATION);
                    }
                }
            }
        }
        function onAnimationCompleted(event) {
            if (_isShowStatsBarWidget && (_SHELL.isMyPlayer(event.playerID))) {
                var _local_3 = _SHELL.getMyPlayerObject().attachedPuffle.id;
                _global.getCurrentEngine().puffleAvatarController.displayPuffleWidget(_local_3, "statsBarWidget", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_ITEM_ID);
            }
            _SHELL.updateListeners(_SHELL.ROOM_EFFECT_COMPLETE, {playerId:event.playerID, effectType:WATER_SPLASH_EFFECT});
            destroy();
        }
        static var WATER_ANIMATION_PATH = "w.puffle.sprite.splash";
        static var WATER_SPLASH_EFFECT = "waterSplashEffect";
    }
