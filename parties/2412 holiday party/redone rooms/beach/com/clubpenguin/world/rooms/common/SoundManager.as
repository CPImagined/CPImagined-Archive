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
            for (var _local_5 in _soundLoopsMap) {
                var _local_2 = _soundLoopsMap[_local_5];
                stopSoundLoop(_local_2.loopId);
            }
            for (var _local_4 in _delayedSoundsMap) {
                var _local_3 = _delayedSoundsMap[_local_4];
                cancelDelayedSound(_local_3.delayedSoundId);
            }
            _frameCounter.removeMovieClip();
            _frameCounter = null;
            var _local_6 = new Sound(_target);
            _local_6.setVolume(0);
            _sfxHolder.removeMovieClip();
            _sfxHolder = null;
        }
        function registerSymbolName(symbolName) {
            _nextSymbolId++;
            for (var _local_3 in _registeredSymbolNamesMap) {
                if (_local_3 == symbolName) {
                    trace(("WARNING '" + symbolName) + "' has already been registered. A new ID for the duplicate name will be returned.");
                }
            }
            _registeredSymbolNamesMap[_nextSymbolId] = symbolName;
            return(_nextSymbolId);
        }
        function getRegisteredSymbolId(symbolName) {
            for (var _local_2 in _registeredSymbolNamesMap) {
                if (_local_2 == symbolName) {
                    return(Number(_local_2));
                }
            }
            return(null);
        }
        function addLayer(layerName, maxConcurrent) {
            var _local_2 = getLayerId(layerName);
            if (getLayer(_local_2) == null) {
                _layersMap[_local_2] = new com.clubpenguin.world.rooms.common.SoundLayer(_local_2, layerName, maxConcurrent);
            }
            return(_local_2);
        }
        function removeLayer(layerId) {
            var _local_2 = _layersMap[layerId];
            if (_local_2 != null) {
                delete _layerNameMap[_local_2.name];
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
            var _local_4 = getLayer(layerId);
            if (_local_4 == null) {
                _local_4 = _defaultLayer;
            }
            if (_local_4.canPlaySound()) {
                var _local_7 = _registeredSymbolNamesMap[symbolId];
                if ((_local_7 == null) || (_sfxHolder == null)) {
                    return(-1);
                }
                var _local_8 = _sfxHolder.getNextHighestDepth();
                var _local_5 = _sfxHolder.createEmptyMovieClip((("sfx_" + symbolId) + "_") + _local_8, _local_8);
                var _local_3 = new Sound(_local_5);
                _local_3.attachSound(_local_7);
                if (_local_3.duration != undefined) {
                    var _local_2 = new Object();
                    var _local_6 = getSoundId();
                    _local_2.soundId = _local_6;
                    _local_2.tag = tag;
                    _local_2.sfx = _local_3;
                    _local_2.layerId = layerId;
                    _local_2.targetHolder = _local_5;
                    _local_2.callback = callback;
                    _local_2.symbolId = symbolId;
                    _local_2.layer = _local_4;
                    _activeSoundsMap[_local_6] = _local_2;
                    _local_4.numSoundsPlaying++;
                    _local_3.onSoundComplete = com.clubpenguin.util.Delegate.create(this, onSoundComplete, _local_3, _local_4, _local_5, tag, callback);
                    _local_3.setVolume(volume);
                    _local_3.start(0, 1);
                    return(_local_6);
                }
            }
            return(-1);
        }
        function playSoundAfterDelay(symbolId, layerId, frameDelay, volume, tag, callback) {
            if (frameDelay <= 0) {
                return(undefined);
            }
            var _local_3 = getDelayedSoundId();
            if (_delayedSoundsMap[_local_3] != null) {
                cancelDelayedSound(_local_3);
            }
            var _local_2 = {};
            _local_2.delay = frameDelay;
            _local_2.delayedSoundId = _local_3;
            _local_2.symbolId = symbolId;
            _local_2.layerId = layerId;
            _local_2.callback = callback;
            _local_2.volume = volume;
            _local_2.tag = tag;
            _delayedSoundsMap[_local_3] = _local_2;
            return(_local_3);
        }
        function cancelDelayedSound(delayedSoundId) {
            var _local_2 = _delayedSoundsMap[delayedSoundId];
            if (_local_2 != null) {
                delete _delayedSoundsMap[delayedSoundId];
            }
        }
        function playSoundLoop(symbolIds, layerId, volume, tag) {
            var _local_3 = getSoundLoopId();
            if (_soundLoopsMap[_local_3] != null) {
                stopSoundLoop(_local_3);
            }
            var _local_2 = new Object();
            _local_2.loopId = _local_3;
            _local_2.symbolIds = symbolIds.slice();
            _local_2.layerId = layerId;
            _local_2.currentSymbolIndex = -1;
            _local_2.isActive = true;
            _local_2.volume = volume;
            _local_2.tag = tag;
            _soundLoopsMap[_local_3] = _local_2;
            playSoundLoopObject(_soundLoopsMap[_local_3]);
            return(_local_3);
        }
        function stopSoundLoop(loopId) {
            var _local_2 = _soundLoopsMap[loopId];
            if (_local_2 != null) {
                _local_2.isActive = false;
                delete _soundLoopsMap[loopId];
            }
        }
        function updateFrameCounters() {
            for (var _local_5 in _delayedSoundsMap) {
                var _local_4 = Number(_local_5);
                var _local_2 = _delayedSoundsMap[_local_4];
                _local_2.delay--;
                if (_local_2.delay <= 0) {
                    playSound(_local_2.symbolId, _local_2.layerId, _local_2.volume, _local_2.tag, _local_2.callback);
                    _frameCountersToDelete.push(_local_2);
                }
            }
            var _local_3 = 0;
            while (_local_3 < _frameCountersToDelete.length) {
                delete _delayedSoundsMap[_frameCountersToDelete[_local_3].delayedSoundId];
                _local_3++;
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
            layer.numSoundsPlaying--;
            if (layer.numSoundsPlaying < 0) {
                layer.numSoundsPlaying = 0;
            }
            callback();
        }
        function stopSoundsForTag(tag) {
            for (var _local_6 in _activeSoundsMap) {
                var _local_3 = _activeSoundsMap[_local_6];
                if (_local_3.tag == tag) {
                    _local_3.sfx.stop();
                    this.onSoundComplete(_local_3.sfx, _local_3.layer, _local_3.targetHolder, _local_3.callback);
                    delete _activeSoundsMap[_local_3.soundId];
                }
            }
            for (var _local_7 in _soundLoopsMap) {
                var _local_2 = _soundLoopsMap[_local_7];
                if (_local_2.tag == tag) {
                    stopSoundLoop(_local_2.loopId);
                }
            }
            for (var _local_5 in _delayedSoundsMap) {
                var _local_3 = _delayedSoundsMap[_local_5];
                if (_local_3.tag == tag) {
                    cancelDelayedSound(_local_3.delayedSoundId);
                }
            }
        }
    }
