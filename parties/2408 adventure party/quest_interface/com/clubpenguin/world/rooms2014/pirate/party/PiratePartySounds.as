//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds
    {
        static var _shell, _interface, _engine, _sfxLayer_crabs, _sfxLayer_timer, _sfxLayer_swords, _sfxLayer_penguin, _sfx_timertick, _sfx_crab_walk, _sfx_crab_highhit, _sfx_crab_mediumhit, _sfx_crab_lowhit, _sfx_crab_boss_highhit, _sfx_crab_boss_mediumhit, _sfx_crab_boss_lowhit, _sfx_crab_hat_lose, _sfx_crab_hat_taunt, _sfx_crab_bandana_lose, _sfx_crab_bandana_taunt, _sfx_crab_eyepatch_lose, _sfx_crab_eyepatch_taunt, _sfx_crab_boss_lose, _sfx_crab_boss_taunt, _sfx_transform_poof, _sfx_penguin_lose, _sfx_penguin_win_0, _sfx_penguin_win_1, _sfx_penguin_win_2, _sfx_wooden_sword_invite, _sfx_wooden_sword_high, _sfx_wooden_sword_mid, _sfx_wooden_sword_low, _sfx_wooden_sword_tie, _sfx_cheese_sword_invite, _sfx_cheese_sword_high, _sfx_cheese_sword_mid, _sfx_cheese_sword_low, _sfx_cheese_sword_tie, _sfx_balloon_sword_invite, _sfx_balloon_sword_high, _sfx_balloon_sword_mid, _sfx_balloon_sword_low, _sfx_balloon_sword_tie, _sfx_rogue_sword_invite, _sfx_rogue_sword_high, _sfx_rogue_sword_mid, _sfx_rogue_sword_low, _sfx_rogue_sword_tie, _sfx_jewel_sword_invite, _sfx_jewel_sword_high, _sfx_jewel_sword_mid, _sfx_jewel_sword_low, _sfx_jewel_sword_tie, _sfx_duel_points, _crabWalkLoopId, _invitationLoopId;
        function PiratePartySounds () {
        }
        static function init() {
            _shell = _global.getCurrentShell();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _shell.addListener(_shell.ROOM_INITIATED, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds, onRoomInitialized));
        }
        static function get soundManager() {
            return(com.clubpenguin.world.rooms.BaseRoom.current.soundManager);
        }
        static function onRoomInitialized() {
            com.clubpenguin.world.rooms.BaseRoom.current.soundManagerReady.addOnce(onSoundManagerReady, com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds);
        }
        static function onSoundManagerReady() {
            _sfxLayer_crabs = soundManager.addLayer("crabs", 4);
            _sfxLayer_timer = soundManager.addLayer("timer", 2);
            _sfxLayer_swords = soundManager.addLayer("swords", 4);
            _sfxLayer_penguin = soundManager.addLayer("penguin", 2);
            var _local_1 = function (symbolName) {
                return(com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds.soundManager.registerSymbolName(symbolName));
            };
            _sfx_timertick = _local_1("sfx_timer");
            _sfx_crab_walk = _local_1("sfx_crab_walk");
            _sfx_crab_highhit = _local_1("sfx_crab_highhit");
            _sfx_crab_mediumhit = _local_1("sfx_crab_midhit");
            _sfx_crab_lowhit = _local_1("sfx_crab_lowhit");
            _sfx_crab_boss_highhit = _local_1("sfx_crab_boss_highhit");
            _sfx_crab_boss_mediumhit = _local_1("sfx_crab_boss_midhit");
            _sfx_crab_boss_lowhit = _local_1("sfx_crab_boss_lowhit");
            _sfx_crab_hat_lose = _local_1("sfx_crab_hat_lose");
            _sfx_crab_hat_taunt = _local_1("sfx_crab_hat_taunt");
            _sfx_crab_bandana_lose = _local_1("sfx_crab_bandana_lose");
            _sfx_crab_bandana_taunt = _local_1("sfx_crab_bandana_taunt");
            _sfx_crab_eyepatch_lose = _local_1("sfx_crab_eyepatch_lose");
            _sfx_crab_eyepatch_taunt = _local_1("sfx_crab_eyepatch_taunt");
            _sfx_crab_boss_lose = _local_1("sfx_crab_boss_lose");
            _sfx_crab_boss_taunt = _local_1("sfx_crab_boss_taunt");
            _sfx_transform_poof = _local_1("sfx_transform_poof");
            _sfx_penguin_lose = _local_1("sfx_penguin_lose");
            _sfx_penguin_win_0 = _local_1("sfx_penguin_win_0");
            _sfx_penguin_win_1 = _local_1("sfx_penguin_win_1");
            _sfx_penguin_win_2 = _local_1("sfx_penguin_win_2");
            _sfx_wooden_sword_invite = _local_1("sfx_wooden_sword_invite");
            _sfx_wooden_sword_high = _local_1("sfx_wooden_sword_high");
            _sfx_wooden_sword_mid = _local_1("sfx_wooden_sword_mid");
            _sfx_wooden_sword_low = _local_1("sfx_wooden_sword_low");
            _sfx_wooden_sword_tie = _local_1("sfx_wooden_sword_tie");
            _sfx_cheese_sword_invite = _local_1("sfx_cheese_sword_invite");
            _sfx_cheese_sword_high = _local_1("sfx_cheese_sword_high");
            _sfx_cheese_sword_mid = _local_1("sfx_cheese_sword_mid");
            _sfx_cheese_sword_low = _local_1("sfx_cheese_sword_low");
            _sfx_cheese_sword_tie = _local_1("sfx_cheese_sword_tie");
            _sfx_balloon_sword_invite = _local_1("sfx_balloon_sword_invite");
            _sfx_balloon_sword_high = _local_1("sfx_balloon_sword_high");
            _sfx_balloon_sword_mid = _local_1("sfx_balloon_sword_mid");
            _sfx_balloon_sword_low = _local_1("sfx_balloon_sword_low");
            _sfx_balloon_sword_tie = _local_1("sfx_balloon_sword_tie");
            _sfx_rogue_sword_invite = _local_1("sfx_rogue_sword_invite");
            _sfx_rogue_sword_high = _local_1("sfx_rogue_sword_high");
            _sfx_rogue_sword_mid = _local_1("sfx_rogue_sword_mid");
            _sfx_rogue_sword_low = _local_1("sfx_rogue_sword_low");
            _sfx_rogue_sword_tie = _local_1("sfx_rogue_sword_tie");
            _sfx_jewel_sword_invite = _local_1("sfx_jewel_sword_invite");
            _sfx_jewel_sword_high = _local_1("sfx_jewel_sword_high");
            _sfx_jewel_sword_mid = _local_1("sfx_jewel_sword_mid");
            _sfx_jewel_sword_low = _local_1("sfx_jewel_sword_low");
            _sfx_jewel_sword_tie = _local_1("sfx_jewel_sword_tie");
            _sfx_duel_points = _local_1("sfx_duel_points");
        }
        static function playTimerTick(player_id) {
            if (_shell.isMyPlayer(player_id)) {
                soundManager.playSound(_sfx_timertick, _sfxLayer_timer, LOCAL_PLAYER_SFX_VOLUME);
            }
        }
        static function playCrabWalkLoop() {
            _crabWalkLoopId = soundManager.playSoundLoop([_sfx_crab_walk], _sfxLayer_crabs, LOCAL_PLAYER_SFX_VOLUME, _shell.getMyPlayerId());
        }
        static function stopCrabWalkLoop() {
            soundManager.stopSoundLoop(_crabWalkLoopId);
        }
        static function playCrabHit(attackLabel) {
            soundManager.playSound(com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds[("_sfx_crab_" + attackLabel) + "hit"], _sfxLayer_crabs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playCrabBossHit(attackLabel) {
            soundManager.playSound(com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds[("_sfx_crab_boss_" + attackLabel) + "hit"], _sfxLayer_crabs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playCrabHatReaction(reactionLabel) {
            soundManager.playSound(com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds["_sfx_crab_hat_" + reactionLabel], _sfxLayer_crabs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playCrabBandanaReaction(reactionLabel) {
            soundManager.playSound(com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds["_sfx_crab_bandana_" + reactionLabel], _sfxLayer_crabs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playCrabEyepatchReaction(reactionLabel) {
            soundManager.playSound(com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds["_sfx_crab_eyepatch_" + reactionLabel], _sfxLayer_crabs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playCrabBossReaction(reactionLabel) {
            soundManager.playSound(com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds["_sfx_crab_boss_" + reactionLabel], _sfxLayer_crabs, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playTransformSound(player_id) {
            if (_shell.isMyPlayer(player_id)) {
                soundManager.playSound(_sfx_transform_poof, _sfxLayer_penguin, LOCAL_PLAYER_SFX_VOLUME);
            }
        }
        static function playPenguinInvitation(player_id) {
            if (_shell.isMyPlayer(player_id)) {
                _invitationLoopId = soundManager.playSoundLoop([com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds[("_sfx_" + com.clubpenguin.world.rooms2014.pirate.party.PirateParty.getEquippedSwordName(player_id)) + "_invite"]], _sfxLayer_swords, LOCAL_PLAYER_SFX_VOLUME, player_id);
            }
        }
        static function stopPenguinInvitation(player_id) {
            if (_shell.isMyPlayer(player_id)) {
                soundManager.stopSoundLoop(_invitationLoopId);
            }
        }
        static function playPenguinLose(player_id) {
            if (_shell.isMyPlayer(player_id)) {
                soundManager.playSound(_sfx_penguin_lose, _sfxLayer_penguin, LOCAL_PLAYER_SFX_VOLUME);
            }
        }
        static function playPenguinWin(player_id) {
            if (_shell.isMyPlayer(player_id)) {
                soundManager.playSound(com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds["_sfx_penguin_win_" + random(3)], _sfxLayer_penguin, LOCAL_PLAYER_SFX_VOLUME);
            }
        }
        static function playPenguinTie(player_id) {
            soundManager.playSound(com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds[("_sfx_" + com.clubpenguin.world.rooms2014.pirate.party.PirateParty.getEquippedSwordName(player_id)) + "_tie"], _sfxLayer_swords, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playPenguinHighHit(player_id) {
            soundManager.playSound(com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds[("_sfx_" + com.clubpenguin.world.rooms2014.pirate.party.PirateParty.getEquippedSwordName(player_id)) + "_high"], _sfxLayer_swords, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playPenguinMidHit(player_id) {
            soundManager.playSound(com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds[("_sfx_" + com.clubpenguin.world.rooms2014.pirate.party.PirateParty.getEquippedSwordName(player_id)) + "_mid"], _sfxLayer_swords, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playPenguinLowHit(player_id) {
            soundManager.playSound(com.clubpenguin.world.rooms2014.pirate.party.PiratePartySounds[("_sfx_" + com.clubpenguin.world.rooms2014.pirate.party.PirateParty.getEquippedSwordName(player_id)) + "_low"], _sfxLayer_swords, LOCAL_PLAYER_SFX_VOLUME);
        }
        static function playPointsSound(player_id) {
            if (_shell.isMyPlayer(player_id)) {
                soundManager.playSound(_sfx_duel_points, _sfxLayer_penguin, LOCAL_PLAYER_SFX_VOLUME);
            }
        }
        static var REMOTE_PLAYER_SFX_VOLUME = 25;
        static var LOCAL_PLAYER_SFX_VOLUME = 100;
    }
