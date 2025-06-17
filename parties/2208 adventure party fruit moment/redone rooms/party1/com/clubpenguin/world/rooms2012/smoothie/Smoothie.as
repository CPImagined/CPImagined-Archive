//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.smoothie.Smoothie
    {
        function Smoothie () {
        }
        static function showSmoothieGame() {
            var _local_2 = _global.getCurrentShell();
            return(_local_2.server_time.getTime() >= SMOOTHIE_GAME);
        }
        static function hasCollectedScavengerHuntItems() {
            var _local_2 = _global.getCurrentInterface();
            return((_local_2.scavengerHunt.isItemFound(SCAVENGER_PINEAPPLE) && (_local_2.scavengerHunt.isItemFound(SCAVENGER_APPLE))) && (_local_2.scavengerHunt.isItemFound(SCAVENGER_WATERMELON)));
        }
        static function hasScavengerHuntPin() {
            var _local_2 = _global.getCurrentShell();
            return((_local_2.isItemInMyInventory(WATERMELON_COSTUME) || (_local_2.isItemInMyInventory(PINEAPPLE_COSTUME))) || (_local_2.isItemInMyInventory(APPLE_COSTUME)));
        }
        static function canAccessMemberExperience() {
            var _local_2 = _global.getCurrentShell();
            return(_local_2.isMyPlayerMember());
        }
        static var SCAVENGER_APPLE = 0;
        static var SCAVENGER_WATERMELON = 1;
        static var SCAVENGER_PINEAPPLE = 2;
        static var APPLE_TRIBE = 5;
        static var WATERMELON_TRIBE = 6;
        static var PINEAPPLE_TRIBE = 7;
        static var APPLE_DATE = 1345852799000;
        static var PINEAPPLE_DATE = 1346198399000;
        static var SMOOTHIE_GAME = 1346317200000;
        static var WATERMELON_COSTUME = 4664;
        static var PINEAPPLE_COSTUME = 4665;
        static var APPLE_COSTUME = 4666;
        static var APPLE_HEADBAND = 1441;
        static var WATERMELON_HEADBAND = 1442;
        static var PINEAPPLE_HEADBAND = 1443;
        static var RED_TRIBE_BACKGROUND = 9149;
        static var GREEN_TRIBE_BACKGROUND = 9150;
        static var YELLOW_TRIBE_BACKGROUND = 9148;
        static var GRAPE_COSTUME = 4667;
        static var PARTY_CATALOGUE = "w.p0812.smoothie.clothing.catalogue";
        static var CONTENT_SCAVENGER_HUNT = "scavenger_hunt";
        static var VOLCANO_TOP_HELP = "w.p0812.smoothie.volcanotop.help";
        static var VOLCANO_TOP_GRAPE_HELP = "w.p0812.smoothie.volcanotop.grape.help";
        static var SCAVENGER_HUNT_ALERT = "w.p0812.smoothie.scavengerhunt";
        static var PARTY_ANNOUNCEMENT = "w.party.announcement";
        static var VOLCANO_TEMPLE_NONMEMBER_OOPS = "oops_party2_room";
    }
