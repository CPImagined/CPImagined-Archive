//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.medieval.MedievalParty
    {
        function MedievalParty () {
        }
        static function isGoodState() {
            var _local_2 = _global.getCurrentShell();
            var _local_3 = 1337709600000;
            trace("MedievalParty SHELL.server_time.getTime(): " + _local_2.server_time.getTime());
            return(_local_2.server_time.getTime() >= _local_3);
        }
        static function track(eventName) {
            var _local_2 = _global.getCurrentShell();
            _local_2._trackerAS2.trackTestImpression("medievalABTest", eventName, _local_2.getTestGroupID(), _local_2.isMyPlayerMember());
        }
        static function playerHasNoScavengerHuntItems() {
            var _local_2 = _global.getCurrentInterface();
            return(!((_local_2.scavengerHunt.isItemFound(0) || (_local_2.scavengerHunt.isItemFound(1))) || (_local_2.scavengerHunt.isItemFound(2))));
        }
        static function canAccessMemberExperience() {
            var _local_2 = _global.getCurrentShell();
            trace((((("MedievalParty.canAccessMemberExperience() SHELL.isMyPlayerMember():" + _local_2.isMyPlayerMember()) + " SHELL.getTestGroupID: ") + _local_2.getTestGroupID) + " SHELL.getTestGroupID():") + _local_2.getTestGroupID());
            var _local_3 = _local_2.getTestGroupID();
            if (isNaN(_local_3) || (_local_3 == undefined)) {
                _local_3 = 1;
            }
            trace("MedievalParty testGroupID: " + _local_3);
            return(_local_2.isMyPlayerMember() || (_local_3 == 0));
        }
        static var SCAVENGER_HUNT_SLINGSHOT = 0;
        static var SCAVENGER_HUNT_ORBS = 1;
        static var SCAVENGER_HUNT_ROCKS = 2;
        static var SCORN_CROWN_PIN_ID = 7110;
        static var BATTLE_CAPE_ID = 3120;
        static var SKYWARD_STAFF_ID = 5148;
        static var NOBLE_HELMET_ID = 1400;
        static var OOPS_SKY_KINGDOM_STAFF = "oops_party26_room";
        static var OOPS_MOUNTAIN_GATE = "oops_party26_room";
        static var OOPS_KNIGHTS_QUEST_2 = "oops_party2_room";
        static var PARTY_CATALOG = "w.p0512.medieval.catalog";
        static var OOPS_MEMBER_MOUNTAIN_GATE = "w.p0512.medieval.mountain.needitems";
        static var CONTENT_SCAVENGER_HUNT = "scavenger_hunt";
        static var CONTENT_NEED_STAFF = "w.p0512.medieval.skykingdom.needstaff";
        static var CONTENT_TELESCOPE_CLOSE_UP = "w.p0512.medieval.lighthouse.telescope";
        static var CONTENT_SKY_KINGDOM_SCORN_BATTLE_GATE = "w.p0512.medieval.skygate.note";
        static var GAME_SCORN_BATTLE = "scornbattle";
        static var STAMP_ID_SOLVE_PUZZLE = 183;
        static var STAMP_ID_SOLVE_SCAVENGER_HUNT = 188;
        static var STAMP_ID_HIT_50_TARGETS = 185;
    }
