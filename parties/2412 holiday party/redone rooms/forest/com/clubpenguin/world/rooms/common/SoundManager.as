//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.SoundManager
    {
        var _layersMap, _target, _defaultLayer, _activeSoundsMap, _registeredSymbolNamesMap, _soundLoopsMap, _delayedSoundsMap, _layerNameMap, _nextSoundId, _nextSymbolId, _nextLayerId, _nextDelayedSoundId, _nextLoopId, _frameCounter, _frameCountersToDelete, _sfxHolder;
        function SoundManager (target) {
            _layersMap = new Object();
            _target = target;
            init();
        }
        function init() {
            _defaultLayer = new com.clubpenguin.world.rooms.common.SoundLayer(getLayerId("default"), "default", -1);
            _activeSoundsMap = new Object();
            _registeredSymbolNamesMap = new Object();
            _soundLoopsMap = new Object();
            _delayedSoundsMap = new Object();
            _layerNameMap = new Object();
            _nextSoundId = 0;
            _nextSymbolId = 0;
            _nextLayerId = 0;
            _nextDelayedSoundId = 0;
            _nextLoopId = 0;
            if (_frameCounter != null) {
                _frameCounter.removeMovieClip();
            }
            _frameCounter = _target.createEmptyMovieClip("SoundManager_frameCounter", _target.getNextHighestDepth());
            _frameCounter.onEnterFrame = com.clubpenguin.util.Delegate.create(this, updateFrameCounters);
            _frameCountersToDelete = new Array();
            if (_sfxHolder != null) {
                _sfxHolder.removeMovieClip();
            }
            _sfxHolder = _target.createEmptyMovieClip("SoundManager_sfxHolder", _target.getNextHighestDepth());
        }
        function destroy() {
            for (var loopKey in _soundLoopsMap) {
                var loop = _soundLoopsMap[loopKey];
                stopSoundLoop(loop.loopId);
            }
            for (var delayKey in _delayedSoundsMap) {
                var sound = _delayedSoundsMap[delayKey];
                cancelDelayedSound(sound.delayedSoundId);
            }
            _frameCounter.removeMovieClip();
            _frameCounter = null;
            var sfx = new Sound(_target);
            sfx.setVolume(0);
            _sfxHolder.removeMovieClip();
            _sfxHolder = null;
        }
        function registerSymbolName(symbolName) {
            _nextSymbolId++;
            for (var key in _registeredSymbolNamesMap) {
                if (key == symbolName) {
                }
            }
            _registeredSymbolNamesMap[_nextSymbolId] = symbolName;
            return(_nextSymbolId);
        }
        function getRegisteredSymbolId(symbolName) {
            for (var key in _registeredSymbolNamesMap) {
                if (key == symbolName) {
                    return(Number(key));
                }
            }
            return(null);
        }
        function addLayer(layerName, maxConcurrent) {
            var layerId = getLayerId(layerName);
            if (getLayer(layerId) == null) {
                _layersMap[layerId] = new com.clubpenguin.world.rooms.common.SoundLayer(layerId, layerName, maxConcurrent);
            }
            return(layerId);
        }
        function removeLayer(layerId) {
            var layer = _layersMap[layerId];
            if (layer != null) {
                delete _layerNameMap[layer.name];
                delete _layersMap[layerId];
            }
        }
        function getLayer(layerId) {
            return(_layersMap[layerId]);
        }
        function getLayerId(layerName) {
            if (_layerNameMap[layerName] != null) {
                return(_layerNameMap[layerName]);
            } else {
                _nextLayerId++;
                _layerNameMap[layerName] = _nextLayerId;
                return(_nextLayerId);
            }
        }
        function getSoundId() {
            _nextSoundId++;
            return(_nextSoundId);
        }
        function getDelayedSoundId() {
            _nextDelayedSoundId++;
            return(_nextDelayedSoundId);
        }
        function getSoundLoopId() {
            _nextLoopId++;
            return(_nextLoopId);
        }
        function playSound(symbolId, layerId, volume, tag, callback) {
            if (volume == null) {
                volume = 100;
            }
            var layer = getLayer(layerId);
            if (layer == null) {
                layer = _defaultLayer;
            }
            if (layer.canPlaySound()) {
                var symbolName = _registeredSymbolNamesMap[symbolId];
                if ((symbolName == null) || (_sfxHolder == null)) {
                    return(-1);
                }
                var depth = _sfxHolder.getNextHighestDepth();
                var targetHolder = _sfxHolder.createEmptyMovieClip((("sfx_" + symbolId) + "_") + depth, depth);
                var sfx = new Sound(targetHolder);
                sfx.attachSound(symbolName);
                if (sfx.duration != undefined) {
                    var sound = new Object();
                    var soundId = getSoundId();
                    sound.soundId = soundId;
                    sound.tag = tag;
                    sound.sfx = sfx;
                    sound.layerId = layerId;
                    sound.targetHolder = targetHolder;
                    sound.callback = callback;
                    sound.symbolId = symbolId;
                    sound.layer = layer;
                    _activeSoundsMap[soundId] = sound;
                    layer.numSoundsPlaying++;
                    sfx.onSoundComplete = com.clubpenguin.util.Delegate.create(this, onSoundComplete, sfx, layer, targetHolder, tag, callback);
                    sfx.setVolume(volume);
                    sfx.start(0, 1);
                    return(soundId);
                }
            }
            return(-1);
        }
        function playSoundAfterDelay(symbolId, layerId, frameDelay, volume, tag, callback) {
            if (frameDelay <= 0) {
                return(undefined);
            }
            var delayedSoundId = getDelayedSoundId();
            if (_delayedSoundsMap[delayedSoundId] != null) {
                cancelDelayedSound(delayedSoundId);
            }
            var sound = {};
            sound.delay = frameDelay;
            sound.delayedSoundId = delayedSoundId;
            sound.symbolId = symbolId;
            sound.layerId = layerId;
            sound.callback = callback;
            sound.volume = volume;
            sound.tag = tag;
            _delayedSoundsMap[delayedSoundId] = sound;
            return(delayedSoundId);
        }
        function cancelDelayedSound(delayedSoundId) {
            var sound = _delayedSoundsMap[delayedSoundId];
            if (sound != null) {
                delete _delayedSoundsMap[delayedSoundId];
            }
        }
        function playSoundLoop(symbolIds, layerId, volume, tag) {
            var loopId = getSoundLoopId();
            if (_soundLoopsMap[loopId] != null) {
                stopSoundLoop(loopId);
            }
            var loop = new Object();
            loop.loopId = loopId;
            loop.symbolIds = symbolIds.slice();
            loop.layerId = layerId;
            loop.currentSymbolIndex = -1;
            loop.isActive = true;
            loop.volume = volume;
            loop.tag = tag;
            _soundLoopsMap[loopId] = loop;
            playSoundLoopObject(_soundLoopsMap[loopId]);
            return(loopId);
        }
        function stopSoundLoop(loopId) {
            var loop = _soundLoopsMap[loopId];
            if (loop != null) {
                loop.isActive = false;
                delete _soundLoopsMap[loopId];
            }
        }
        function updateFrameCounters() {
            for (var key in _delayedSoundsMap) {
                var delayedSoundId = Number(key);
                var sound = _delayedSoundsMap[delayedSoundId];
                sound.delay--;
                if (sound.delay <= 0) {
                    playSound(sound.symbolId, sound.layerId, sound.volume, sound.tag, sound.callback);
                    _frameCountersToDelete.push(sound);
                }
            }
            var i = 0;
            while (i < _frameCountersToDelete.length) {
                delete _delayedSoundsMap[_frameCountersToDelete[i].delayedSoundId];
                i++;
            }
            _frameCountersToDelete.length = 0;
        }
        function playSoundLoopObject(loop) {
            loop.currentSymbolIndex++;
            if (loop.currentSymbolIndex >= loop.symbolIds.length) {
                loop.currentSymbolIndex = 0;
            }
            playSound(loop.symbolIds[loop.currentSymbolIndex], loop.layerId, loop.volume, loop.tag, com.clubpenguin.util.Delegate.create(this, soundLoopCallback, loop));
        }
        function soundLoopCallback(loop) {
            if (loop.isActive) {
                playSoundLoopObject(loop);
            }
        }
        function onSoundComplete(sfx, layer, targetHolder, tag, callback) {
            targetHolder.removeMovieClip();
            delete sfx;
            layer.numSoundsPlaying--;
            if (layer.numSoundsPlaying < 0) {
                layer.numSoundsPlaying = 0;
            }
            callback();
        }
        function stopSoundsForTag(tag) {
            for (var soundId in _activeSoundsMap) {
                var sound = _activeSoundsMap[soundId];
                if (sound.tag == tag) {
                    sound.sfx.stop();
                    this.onSoundComplete(sound.sfx, sound.layer, sound.targetHolder, sound.callback);
                    delete _activeSoundsMap[sound.soundId];
                }
            }
            for (var loopId in _soundLoopsMap) {
                var loop = _soundLoopsMap[loopId];
                if (loop.tag == tag) {
                    stopSoundLoop(loop.loopId);
                }
            }
            for (var delayedId in _delayedSoundsMap) {
                var sound = _delayedSoundsMap[delayedId];
                if (sound.tag == tag) {
                    cancelDelayedSound(sound.delayedSoundId);
                }
            }
        }
    }
