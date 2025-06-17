//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.muppets.MuppetsSounds
    {
        static var _shell, _interface, _engine, _sfxLayer_animations, _sfxLayer_poofs, _sfx_poofin, _sfx_poofout, _sfx_fozzie, _sfx_miss_piggy, _sfx_gonzo, _sfx_swedish_chef_1, _sfx_swedish_chef_2, _sfx_walter, _sfx_bunsen_beaker, _sfx_animal, _sfx_pepe_1, _sfx_pepe_2, _sfx_transformpoof, _sfx_transform;
        function MuppetsSounds () {
        }
        static function init() {
            _shell = _global.getCurrentShell();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _shell.addListener(_shell.ROOM_INITIATED, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds, onRoomInitialized));
        }
        static function get soundManager() {
            return(com.clubpenguin.world.rooms.BaseRoom.current.soundManager);
        }
        static function onRoomInitialized() {
            com.clubpenguin.world.rooms.BaseRoom.current.soundManagerReady.addOnce(onSoundManagerReady, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds);
        }
        static function onSoundManagerReady() {
            _sfxLayer_animations = soundManager.addLayer("animations", 2);
            _sfxLayer_poofs = soundManager.addLayer("poofs", 2);
            var _local_1 = function (symbolName) {
                return(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.soundManager.registerSymbolName(symbolName));
            };
            _sfx_poofin = _local_1("sfx_poofin");
            _sfx_poofout = _local_1("sfx_poofout");
            _sfx_fozzie = _local_1("sfx_fozzie");
            _sfx_miss_piggy = _local_1("sfx_miss_piggy");
            _sfx_gonzo = _local_1("sfx_gonzo");
            _sfx_swedish_chef_1 = _local_1("sfx_swedish_chef_1");
            _sfx_swedish_chef_2 = _local_1("sfx_swedish_chef_2");
            _sfx_walter = _local_1("sfx_walter");
            _sfx_bunsen_beaker = _local_1("sfx_bunsen_beaker");
            _sfx_animal = _local_1("sfx_animal");
            _sfx_pepe_1 = _local_1("sfx_pepe_1");
            _sfx_pepe_2 = _local_1("sfx_pepe_2");
            _sfx_transformpoof = _local_1("sfx_transformpoof");
            _sfx_transform = _local_1("sfx_transform");
        }
        static function playPoofIn() {
            soundManager.playSound(_sfx_poofin, _sfxLayer_poofs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playPoofOut() {
            soundManager.playSound(_sfx_poofout, _sfxLayer_poofs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playMuppetAnimationSoundByItem(itemID) {
            var _local_1 = com.clubpenguin.world.rooms2014.muppets.MuppetsParty.getMuppetByInteractiveItem(itemID);
            trace("MuppetsSounds muppetName " + _local_1);
            com.clubpenguin.world.rooms2014.muppets.MuppetsSounds[_local_1]();
        }
        static function fozzie() {
            soundManager.playSoundAfterDelay(_sfx_fozzie, _sfxLayer_animations, 33, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function miss_piggy() {
            soundManager.playSound(_sfx_miss_piggy, _sfxLayer_animations, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function gonzo() {
            soundManager.playSound(_sfx_gonzo, _sfxLayer_animations, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function animal() {
            soundManager.playSound(_sfx_animal, _sfxLayer_animations, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function swedish_chef() {
            soundManager.playSoundAfterDelay(_sfx_swedish_chef_1, _sfxLayer_animations, 33, LOCAL_PLAYER_SFX_VOLUME);
            soundManager.playSoundAfterDelay(_sfx_swedish_chef_2, _sfxLayer_animations, 75, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function walter() {
            soundManager.playSound(_sfx_walter, _sfxLayer_animations, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function pepe() {
            soundManager.playSoundAfterDelay(_sfx_pepe_1, _sfxLayer_animations, 9, LOCAL_PLAYER_SFX_VOLUME);
            soundManager.playSoundAfterDelay(_sfx_pepe_2, _sfxLayer_animations, 40, LOCAL_PLAYER_SFX_VOLUME);
            soundManager.playSoundAfterDelay(_sfx_pepe_1, _sfxLayer_animations, 69, LOCAL_PLAYER_SFX_VOLUME);
            soundManager.playSoundAfterDelay(_sfx_pepe_2, _sfxLayer_animations, 99, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function bunsen_beaker() {
            soundManager.playSound(_sfx_bunsen_beaker, _sfxLayer_animations, LOCAL_PLAYER_SFX_VOLUME);
            soundManager.playSoundAfterDelay(_sfx_transformpoof, _sfxLayer_animations, 63, LOCAL_PLAYER_SFX_VOLUME);
            soundManager.playSoundAfterDelay(_sfx_transform, _sfxLayer_animations, 63, LOCAL_PLAYER_SFX_VOLUME);
            soundManager.playSoundAfterDelay(_sfx_transformpoof, _sfxLayer_animations, 111, LOCAL_PLAYER_SFX_VOLUME);
        }
        static var REMOTE_PLAYER_SFX_VOLUME = 25;
        static var LOCAL_PLAYER_SFX_VOLUME = 100;
    }
