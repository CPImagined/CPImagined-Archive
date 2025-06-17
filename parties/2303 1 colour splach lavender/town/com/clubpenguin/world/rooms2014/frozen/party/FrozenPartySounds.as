class com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds
{
    static var _this, _shell, _interface, _engine, __get__soundManager, _sfxLayer_snowballs, _sfxLayer_freezing, _sfxLayer_melting, _sfxLayer_snowflakeCollect, _sfx_impact_1, _sfx_impact_2, _sfx_throw_1, _sfx_throw_2, _sfx_melt_1, _sfx_melt_2, _sfx_freeze_1, _sfx_freeze_2, _sfx_freeze_3, _sfx_freeze_4, _sfx_collect_snowflake, _sfx_transform;
    function FrozenPartySounds()
    {
    } // End of the function
    static function init()
    {
        _this = com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds;
        _shell = _global.getCurrentShell();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._shell.addListener(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._shell.ROOM_INITIATED, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.onRoomInitialized));
    } // End of the function
    static function get soundManager()
    {
        //return (com.clubpenguin.world.rooms.BaseRoom.current().__get__soundManager());
    } // End of the function
    static function onRoomInitialized()
    {
        com.clubpenguin.world.rooms.BaseRoom.__get__current().soundManagerReady.addOnce(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.onSoundManagerReady, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds);
    } // End of the function
    static function onSoundManagerReady()
    {
        _sfxLayer_snowballs = com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().addLayer("snowballs", 4);
        _sfxLayer_freezing = com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().addLayer("freezing", 4);
        _sfxLayer_melting = com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().addLayer("melting", 4);
        _sfxLayer_snowflakeCollect = com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().addLayer("snowflake", 3);
        var _loc1 = function (symbolName)
        {
            //return (com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.soundManager().registerSymbolName(symbolName));
        };
        _sfx_impact_1 = _loc1("sfx_impact_1");
        _sfx_impact_2 = _loc1("sfx_impact_2");
        _sfx_throw_1 = _loc1("sfx_throw_1");
        _sfx_throw_2 = _loc1("sfx_throw_2");
        _sfx_melt_1 = _loc1("sfx_melt_1");
        _sfx_melt_2 = _loc1("sfx_melt_2");
        _sfx_freeze_1 = _loc1("sfx_freeze_1");
        _sfx_freeze_2 = _loc1("sfx_freeze_2");
        _sfx_freeze_3 = _loc1("sfx_freeze_3");
        _sfx_freeze_4 = _loc1("sfx_freeze_4");
        _sfx_collect_snowflake = _loc1("sfx_collect_snowflake");
        _sfx_transform = _loc1("sfx_transform");
    } // End of the function
    static function playSnowballImpact()
    {
        com.clubpenguin.util.Log.debug("playSnowballImpact");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._this["_sfx_impact_" + Number(random(2) + 1)], com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfxLayer_snowballs, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.LOCAL_PLAYER_SFX_VOLUME);
    } // End of the function
    static function playSnowballThrow()
    {
        com.clubpenguin.util.Log.debug("play snowball throw");
        var _loc1 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__localPlayerAvatarID() == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().MARSHMALLOW_TRANSFORMATION_ID ? (40) : (10);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().playSoundAfterDelay(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._this["_sfx_throw_" + Number(random(2) + 1)], com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfxLayer_snowballs, _loc1, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.LOCAL_PLAYER_SFX_VOLUME);
    } // End of the function
    static function playFreezeSFX()
    {
        com.clubpenguin.util.Log.debug("playFreezeSFX");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._this["_sfx_freeze_" + Number(random(4) + 1)], com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfxLayer_freezing, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.LOCAL_PLAYER_SFX_VOLUME);
    } // End of the function
    static function playThawSFX()
    {
        com.clubpenguin.util.Log.debug("playThawSFX");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._this["_sfx_melt_" + Number(random(2) + 1)], com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfxLayer_melting, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.LOCAL_PLAYER_SFX_VOLUME);
    } // End of the function
    static function playCollectSnowflakeSFX()
    {
        com.clubpenguin.util.Log.debug("playCollectSnowflakeSFX");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfx_collect_snowflake, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfxLayer_snowflakeCollect, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.LOCAL_PLAYER_SFX_VOLUME);
    } // End of the function
    static function playTransformSFX()
    {
        com.clubpenguin.util.Log.debug("playTransformSFX");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfx_transform, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfxLayer_snowflakeCollect, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.LOCAL_PLAYER_SFX_VOLUME);
    } // End of the function
    static var REMOTE_PLAYER_SFX_VOLUME = 25;
    static var LOCAL_PLAYER_SFX_VOLUME = 100;
} // End of Class
