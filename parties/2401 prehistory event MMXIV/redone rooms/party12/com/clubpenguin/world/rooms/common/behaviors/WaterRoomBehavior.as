//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.behaviors.WaterRoomBehavior extends com.clubpenguin.world.rooms.common.behaviors.RoomBehavior implements com.clubpenguin.world.rooms.common.behaviors.IRoomBehavior
    {
        var _SHELL, _ENGINE;
        function WaterRoomBehavior () {
            super();
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
        }
        function applyEffect(playerID) {
            var _local_3 = _SHELL.getPlayerObjectById(playerID).attachedPuffle;
            if (_local_3) {
                var _local_4 = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(playerID, _local_3.id, _SHELL, _ENGINE, true);
                _local_4.addEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, com.clubpenguin.util.Delegate.create(this, onAnimationCompleted));
                var _local_5 = _local_3["color"];
                var _local_2 = _SHELL.getPath(WATER_ANIMATION_PATH);
                _local_2 = com.clubpenguin.util.StringUtils.replaceString("%color%", _local_5, _local_2);
                _local_4.playPuffleAnimation(_local_2);
            }
        }
        function onAnimationCompleted(event) {
            if (_SHELL.isMyPlayer(event.playerID)) {
                var _local_3 = _SHELL.getMyPlayerObject().attachedPuffle.id;
                _global.getCurrentEngine().puffleAvatarController.displayPuffleWidget(_local_3, "statsBarWidget", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_ITEM_ID);
            }
            _SHELL.updateListeners(_SHELL.ROOM_EFFECT_COMPLETE, {playerId:event.playerID, effectType:WATER_SPLASH_EFFECT});
        }
        static var WATER_ANIMATION_PATH = "w.puffle.sprite.splash";
        static var WATER_SPLASH_EFFECT = "waterSplashEffect";
    }
