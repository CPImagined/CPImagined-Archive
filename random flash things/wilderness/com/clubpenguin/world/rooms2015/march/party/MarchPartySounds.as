class com.clubpenguin.world.rooms2015.march.party.MarchPartySounds
{
    static var _shell, _interface, _engine, __get__soundManager, _sfxLayer_ui, _sfxLayer_random, _sxf_pickup_fish, _sxf_pickup_fishingrod, _sfx_pickup_joke_item1, _sxf_pickup_joke_item2, _sfx_pickup_berry1, _sfx_pickup_berry2, _sfx_place_joke_item1, _sfx_place_joke_item2, _sfx_reveal_deer, _sfx_reveal_rabbit, _sfx_reveal_raccoon, _sfx_reveal_unicorn, _sfx_reveal_sasquatch, _sfx_item_collection, _sfx_close_ui;
    function MarchPartySounds()
    {
    } // End of the function
    static function init()
    {
        _shell = _global.getCurrentShell();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        com.clubpenguin.world.rooms2015.march.party.MarchPartySounds._shell.addListener(com.clubpenguin.world.rooms2015.march.party.MarchPartySounds._shell.ROOM_INITIATED, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.march.party.MarchPartySounds, com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.onRoomInitialized));
    } // End of the function
    static function get soundManager()
    {
        //return (com.clubpenguin.world.rooms.BaseRoom.current().__get__soundManager());
    } // End of the function
    static function onRoomInitialized()
    {
        com.clubpenguin.world.rooms.BaseRoom.__get__current().soundManagerReady.addOnce(com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.onSoundManagerReady, com.clubpenguin.world.rooms2015.march.party.MarchPartySounds);
        trace ("MarchPartySounds.onRoomInitialized()");
    } // End of the function
    static function onSoundManagerReady()
    {
        _sfxLayer_ui = com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.__get__soundManager().addLayer("ui_layer", 2);
        _sfxLayer_random = com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.__get__soundManager().addLayer("random_layer", 2);
        var _loc1 = function (symbolName)
        {
            //return (com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.soundManager().registerSymbolName(symbolName));
        };
        _sxf_pickup_fish = _loc1("sxf_pickup_fish");
        _sxf_pickup_fishingrod = _loc1("sxf_pickup_fishingrod");
        _sfx_pickup_joke_item1 = _loc1("sfx_pickup_joke_item1");
        _sxf_pickup_joke_item2 = _loc1("sfx_pickup_joke_item2");
        _sfx_pickup_berry1 = _loc1("sfx_pickup_berry1");
        _sfx_pickup_berry2 = _loc1("sfx_pickup_berry2");
        _sfx_place_joke_item1 = _loc1("sfx_place_joke_item1");
        _sfx_place_joke_item2 = _loc1("sfx_place_joke_item2");
        _sfx_reveal_deer = _loc1("sfx_reveal_deer");
        _sfx_reveal_rabbit = _loc1("sfx_reveal_rabbit");
        _sfx_reveal_raccoon = _loc1("sfx_reveal_raccoon");
        _sfx_reveal_unicorn = _loc1("sfx_reveal_unicorn");
        _sfx_reveal_sasquatch = _loc1("sfx_reveal_sasquatch");
        _sfx_item_collection = _loc1("sfx_item_collection");
        _sfx_close_ui = _loc1("sfx_close_ui");
    } // End of the function
    static function playPartySound(soundString, callback)
    {
        var _loc1 = String("_sfx_" + soundString);
        trace ("MarchPartySounds.playPartySound() - soundLinkageName : " + _loc1);
        if (com.clubpenguin.world.rooms2015.march.party.MarchPartySounds._shell.isMyPlayer(com.clubpenguin.world.rooms2015.march.party.MarchPartySounds._shell.getMyPlayerId()))
        {
            com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2015.march.party.MarchPartySounds[_loc1], null, com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.LOCAL_PLAYER_SFX_VOLUME, null, callback);
        } // end if
    } // End of the function
    static function playUISound(soundString, callback)
    {
        var _loc1 = String("_sfx_" + soundString);
        trace ("MarchPartySounds.playPartySound() - soundLinkageName : " + _loc1);
        if (com.clubpenguin.world.rooms2015.march.party.MarchPartySounds._shell.isMyPlayer(com.clubpenguin.world.rooms2015.march.party.MarchPartySounds._shell.getMyPlayerId()))
        {
            com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2015.march.party.MarchPartySounds[_loc1], com.clubpenguin.world.rooms2015.march.party.MarchPartySounds._sfxLayer_ui, com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.LOCAL_PLAYER_SFX_VOLUME, null, callback);
        } // end if
    } // End of the function
    static function playRandomSound(soundString, minNum, maxNum, callback)
    {
        var _loc2 = com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.getRandomNumber(minNum, maxNum);
        var _loc1 = String("_sfx_" + soundString + _loc2);
        trace ("MarchPartySounds.playRandomSound() - soundLinkageName : " + _loc1);
        if (com.clubpenguin.world.rooms2015.march.party.MarchPartySounds._shell.isMyPlayer(com.clubpenguin.world.rooms2015.march.party.MarchPartySounds._shell.getMyPlayerId()))
        {
            com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2015.march.party.MarchPartySounds[_loc1], null, com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.LOCAL_PLAYER_SFX_VOLUME, null, callback);
        } // end if
    } // End of the function
    static function getRandomNumber(minValue, maxValue)
    {
        var _loc1 = Math.floor(Math.random() * (maxValue - minValue + 1)) + minValue;
        return (String(_loc1));
    } // End of the function
    static function playSoundLoop()
    {
    } // End of the function
    static function stopSoundLoop()
    {
    } // End of the function
    static var LOCAL_PLAYER_SFX_VOLUME = 100;
} // End of Class
