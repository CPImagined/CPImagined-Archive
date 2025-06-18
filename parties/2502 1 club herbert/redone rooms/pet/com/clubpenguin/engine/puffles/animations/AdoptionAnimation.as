//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.animations.AdoptionAnimation
    {
        var _SHELL, _ENGINE, loader;
        function AdoptionAnimation (_arg_3, _arg_2) {
            _SHELL = _arg_3;
            _ENGINE = _arg_2;
        }
        function playAnimation(_arg_4) {
            var _local_3 = _SHELL.getPlayerObjectById(_arg_4).attachedPuffle;
            if (_local_3) {
                loader = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(_arg_4, _local_3.id, _SHELL, _ENGINE, true);
                var _local_2 = _SHELL.getPath(ASSET_PATH);
                _local_2 = _local_3.getFormattedAssetURL(_local_2);
                loader.addEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, com.clubpenguin.util.Delegate.create(this, onAnimationComplete));
                _SHELL.addListener(_SHELL.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, onAnimationComplete));
                _ENGINE.disableMouseMovement();
                loader.playPuffleAnimation(_local_2);
            }
        }
        function onAnimationComplete() {
            loader.removeEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, com.clubpenguin.util.Delegate.create(this, onAnimationComplete));
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, onAnimationComplete));
            _ENGINE.enableMouseMovement();
        }
        static var ASSET_PATH = "w.puffle.sprite.adopt";
    }
