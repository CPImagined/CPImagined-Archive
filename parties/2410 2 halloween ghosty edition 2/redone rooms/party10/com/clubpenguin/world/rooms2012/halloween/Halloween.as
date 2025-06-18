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
            var _local_2 = com.clubpenguin.world.rooms2012.halloween.scavengerhunts.ScavengerHuntMain.getKeyScavengerHunt();
            return((((_local_2.isItemFound(GREENHOUSE_KEY) && (_local_2.isItemFound(ATTIC_KEY))) && (_local_2.isItemFound(DINING_ROOM_KEY))) && (_local_2.isItemFound(FOYER_KEY))) && (_local_2.isItemFound(LIBRARY_KEY)));
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
        static var FOYER_KEY = 0;
        static var GREENHOUSE_KEY = 1;
        static var DINING_ROOM_KEY = 2;
        static var LIBRARY_KEY = 3;
        static var ATTIC_KEY = 4;
        static var HAUNTED_ANY_PARTY_ROOM = 0;
        static var HAUNTED_BEACH = 1;
        static var HAUNTED_FORTS = 2;
        static var HAUNTED_FOREST = 3;
        static var HAUNTED_COVE = 4;
        static var HAUNTING_PRIZE_2_AVAILABILITY_DATE = 1350716400000;
        static var HAUNTING_PRIZE_3_AVAILABILITY_DATE = 1351062000000;
        static var GHOST_GOGGLES = 2083;
        static var GARIWALD_BACKGROUND = 9167;
        static var GHOST_AVATAR_ID = 8;
        static var GHOST_HUNTER_AVATAR_ID = 9;
        static var GHOST_HAUNT_ITEM_1 = 914;
        static var GHOST_HAUNT_ITEM_2 = 913;
        static var GHOST_HAUNT_ITEM_3 = 902;
        static var GHOST_HUNTER_SUIT_ID = 4727;
        static var PARTY_CATALOGUE = "w.p1012.halloween.clothing.catalogue";
        static var CONTENT_TELESCOPE_CLOSE_UP = "w.p1012.halloween.attic.telescope";
        static var GARIWALD_POPUP = "w.p1012.halloween.note.gariwald";
        static var GET_GHOST_GOGGLES_NOTE = "w.p1012.halloween.note.goggles";
        static var CONTENT_SCAVENGER_HUNT = "scavenger_hunt";
        static var GHOSTLAB_OOPS_MEESSAGE = "oops_party9_room";
        static var PARTY_ANNOUNCEMENT = "w.party.announcement";
    }
