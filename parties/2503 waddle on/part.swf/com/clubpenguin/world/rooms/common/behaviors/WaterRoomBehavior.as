
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.behaviors.WaterRoomBehavior extends com.clubpenguin.world.rooms.common.behaviors.RoomBehavior implements com.clubpenguin.world.rooms.common.behaviors.IRoomBehavior
    {
        var _SHELL, _ENGINE, _playerId, _puffleModel;
        function WaterRoomBehavior () {
            super();
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
        }
        function applyEffect(_arg_5) {
            _playerId = _arg_5;
            _puffleModel = _SHELL.getPlayerObjectById(_arg_5).attachedPuffle;
            if (_puffleModel) {
                var _local_3 = _ENGINE.puffleAvatarController.getPuffleAvatar(_puffleModel.id).splashCount;
                if (_local_3 < 1) {
                    _ENGINE.puffleAvatarController.getPuffleAvatar(_puffleModel.id).splashCount = _local_3 + 1;
                    var _local_4 = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(_arg_5, _puffleModel.id, _SHELL, _ENGINE, true);
                    _local_4.addEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, com.clubpenguin.util.Delegate.create(this, onAnimationCompleted));
                    var _local_6 = _puffleModel["color"];
                    var _local_2 = _SHELL.getPath(WATER_ANIMATION_PATH);
                    _local_2 = _puffleModel.getFormattedAssetURL(_local_2);
                    _local_4.playPuffleAnimation(_local_2);
                    if (_SHELL.isMyPlayer(_playerId)) {
                        com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.SPLASH_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_STATION);
                    }
                }
            }
        }
        function onAnimationCompleted(_arg_4) {
            if (_SHELL.isMyPlayer(_arg_4.playerID)) {
                var _local_3 = _SHELL.getMyPlayerObject().attachedPuffle.id;
                _global.getCurrentEngine().puffleAvatarController.displayPuffleWidget(_local_3, "statsBarWidget", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_ITEM_ID);
            }
            _SHELL.updateListeners(_SHELL.ROOM_EFFECT_COMPLETE, {playerId:_arg_4.playerID, effectType:WATER_SPLASH_EFFECT});
        }
        static var WATER_ANIMATION_PATH = "w.puffle.sprite.splash";
        static var WATER_SPLASH_EFFECT = "waterSplashEffect";
    }
