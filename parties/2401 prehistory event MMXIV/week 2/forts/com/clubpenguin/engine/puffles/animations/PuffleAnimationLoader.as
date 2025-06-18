//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader extends mx.events.EventDispatcher
    {
        var _SHELL, _ENGINE, _playerMC, _puffleMC, _playerID, _puffleID, _usesEvent, _puffleAnimationClip, dispatchEvent;
        function PuffleAnimationLoader (playerID, puffleID, shell_mc, engine_mc, usesEvent) {
            super();
            _SHELL = shell_mc;
            _ENGINE = engine_mc;
            _playerMC = _ENGINE.getPlayerMovieClip(playerID);
            _puffleMC = _ENGINE.puffleManager.getPuffleByID(puffleID).clip;
            _playerID = playerID;
            _puffleID = puffleID;
            _usesEvent = usesEvent;
        }
        function playPuffleAnimation(animationURL, overPuffle) {
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, cleanup, this);
            var _local_3 = _ENGINE.puffleAvatarController.getPuffleClip(_puffleID);
            _puffleAnimationClip = _ENGINE.getRoomMovieClip().createEmptyMovieClip("puffleAnimationClip" + _puffleID, _local_3.getDepth() + com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_CLIP_DEPTH_PADDING);
            _puffleAnimationClip._x = _playerMC._x;
            _puffleAnimationClip._y = _playerMC._y;
            _puffleAnimationClip._xscale = _playerMC._xscale;
            _puffleAnimationClip._yscale = _playerMC._yscale;
            _puffleAnimationClip._visible = false;
            if (overPuffle && (_puffleMC)) {
                _puffleAnimationClip._x = _puffleMC._x;
                _puffleAnimationClip._y = _puffleMC._y;
            }
            var _local_2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _local_2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onAnimationLoaded));
            _local_2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onAnimationLoadError));
            _local_2.loadClip(animationURL, _puffleAnimationClip, "PuffleAnimationLoader playPuffleAnimation()");
        }
        function onAnimationLoaded(event) {
            com.clubpenguin.util.Log.debug("PuffleAnimationLoader onAnimationLoaded()");
            dispatchEvent({target:this, type:PUFFLE_ANIMATION_LOADED_EVENT, playerID:_playerID, puffleID:_puffleID});
            _ENGINE.puffleAvatarController.hidePuffle(_puffleID);
            _puffleAnimationClip._visible = true;
            var scope = this;
            _puffleAnimationClip.onEnterFrame = function () {
                if (scope._puffleAnimationClip.puffle._currentframe >= scope._puffleAnimationClip.puffle._totalframes) {
                    scope.onAnimationFinished();
                }
            };
        }
        function onAnimationLoadError(event) {
            com.clubpenguin.util.Log.debug("PuffleAnimationLoader onAnimationLoadError()");
            _puffleAnimationClip.removeMovieClip();
            cleanup();
        }
        function onAnimationFinished() {
            com.clubpenguin.util.Log.debug("PuffleAnimationLoader onAnimationFinished()");
            _puffleAnimationClip.onEnterFrame = null;
            _puffleAnimationClip.removeMovieClip();
            cleanup();
        }
        function cleanup() {
            com.clubpenguin.util.Log.debug("PuffleAnimationLoader cleanup()");
            if (_usesEvent) {
                dispatchEvent({target:this, type:PUFFLE_ANIMATION_EVENT, playerID:_playerID, puffleID:_puffleID});
            }
            _ENGINE.puffleAvatarController.showPuffle(_puffleID);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, cleanup, this);
        }
        function cancelAndRemoveAnimation() {
            com.clubpenguin.util.Log.debug("PuffleAnimationLoader cancelAndRemoveAnimation()");
            onAnimationFinished();
        }
        static var PUFFLE_ANIMATION_EVENT = "puffleAnimation";
        static var PUFFLE_ANIMATION_LOADED_EVENT = "puffleAnimationLoaded";
    }
