//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.halloween.Halloween
    {
        function Halloween () {
        }
        static function hasCollectedAllKeys() {
            var _local_3 = _global.getCurrentShell();
            var _local_4 = _global.getCurrentInterface();
            if (_local_3.isItemInMyInventory(GHOST_GOGGLES)) {
                return(true);
            }
            var _local_2 = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            return((((_local_2.getTaskComplete(GREENHOUSE_KEY) && (_local_2.getTaskComplete(ATTIC_KEY))) && (_local_2.getTaskComplete(DINING_ROOM_KEY))) && (_local_2.getTaskComplete(FOYER_KEY))) && (_local_2.getTaskComplete(LIBRARY_KEY)));
        }
        static function isGhost(playerObject) {
            return(playerObject.avatar_id == GHOST_AVATAR_ID);
        }
        static function isGhostHunter(playerObject) {
            return(playerObject.avatar_id == GHOST_HUNTER_AVATAR_ID);
        }
        static function isMyPlayerGhost() {
            var _local_2 = _global.getCurrentShell();
            var _local_3 = _local_2.getPlayerObjectById(_local_2.getMyPlayerId());
            return(isGhost(_local_3));
        }
        static function playerCanSeeGhosts() {
            var _local_2 = _global.getCurrentShell();
            var _local_3 = _local_2.getPlayerObjectById(_local_2.getMyPlayerId());
            return((_local_3.face == GHOST_GOGGLES) || (_local_3.avatar_id == GHOST_AVATAR_ID));
        }
        static function hasGhostGoggles() {
            var _local_2 = _global.getCurrentShell();
            return(_local_2.isItemInMyInventory(GHOST_GOGGLES));
        }
        static function canAccessMemberExperience() {
            var _local_2 = _global.getCurrentShell();
            return(_local_2.isMyPlayerMember());
        }
        static var FOYER_KEY = 10;
        static var GREENHOUSE_KEY = 11;
        static var DINING_ROOM_KEY = 12;
        static var LIBRARY_KEY = 13;
        static var ATTIC_KEY = 14;
        static var GHOST_GOGGLES = 93043;
        static var GHOST_AVATAR_ID = 1917;
        static var GHOST_HUNTER_AVATAR_ID = 9;
        static var GHOST_HUNTER_SUIT_ID = 93044;
        static var CONTENT_TELESCOPE_CLOSE_UP = "w.p1012.halloween.attic.telescope";
    }
