//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader extends mx.events.EventDispatcher
    {
        var _SHELL, _ENGINE, _playerMC, _playerID, _puffleID, _usesEvent, dispatchEvent;
        function PuffleAnimationLoader (playerID, puffleID, shell_mc, engine_mc, usesEvent) {
            super();
            _SHELL = shell_mc;
            _ENGINE = engine_mc;
            _playerMC = _ENGINE.getPlayerMovieClip(playerID);
            _playerID = playerID;
            _puffleID = puffleID;
            _usesEvent = usesEvent;
        }
        function playPuffleAnimation(animationURL) {
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, cleanup, this);
            var _local_4 = _ENGINE.puffleAvatarController.getPuffleClip(_puffleID);
            var _local_2 = _ENGINE.getRoomMovieClip().createEmptyMovieClip("puffleAnimationClip" + _puffleID, _local_4.getDepth() + 1);
            _local_2._x = _playerMC._x;
            _local_2._y = _playerMC._y;
            _local_2._xscale = _playerMC._xscale;
            _local_2._yscale = _playerMC._yscale;
            _local_2._visible = false;
            var _local_3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _local_3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onAnimationLoaded, _local_2));
            _local_3.loadClip(animationURL, _local_2, "PuffleAnimationLoader playPuffleAnimation()");
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
        function onAnimationFinished(puffleAnimationClip) {
            if (_usesEvent) {
                dispatchEvent({target:this, type:PUFFLE_ANIMATION_EVENT, playerID:_playerID, puffleID:_puffleID});
            }
            puffleAnimationClip.onEnterFrame = null;
            puffleAnimationClip.removeMovieClip();
            cleanup();
        }
        function cleanup() {
            com.clubpenguin.util.Log.debug("PuffleAnimationLoader cleanup()");
            _ENGINE.puffleAvatarController.showPuffle(_puffleID);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, onAnimationFinished);
        }
        static var PUFFLE_ANIMATION_EVENT = "puffleAnimation";
    }
