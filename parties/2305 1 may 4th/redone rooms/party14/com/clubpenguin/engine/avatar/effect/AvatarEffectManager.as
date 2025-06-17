//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.avatar.effect.AvatarEffectManager
    {
        var _SHELL, _ENGINE, effectsLoaded, _numLoadedEffectLibs;
        function AvatarEffectManager () {
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            effectsLoaded = new org.osflash.signals.Signal();
        }
        function createEffectInstance(effect, name, depth) {
            var _local_5 = _ENGINE.getRoomMovieClip();
            var _local_2 = _local_5[effect.swfName];
            if (_local_2 != null) {
                if (depth == undefined) {
                    depth = _local_2.getNextHighestDepth();
                }
                if (name == undefined) {
                    name = (effect.symbolName + "_") + depth;
                }
                return(_local_2.attachMovie(effect.symbolName, name, depth));
            }
            return(null);
        }
        function playEffectForPlayer(effect, player) {
            var _local_2 = createEffectInstance(effect);
            if (_local_2 != null) {
                var player_mc = _ENGINE.getPlayerMovieClip(player.player_id);
                _local_2._visible = true;
                _local_2._x = player_mc._x;
                _local_2._y = player_mc._y;
                _local_2.onEnterFrame = function () {
                    if ((!effect.loopAnimation) && (this._currentFrame == this._totalFrames)) {
                        if (effect.stopOnLastFrame) {
                            this.stop();
                        } else {
                            this.removeMovieClip();
                        }
                    }
                    if (effect.attachToPlayer && (this.overrideAttachToPlayer != true)) {
                        this._x = player_mc._x;
                        this._y = player_mc._y;
                    }
                };
            }
            return(_local_2);
        }
        function playEffectAtLocation(effect, xLocation, yLocation) {
            var _local_2 = playEffectForPlayer(effect);
            _local_2.overrideAttachToPlayer = true;
            if (_local_2 != null) {
                _local_2._x = xLocation;
                _local_2._y = yLocation;
            }
            return(_local_2);
        }
        function loadEffectLibs(room_mc) {
            _numLoadedEffectLibs = 0;
            var _local_10 = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.EFFECT_LIBS;
            var _local_4 = 0;
            while (_local_4 < _local_10.length) {
                var _local_3 = _local_4;
                var _local_2 = _local_10[_local_3];
                if (room_mc[_local_2.swfName] != null) {
                } else {
                    var _local_9;
                    var _local_7 = ((_local_2.depth != null) ? (_local_2.depth) : (room_mc.getNextHighestDepth()));
                    _local_9 = room_mc.createEmptyMovieClip(_local_2.swfName, _local_7);
                    var _local_8 = ((_SHELL.getGlobalContentPath() + "rooms/effects/") + _local_2.swfName) + ".swf";
                    var _local_5 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
                    _local_5.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, handleEffectLibLoaded, _local_3));
                    _local_5.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, handleEffectLibLoaded), _local_3);
                    _local_5.loadClip(_local_8, _local_9, "AvatarManager loadAnimations() " + _local_2.swfName);
                }
                _local_4++;
            }
        }
        function handleEffectLibLoaded(event, effectIndex) {
            _numLoadedEffectLibs = _numLoadedEffectLibs + 1;
            if (_numLoadedEffectLibs >= com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.EFFECT_LIBS.length) {
                effectsLoaded.dispatch();
            }
        }
    }
