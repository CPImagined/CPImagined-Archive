dynamic class com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds
{
    static var REMOTE_PLAYER_SFX_VOLUME: Number = 25;
    static var LOCAL_PLAYER_SFX_VOLUME: Number = 100;

    function FrozenPartySounds()
    {
    }

    static function init()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._this = com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds;
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._shell = _global.getCurrentShell();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._interface = _global.getCurrentInterface();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._engine = _global.getCurrentEngine();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._shell.addListener(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._shell.ROOM_INITIATED, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.onRoomInitialized));
    }

    static function get soundManager()
    {
        return com.clubpenguin.world.rooms.BaseRoom.__get__current().__get__soundManager();
    }

    static function onRoomInitialized()
    {
        com.clubpenguin.world.rooms.BaseRoom.__get__current().soundManagerReady.addOnce(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.onSoundManagerReady, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds);
    }

    static function onSoundManagerReady()
    {
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfxLayer_snowballs = com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().addLayer("snowballs", 4);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfxLayer_freezing = com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().addLayer("freezing", 4);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfxLayer_melting = com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().addLayer("melting", 4);
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfxLayer_snowflakeCollect = com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().addLayer("snowflake", 3);
        var __reg1 = function (symbolName)
        {
            return com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().registerSymbolName(symbolName);
        }
        ;
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfx_impact_1 = __reg1("sfx_impact_1");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfx_impact_2 = __reg1("sfx_impact_2");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfx_throw_1 = __reg1("sfx_throw_1");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfx_throw_2 = __reg1("sfx_throw_2");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfx_melt_1 = __reg1("sfx_melt_1");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfx_melt_2 = __reg1("sfx_melt_2");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfx_freeze_1 = __reg1("sfx_freeze_1");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfx_freeze_2 = __reg1("sfx_freeze_2");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfx_freeze_3 = __reg1("sfx_freeze_3");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfx_freeze_4 = __reg1("sfx_freeze_4");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfx_collect_snowflake = __reg1("sfx_collect_snowflake");
    }

    static function playSnowballImpact()
    {
        com.clubpenguin.util.Log.debug("playSnowballImpact");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._this["_sfx_impact_" + Number(random(2) + 1)], com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfxLayer_snowballs, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.LOCAL_PLAYER_SFX_VOLUME);
    }

    static function playSnowballThrow()
    {
        com.clubpenguin.util.Log.debug("play snowball throw");
        var __reg1 = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__localPlayerAvatarID() == com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.__get__CONSTANTS().MARSHMALLOW_TRANSFORMATION_ID ? 70 : 40;
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().playSoundAfterDelay(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._this["_sfx_throw_" + Number(random(2) + 1)], __reg1, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfxLayer_snowballs, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.LOCAL_PLAYER_SFX_VOLUME);
    }

    static function playFreezeSFX()
    {
        com.clubpenguin.util.Log.debug("playFreezeSFX");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._this["_sfx_freeze_" + Number(random(4) + 1)], com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfxLayer_freezing, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.LOCAL_PLAYER_SFX_VOLUME);
    }

    static function playThawSFX()
    {
        com.clubpenguin.util.Log.debug("playThawSFX");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._this["_sfx_melt_" + Number(random(2) + 1)], com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfxLayer_melting, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.LOCAL_PLAYER_SFX_VOLUME);
    }

    static function playCollectSnowflakeSFX()
    {
        com.clubpenguin.util.Log.debug("playCollectSnowflakeSFX");
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfx_collect_snowflake, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds._sfxLayer_snowflakeCollect, com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.LOCAL_PLAYER_SFX_VOLUME);
    }

}
