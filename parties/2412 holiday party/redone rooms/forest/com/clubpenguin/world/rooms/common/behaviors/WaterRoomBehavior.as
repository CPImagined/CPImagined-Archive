﻿//Created by Action Script Viewer - https://www.buraks.com/asv
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
                var splashCount = _ENGINE.puffleAvatarController.getPuffleAvatar(_puffleModel.id).splashCount;
                if (splashCount < 1) {
                    _ENGINE.puffleAvatarController.getPuffleAvatar(_puffleModel.id).splashCount = splashCount + 1;
                    _loader = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(playerID, _puffleModel.id, _SHELL, _ENGINE, true);
                    _onAnimationCompleteDelegate = com.clubpenguin.util.Delegate.create(this, onAnimationCompleted);
                    _loader.addEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, _onAnimationCompleteDelegate);
                    var puffleColor = _puffleModel["color"];
                    var splashAnimationURL = _SHELL.getPath(WATER_ANIMATION_PATH);
                    splashAnimationURL = _puffleModel.getFormattedAssetURL(splashAnimationURL);
                    _loader.playPuffleAnimation(splashAnimationURL);
                    if (_SHELL.isMyPlayer(_playerId)) {
                        com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.SPLASH_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_STATION);
                    }
                }
            }
        }
        function onAnimationCompleted(event) {
            if (_isShowStatsBarWidget && (_SHELL.isMyPlayer(event.playerID))) {
                var puffleId = _SHELL.getMyPlayerObject().attachedPuffle.id;
                _global.getCurrentEngine().puffleAvatarController.displayPuffleWidget(puffleId, "statsBarWidget", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_ITEM_ID);
            }
            _SHELL.updateListeners(_SHELL.ROOM_EFFECT_COMPLETE, {playerId:event.playerID, effectType:WATER_SPLASH_EFFECT});
            destroy();
        }
        static var WATER_ANIMATION_PATH = "w.puffle.sprite.splash";
        static var WATER_SPLASH_EFFECT = "waterSplashEffect";
    }
