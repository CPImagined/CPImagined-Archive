//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.march.party.MarchPartySounds
    {
        static var _shell, _interface, _engine, _sfxLayer_ui, _sfxLayer_random, _sfx_pickup_fish, _sfx_pickup_fishingrod, _sfx_pickup_joke_item1, _sxf_pickup_joke_item2, _sfx_pickup_berry1, _sfx_pickup_berry2, _sfx_place_joke_item1, _sfx_place_joke_item2, _sfx_reveal_deer, _sfx_reveal_rabbit, _sfx_reveal_raccoon, _sfx_reveal_unicorn, _sfx_reveal_sasquatch, _sfx_item_collection;
        function MarchPartySounds () {
        }
        static function init() {
            _shell = _global.getCurrentShell();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _shell.addListener(_shell.ROOM_INITIATED, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.march.party.MarchPartySounds, onRoomInitialized));
        }
        static function get soundManager() {
            return(com.clubpenguin.world.rooms.BaseRoom.current.soundManager);
        }
        static function onRoomInitialized() {
            com.clubpenguin.world.rooms.BaseRoom.current.soundManagerReady.addOnce(onSoundManagerReady, com.clubpenguin.world.rooms2015.march.party.MarchPartySounds);
            trace("MarchPartySounds.onRoomInitialized()");
        }
        static function onSoundManagerReady() {
            _sfxLayer_ui = soundManager.addLayer("ui_layer", 2);
            _sfxLayer_random = soundManager.addLayer("random_layer", 2);
            var _local_1 = function (symbolName) {
                return(com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.soundManager.registerSymbolName(symbolName));
            };
            _sfx_pickup_fish = _local_1("sfx_pickup_fish");
            _sfx_pickup_fishingrod = _local_1("sfx_pickup_fishingrod");
            _sfx_pickup_joke_item1 = _local_1("sfx_pickup_joke_item1");
            _sxf_pickup_joke_item2 = _local_1("sfx_pickup_joke_item2");
            _sfx_pickup_berry1 = _local_1("sfx_pickup_berry1");
            _sfx_pickup_berry2 = _local_1("sfx_pickup_berry2");
            _sfx_place_joke_item1 = _local_1("sfx_place_joke_item1");
            _sfx_place_joke_item2 = _local_1("sfx_place_joke_item2");
            _sfx_reveal_deer = _local_1("sfx_reveal_deer");
            _sfx_reveal_rabbit = _local_1("sfx_reveal_rabbit");
            _sfx_reveal_raccoon = _local_1("sfx_reveal_raccoon");
            _sfx_reveal_unicorn = _local_1("sfx_reveal_unicorn");
            _sfx_reveal_sasquatch = _local_1("sfx_reveal_sasquatch");
            _sfx_item_collection = _local_1("sfx_item_collection");
        }
        static function playPartySound(soundString, callback) {
            var _local_1 = String("_sfx_" + soundString);
            trace("MarchPartySounds.playPartySound() - soundLinkageName : " + _local_1);
            if (_shell.isMyPlayer(_shell.getMyPlayerId())) {
                soundManager.playSound(com.clubpenguin.world.rooms2015.march.party.MarchPartySounds[_local_1], null, LOCAL_PLAYER_SFX_VOLUME, null, callback);
            }
        }
        static function playUISound(soundString, callback) {
            var _local_1 = String("_sfx_" + soundString);
            trace("MarchPartySounds.playPartySound() - soundLinkageName : " + _local_1);
            if (_shell.isMyPlayer(_shell.getMyPlayerId())) {
                soundManager.playSound(com.clubpenguin.world.rooms2015.march.party.MarchPartySounds[_local_1], _sfxLayer_ui, LOCAL_PLAYER_SFX_VOLUME, null, callback);
            }
        }
        static function playRandomSound(soundString, minNum, maxNum, callback) {
            var _local_2 = getRandomNumber(minNum, maxNum);
            var _local_1 = String(("_sfx_" + soundString) + _local_2);
            trace("MarchPartySounds.playRandomSound() - soundLinkageName : " + _local_1);
            if (_shell.isMyPlayer(_shell.getMyPlayerId())) {
                soundManager.playSound(com.clubpenguin.world.rooms2015.march.party.MarchPartySounds[_local_1], null, LOCAL_PLAYER_SFX_VOLUME, null, callback);
            }
        }
        static function getRandomNumber(minValue, maxValue) {
            var _local_1 = Math.floor(Math.random() * ((maxValue - minValue) + 1)) + minValue;
            return(String(_local_1));
        }
        static function playSoundLoop() {
        }
        static function stopSoundLoop() {
        }
        static var LOCAL_PLAYER_SFX_VOLUME = 100;
    }
