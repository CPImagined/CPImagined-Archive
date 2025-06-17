class com.clubpenguin.world.rooms2015.automated.party.DecemberSounds
{
   static var LOCAL_PLAYER_SFX_VOLUME = 100;
   function DecemberSounds()
   {
   }
   static function init()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberSounds._shell = _global.getCurrentShell();
      com.clubpenguin.world.rooms2015.automated.party.DecemberSounds._interface = _global.getCurrentInterface();
      com.clubpenguin.world.rooms2015.automated.party.DecemberSounds._engine = _global.getCurrentEngine();
      com.clubpenguin.world.rooms2015.automated.party.DecemberSounds._shell.addListener(com.clubpenguin.world.rooms2015.automated.party.DecemberSounds._shell.ROOM_INITIATED,com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.automated.party.DecemberSounds,com.clubpenguin.world.rooms2015.automated.party.DecemberSounds.onRoomInitialized));
   }
   static function get soundManager()
   {
      return com.clubpenguin.world.rooms.BaseRoom.__get__current().__get__soundManager();
   }
   static function onRoomInitialized()
   {
      com.clubpenguin.world.rooms.BaseRoom.__get__current().soundManagerReady.addOnce(com.clubpenguin.world.rooms2015.automated.party.DecemberSounds.onSoundManagerReady,com.clubpenguin.world.rooms2015.automated.party.DecemberSounds);
   }
   static function onSoundManagerReady()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberSounds._sfxLayer_snowballs = com.clubpenguin.world.rooms2015.automated.party.DecemberSounds.__get__soundManager().addLayer("snowballs",4);
      com.clubpenguin.world.rooms2015.automated.party.DecemberSounds._sfxLayer_transform = com.clubpenguin.world.rooms2015.automated.party.DecemberSounds.__get__soundManager().addLayer("tansform",3);
      var _loc1_ = function(symbolName)
      {
         return com.clubpenguin.world.rooms2015.automated.party.DecemberSounds.__get__soundManager().registerSymbolName(symbolName);
      };
      com.clubpenguin.world.rooms2015.automated.party.DecemberSounds._sfx_snowball_impact_1 = _loc1_("sfx_snowball_impact_1");
      com.clubpenguin.world.rooms2015.automated.party.DecemberSounds._sfx_snowball_impact_2 = _loc1_("sfx_snowball_impact_2");
      com.clubpenguin.world.rooms2015.automated.party.DecemberSounds._sfx_snowball_impact_normal_1 = _loc1_("sfx_snowball_normal_1");
      com.clubpenguin.world.rooms2015.automated.party.DecemberSounds._sfx_snowball_impact_normal_2 = _loc1_("sfx_snowball_normal_2");
      com.clubpenguin.world.rooms2015.automated.party.DecemberSounds._sfx_transform_frostbite = _loc1_("sfx_transform");
      com.clubpenguin.world.rooms2015.automated.party.DecemberSounds._sfx_throw_1 = _loc1_("sfx_throw_1");
   }
   static function playFrostbiteSnowballThrow()
   {
      com.clubpenguin.util.Log.debug("playFrostbiteSnowballThrow()");
      com.clubpenguin.world.rooms2015.automated.party.DecemberSounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2015.automated.party.DecemberSounds._sfx_throw_1,com.clubpenguin.world.rooms2015.automated.party.DecemberSounds._sfxLayer_snowballs,com.clubpenguin.world.rooms2015.automated.party.DecemberSounds.LOCAL_PLAYER_SFX_VOLUME);
   }
   static function playFrostbiteTransform()
   {
      var _loc1_ = random(2) + 1;
      com.clubpenguin.world.rooms2015.automated.party.DecemberSounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2015.automated.party.DecemberSounds["_sfx_transform_frostbite" + _loc1_],com.clubpenguin.world.rooms2015.automated.party.DecemberSounds._sfxLayer_transform,com.clubpenguin.world.rooms2015.automated.party.DecemberSounds.LOCAL_PLAYER_SFX_VOLUME);
   }
   static function playFrostbiteSnowballImpact()
   {
      var _loc1_ = random(2) + 1;
      com.clubpenguin.world.rooms2015.automated.party.DecemberSounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2015.automated.party.DecemberSounds["_sfx_snowball_impact_" + _loc1_],com.clubpenguin.world.rooms2015.automated.party.DecemberSounds._sfxLayer_snowballs,com.clubpenguin.world.rooms2015.automated.party.DecemberSounds.LOCAL_PLAYER_SFX_VOLUME);
   }
   static function playNormalSnowballImpact()
   {
      var _loc1_ = random(2) + 1;
      com.clubpenguin.world.rooms2015.automated.party.DecemberSounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2015.automated.party.DecemberSounds["_sfx_snowball_impact_normal_" + _loc1_],com.clubpenguin.world.rooms2015.automated.party.DecemberSounds._sfxLayer_snowballs,com.clubpenguin.world.rooms2015.automated.party.DecemberSounds.LOCAL_PLAYER_SFX_VOLUME);
   }
}
