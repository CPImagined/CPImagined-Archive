//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.holiday.Holiday
    {
        function Holiday () {
        }
        static function canAccessMemberExperience() {
            var _local_2 = _global.getCurrentShell();
            return(_local_2.isMyPlayerMember());
        }
        static function checkDestructableIsHit(snowballInfo, destructableList) {
            var _local_7 = _global.getCurrentShell();
            var _local_6;
            switch (_local_7.getPlayerObjectById(snowballInfo.player_id).avatar_id) {
                case FROST_BITE_AVATAR_ID : 
                    _local_6 = 2;
                    break;
                default : 
                    _local_6 = 3;
                    break;
            }
            var _local_5;
            var _local_2 = 0;
            while (_local_2 < destructableList.length) {
                if (destructableList[_local_2].hitTest(snowballInfo.x, snowballInfo.y, true)) {
                    _local_5 = destructableList[_local_2];
                    break;
                }
                _local_2++;
            }
            if (_local_5) {
                snowballInfo.snowballMC._visible = false;
                _local_5.effect.gotoAndStop(_local_6);
            }
        }
        static var DEC20_GIFT_AVAILABILITY_DATE = 1355986800000;
        static var DEC21_GIFT_AVAILABILITY_DATE = 1356073200000;
        static var DEC22_GIFT_AVAILABILITY_DATE = 1356159600000;
        static var DEC23_GIFT_AVAILABILITY_DATE = 1356246000000;
        static var DEC24_GIFT_AVAILABILITY_DATE = 1356332400000;
        static var DEC25_GIFT_AVAILABILITY_DATE = 1356418800000;
        static var DEC25_MEMBER_GIFT_AVAILABILITY_DATE = 1356418800000;
        static var NEW_YEARS_EVE_DATE = 1357027200000;
        static var HOLIDAY_TEDDY = 5191;
        static var HOT_CHOCOLATE = 5192;
        static var FROST_BITE_CAVERN = 9178;
        static var RACE_CAR_CONTROLLER = 5190;
        static var GREEN_LIGHTBULB = 1518;
        static var ARCTIC_WHITE = 16;
        static var BIG_COZY_CHAIR = 9174;
        static var FROST_BITE_PALACE = 55;
        static var MEMBER_ITEM_1 = 954;
        static var MEMBER_ITEM_2 = 955;
        static var MEMBER_ITEM_3 = 956;
        static var MEMBER_ITEM_4 = 957;
        static var MEMBER_ITEM_5 = 958;
        static var REINDEER_PUFFLE_AVATAR_ID = 10;
        static var TOY_CAR_AVATAR_ID = 11;
        static var FROST_BITE_AVATAR_ID = 12;
        static var PARTY_CATALOGUE_1 = "w.p1212.holiday.clothing.catalogue1";
        static var PARTY_CATALOGUE_2 = "w.p1212.holiday.clothing.catalogue2";
        static var CONTENT_SCAVENGER_HUNT = "scavenger_hunt";
        static var GO_THERE_POSTER = "party_poster";
        static var LOGIN_CALENDAR_OOPS_MESSAGE = "oops_party_login_calendar";
        static var PARTY_ANNOUNCEMENT = "w.party.announcement";
        static var BUY_COOKIE_UI = "w.p1212.holiday.buycookie";
        static var BUY_FROSTBITE_COOKIE_OOPS = "oops_buy_frostbite_cookie";
        static var BUY_REINDEER_COOKIE_OOPS = "oops_buy_reindeer_cookie";
        static var COINS_FOR_CHANGE_POPUP = "coins_for_change";
        static var COINS_FOR_CHANGE_INFO_POSTER = "w.party.cfcInfoPoster";
        static var COOKIE_BAKERY_HELP = "w.p1212.holiday.bakery.help";
    }
