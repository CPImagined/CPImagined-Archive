
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.SoundManager
    {
        var _layersMap, _target, _defaultLayer, _activeSoundsMap, _registeredSymbolNamesMap, _soundLoopsMap, _delayedSoundsMap, _layerNameMap, _nextSoundId, _nextSymbolId, _nextLayerId, _nextDelayedSoundId, _nextLoopId, _frameCounter, _frameCountersToDelete, _sfxHolder;
        function SoundManager (_arg_2) {
            _layersMap = new Object();
            _target = _arg_2;
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
        function registerSymbolName(_arg_2) {
            _nextSymbolId++;
            for (var _local_3 in _registeredSymbolNamesMap) {
                if (_local_3 == _arg_2) {
                }
            }
            _registeredSymbolNamesMap[_nextSymbolId] = _arg_2;
            return(_nextSymbolId);
        }
        function getRegisteredSymbolId(_arg_3) {
            for (var _local_2 in _registeredSymbolNamesMap) {
                if (_local_2 == _arg_3) {
                    return(Number(_local_2));
                }
            }
            return(null);
        }
        function addLayer(_arg_3, _arg_4) {
            var _local_2 = getLayerId(_arg_3);
            if (getLayer(_local_2) == null) {
                _layersMap[_local_2] = new com.clubpenguin.world.rooms.common.SoundLayer(_local_2, _arg_3, _arg_4);
            }
            return(_local_2);
        }
        function removeLayer(_arg_3) {
            var _local_2 = _layersMap[_arg_3];
            if (_local_2 != null) {
                delete _layerNameMap[_local_2.name];
                delete _layersMap[_arg_3];
            }
        }
        function getLayer(_arg_2) {
            return(_layersMap[_arg_2]);
        }
        function getLayerId(_arg_2) {
            if (_layerNameMap[_arg_2] != null) {
                return(_layerNameMap[_arg_2]);
            } else {
                _nextLayerId++;
                _layerNameMap[_arg_2] = _nextLayerId;
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
        function playSound(_arg_9, _arg_13, _arg_10, _arg_12, _arg_11) {
            if (_arg_10 == null) {
                _arg_10 = 100;
            }
            var _local_4 = getLayer(_arg_13);
            if (_local_4 == null) {
                _local_4 = _defaultLayer;
            }
            if (_local_4.canPlaySound()) {
                var _local_7 = _registeredSymbolNamesMap[_arg_9];
                if ((_local_7 == null) || (_sfxHolder == null)) {
                    return(-1);
                }
                var _local_8 = _sfxHolder.getNextHighestDepth();
                var _local_5 = _sfxHolder.createEmptyMovieClip((("sfx_" + _arg_9) + "_") + _local_8, _local_8);
                var _local_3 = new Sound(_local_5);
                _local_3.attachSound(_local_7);
                if (_local_3.duration != undefined) {
                    var _local_2 = new Object();
                    var _local_6 = getSoundId();
                    _local_2.soundId = _local_6;
                    _local_2.tag = _arg_12;
                    _local_2.sfx = _local_3;
                    _local_2.layerId = _arg_13;
                    _local_2.targetHolder = _local_5;
                    _local_2.callback = _arg_11;
                    _local_2.symbolId = _arg_9;
                    _local_2.layer = _local_4;
                    _activeSoundsMap[_local_6] = _local_2;
                    _local_4.numSoundsPlaying++;
                    _local_3.onSoundComplete = com.clubpenguin.util.Delegate.create(this, onSoundComplete, _local_3, _local_4, _local_5, _arg_12, _arg_11);
                    _local_3.setVolume(_arg_10);
                    _local_3.start(0, 1);
                    return(_local_6);
                }
            }
            return(-1);
        }
        function playSoundAfterDelay(_arg_7, _arg_8, _arg_4, _arg_9, _arg_6, _arg_5) {
            if (_arg_4 <= 0) {
                return(undefined);
            }
            var _local_3 = getDelayedSoundId();
            if (_delayedSoundsMap[_local_3] != null) {
                cancelDelayedSound(_local_3);
            }
            var _local_2 = {};
            _local_2.delay = _arg_4;
            _local_2.delayedSoundId = _local_3;
            _local_2.symbolId = _arg_7;
            _local_2.layerId = _arg_8;
            _local_2.callback = _arg_5;
            _local_2.volume = _arg_9;
            _local_2.tag = _arg_6;
            _delayedSoundsMap[_local_3] = _local_2;
            return(_local_3);
        }
        function cancelDelayedSound(_arg_3) {
            var _local_2 = _delayedSoundsMap[_arg_3];
            if (_local_2 != null) {
                delete _delayedSoundsMap[_arg_3];
            }
        }
        function playSoundLoop(_arg_5, _arg_6, _arg_7, _arg_4) {
            var _local_3 = getSoundLoopId();
            if (_soundLoopsMap[_local_3] != null) {
                stopSoundLoop(_local_3);
            }
            var _local_2 = new Object();
            _local_2.loopId = _local_3;
            _local_2.symbolIds = _arg_5.slice();
            _local_2.layerId = _arg_6;
            _local_2.currentSymbolIndex = -1;
            _local_2.isActive = true;
            _local_2.volume = _arg_7;
            _local_2.tag = _arg_4;
            _soundLoopsMap[_local_3] = _local_2;
            playSoundLoopObject(_soundLoopsMap[_local_3]);
            return(_local_3);
        }
        function stopSoundLoop(_arg_3) {
            var _local_2 = _soundLoopsMap[_arg_3];
            if (_local_2 != null) {
                _local_2.isActive = false;
                delete _soundLoopsMap[_arg_3];
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
        function playSoundLoopObject(_arg_2) {
            _arg_2.currentSymbolIndex++;
            if (_arg_2.currentSymbolIndex >= _arg_2.symbolIds.length) {
                _arg_2.currentSymbolIndex = 0;
            }
            playSound(_arg_2.symbolIds[_arg_2.currentSymbolIndex], _arg_2.layerId, _arg_2.volume, _arg_2.tag, com.clubpenguin.util.Delegate.create(this, soundLoopCallback, _arg_2));
        }
        function soundLoopCallback(_arg_2) {
            if (_arg_2.isActive) {
                playSoundLoopObject(_arg_2);
            }
        }
        function onSoundComplete(_arg_4, _arg_1, _arg_3, tag, _arg_2) {
            _arg_3.removeMovieClip();
            _arg_1.numSoundsPlaying--;
            if (_arg_1.numSoundsPlaying < 0) {
                _arg_1.numSoundsPlaying = 0;
            }
            _arg_2();
        }
        function stopSoundsForTag(_arg_4) {
            for (var _local_6 in _activeSoundsMap) {
                var _local_3 = _activeSoundsMap[_local_6];
                if (_local_3.tag == _arg_4) {
                    _local_3.sfx.stop();
                    this.onSoundComplete(_local_3.sfx, _local_3.layer, _local_3.targetHolder, _local_3.callback);
                    delete _activeSoundsMap[_local_3.soundId];
                }
            }
            for (var _local_7 in _soundLoopsMap) {
                var _local_2 = _soundLoopsMap[_local_7];
                if (_local_2.tag == _arg_4) {
                    stopSoundLoop(_local_2.loopId);
                }
            }
            for (var _local_5 in _delayedSoundsMap) {
                var _local_3 = _delayedSoundsMap[_local_5];
                if (_local_3.tag == _arg_4) {
                    cancelDelayedSound(_local_3.delayedSoundId);
                }
            }
        }
    }
