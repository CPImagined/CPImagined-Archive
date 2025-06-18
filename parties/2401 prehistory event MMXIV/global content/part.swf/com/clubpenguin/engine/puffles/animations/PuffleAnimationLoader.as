
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader extends mx.events.EventDispatcher
    {
        var _SHELL, _ENGINE, _playerMC, _puffleMC, _playerID, _puffleID, _usesEvent, dispatchEvent;
        function PuffleAnimationLoader (_arg_4, _arg_3, _arg_6, _arg_5, _arg_7) {
            super();
            _SHELL = _arg_6;
            _ENGINE = _arg_5;
            _playerMC = _ENGINE.getPlayerMovieClip(_arg_4);
            _puffleMC = _ENGINE.puffleManager.getPuffleByID(_arg_3).clip;
            _playerID = _arg_4;
            _puffleID = _arg_3;
            _usesEvent = _arg_7;
        }
        function playPuffleAnimation(_arg_5, _arg_6) {
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, cleanup, this);
            var _local_4 = _ENGINE.puffleAvatarController.getPuffleClip(_puffleID);
            var _local_2 = _ENGINE.getRoomMovieClip().createEmptyMovieClip("puffleAnimationClip" + _puffleID, _local_4.getDepth() + 1);
            _local_2._x = _playerMC._x;
            _local_2._y = _playerMC._y;
            _local_2._xscale = _playerMC._xscale;
            _local_2._yscale = _playerMC._yscale;
            _local_2._visible = false;
            if (_arg_6 && (_puffleMC)) {
                _local_2._x = _puffleMC._x;
                _local_2._y = _puffleMC._y;
            }
            var _local_3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _local_3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onAnimationLoaded, _local_2));
            _local_3.loadClip(_arg_5, _local_2, "PuffleAnimationLoader playPuffleAnimation()");
        }
        function onAnimationLoaded(event, puffleAnimationClip) {
            com.clubpenguin.util.Log.debug("PuffleAnimationLoader onAnimationLoaded()");
            _ENGINE.puffleAvatarController.hidePuffle(_puffleID);
            puffleAnimationClip._visible = true;
            var scope = this;
            puffleAnimationClip.onEnterFrame = function () {
                if (puffleAnimationClip.puffle._currentframe >= puffleAnimationClip.puffle._totalframes) {
                    scope.onAnimationFinished(puffleAnimationClip);
                }
            };
        }
        function onAnimationFinished(_arg_2) {
            if (_usesEvent) {
                dispatchEvent({target:this, type:PUFFLE_ANIMATION_EVENT, playerID:_playerID, puffleID:_puffleID});
            }
            _arg_2.onEnterFrame = null;
            _arg_2.removeMovieClip();
            cleanup();
        }
        function cleanup() {
            com.clubpenguin.util.Log.debug("PuffleAnimationLoader cleanup()");
            _ENGINE.puffleAvatarController.showPuffle(_puffleID);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, onAnimationFinished);
        }
        static var PUFFLE_ANIMATION_EVENT = "puffleAnimation";
    }
