class com.clubpenguin.world.rooms.common.SoundManager
{
   function SoundManager(target)
   {
      this._layersMap = new Object();
      this._target = target;
      this.init();
   }
   function init()
   {
      this._defaultLayer = new com.clubpenguin.world.rooms.common.SoundLayer(this.getLayerId("default"),"default",-1);
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
      if(this._frameCounter != null)
      {
         this._frameCounter.removeMovieClip();
      }
      this._frameCounter = this._target.createEmptyMovieClip("SoundManager_frameCounter",this._target.getNextHighestDepth());
      this._frameCounter.onEnterFrame = com.clubpenguin.util.Delegate.create(this,this.updateFrameCounters);
      this._frameCountersToDelete = new Array();
      if(this._sfxHolder != null)
      {
         this._sfxHolder.removeMovieClip();
      }
      this._sfxHolder = this._target.createEmptyMovieClip("SoundManager_sfxHolder",this._target.getNextHighestDepth());
   }
   function destroy()
   {
      for(var _loc5_ in this._soundLoopsMap)
      {
         var _loc2_ = this._soundLoopsMap[_loc5_];
         this.stopSoundLoop(_loc2_.loopId);
      }
      for(var _loc4_ in this._delayedSoundsMap)
      {
         var _loc3_ = this._delayedSoundsMap[_loc4_];
         this.cancelDelayedSound(_loc3_.delayedSoundId);
      }
      this._frameCounter.removeMovieClip();
      this._frameCounter = null;
      var _loc6_ = new Sound(this._target);
      _loc6_.setVolume(0);
      this._sfxHolder.removeMovieClip();
      this._sfxHolder = null;
   }
   function registerSymbolName(symbolName)
   {
      this._nextSymbolId++;
      for(var _loc3_ in this._registeredSymbolNamesMap)
      {
         if(_loc3_ == symbolName)
         {
         }
      }
      this._registeredSymbolNamesMap[this._nextSymbolId] = symbolName;
      return this._nextSymbolId;
   }
   function getRegisteredSymbolId(symbolName)
   {
      for(var _loc2_ in this._registeredSymbolNamesMap)
      {
         if(_loc2_ == symbolName)
         {
            return Number(_loc2_);
         }
      }
      return null;
   }
   function addLayer(layerName, maxConcurrent)
   {
      var _loc2_ = this.getLayerId(layerName);
      if(this.getLayer(_loc2_) == null)
      {
         this._layersMap[_loc2_] = new com.clubpenguin.world.rooms.common.SoundLayer(_loc2_,layerName,maxConcurrent);
      }
      return _loc2_;
   }
   function removeLayer(layerId)
   {
      var _loc2_ = this._layersMap[layerId];
      if(_loc2_ != null)
      {
         delete this._layerNameMap[_loc2_.name];
         delete this._layersMap[layerId];
      }
   }
   function getLayer(layerId)
   {
      return this._layersMap[layerId];
   }
   function getLayerId(layerName)
   {
      if(this._layerNameMap[layerName] != null)
      {
         return this._layerNameMap[layerName];
      }
      this._nextLayerId++;
      this._layerNameMap[layerName] = this._nextLayerId;
      return this._nextLayerId;
   }
   function getSoundId()
   {
      this._nextSoundId++;
      return this._nextSoundId;
   }
   function getDelayedSoundId()
   {
      this._nextDelayedSoundId++;
      return this._nextDelayedSoundId;
   }
   function getSoundLoopId()
   {
      this._nextLoopId++;
      return this._nextLoopId;
   }
   function playSound(symbolId, layerId, volume, tag, callback)
   {
      if(volume == null)
      {
         volume = 100;
      }
      var _loc4_ = this.getLayer(layerId);
      if(_loc4_ == null)
      {
         _loc4_ = this._defaultLayer;
      }
      if(_loc4_.canPlaySound())
      {
         var _loc7_ = this._registeredSymbolNamesMap[symbolId];
         if(_loc7_ == null || this._sfxHolder == null)
         {
            return -1;
         }
         var _loc8_ = this._sfxHolder.getNextHighestDepth();
         var _loc5_ = this._sfxHolder.createEmptyMovieClip("sfx_" + symbolId + "_" + _loc8_,_loc8_);
         var _loc3_ = new Sound(_loc5_);
         _loc3_.attachSound(_loc7_);
         if(_loc3_.duration != undefined)
         {
            var _loc2_ = new Object();
            var _loc6_ = this.getSoundId();
            _loc2_.soundId = _loc6_;
            _loc2_.tag = tag;
            _loc2_.sfx = _loc3_;
            _loc2_.layerId = layerId;
            _loc2_.targetHolder = _loc5_;
            _loc2_.callback = callback;
            _loc2_.symbolId = symbolId;
            _loc2_.layer = _loc4_;
            this._activeSoundsMap[_loc6_] = _loc2_;
            _loc4_.numSoundsPlaying++;
            _loc3_.onSoundComplete = com.clubpenguin.util.Delegate.create(this,this.onSoundComplete,_loc3_,_loc4_,_loc5_,tag,callback);
            _loc3_.setVolume(volume);
            _loc3_.start(0,1);
            return _loc6_;
         }
      }
      return -1;
   }
   function playSoundAfterDelay(symbolId, layerId, frameDelay, volume, tag, callback)
   {
      if(frameDelay <= 0)
      {
         return undefined;
      }
      var _loc3_ = this.getDelayedSoundId();
      if(this._delayedSoundsMap[_loc3_] != null)
      {
         this.cancelDelayedSound(_loc3_);
      }
      var _loc2_ = {};
      _loc2_.delay = frameDelay;
      _loc2_.delayedSoundId = _loc3_;
      _loc2_.symbolId = symbolId;
      _loc2_.layerId = layerId;
      _loc2_.callback = callback;
      _loc2_.volume = volume;
      _loc2_.tag = tag;
      this._delayedSoundsMap[_loc3_] = _loc2_;
      return _loc3_;
   }
   function cancelDelayedSound(delayedSoundId)
   {
      var _loc2_ = this._delayedSoundsMap[delayedSoundId];
      if(_loc2_ != null)
      {
         delete this._delayedSoundsMap[delayedSoundId];
      }
   }
   function playSoundLoop(symbolIds, layerId, volume, tag)
   {
      var _loc3_ = this.getSoundLoopId();
      if(this._soundLoopsMap[_loc3_] != null)
      {
         this.stopSoundLoop(_loc3_);
      }
      var _loc2_ = new Object();
      _loc2_.loopId = _loc3_;
      _loc2_.symbolIds = symbolIds.slice();
      _loc2_.layerId = layerId;
      _loc2_.currentSymbolIndex = -1;
      _loc2_.isActive = true;
      _loc2_.volume = volume;
      _loc2_.tag = tag;
      this._soundLoopsMap[_loc3_] = _loc2_;
      this.playSoundLoopObject(this._soundLoopsMap[_loc3_]);
      return _loc3_;
   }
   function stopSoundLoop(loopId)
   {
      var _loc2_ = this._soundLoopsMap[loopId];
      if(_loc2_ != null)
      {
         _loc2_.isActive = false;
         delete this._soundLoopsMap[loopId];
      }
   }
   function updateFrameCounters()
   {
      for(var _loc5_ in this._delayedSoundsMap)
      {
         var _loc4_ = Number(_loc5_);
         var _loc2_ = this._delayedSoundsMap[_loc4_];
         _loc2_.delay--;
         if(_loc2_.delay <= 0)
         {
            this.playSound(_loc2_.symbolId,_loc2_.layerId,_loc2_.volume,_loc2_.tag,_loc2_.callback);
            this._frameCountersToDelete.push(_loc2_);
         }
      }
      var _loc3_ = 0;
      while(_loc3_ < this._frameCountersToDelete.length)
      {
         delete this._delayedSoundsMap[this._frameCountersToDelete[_loc3_].delayedSoundId];
         _loc3_ = _loc3_ + 1;
      }
      this._frameCountersToDelete.length = 0;
   }
   function playSoundLoopObject(loop)
   {
      loop.currentSymbolIndex++;
      if(loop.currentSymbolIndex >= loop.symbolIds.length)
      {
         loop.currentSymbolIndex = 0;
      }
      this.playSound(loop.symbolIds[loop.currentSymbolIndex],loop.layerId,loop.volume,loop.tag,com.clubpenguin.util.Delegate.create(this,this.soundLoopCallback,loop));
   }
   function soundLoopCallback(loop)
   {
      if(loop.isActive)
      {
         this.playSoundLoopObject(loop);
      }
   }
   function onSoundComplete(sfx, layer, targetHolder, tag, callback)
   {
      targetHolder.removeMovieClip();
      false;
      layer.numSoundsPlaying--;
      if(layer.numSoundsPlaying < 0)
      {
         layer.numSoundsPlaying = 0;
      }
      callback();
   }
   function stopSoundsForTag(tag)
   {
      for(var _loc6_ in this._activeSoundsMap)
      {
         var _loc3_ = this._activeSoundsMap[_loc6_];
         if(_loc3_.tag == tag)
         {
            _loc3_.sfx.stop();
            this.onSoundComplete(_loc3_.sfx,_loc3_.layer,_loc3_.targetHolder,_loc3_.callback);
            delete this._activeSoundsMap[_loc3_.soundId];
         }
      }
      for(var _loc7_ in this._soundLoopsMap)
      {
         var _loc2_ = this._soundLoopsMap[_loc7_];
         if(_loc2_.tag == tag)
         {
            this.stopSoundLoop(_loc2_.loopId);
         }
      }
      for(var _loc5_ in this._delayedSoundsMap)
      {
         _loc3_ = this._delayedSoundsMap[_loc5_];
         if(_loc3_.tag == tag)
         {
            this.cancelDelayedSound(_loc3_.delayedSoundId);
         }
      }
   }
}
