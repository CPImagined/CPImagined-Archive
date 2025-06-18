dynamic class com.clubpenguin.world.rooms.common.SoundManager
{
    var _activeSoundsMap;
    var _defaultLayer;
    var _delayedSoundsMap;
    var _frameCounter;
    var _frameCountersToDelete;
    var _layerNameMap;
    var _layersMap;
    var _nextDelayedSoundId;
    var _nextLayerId;
    var _nextLoopId;
    var _nextSoundId;
    var _nextSymbolId;
    var _registeredSymbolNamesMap;
    var _sfxHolder;
    var _soundLoopsMap;
    var _target;

    function SoundManager(target)
    {
        this._layersMap = new Object();
        this._target = target;
        this.init();
    }

    function init()
    {
        this._defaultLayer = new com.clubpenguin.world.rooms.common.SoundLayer(this.getLayerId("default"), "default", -1);
        this._activeSoundsMap = new Object();
        this._registeredSymbolNamesMap = new Object();
        this._soundLoopsMap = new Object();
        this._delayedSoundsMap = new Object();
        this._layerNameMap = new Object();
        this._nextSoundId = 0;
        this._nextSymbolId = 0;
        this._nextLayerId = 0;
        this._nextDelayedSoundId = 0;
        this._nextLoopId = 0;
        if (this._frameCounter != null) 
        {
            this._frameCounter.removeMovieClip();
        }
        this._frameCounter = this._target.createEmptyMovieClip("SoundManager_frameCounter", this._target.getNextHighestDepth());
        this._frameCounter.onEnterFrame = com.clubpenguin.util.Delegate.create(this, this.updateFrameCounters);
        this._frameCountersToDelete = new Array();
        if (this._sfxHolder != null) 
        {
            this._sfxHolder.removeMovieClip();
        }
        this._sfxHolder = this._target.createEmptyMovieClip("SoundManager_sfxHolder", this._target.getNextHighestDepth());
    }

    function destroy()
    {
        for (var __reg5 in this._soundLoopsMap) 
        {
            var __reg2 = this._soundLoopsMap[__reg5];
            this.stopSoundLoop(__reg2.loopId);
        }
        for (var __reg4 in this._delayedSoundsMap) 
        {
            var __reg3 = this._delayedSoundsMap[__reg4];
            this.cancelDelayedSound(__reg3.delayedSoundId);
        }
        this._frameCounter.removeMovieClip();
        this._frameCounter = null;
        var __reg6 = new Sound(this._target);
        __reg6.setVolume(0);
        this._sfxHolder.removeMovieClip();
        this._sfxHolder = null;
    }

    function registerSymbolName(symbolName)
    {
        ++this._nextSymbolId;
        for (var __reg3 in this._registeredSymbolNamesMap) 
        {
            __reg3 != symbolName;
        }
        this._registeredSymbolNamesMap[this._nextSymbolId] = symbolName;
        return this._nextSymbolId;
    }

    function getRegisteredSymbolId(symbolName)
    {
        for (var __reg2 in this._registeredSymbolNamesMap) 
        {
            if (__reg2 == symbolName) 
            {
                do 
                {
                }
                while (undefined != null);
                return Number(__reg2);
            }
        }
        return null;
    }

    function addLayer(layerName, maxConcurrent)
    {
        var __reg2 = this.getLayerId(layerName);
        if (this.getLayer(__reg2) == null) 
        {
            this._layersMap[__reg2] = new com.clubpenguin.world.rooms.common.SoundLayer(__reg2, layerName, maxConcurrent);
        }
        return __reg2;
    }

    function removeLayer(layerId)
    {
        var __reg2 = this._layersMap[layerId];
        if (__reg2 != null) 
        {
            delete this._layerNameMap[__reg2.name];
            delete this._layersMap[layerId];
        }
    }

    function getLayer(layerId)
    {
        return this._layersMap[layerId];
    }

    function getLayerId(layerName)
    {
        if (this._layerNameMap[layerName] != null) 
        {
            return this._layerNameMap[layerName];
        }
        ++this._nextLayerId;
        this._layerNameMap[layerName] = this._nextLayerId;
        return this._nextLayerId;
    }

    function getSoundId()
    {
        ++this._nextSoundId;
        return this._nextSoundId;
    }

    function getDelayedSoundId()
    {
        ++this._nextDelayedSoundId;
        return this._nextDelayedSoundId;
    }

    function getSoundLoopId()
    {
        ++this._nextLoopId;
        return this._nextLoopId;
    }

    function playSound(symbolId, layerId, volume, tag, callback)
    {
        if (volume == null) 
        {
            volume = 100;
        }
        var __reg4 = this.getLayer(layerId);
        if (__reg4 == null) 
        {
            __reg4 = this._defaultLayer;
        }
        if (__reg4.canPlaySound()) 
        {
            var __reg7 = this._registeredSymbolNamesMap[symbolId];
            if (__reg7 == null || this._sfxHolder == null) 
            {
                return -1;
            }
            var __reg8 = this._sfxHolder.getNextHighestDepth();
            var __reg5 = this._sfxHolder.createEmptyMovieClip("sfx_" + symbolId + "_" + __reg8, __reg8);
            var __reg3 = new Sound(__reg5);
            __reg3.attachSound(__reg7);
            if (__reg3.duration != undefined) 
            {
                var __reg2 = new Object();
                var __reg6 = this.getSoundId();
                __reg2.soundId = __reg6;
                __reg2.tag = tag;
                __reg2.sfx = __reg3;
                __reg2.layerId = layerId;
                __reg2.targetHolder = __reg5;
                __reg2.callback = callback;
                __reg2.symbolId = symbolId;
                __reg2.layer = __reg4;
                this._activeSoundsMap[__reg6] = __reg2;
                ++__reg4.numSoundsPlaying;
                __reg3.onSoundComplete = com.clubpenguin.util.Delegate.create(this, this.onSoundComplete, __reg3, __reg4, __reg5, tag, callback);
                __reg3.setVolume(volume);
                __reg3.start(0, 1);
                return __reg6;
            }
        }
        return -1;
    }

    function playSoundAfterDelay(symbolId, layerId, frameDelay, volume, tag, callback)
    {
        if (frameDelay > 0) 
        {
            var __reg3 = this.getDelayedSoundId();
            if (this._delayedSoundsMap[__reg3] != null) 
            {
                this.cancelDelayedSound(__reg3);
            }
            var __reg2 = {};
            __reg2.delay = frameDelay;
            __reg2.delayedSoundId = __reg3;
            __reg2.symbolId = symbolId;
            __reg2.layerId = layerId;
            __reg2.callback = callback;
            __reg2.volume = volume;
            __reg2.tag = tag;
            this._delayedSoundsMap[__reg3] = __reg2;
            return __reg3;
        }
    }

    function cancelDelayedSound(delayedSoundId)
    {
        var __reg2 = this._delayedSoundsMap[delayedSoundId];
        if (__reg2 != null) 
        {
            delete this._delayedSoundsMap[delayedSoundId];
        }
    }

    function playSoundLoop(symbolIds, layerId, volume, tag)
    {
        var __reg3 = this.getSoundLoopId();
        if (this._soundLoopsMap[__reg3] != null) 
        {
            this.stopSoundLoop(__reg3);
        }
        var __reg2 = new Object();
        __reg2.loopId = __reg3;
        __reg2.symbolIds = symbolIds.slice();
        __reg2.layerId = layerId;
        __reg2.currentSymbolIndex = -1;
        __reg2.isActive = true;
        __reg2.volume = volume;
        __reg2.tag = tag;
        this._soundLoopsMap[__reg3] = __reg2;
        this.playSoundLoopObject(this._soundLoopsMap[__reg3]);
        return __reg3;
    }

    function stopSoundLoop(loopId)
    {
        var __reg2 = this._soundLoopsMap[loopId];
        if (__reg2 != null) 
        {
            __reg2.isActive = false;
            delete this._soundLoopsMap[loopId];
        }
    }

    function updateFrameCounters()
    {
        for (var __reg5 in this._delayedSoundsMap) 
        {
            var __reg4 = Number(__reg5);
            var __reg2 = this._delayedSoundsMap[__reg4];
            --__reg2.delay;
            if (__reg2.delay <= 0) 
            {
                this.playSound(__reg2.symbolId, __reg2.layerId, __reg2.volume, __reg2.tag, __reg2.callback);
                this._frameCountersToDelete.push(__reg2);
            }
        }
        var __reg3 = 0;
        while (__reg3 < this._frameCountersToDelete.length) 
        {
            delete this._delayedSoundsMap[this._frameCountersToDelete[__reg3].delayedSoundId];
            ++__reg3;
        }
        this._frameCountersToDelete.length = 0;
    }

    function playSoundLoopObject(loop)
    {
        ++loop.currentSymbolIndex;
        if (loop.currentSymbolIndex >= loop.symbolIds.length) 
        {
            loop.currentSymbolIndex = 0;
        }
        this.playSound(loop.symbolIds[loop.currentSymbolIndex], loop.layerId, loop.volume, loop.tag, com.clubpenguin.util.Delegate.create(this, this.soundLoopCallback, loop));
    }

    function soundLoopCallback(loop)
    {
        if (loop.isActive) 
        {
            this.playSoundLoopObject(loop);
        }
    }

    function onSoundComplete(sfx, layer, targetHolder, tag, callback)
    {
        targetHolder.removeMovieClip();
        false;
        --layer.numSoundsPlaying;
        if (layer.numSoundsPlaying < 0) 
        {
            layer.numSoundsPlaying = 0;
        }
        callback();
    }

    function stopSoundsForTag(tag)
    {
        for (var __reg6 in this._activeSoundsMap) 
        {
            var __reg3 = this._activeSoundsMap[__reg6];
            if (__reg3.tag == tag) 
            {
                __reg3.sfx.stop();
                this.onSoundComplete(__reg3.sfx, __reg3.layer, __reg3.targetHolder, __reg3.callback);
                delete this._activeSoundsMap[__reg3.soundId];
            }
        }
        for (var __reg7 in this._soundLoopsMap) 
        {
            var __reg2 = this._soundLoopsMap[__reg7];
            if (__reg2.tag == tag) 
            {
                this.stopSoundLoop(__reg2.loopId);
            }
        }
        for (var __reg5 in this._delayedSoundsMap) 
        {
            __reg3 = this._delayedSoundsMap[__reg5];
            if (__reg3.tag == tag) 
            {
                this.cancelDelayedSound(__reg3.delayedSoundId);
            }
        }
    }

}
